namespace IcmTool.WorkItemManagement
{
    using System;
    using System.Security.Cryptography.X509Certificates;
    using System.ServiceModel;
    using System.ServiceModel.Security;
    using log4net;
    using Microsoft.AzureAd.Icm.Types;
    using Microsoft.AzureAd.Icm.WebService.Client;
    using System.Threading.Tasks;
    using System.Web;
    using System.IO;
    using System.Configuration;

    public class IcmWorkItemManagment
    {
        public static string workitemid;
        private static readonly string CertThumbprint = ConfigurationManager.AppSettings["CertThumbPrint"];
        private static readonly ILog Logger = LogManager.GetLogger(typeof(IcmWorkItemManagment));
        private readonly Config.InstanceConfig config;
        private readonly DateTime dateHolder;
        private readonly DataServiceODataClient dataServiceClient;
        private readonly AlertSourceIncident incidentDefaults;
        private ConnectorIncidentManagerClient connectorClient;

        // Initializing ICM Workitem
        public IcmWorkItemManagment(Config.InstanceConfig instanceConfig, IcmItem Message)
        {
            IcmItem message = Message;
            ValidateConfig(instanceConfig);
            config = instanceConfig;
            incidentDefaults = config.IncidentDefaults;

            try
            {
                //code to read cert
                ICMWorkItemInit.WriteLog("Reading ICM certificate", false);
                string certThumbPrint = System.Text.RegularExpressions.Regex.Replace(CertThumbprint, @"[^\da-zA-z]", string.Empty).ToUpper(); ;
                X509Store certStore = new X509Store(StoreName.My, StoreLocation.LocalMachine);
                // Try to open the store.
                certStore.Open(OpenFlags.ReadOnly);
                // Find the certificate that matches the thumbprint.
                X509Certificate2Collection certCollection = certStore.Certificates.Find(X509FindType.FindByThumbprint, certThumbPrint, false);
                X509Certificate certificate = certCollection[0];
                ICMWorkItemInit.WriteLog("Certificate loaded with name=" + certificate.Subject.ToString(), false);
                certStore.Close();

                dataServiceClient = new DataServiceODataClient(
                    new Uri(config.IcmClientConfig.OdataServiceBaseUri), certificate);
                connectorClient = ConnectToIcmInstance();
                if (connectorClient == null)
                {
                    ICMWorkItemInit.WriteLog("Cannot initialize IcM Webservice.", false);
                    throw new Exception("Cannot initialize IcM Webservice.");
                }
                dateHolder = DateTime.UtcNow;
                CreateWorkItem(message);
            }
            catch (Exception e)
            {
                ICMWorkItemInit.WriteLog(e.ToString(), true);
                throw;
            }
        }

        public IcmWorkItemManagment(Config.InstanceConfig instanceConfig, OnboardingItem Message)
        {
            OnboardingItem message = Message;
            IcmWorkItemManagment.ValidateConfig(instanceConfig);
            this.config = instanceConfig;
            this.incidentDefaults = this.config.IncidentDefaults;
            X509Certificate2Collection set = null;
            try
            {
                ICMWorkItemInit.WriteLog("Reading ICM certificate", false);
                string upper = System.Text.RegularExpressions.Regex.Replace(IcmWorkItemManagment.CertThumbprint, "[^\\da-zA-z]", string.Empty).ToUpper();
                X509Store x509Store = new X509Store(StoreName.My, StoreLocation.LocalMachine);
                int num = 0;
                x509Store.Open(OpenFlags.ReadOnly);
              
                foreach (X509Certificate2 mCert in x509Store.Certificates)
                {
                    if (mCert.Thumbprint.StartsWith("‎‎02011F31AE7E7E91C5429FD4164A8881368AD22A"))
                    {
                        set = x509Store.Certificates.Find(X509FindType.FindByThumbprint, mCert.Thumbprint, false);
                    }
                }

                X509Certificate certificate = (X509Certificate)x509Store.Certificates.Find(X509FindType.FindByThumbprint, (object)upper, false)[0];

                ICMWorkItemInit.WriteLog("Certificate loaded with name=" + certificate.Subject.ToString(), false);
                x509Store.Close();
                this.dataServiceClient = new DataServiceODataClient(new Uri(this.config.IcmClientConfig.OdataServiceBaseUri), certificate);
                this.connectorClient = this.ConnectToIcmInstance();
                if (this.connectorClient == null)
                {
                    ICMWorkItemInit.WriteLog("Cannot initialize IcM Webservice.", false);
                    throw new Exception("Cannot initialize IcM Webservice.");
                }
                this.dateHolder = DateTime.UtcNow;
                this.CreateWorkItemForOnBoarding(message);
            }
            catch (Exception ex)
            {
                ICMWorkItemInit.WriteLog(ex.ToString(), true);
                throw;
            }
        }

