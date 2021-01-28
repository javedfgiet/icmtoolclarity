<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Acknowledgement.aspx.cs" Inherits="IcmTool.Acknowledgement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="well" style="padding-left: 2%; padding-top: 4%; padding-bottom: 4%; width: 90%; margin: 20px auto; text-align: left; position: relative; border: 0 none; border-radius: 3px; box-shadow: 0 0 15px 1px rgba(0, 0, 0, 0.4); box-sizing: border-box; background-color: white">
        <div class="panel panel-default" style="background-color: white; color: #097F6F">
            <div class="panel-body">
                <div class="row form-group no-gutter" style="padding-top: 0%">
                    <div class="col-lg-1" style="padding-top: 10px">
                        <asp:Image runat="server" src="Images/bingapilogo.jpg" />
                    </div>
                    <div class="col-lg-11">
                        <h2 style="padding-left: 22%"><b>Search Partner Support Request</b></h2>
                    </div>
                </div>
                <div style="text-align: center; padding-bottom: 0%">
                    <asp:SiteMapPath ID="SiteMapPath1" runat="server"></asp:SiteMapPath>
                </div>
            </div>
        </div>
        <div class="panel panel-default" style="background-color: white; color: #097F6F">
            <div class="panel-body">
                <div style="font-size: 16px">
                    Request with ID:<asp:Label runat="server" ID="IncidentId" Font-Bold="true"></asp:Label>
                    created successfully.
        Visit
        <asp:HyperLink runat="server" ID="IncidentLink" Target="_blank">this link</asp:HyperLink>
                    to track the progress or to add more details to your request.<br />
                    Also save the link for any future reference.
                </div>
            </div>
        </div>
    </div>
    <footer style="padding-bottom: 0px; padding-top: 17%">
        <hr />
        <div style="text-align: center;">
            <p><b>&copy;-Search Partner Support</b></p>
            <p>Contact us @:
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="mailto:spbsupp@microsoft.com" Text="spbsupp@microsoft.com" ForeColor="White"></asp:HyperLink></p>
        </div>
    </footer>
</asp:Content>
