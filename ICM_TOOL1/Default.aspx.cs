using System;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.DirectoryServices.AccountManagement;
using IcmTool.WorkItemManagement;
using Microsoft.AzureAd.Icm.Types;


namespace IcmTool
{
    public partial class _Default : Page
    {

        public bool incidentCreatedSuccess = false;
        public string domain = null;

        protected void page_Load(object sender, EventArgs e)
        {
            SiteMapPath1.Visible = (SiteMap.CurrentNode != SiteMap.RootNode);
            Label_Message.Text = "";
            
        }

        public string LabelText
        {
            get { return Label_Message.Text; }
            set { Label_Message.Text = value; }
        }

        //Custom validator to validate that if issue type is bug or technical then repro steps are must.
        protected void CustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if ((DropDownList_IssueType.SelectedValue == "1" || DropDownList_IssueType.SelectedValue == "2") && args.Value == "")
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        //Custom validator to validate AppID.
        protected void CustomValidator_ServerAppIDValidate(object source, ServerValidateEventArgs args)
        {
            bool validateAppID = ValidateAppID(args.Value);

            if (!String.IsNullOrEmpty(args.Value))
            {
                if (validateAppID)
                {
                    args.IsValid = true;
                }
                else
                {
                    args.IsValid = false;
                }
            }

            else
            {
                if ((DropDownList_IssueType.SelectedValue == "1" || DropDownList_IssueType.SelectedValue == "2") && (args.Value == "" || (!validateAppID)))
                {
                    args.IsValid = false;
                }
                else
                {
                    args.IsValid = true;
                }
            }
        }

        //function to validate AppID.
        public static bool ValidateAppID(string appID)
        {
            const int Length = 40;
            if (appID == null)
            {
                return false;
            }

            foreach (char c in appID)
            {
                if ((c < '0' || c > '9') && (c < 'a' || c > 'f') && (c < 'A' || c > 'F'))
                {
                    return false;
                }
            }
            return appID.Length == Length;
        }




        protected void SubmitBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    InitMessage();
                    Label_Message.Visible = true;
                    Label_Message.Text = "WorkItem successfully created, itemId=" + IcmWorkItemManagment.workitemid;
                    incidentCreatedSuccess = true;
                }
                catch (Exception ex)
                {
                    incidentCreatedSuccess = false;
                    Label_Message.Visible = true;
                    Label_Message.Text = "Sorry, there is some problem in the system contact SPS.";
                    ICMWorkItemInit.WriteLog(ex.ToString(), true);
                }
                finally
                {
                    string path = HttpContext.Current.Server.MapPath("~/Uploads/");
                    string[] files = Directory.GetFiles(path);
                    foreach (string filePath in files)
                    {
                        File.Delete(filePath);
                    }
                }
            }
            else
            {
                incidentCreatedSuccess = false;
                Label_Message.Visible = true;
                Label_Message.Text = "Validation failed, please enter required fields.";
            }

            if (incidentCreatedSuccess)
            {
                Response.Redirect("~/Acknowledgement.aspx?incidentid=" + IcmWorkItemManagment.workitemid);
            }
        }

        //custom validator to validate alias based on domain
        protected void CustomValidator_DoesUserExist(object source, ServerValidateEventArgs args)
        {
            try
            {
                string value = args.Value;
                string username;
                if (value.Contains("\\"))
                {
                    string[] contact = value.Split('\\');
                    username = contact[1];
                    domain = contact[0];
                    using (var domainContext = new PrincipalContext(ContextType.Domain, domain + ".corp.microsoft.com"))
                    {
                        using (var foundUser = UserPrincipal.FindByIdentity(domainContext, IdentityType.SamAccountName, username))
                        {
                            if (foundUser != null)
                            {
                                args.IsValid = true;
                            }
                            else
                            {
                                args.IsValid = false;
                            }
                        }
                    }
                }
                else
                {
                    args.IsValid = false;
                }
            }
            catch (Exception e)
            {
                ICMWorkItemInit.WriteLog(e.ToString(), true);
                args.IsValid = false;
            }
        }

        //Method to set the Icmitem object
        public void InitMessage()
        {
            IcmItem icmtype = new IcmItem();
            icmtype.title = TextBoxTitle.Text;
            icmtype.description = DropDownList_IssueType.SelectedItem.Text + " regarding " + DropDownList_ApiType.SelectedItem.Text + System.Environment.NewLine + System.Environment.NewLine + TextArea_Description.Text + System.Environment.NewLine + System.Environment.NewLine + "Repro Steps:" + System.Environment.NewLine + TextArea_ReproSteps.Text + System.Environment.NewLine + System.Environment.NewLine + "AppId:" + System.Environment.NewLine + TextBoxAppId.Text;
            icmtype.reproSteps = TextArea_ReproSteps.Text;
            icmtype.incidentType = DropDownList_IssueType.SelectedItem.Text;
            icmtype.severity = Convert.ToInt32(DropDownList_Severity.SelectedValue);
            icmtype.contactAlias = ContactTextBox.Text + ";" + TeamContactTextBox.Text;

            try
            {
                ICMWorkItemInit.configSet(icmtype);
            }
            catch (Exception e)
            {
                ICMWorkItemInit.WriteLog(e.ToString(), true);
                throw;
            }
        }

        protected void ResetBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Default.aspx");
        }
    }
}