        //Validate Config
        private static void ValidateConfig(Config.InstanceConfig config)
        {
            if (config == null)
            {
                throw new ArgumentNullException("config");
            }

            // Temp variable used for shorthand writing below
            var icmConfig = config.IcmClientConfig;

            ValidateConfigString(icmConfig.IcmUri, "IcmClientConfig.IcmUri");
            ValidateConfigString(icmConfig.IcmTenant, "IcmClientConfig.IcmTenant");
            ValidateConfigString(
                config.WorkItemSettings.ConversationIndexFieldName,
                "WorkItemSettings.ConversationIndexFieldName");
        }

        //Connect to ICM instance
        private ConnectorIncidentManagerClient ConnectToIcmInstance()
        {
            try
            {
                ICMWorkItemInit.WriteLog("Connecting to IcM using certificate...", false);
                var icmServer = CreateConnectorClient(config.IcmClientConfig.IcmUri);
                ICMWorkItemInit.WriteLog("Successfully connected to IcM.", false);
                return icmServer;
            }
            catch (Exception ex)
            {
                ICMWorkItemInit.WriteLog(ex.ToString(), true);
            }
            return null;
        }

        //Create Connector Client
        private static ConnectorIncidentManagerClient CreateConnectorClient(string icmWebServiceBaseUrl)
        {
            WS2007HttpBinding binding = new WS2007HttpBinding(SecurityMode.Transport)
            {
                Name = "IcmBindingConfigCert",
                MaxBufferPoolSize = 4194304,
                MaxReceivedMessageSize = 16777216
            };

            binding.Security.Transport.Realm = string.Empty;
            binding.Security.Transport.ProxyCredentialType = HttpProxyCredentialType.None;
            binding.Security.Transport.ClientCredentialType = HttpClientCredentialType.Certificate;
            binding.Security.Message.EstablishSecurityContext = false;
            binding.Security.Message.NegotiateServiceCredential = true;
            binding.Security.Message.AlgorithmSuite = SecurityAlgorithmSuite.Default;
            binding.Security.Message.ClientCredentialType = MessageCredentialType.Certificate;

            EndpointAddress remoteAddress = new EndpointAddress(icmWebServiceBaseUrl);

            ConnectorIncidentManagerClient client = new ConnectorIncidentManagerClient(binding, remoteAddress);
            if (client.ClientCredentials != null)
            {
                client.ClientCredentials.ClientCertificate.SetCertificate(
                    StoreLocation.LocalMachine,
                    StoreName.My,
                    X509FindType.FindByThumbprint,
                    CertThumbprint);
            }
            return client;
        }

        private static void ValidateConfigString(string value, string configValueName)
        {
            if (string.IsNullOrEmpty(value))
            {
                ICMWorkItemInit.WriteLog("BadConfig", true);
            }
        }

        //Method for attaching file
        public async Task AttachFiles(long workItemId, string file)
        {
            await dataServiceClient.ProcessAttachment(workItemId, file);
        }

