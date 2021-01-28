<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadFiles.aspx.cs" Inherits="IcmTool.UploadFiles" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form">

            <div class="form-group">

                <asp:FileUpload ID="FileUploadControl" runat="server" AllowMultiple="true" Width="90%" />


                <asp:Button class="btn btn-primary form-control" ID="UploadButton" OnClick="UploadBtn_Click" runat="server" Text="Upload" />
                <br />
                <br />

                <asp:Label ID="Statuslabel" runat="server"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
