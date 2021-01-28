using System;
using System.IO;
using System.Linq;
using System.Web;


namespace IcmTool
{
    public partial class UploadFiles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }

        }

        protected void UploadBtn_Click(object sender, EventArgs e)
        {

            if (FileUploadControl.HasFile)
            {
                int filecount = 0;
                int fileuploadcount = 0;
                //check No of Files Selected  
                filecount = FileUploadControl.PostedFiles.Count();
                if (filecount <= 10)
                {
                    foreach (HttpPostedFile postfiles in FileUploadControl.PostedFiles)
                    {
                        //Get The File Extension  
                        string filetype = Path.GetExtension(postfiles.FileName);
                        //Get The File Size In Bite  
                        double filesize = postfiles.ContentLength;
                        if (filesize <= (1000000))
                        {
                            try
                            {
                                string filename = Path.GetFileName(postfiles.FileName);
                                bool exists = System.IO.Directory.Exists(HttpContext.Current.Server.MapPath("~/Uploads/"));
                                if (!exists)
                                    System.IO.Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/Uploads/"));
                                FileUploadControl.SaveAs(Server.MapPath("~/Uploads/") + filename);
                                fileuploadcount++;
                            }
                            catch (Exception ex)
                            {
                                ICMWorkItemInit.WriteLog(ex.ToString(), true);
                            }
                        }
                    }
                    if (filecount == fileuploadcount)
                    {
                        Statuslabel.Visible = true;
                        Statuslabel.ForeColor = System.Drawing.Color.Blue;
                        Statuslabel.Text = "All file uploaded successfully, number of filesuploaded=" + fileuploadcount;
                    }
                    else if(fileuploadcount > 0)
                    {
                        Statuslabel.Visible = true;
                        Statuslabel.ForeColor = System.Drawing.Color.Red;
                        Statuslabel.Text = "Some file could not be uploaded, number of filesuploaded=" + fileuploadcount + " , maximum allowed file size is 1mb.";
                    }
                    else if (fileuploadcount== 0)
                    {
                        Statuslabel.Visible = true;
                        Statuslabel.ForeColor = System.Drawing.Color.Red;
                        Statuslabel.Text = "No files uploaded, maximum allowed file size is 1mb.";
                    }
                }
                if (filecount > 10)
                {
                    Statuslabel.Visible = true;
                    Statuslabel.ForeColor = System.Drawing.Color.Red;
                    Statuslabel.Text = "Maximum number of files that can be uploaded at a time is 10.";
                }
            }
        }
    }
}