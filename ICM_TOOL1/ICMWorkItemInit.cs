using System;
using System.Collections.Generic;
using System.Web;
using System.IO;
using System.Configuration;
using log4net;
using IcmTool.WorkItemManagement;
using System.Text;

namespace IcmTool
{
    public class ICMWorkItemInit
    {
        private static readonly ILog Logger = LogManager.GetLogger(typeof(ICMWorkItemInit));

        public static void WriteLog(string message, bool iserror)
        {
            string BoolWriteLog = ConfigurationManager.AppSettings["WriteLogs"];
            if (BoolWriteLog.ToLower() == "true" && iserror)
            {
                Logger.ErrorFormat(message);
            }

            if (BoolWriteLog.ToLower() == "true" && !iserror)
            {
                Logger.InfoFormat(message);
            }
        }

        // Initialising the configs
        public static void configSet(IcmItem message)
        {
            string tenantToken = ConfigurationManager.AppSettings["AriaTenantToken"];

            try
            {
                string configName = ConfigurationManager.AppSettings["ConfigPath"];
                string configPath = HttpContext.Current.Server.MapPath(configName);
                string[] configsFilePattern = ConfigurationManager.AppSettings["ConfigFilePattern"].Split(',');
                List<string> configFiles = new List<string>();
                foreach (string configpat in configsFilePattern)
                {
                    var configFileNames = Directory.GetFiles(configPath, configpat);
                    configFiles.AddRange(configFileNames);
                }


                if (configFiles.Count == 0)
                {
                    throw new ConfigurationErrorsException("No configs found");
                }

                var configs = new List<Config>();
                var configTimeStamps = new Dictionary<string, DateTime>();

                foreach (var configFile in configFiles)
                {
                    // Save the timestamp for the config so that we can detect if it changed later on
                    configTimeStamps[configFile] = File.GetLastWriteTime(configFile);
                    // Load the config and add it to the list.
                    // If loading failed, print error message and continue
                    var cfg = TryLoadConfig(configFile);
                    if (cfg == null)
                    {
                        continue;
                    }
                    configs.Add(cfg);
                }

                if (configs.Count == 0)
                {
                    WriteLog("No config loaded.", false);
                    throw new ConfigurationErrorsException("None of the configs were valid.");
                }
                InitInstances(configs, message);
            }
            catch (Exception exception)
            {
                WriteLog(exception.ToString(), true);
                throw;
            }
        }

        private static Config TryLoadConfig(string configFile)
        {
            try
            {
                return Config.GetConfig(configFile);
            }
            catch (Exception ex)
            {
                WriteLog(ex.ToString(), true);
            }

            return null;
        }

        private static void InitInstances(IEnumerable<Config> configs, IcmItem message)
        {
            foreach (var config in configs)
            {
                foreach (var instance in config.Instances)
                {
                    try
                    {
                        if ((instance.IcmClientConfig != null) && (instance.IncidentDefaults != null))
                        {
                            new IcmWorkItemManagment(instance, message);
                        }
                    }
                    catch (Exception ex)
                    {
                        WriteLog(ex.ToString(), true);
                        throw;
                    }
                }
            }
        }

        public static void configSetOnBoarding(OnboardingItem message)
        {
            string appSetting = ConfigurationManager.AppSettings["AriaTenantToken"];
            try
            {
                string path = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["ConfigPath"]);
                string[] strArray = ConfigurationManager.AppSettings["ConfigFilePattern"].Split(',');
                List<string> stringList = new List<string>();
                foreach (string searchPattern in strArray)
                {
                    string[] files = Directory.GetFiles(path, searchPattern);
                    stringList.AddRange((IEnumerable<string>)files);
                }
                if (stringList.Count == 0)
                    throw new ConfigurationErrorsException("No configs found");
                List<Config> configList = new List<Config>();
                Dictionary<string, DateTime> dictionary = new Dictionary<string, DateTime>();
                foreach (string index in stringList)
                {
                    dictionary[index] = File.GetLastWriteTime(index);
                    Config config = ICMWorkItemInit.TryLoadConfig(index);
                    if (config != null)
                        configList.Add(config);
                }
                if (configList.Count == 0)
                {
                    ICMWorkItemInit.WriteLog("No config loaded.", false);
                    throw new ConfigurationErrorsException("None of the configs were valid.");
                }
                ICMWorkItemInit.InitInstancesOnBoarding((IEnumerable<Config>)configList, message);
            }
            catch (Exception ex)
            {
                ICMWorkItemInit.WriteLog(ex.ToString(), true);
                throw;
            }
        }

        private static void InitInstancesOnBoarding(IEnumerable<Config> configs, OnboardingItem message)
        {
            foreach (Config config in configs)
            {
                foreach (Config.InstanceConfig instance in config.Instances)
                {
                    try
                    {
                        if (instance.IcmClientConfig != null)
                        {
                            if (instance.IncidentDefaults != null)
                            {
                                IcmWorkItemManagment workItemManagment = new IcmWorkItemManagment(instance, message);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ICMWorkItemInit.WriteLog(ex.ToString(), true);
                        throw;
                    }
                }
            }
        }

    }
}