        //Method to set up values for incident object
        public AlertSourceIncident CreateIncidentWithDefault(IcmItem message)
        {
            AlertSourceIncident incident = new AlertSourceIncident();
            incident.ImpactStartDate = DateTime.UtcNow;
            incident.Title = message.title;
            incident.Description = message.description;
            incident.ReproSteps = message.reproSteps;
            incident.IncidentType = message.incidentType;
            incident.Severity = message.severity;
            incident.CustomerName = message.contactAlias;
           
            var descriptionEntry = new DescriptionEntry
            {
                Cause = DescriptionEntryCause.Created,
                Date = DateTime.UtcNow,
                ChangedBy = message.contactAlias,
                SubmitDate = DateTime.UtcNow,
                SubmittedBy = message.contactAlias,
                Text = incident.Description,
                RenderType = DescriptionTextRenderType.Html,
            };
            incident.DescriptionEntries = new[] { descriptionEntry };

            incident.Source = new AlertSourceInfo
            {
                CreatedBy = string.IsNullOrEmpty(message.contactAlias) ? incidentDefaults.Source.CreatedBy : message.contactAlias,
                CreateDate = DateTime.UtcNow,
                IncidentId = Guid.NewGuid().ToString(),
                ModifiedDate = DateTime.UtcNow,
                Origin = incidentDefaults.Source.Origin
            };
            incident.OccurringLocation = new IncidentLocation
            {
                DataCenter = incidentDefaults.OccurringLocation.DataCenter,
                DeviceGroup = incidentDefaults.OccurringLocation.DeviceGroup,
                DeviceName = incidentDefaults.OccurringLocation.DeviceName,
                Environment = incidentDefaults.OccurringLocation.Environment,
                ServiceInstanceId = incidentDefaults.OccurringLocation.ServiceInstanceId
            };
            incident.RaisingLocation = new IncidentLocation
            {
                DataCenter = incidentDefaults.RaisingLocation.DataCenter,
                DeviceGroup = incidentDefaults.RaisingLocation.DeviceGroup,
                DeviceName = incidentDefaults.RaisingLocation.DeviceName,
                Environment = incidentDefaults.RaisingLocation.Environment,
                ServiceInstanceId = incidentDefaults.RaisingLocation.ServiceInstanceId
            };
            incident.RoutingId = config.IcmClientConfig.RoutingId;
            incident.Status = incidentDefaults.Status;
            return incident;
        }

        public AlertSourceIncident CreateOnBaordingWithDefault(OnboardingItem message)
        {
            AlertSourceIncident alertSourceIncident = new AlertSourceIncident();
            alertSourceIncident.ImpactStartDate = new DateTime?(DateTime.UtcNow);
            alertSourceIncident.Title = message.title;
            alertSourceIncident.Description = message.description;
            alertSourceIncident.CustomerName = message.contactAlias;
            DescriptionEntry descriptionEntry1 = new DescriptionEntry();
            descriptionEntry1.Cause = DescriptionEntryCause.Created;
            descriptionEntry1.Date = DateTime.UtcNow;
            string contactAlias1 = message.contactAlias;
            descriptionEntry1.ChangedBy = contactAlias1;
            DateTime utcNow = DateTime.UtcNow;
            descriptionEntry1.SubmitDate = utcNow;
            string contactAlias2 = message.contactAlias;
            descriptionEntry1.SubmittedBy = contactAlias2;
            string description = alertSourceIncident.Description;
            descriptionEntry1.Text = description;
            int num = 1;
            descriptionEntry1.RenderType = (DescriptionTextRenderType)num;
            DescriptionEntry descriptionEntry2 = descriptionEntry1;
            alertSourceIncident.DescriptionEntries = new DescriptionEntry[1]
            {
        descriptionEntry2
            };
            alertSourceIncident.Source = new AlertSourceInfo()
            {
                CreatedBy = string.IsNullOrEmpty(message.contactAlias) ? this.incidentDefaults.Source.CreatedBy : message.contactAlias,
                CreateDate = DateTime.UtcNow,
                IncidentId = Guid.NewGuid().ToString(),
                ModifiedDate = DateTime.UtcNow,
                Origin = this.incidentDefaults.Source.Origin
            };
            alertSourceIncident.OccurringLocation = new IncidentLocation()
            {
                DataCenter = this.incidentDefaults.OccurringLocation.DataCenter,
                DeviceGroup = this.incidentDefaults.OccurringLocation.DeviceGroup,
                DeviceName = this.incidentDefaults.OccurringLocation.DeviceName,
                Environment = this.incidentDefaults.OccurringLocation.Environment,
                ServiceInstanceId = this.incidentDefaults.OccurringLocation.ServiceInstanceId
            };
            alertSourceIncident.RaisingLocation = new IncidentLocation()
            {
                DataCenter = this.incidentDefaults.RaisingLocation.DataCenter,
                DeviceGroup = this.incidentDefaults.RaisingLocation.DeviceGroup,
                DeviceName = this.incidentDefaults.RaisingLocation.DeviceName,
                Environment = this.incidentDefaults.RaisingLocation.Environment,
                ServiceInstanceId = this.incidentDefaults.RaisingLocation.ServiceInstanceId
            };
            alertSourceIncident.RoutingId = this.config.IcmClientConfig.RoutingId;
            alertSourceIncident.Status = this.incidentDefaults.Status;
            return alertSourceIncident;
        }

