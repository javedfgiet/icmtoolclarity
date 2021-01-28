using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IcmTool
{
    public partial class Acknowledgement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["incidentid"]))
            {
                IncidentId.Text = Request.QueryString["incidentid"];
                IncidentLink.NavigateUrl = string.Format("https://icm.ad.msft.net/imp/v3/incidents/details/{0}/home", Request.QueryString["incidentid"]);
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }
        }
    }
}