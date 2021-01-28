using System;
using System.Collections.Generic;
using System.IO;
using System.Xml.Serialization;

namespace IcmTool
{
    using Microsoft.AzureAd.Icm.Types;

    public class Config
    {
        public List<InstanceConfig> Instances;

        public class InstanceConfig
        {
            [XmlAttribute]
            public string Name { get; set; }

            public IcmClientConfig IcmClientConfig { get; set; }

            public WorkItemSettings WorkItemSettings { get; set; }

            public AlertSourceIncident IncidentDefaults { get; set; }


            public override string ToString()
            {
                return $"Name: {Name}";
            }
        }

        public class IcmClientConfig
        {
            public string OdataServiceBaseUri { get; set; }

            // ICM API used to connect to ICM to create/update ICM tickets.
            public string IcmUri { get; set; }

            public string FilterOption { get; set; }

            public string TopOption { get; set; }

            public string SkipOption { get; set; }

            public Guid ConnectorId { get; set; }

            public string RoutingId { get; set; }

            // Template to create a ICM ticket.
            // public string IcmTicketTemplate { get; set; }

            // The query to be used for populating the cache used for connecting outlook conversations to bugs.
            // If a work item is not captured by the query, the connection between conversation and work item would 
            // fail (and a new work item will be created instead of updating the existing one)
            // public string CacheQueryFile { get; set; }

            // Used for testing purposes and wouldn't create any ICM tickets. 
            public bool SimulationMode { get; set; }

            // The name of the field which contains all the allowed names in its allowed values list (usually "Assigned To")
            //public string NamesListFieldName { get; set; }

            // Team ticket will be assigned to in ICM.
            public string IcmTenant { get; set; }

            public override string ToString()
            {
                return String.Format("IcmTenant: {0}", IcmTenant);
            }
        }


        public class WorkItemSettings
        {
            public enum ProcessingStrategyType
            {
                SimpleBugStrategy
            }

            public string ConversationIndexFieldName { get; set; }

            public List<DefaultValueDefinition> DefaultFieldValues { get; set; }

            public List<MnemonicDefinition> Mnemonics { get; set; }

            public List<RecipientOverrideDefinition> RecipientOverrides { get; set; }

            public List<DateBasedFieldOverrides> DateBasedOverrides { get; set; }

            public bool ApplyOverridesDuringUpdate { get; set; }

            public bool AttachOriginalMessage { get; set; }

            public ProcessingStrategyType ProcessingStrategy = ProcessingStrategyType.SimpleBugStrategy;

            public int? RemoveHyperlinkExceedingNCharacters { get; set; }
        }

        public class DefaultValueDefinition
        {
            [XmlAttribute]
            public string Field { get; set; }

            [XmlAttribute]
            public string Value { get; set; }
        }

        public class MnemonicDefinition
        {
            [XmlAttribute]
            public string Mnemonic { get; set; }

            [XmlAttribute]
            public string Field { get; set; }

            [XmlAttribute]
            public string Value { get; set; }
        }

        public class RecipientOverrideDefinition
        {
            [XmlAttribute]
            public string Alias { get; set; }

            [XmlAttribute]
            public string Field { get; set; }

            [XmlAttribute]
            public string Value { get; set; }
        }

        public class DateBasedFieldOverrides
        {
            [XmlAttribute]
            public string FieldName { get; set; }

            public string DefaultValue { get; set; }

            public List<DateBasedOverrideEntry> Entries;
        }

        public class DateBasedOverrideEntry
        {
            [XmlAttribute]
            public DateTime StartDate { get; set; }

            [XmlAttribute]
            public string Value { get; set; }
        }


        public Config()
        {
            Instances = new List<InstanceConfig>();
        }

        public static Config GetConfig(string configFilePath)
        {
            using (var fs = new FileStream(configFilePath, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                XmlAttributes attributes = new XmlAttributes { XmlIgnore = true };
                XmlAttributeOverrides overrides = new XmlAttributeOverrides();
                overrides.Add(typeof(AlertSourceIncident), "CustomFields", attributes);
                // Microsoft.AzureAd.Icm.Types.TenantIdentifier cannot be serialized because it does not have a parameterless constructor.
                overrides.Add(typeof(AlertSourceIncident), "ServiceResponsible", attributes);
                overrides.Add(typeof(AlertSourceIncident), "ImpactedServices", attributes);
                var serializer = new XmlSerializer(typeof(Config), overrides);
                var configObject = (Config)serializer.Deserialize(fs);
                configObject.Name = Path.GetFileNameWithoutExtension(configFilePath);
                return configObject;
            }
        }

        /// <summary>
        /// Load the file contents and return as a string.
        /// </summary>
        /// <param name="fileName">File name</param>
        /// <returns>File contents as a string</returns>
        public static string FileToString(string fileName)
        {
            if (string.IsNullOrEmpty(fileName))
            {
                throw new ArgumentException("fileName can't be empty/null", "fileName");
            }

            using (var r = new StreamReader(fileName))
            {
                return r.ReadToEnd();
            }
        }

        public string Name;

        public override string ToString()
        {
            return String.Format("Name: {0}", Name);
        }
    }
}