        //Create new work item
        public void CreateWorkItem(IcmItem message)
        {
            try
            {
                AlertSourceIncident incident = CreateIncidentWithDefault(message);
                if (connectorClient == null)
                {
                    connectorClient = ConnectToIcmInstance();
                }

                ICMWorkItemInit.WriteLog("creating incident in ICM", false);
                long incidentId = 0;
                IncidentAddUpdateResult result = connectorClient.AddOrUpdateIncident2(config.IcmClientConfig.ConnectorId, incident, RoutingOptions.None);

                if (result?.IncidentId != null)
                {
                    incidentId = result.IncidentId.Value;
                    ICMWorkItemInit.WriteLog("Incident created successfully in ICM with incident id=" + incidentId.ToString(), false);
                    bool exists = System.IO.Directory.Exists(HttpContext.Current.Server.MapPath("~/Uploads/"));
                    if (!exists)
                        System.IO.Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/Uploads/"));
                    string path = HttpContext.Current.Server.MapPath("~/Uploads/");
                    string[] files = Directory.GetFiles(path);
                    ICMWorkItemInit.WriteLog("Uploading attachements", false);
                    foreach (string file in files)
                    {
                        var Task = AttachFiles(incidentId, file);
                    }
                    foreach (string filePath in files)
                    {
                        File.Delete(filePath);
                    }
                    workitemid = incidentId.ToString();
                }
            }
            catch (Exception e)
            {
                ICMWorkItemInit.WriteLog(e.ToString(), true);
                throw;
            }
        }

        public void CreateWorkItemForOnBoarding(OnboardingItem message)
        {
            try
            {
                AlertSourceIncident baordingWithDefault = this.CreateOnBaordingWithDefault(message);
                if (this.connectorClient == null)
                    this.connectorClient = this.ConnectToIcmInstance();
                ICMWorkItemInit.WriteLog("creating incident in ICM", false);
                IncidentAddUpdateResult incidentAddUpdateResult = this.connectorClient.AddOrUpdateIncident2(this.config.IcmClientConfig.ConnectorId, baordingWithDefault, RoutingOptions.None);
                if (incidentAddUpdateResult == null)
                    return;
                long? incidentId = incidentAddUpdateResult.IncidentId;
                if (!incidentId.HasValue)
                    return;
                incidentId = incidentAddUpdateResult.IncidentId;
                long workItemId = incidentId.Value;
                ICMWorkItemInit.WriteLog("Incident created successfully in ICM with incident id=" + workItemId.ToString(), false);
                if (!Directory.Exists(HttpContext.Current.Server.MapPath("~/Uploads/")))
                    Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/Uploads/"));
                string[] files = Directory.GetFiles(HttpContext.Current.Server.MapPath("~/Uploads/"));
                ICMWorkItemInit.WriteLog("Uploading attachements", false);
                foreach (string file in files)
                    this.AttachFiles(workItemId, file);
                foreach (string path in files)
                    File.Delete(path);
                IcmWorkItemManagment.workitemid = workItemId.ToString();
            }
            catch (Exception ex)
            {
                ICMWorkItemInit.WriteLog(ex.ToString(), true);
                throw;
            }
        }
    }
}
