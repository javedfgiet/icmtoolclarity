using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IcmTool.WorkItemManagement;
using ICM_TOOL1.localhost;
using System.Text;
using JetBrains.Util;
using System.Configuration;

namespace IcmTool
{
    public partial class OnBoardingForm : Page
    {
        
        public bool incidentCreatedSuccess = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            AddTologfile("Inside Page Load");

            this.SiteMapPath1.Visible = SiteMap.CurrentNode != SiteMap.RootNode;
            this.Label_Message.Text = "";
        }

        public string LabelText
        {
            get
            {
                return this.Label_Message.Text;
            }
            set
            {
                this.Label_Message.Text = value;
            }
        }

        public void AddTologfile(string logDetails)
        {
            string path= ConfigurationManager.AppSettings["logFilePath"].ToString();
            //string path = @"D:\ClarityOnBoarding\Onboarding\Onboarding\Onboarding\ICM_TOOL1\LogFiles\Log.txt";

            using (System.IO.StreamWriter file = new System.IO.StreamWriter(path, true))
            {
                file.WriteLine("Run at : " + DateTime.Now + "---->" + " Message " + logDetails);
                return;
            }

        }

        protected void Submit_Click(object sender, EventArgs e)
        {

            
            ICM_TOOL1.localhost.mailProcessing mailProcessing = new mailProcessing();
            var mailDetails = mailProcessing.ReadMailItems();
            foreach (var dataMail in mailDetails)
            {
                try
                {
                    icmDataMail mail = new icmDataMail()
                    {
                        From = dataMail.From,
                        To = dataMail.To,
                        Subject = dataMail.Subject,
                        Body = dataMail.Body

                    };
                    this.InitMessage(mail);
                    this.incidentCreatedSuccess = true;
                    this.Label_Message.Text = "WorkItem successfully created, itemId=" + IcmWorkItemManagment.workitemid;
                    return;

                }
                catch (Exception ex)
                {
                    this.incidentCreatedSuccess = false;
                    AddTologfile("Inside Submit CLick --> " + ex.Message.ToString());
                }

            }
            //if (this.Page.IsValid)
            //{
                
            //    try
            //    {
            //        this.InitMessage();
            //        this.Label_Message.Text = "WorkItem successfully created, itemId=" + IcmWorkItemManagment.workitemid;
            //        this.incidentCreatedSuccess = true;
            //    }
            //    catch (Exception ex)
            //    {
            //        this.incidentCreatedSuccess = false;
            //        this.Label_Message.Text = "Sorry, there is some problem in the system contact SPS.";
            //        ICMWorkItemInit.WriteLog(ex.ToString(), true);
            //    }
            //}
            //else
            //{
            //    this.incidentCreatedSuccess = false;
            //    this.Label_Message.Text = "Validation failed, please enter required fields.";
            //}
            //if (!this.incidentCreatedSuccess)
            //    return;
            //this.Response.Redirect("~/Acknowledgement.aspx?incidentid=" + IcmWorkItemManagment.workitemid);
        }


        public void InitMessage(icmDataMail mail)
        {
            
            try
            {
                OnboardingItem message = new OnboardingItem();
                message.title = mail.Subject;
                message.description = mail.Body;
                message.contactAlias = mail.From;
                ICMWorkItemInit.configSetOnBoarding(message);
            }
            catch (Exception ex)
            {
                ICMWorkItemInit.WriteLog(ex.ToString(), true);
                throw;
            }
        }



        public void InitMessage()
        {
            string StringForCheckListBox = "";
            for (int i = 0; i < DistributionMethodCheckBoxList.Items.Count; i++)
            {
                if (DistributionMethodCheckBoxList.Items[i].Selected)
                {
                    StringForCheckListBox += DistributionMethodCheckBoxList.Items[i].Value + ";";
                }

            }
            OnboardingItem message = new OnboardingItem();
            message.title = "Partner Intake Form for " + TextTeamName.Text;
            message.description = LabelTeamName.Text + " : " + TextTeamName.Text + "\n" +
                Contact.Text + " : " + ContactTextBox.Text + "\n" +
                POCContact.Text + " : " + POCContactText.Text + "\n" +
                TeamContact.Text + " : " + TeamContactTextBox.Text + "\n" +
                ProjectOverView.Text + " : " + ProjectOverViewText.Text + "\n" +
                ProjectReleaseDates.Text + " : " + ProjectReleaseCalendar.SelectedDate.ToString("dd/MM/yyyy") + "\n" +
                DistributionMethod.Text + " : " + StringForCheckListBox + "\n" +
                MarketList.Text + " : " + MarketListText.Text + "\n" + QPM.Text + " : " + QPMText.Text + "\n" +
                QPS.Text + " : " + QPSText.Text + "\n" + ImplementationAdheres.Text + " : " + ImplementationAdheresRadio.SelectedItem.Value.ToString() + "\n" +
                Label_IssueType.Text + " : " + DropDownList_DataType.SelectedItem.Value.ToString() + "\n" +
                FormCodeVerification.Text + " : " + FormCodeVerificationRadioButton.SelectedItem.Value.ToString() + "\n" +
                FormCode.Text + " : " + FormCodeText.Text + "\n" + BingService.Text + " : " + BingServiceRadio.SelectedItem.Value.ToString() + "\n" +
                Mention.Text + " : " + TextMention.Text + "\n" + ScenarioLabel.Text + " : " + ScenarioLabelText.Text + "\n";
            message.contactAlias = this.ContactTextBox.Text + ";" + this.TeamContactTextBox.Text;
            try
            {
                ICMWorkItemInit.configSetOnBoarding(message);
            }
            catch (Exception ex)
            {
                ICMWorkItemInit.WriteLog(ex.ToString(), true);
                throw;
            }
        }
    }
    public class icmDataMail
    {
        public string From;
        public string To;
        public string Cc;
        public string Subject;
        public string Body;
    }

}