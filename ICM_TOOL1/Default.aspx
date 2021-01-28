<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="IcmTool._Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <link href="Content/Custom.css" rel="stylesheet" />

    <script type="text/javascript">
        function DisableButtons() {
            var inputs = document.getElementsByTagName("INPUT");
            for (var i in inputs) {
                if (inputs[i].type == "button" || inputs[i].type == "submit") {
                    inputs[i].disabled = true;
                }
            }
            document.getElementById('<%=Label_Message.ClientID %>').style.display = 'none';
        }
        window.onbeforeunload = DisableButtons;
    </script>

    <div class="well" style="padding-left: 2%; width: 90%; margin: 2% auto; text-align: left; position: relative; border: 0 none; border-radius: 3px; box-shadow: 0 0 15px 1px rgba(0, 0, 0, 0.4); box-sizing: border-box; background-color: white">
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

        <div class="panel panel-default" style="background-color: white">
            <div class="panel-body">
                <fieldset>
                    <div class="row form-group ">
                        <div class="col-lg-2">
                            <asp:Label ID="Label_ApiType" runat="server" Text="API*" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>

                        <div class="col-lg-4">
                            <asp:DropDownList ID="DropDownList_ApiType" runat="server" class="form-control" Style="width: 100%" ToolTip="Please select the API type,if you are not sure select other.">
                                <asp:ListItem Value="0" Selected="True">Select API Type</asp:ListItem>
                                <asp:ListItem Value="1">Bing Autosuggest API</asp:ListItem>
                                <asp:ListItem Value="2">Bing Custom Search API</asp:ListItem>
                                <asp:ListItem Value="3">Bing Entity Search API</asp:ListItem>
                                <asp:ListItem Value="4">Bing Image Search API</asp:ListItem>
                                <asp:ListItem Value="5">Bing Knowledge Graph API (Private)</asp:ListItem>
                                <asp:ListItem Value="6">Bing News Search API</asp:ListItem>
                                <asp:ListItem Value="7">Bing Spell Check API</asp:ListItem>
                                <asp:ListItem Value="8">Bing Video Search API</asp:ListItem>
                                <asp:ListItem Value="9">Bing Web Search API</asp:ListItem>
                                <asp:ListItem Value="10">Other</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorAPI" runat="server" ErrorMessage="*Please select API type." ForeColor="red" ControlToValidate="DropDownList_ApiType" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="col-lg-2">
                            <asp:Label ID="Label_IssueType" runat="server" Text="Issue Type*" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-4">
                            <asp:DropDownList ID="DropDownList_IssueType" runat="server" class="form-control" Style="width: 100%" ToolTip="Please select the issue type.">
                                <asp:ListItem Value="0" Selected="True">Select the issue type</asp:ListItem>
                                <asp:ListItem Value="1">Bug</asp:ListItem>
                                <asp:ListItem Value="2">Technical issue</asp:ListItem>
                                <asp:ListItem Value="3">Terms of Use</asp:ListItem>
                                <asp:ListItem Value="4">Pricing</asp:ListItem>
                                <asp:ListItem Value="5">Feature request</asp:ListItem>
                                <asp:ListItem Value="6">General Inquiry</asp:ListItem>
                                <asp:ListItem Value="7">Documentation</asp:ListItem>
                                <asp:ListItem Value="8">Other</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorIssueType" runat="server" ErrorMessage="*Please select issue type." ForeColor="red" ControlToValidate="DropDownList_IssueType" InitialValue="0" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="row form-group">
                        <div class="col-lg-2">
                            <asp:Label ID="Severity" runat="server" Text="Severity" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-4">
                            <asp:DropDownList ID="DropDownList_Severity" runat="server" class="form-control" Style="width: 100%" ToolTip="Please select the severity of the issue,default severity is low.
                            
High: Defects resulting in system unavailable,crash,unrecoverable data corruption,inability to perform core business etc.

Medium: Defects resulting in system not operation per specification with severity less than High,Low likelihood of data corruption or loss,clear workaround available.

Low: Defects resulting in system working but with minor issues,workaround may or may not available.
">
                                <asp:ListItem Value="3" Selected="True">Low</asp:ListItem>
                                <asp:ListItem Value="2">Medium</asp:ListItem>
                                <asp:ListItem Value="1">High</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-lg-2">
                            <asp:Label ID="Label_Contact" runat="server" Text="Contact*" class="" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-4">
                            <asp:TextBox runat="server" ID="ContactTextBox" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="please enter your microsoft alias, eg.. redmond\alias." placeholder="Domain\Alias"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorContactBox" runat="server" ErrorMessage="*Please enter correct domain and alias." ForeColor="red" ControlToValidate="ContactTextBox" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="CustomValidatorContact" runat="server" ErrorMessage="*Please enter correct domain and alias." ForeColor="red" OnServerValidate="CustomValidator_DoesUserExist" ControlToValidate="ContactTextBox" ValidateEmptyText="True" Display="Dynamic"></asp:CustomValidator>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-lg-2">
                            <asp:Label ID="Label_TeamContact" runat="server" Text="Team Contact*" class="" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-4">
                            <asp:TextBox runat="server" ID="TeamContactTextBox" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="please enter your team alias." placeholder="YourTeamAlias@microsoft.com"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorTeamContact" runat="server" ErrorMessage="*Please enter team alias." ForeColor="red" ControlToValidate="TeamContactTextBox" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidatorTeamContact" runat="server" ErrorMessage="*Please enter correct Microsoft team alias." ForeColor="red" ControlToValidate="TeamContactTextBox" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@microsoft.com"></asp:RegularExpressionValidator>
                        </div>
                    </div>

                </fieldset>
            </div>
        </div>

        <div class="panel panel-default" style="background-color: white">
            <div class="panel-body">

                <fieldset>
                    <div class="row form-group">
                        <div class="col-lg-2">
                            <asp:Label ID="Label_Title" runat="server" Text="Title*" class="control-label" Style="color: #097F6F; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-10">
                            <asp:TextBox runat="server" ID="TextBoxTitle" autocomplete="off" class="form-control" Style="width: 100%;" placeholder="Please enter issue title." ToolTip="Please enter issue title." MaxLength="150"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorTitle" runat="server" ErrorMessage="*Please enter issue title." ForeColor="red" ControlToValidate="TextBoxTitle" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-lg-2">
                            <asp:Label ID="Label_AppID" runat="server" Text="AppId" class="control-label" Style="color: #097F6F; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-10">
                            <asp:TextBox runat="server" ID="TextBoxAppId" autocomplete="off" class="form-control" Style="width: 100%;" placeholder="Please enter your related AppId if you have one." ToolTip="Please enter your related AppId if you have one." MaxLength="100"></asp:TextBox>
                            <asp:CustomValidator ID="CustomValidatorAppId" runat="server" ErrorMessage="*Please enter correct AppID." ForeColor="red" OnServerValidate="CustomValidator_ServerAppIDValidate" ControlToValidate="TextBoxAppId" ValidateEmptyText="True" Display="Dynamic"></asp:CustomValidator>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-lg-2">
                            <asp:Label ID="Label_Description" runat="server" Text="Description*" class="control-label" Style="color: #097F6F; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-10">
                            <asp:TextBox runat="server" ID="TextArea_Description" name="TextArea_Description" autocomplete="off" class="form-control" Style="width: 100%; height: 120px" TextMode="MultiLine" ToolTip="Please enter issue description." placeholder="Please enter issue description."></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorDescription" runat="server" ErrorMessage="*Please enter issue description." ForeColor="red" ControlToValidate="TextArea_Description" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="row form-group">
                        <div class="col-lg-2">
                            <asp:Label ID="Label_ReproSteps" runat="server" Text="Repro Steps" class="control-label" Style="color: #097F6F; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-10">
                            <asp:TextBox runat="server" ID="TextArea_ReproSteps" name="TextArea_ReproSteps" autocomplete="off" class="form-control" Style="width: 100%; height: 120px" TextMode="MultiLine" ToolTip="Please enter repro steps." placeholder="Please enter repro steps."></asp:TextBox>
                            <asp:CustomValidator ID="CustomValidatorReproSteps" runat="server" ErrorMessage="*Please enter repro steps." ForeColor="red" OnServerValidate="CustomValidator_ServerValidate" ControlToValidate="TextArea_ReproSteps" ValidateEmptyText="True" Display="Dynamic"></asp:CustomValidator>
                        </div>
                    </div>

                    <div class="row form-group">
                        <div class="col-lg-2">
                        </div>
                        <div class="col-lg-8">
                            <asp:Label ID="Label_Attachment" runat="server" Text="Attachment" class="control-label" Style="color: #097F6F; float: left; font-weight: bold"></asp:Label>
                            <asp:ImageButton ID="ImageButton" runat="Server" ImageUrl="~/Images/Attach.ico" Style="height: 20px; padding-left: 10px; float: left" ToolTip="Add attachment if you have any." CausesValidation="False" />
                        </div>
                    </div>

                    <div class="row no-gutter">
                        <div class="col-lg-4 col-md-4"></div>
                        <div class="col-lg-2 col-md-2">
                            <div style="padding-left: 20%; padding-top: 10px">
                                <asp:Button ID="Submit" class="btn" type="submit" value="Submit" Style="background-color: #097F6F; color: white; float: inherit; width: 70%;" runat="server" Text="Submit" OnClick="SubmitBtn_Click" OnClientClick="DisableButtons" />
                            </div>
                        </div>

                        <div class="col-lg-2 col-md-2">
                            <div style="padding-left: 20%; padding-top: 10px">
                                <asp:Button ID="Reset" class="btn" type="submit" value="Reset" Style="background-color: #097F6F; color: white; float: inherit; width: 70%;" runat="server" Text="Reset" OnClick="ResetBtn_Click" CausesValidation="False" OnClientClick="DisableButtons" />
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4"></div>

                    </div>
                    <br />
                    <br />
                    <div class="row form-group">
                        <div class="Label" style="padding-top: 5px; text-align: center">
                            <asp:Label ID="Label_Message" runat="server" ForeColor="red" Visible="false" ></asp:Label>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>

    </div>



    <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panl1" TargetControlID="ImageButton"
        CancelControlID="Button2" BackgroundCssClass="Background">
    </cc1:ModalPopupExtender>

    <asp:Panel Title="File" ID="Panl1" runat="server" CssClass="Popup" align="center" Width="45%" Style="display: none">
        <h4 style="align-content: center; color: #097F6F">Attach File</h4>
        <hr />
        <iframe style="width: 90%; height: 40%;" id="irm1" src="UploadFIles.aspx?id=1" runat="server"></iframe>
        <br />
        <asp:Button ID="Button2" Style="background-color: #097F6F; color: white; width: 25%;" runat="server" Text="Close" CausesValidation="False" />
    </asp:Panel>
    <hr />
    <footer style="padding-bottom: 0px">
        <div style="text-align: center;">
            <p><b>&copy;-Search Partner Support</b></p>
            <p>Contact us @:
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="mailto:spbsupp@microsoft.com" Text="spbsupp@microsoft.com" ForeColor="White"></asp:HyperLink></p>
        </div>
    </footer>

</asp:Content>


