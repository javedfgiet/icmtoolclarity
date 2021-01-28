<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OnBoardingForm.aspx.cs" Inherits="IcmTool.OnBoardingForm" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/Custom.css" rel="stylesheet" />
    <link href="Content/Site.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.12.4.min.js"></script>
    <script src="Scripts/jquery.easing.1.3.js"></script>
    <script src="Scripts/OnBaordingScript.js"></script>

    <div class="well" style="padding-left: 2%; width: 90%; margin: 2% auto; text-align: left; position: relative; border: 0 none; border-radius: 3px; box-shadow: 0 0 15px 1px rgba(0, 0, 0, 0.4); box-sizing: border-box; background-color: white">
        <div class="panel panel-default" style="background-color: white;color:#097F6F">
            <div class="panel-body">
                <div class="row form-group no-gutter" style="padding-top: 0%">
                    <div class="col-lg-1" style="padding-top: 10px">
                        <asp:Image runat="server" src="Images/bingapilogo.jpg" />
                    </div>
                    <div class="col-lg-11">
                        <h2 style="padding-left: 22%"><b>Partner Intake Form for Bing APIs</b></h2>
                    </div>
                </div>
                <div style="text-align:center; padding-bottom: 0%">
                    <asp:SiteMapPath ID="SiteMapPath1" runat="server"></asp:SiteMapPath>
                </div>
            </div>
        </div>
        
                <fieldset>
                    <div class="row form-group ">
                        <div class="col-lg-4">
                            <asp:Label ID="LabelTeamName" runat="server" Font-Bold="true" Text="Team Name & Division" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="TextTeamName" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="please enter your Team Name & Division " placeholder="Team Name & Division "></asp:TextBox>
                        </div>             
                    </div>
                    <div class="row form-group ">
                    <div class="col-lg-4">
                            <asp:Label ID="Contact" runat="server" Font-Bold="true" Text="Partner Contact Name" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="ContactTextBox" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Partner Contact Name." placeholder="Partner Contact Name"></asp:TextBox>
                        </div>  
                        </div>

                    <div class="row form-group">
                     <div class="col-lg-4">
                            <asp:Label ID="POCContact" runat="server" Text="POC Email Address" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="POCContactText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Search Team Contact" placeholder="Search Team Contact"></asp:TextBox>
                        </div> 
                        </div>

                     <div class="row form-group ">
                        <div class="col-lg-4">
                            <asp:Label ID="TeamContact" Font-Bold="true" runat="server" Text="Team Alias Email" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="TeamContactTextBox" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Team Alias Email." placeholder="Team alias"></asp:TextBox>
                        </div>             
                    </div>
                     
                    <div class="row form-group">
                        <div class="col-lg-4">
                            <asp:Label ID="ProjectOverView" runat="server" Text="Project Overview" class="control-label" Style="color: #097F6F; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="ProjectOverViewText" name="Project Overview" autocomplete="off" class="form-control" Style="width: 100%; height: 120px" TextMode="MultiLine" ToolTip="Please enter Project Overview." placeholder="Please enter Project Overview."></asp:TextBox>
                        </div>
                    </div>
                    <!--<div class="row form-group ">
                        <div class="col-lg-4">
                            <asp:Label ID="ProjectWebsite" runat="server" Text="Project Website" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="ProjectWebsiteText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Project Website" placeholder="Project Website"></asp:TextBox>
                        </div>              
                    </div>-->
                    <div class="row form-group ">
                        <div class="col-lg-4">
                            <asp:Label ID="ProjectReleaseDates" runat="server" Text="Project Release Dates" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">

                            <asp:Calendar ID="ProjectReleaseCalendar" runat="server" BackColor="White" BorderColor="Black" BorderStyle="Solid" CellSpacing="1" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="231px" NextPrevFormat="ShortMonth" Width="260px" ShowGridLines="True" UseAccessibleHeader="False" VisibleDate="2017-11-11">
                                <DayHeaderStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" Height="8pt" />
                                <DayStyle BackColor="#CCCCCC" />
                                <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="White" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <SelectedDayStyle BackColor="#097F6F" ForeColor="White" />
                                <TitleStyle BackColor="#097F6F" BorderStyle="Solid" Font-Bold="True" Font-Size="12pt" ForeColor="White" Height="12pt" />
                                <TodayDayStyle BackColor="#999999" ForeColor="White" />
                            </asp:Calendar>
                           <!-- <asp:TextBox runat="server" ID="ProjectReleaseDatesText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Project Release Dates" placeholder="Project Release Dates"></asp:TextBox>-->
                        </div>               
                    </div>
                    <div class="row form-group ">
                        <div class="col-lg-4">
                            <asp:Label ID="DistributionMethod" runat="server" Text="What is the distribution method for your product/service/application" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:CheckBoxList ID="DistributionMethodCheckBoxList" runat="server" Style="color: #5c5c5c; text-align: left; font-weight: bold">
                                <asp:ListItem Value="Microsoft internal use only">Microsoft internal use only</asp:ListItem>
                                <asp:ListItem Value="Microsoft consumer devices"> Microsoft consumer devices</asp:ListItem>
                                <asp:ListItem Value="Microsoft enterprise/consumer software">Microsoft enterprise/consumer software</asp:ListItem>
                                <asp:ListItem Value="2nd party, 3rd party or OEM services/devices">2nd party, 3rd party or OEM services/devices</asp:ListItem>
                                <asp:ListItem Value="Public distribution of libraries through GitHub or similar">Public distribution of libraries through GitHub or similar</asp:ListItem>
                                <asp:ListItem Value="Other package distribution outside Microsoft">Other package distribution outside Microsoft.</asp:ListItem>
                            </asp:CheckBoxList>
                            <asp:Label ID="DistributionMethodLabel" runat="server" Text="If Other, please specify" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold" Visible="True"></asp:Label>
                            <asp:TextBox runat="server" ID="DistributionMethodText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="please specify" placeholder="Please specify" Visible="True"></asp:TextBox>
                        </div>             
                                      
                    </div>
                    <div class="row form-group ">
                        
                        <div class="col-lg-4">
                            <asp:Label ID="MarketList" runat="server" Text="List the Markets/countries where Bing results will be shown" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="MarketListText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="List the Markets/countries where Bing results will be shown" placeholder="List the Markets/countries where Bing results will be shown"></asp:TextBox>
                        </div>               
                    </div>

                    <div class="row form-group ">
                        <div class="col-lg-4">
                            <asp:Label ID="QPM" runat="server" Text="Estimate the query volume per month by market" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="QPMText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Estimate the query volume per month by market" placeholder="Estimate the query volume per month by market"></asp:TextBox>
                        </div>
                          
                    </div>
                    <!--<div class="row form-group ">
                       <div class="col-lg-4">
                            <asp:Label ID="ProjectGrowth" runat="server" Text="Projected growth in query volume over time by market" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="ProjectGrowthText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Projected growth in query volume over time by market" placeholder="Projected growth in query volume over time by market"></asp:TextBox>
                        </div>               
                    </div>-->
                    <div class="row form-group ">
                       <div class="col-lg-4">
                            <asp:Label ID="QPS" runat="server" Text="Estimate the peak queries per second to be sent to search" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="QPSText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Estimate the peak queries per second to be sent to search" placeholder="Estimate the peak queries per second to be sent to search"></asp:TextBox>
                        </div>               
                    </div>
                   <!-- <div class="row form-group ">
                       <div class="col-lg-4">
                            <asp:Label ID="ProjectRevenue" runat="server" Text="Projected Revenue from Ads" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="ProjectRevenueText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Projected Revenue from Ads" placeholder="Projected Revenue from Ads"></asp:TextBox>
                        </div>               
                    </div>-->
                   <!-- <div class="row form-group ">
                       <div class="col-lg-4">
                            <asp:Label ID="ProjectExplicit" runat="server" Text="Projected Explicit True Search Share" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="ProjectExplicitText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Projected Explicit True Search Share" placeholder="Projected Explicit True Search Share"></asp:TextBox>
                        </div>               
                    </div>-->
                    <div class="row form-group ">
                       <div class="col-lg-4">
                            <asp:Label ID="ImplementationAdheres" runat="server" Text="Please ensure your implementation adheres to the" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                           <asp:HyperLink runat="server" ID="guidline" Target="_blank" NavigateUrl="http://download.microsoft.com/download/0/4/E/04E076D4-60B2-4D31-BCC7-C4805B558DBB/Bing product guidelines.pdf">Bing Product Guidelines.</asp:HyperLink>
                        </div>
                        <div class="col-lg-8">
                            <asp:RadioButtonList ID="ImplementationAdheresRadio" runat="server"  RepeatDirection="Vertical" CssClass="fs-subtitle" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold">
                                        <asp:ListItem Text="Accept:" Value="Accepted" ></asp:ListItem>
                                        <asp:ListItem Text="Not Accept:" Value="Not Accepted" ></asp:ListItem>
                                </asp:RadioButtonList>
                        </div>               
                    </div>
                    <!--<div class="row form-group ">
                       <div class="col-lg-4">
                            <asp:Label ID="TermOfUseLabel" runat="server" Text="We assume the standard" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                           <asp:HyperLink runat="server" ID="TermsOfUse" Target="_blank" NavigateUrl="https://datamarket.azure.com/dataset/5BA839F1-12CE-4CCE-BF57-A49D98D29A44#terms">Terms Of Use</asp:HyperLink>
                           <asp:Label ID="TOUText" runat="server" Text="will apply and your project will be in compliance with our terms." class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:RadioButtonList ID="TermOfUseLabelRadio" runat="server"  RepeatDirection="Horizontal" CssClass="fs-subtitle" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold">
                                        <asp:ListItem Text="Accept:" Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="Not Accept:" Value="2" ></asp:ListItem>
                                </asp:RadioButtonList>
                        </div>               
                    </div>-->
                    <!--<div class="row form-group ">
                       <div class="col-lg-4">
                            <asp:Label ID="APIPlatform" runat="server" Text="Which API platform is being considered?" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:RadioButtonList ID="APIPlatformRadio" runat="server"  RepeatDirection="Horizontal" CssClass="fs-subtitle" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold">
                                        <asp:ListItem Text="API V6:" Value="1" ></asp:ListItem>
                                        <asp:ListItem Text="API V7:" Value="2" ></asp:ListItem>
                                </asp:RadioButtonList>
                        </div>               
                    </div>-->
                    <div class="row form-group ">
                       <div class="col-lg-4">
                            <asp:Label ID="Label_IssueType" runat="server" Text="What Data Types are being considered for use?" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:DropDownList ID="DropDownList_DataType" runat="server" class="form-control" Style="width: 100%" ToolTip="Please select the issue type.">
                               <asp:ListItem Value="Choose Data Type">Choose Data Type</asp:ListItem>
                                 <asp:ListItem Value="Web">Web</asp:ListItem>
                                  <asp:ListItem Value="Video">Video</asp:ListItem>
                                  <asp:ListItem Value="Images">Images</asp:ListItem>
                                  <asp:ListItem Value="Related Queries">Related Queries</asp:ListItem>
                                  <asp:ListItem Value="Spelling Suggestions for query terms ">Spelling Suggestions for query terms </asp:ListItem>
                                  <asp:ListItem Value="Ads">Ads</asp:ListItem>
                                 <asp:ListItem Value="Other (Autosuggest, Local, etc)">Other (Autosuggest, Local, etc)</asp:ListItem>
                            </asp:DropDownList>
                            
                        </div>               
                    </div>           
          
                   <!-- <div class="row form-group ">
                        <div class="col-lg-4">
                            <asp:Label ID="Scenario" runat="server" Text="Does your scenario require you to consume multiple Data types?" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="ScenarioText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Does your scenario require you to consume multiple Data types?" placeholder="Multiple Data Type "></asp:TextBox>
                        </div>             
                    </div>-->
                    <div class="row form-group ">
                    <div class="col-lg-4">
                            <asp:Label ID="FormCodeVerification" runat="server" Text="Do you have an AppId and/or FORMCode?" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:RadioButtonList ID="FormCodeVerificationRadioButton" runat="server"  RepeatDirection="Vertical" CssClass="fs-subtitle" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold">
                                        <asp:ListItem Text="Yes:" Value="Yes"></asp:ListItem>
                                        <asp:ListItem Text="No" Value="No" ></asp:ListItem>
                                        
                                </asp:RadioButtonList>
                            <asp:Label ID="FormCode" runat="server" Text="If Yes, then please mention it" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                            <asp:TextBox runat="server" ID="FormCodeText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Mention" placeholder="Mention the FormCode/AppID"></asp:TextBox>
                        </div>   
                        </div>
                    <!--<div class="row form-group ">
                        <div class="col-lg-4">
                            <asp:Label ID="TypeOfApplication" runat="server" Text="List the types of application(s) to be supported" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="TypeOfApplicationText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="List the types of application(s) to be supported." placeholder="List the types of application(s) to be supported"></asp:TextBox>
                        </div>             
                    </div>-->
                    <div class="row form-group">
                     <div class="col-lg-4">
                            <asp:Label ID="BingService" runat="server" Text="Where will the Bing APIs be called from?" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:RadioButtonList ID="BingServiceRadio" runat="server"  RepeatDirection="Vertical" CssClass="fs-subtitle" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold">
                                        <asp:ListItem Text="Server Side (Preferred):" Value="Server Side"></asp:ListItem>
                                        <asp:ListItem Text="Client Side:" Value="Client Side" ></asp:ListItem>
                                        <asp:ListItem Text="Others:" Value="Others"></asp:ListItem>
                                </asp:RadioButtonList>
                            <asp:Label ID="Mention" runat="server" Text="If others, then please mention it" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                            <asp:TextBox runat="server" ID="TextMention" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Mention" placeholder="Mention the other source from where APIs will be called"></asp:TextBox>
                        </div> 
                        </div>
                   <!-- <div class="row form-group">
                        <div class="col-lg-4">
                            <asp:Label ID="TypeOfQueries" runat="server" Text="What types of queries will be sent?" class="control-label" Style="color: #097F6F; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="TypeOfQueriesText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="What types of queries will be sent?" placeholder="What types of queries will be sent?"></asp:TextBox>
                        </div>
                        </div> 
                    <div class="row form-group ">
                       <div class="col-lg-4">
                            <asp:Label ID="ListOfPerson" runat="server" Text="Please list the name of the person who will sign off that queries are user initiated and not automated and that use complies with our" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                           <asp:HyperLink runat="server" ID="ListOfPersonHyperLink1" Target="_blank" NavigateUrl="http://www.bing.com/developers/tou.aspx">Terms of Use</asp:HyperLink>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="ListOfPersonText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Name of the person" placeholder="Name of the person"></asp:TextBox>
                        </div> 
                        </div>           
                    <div class="row form-group ">
                        <div class="col-lg-4">
                            <asp:Label ID="ProjectReleaseDate" runat="server" Text="Project Release Dates" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="ProjectReleaseDateText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Project Release Dates" placeholder="Project Release Dates"></asp:TextBox>
                        </div>               
                    </div>-->
                    <div class="row form-group ">
                        <div class="col-lg-4">
                            <asp:Label ID="ScenarioLabel" runat="server" Text="Scenarios" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="ScenarioLabelText" name="Scenarios" autocomplete="off" class="form-control" Style="width: 100%; height: 120px" TextMode="MultiLine" ToolTip="Scenarios." placeholder="Scenarios."></asp:TextBox>
                        </div>
                                      
                    </div>
                    
                  <!--  <div class="row form-group ">
                        <div class="col-lg-4">
                            <asp:Label ID="ProductionIP" runat="server" Text="Provide your Production IP Addresses" class="control-label" Style="color: #097F6F; text-align: left; font-weight: bold"></asp:Label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox runat="server" ID="ProductionIPText" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Provide your Production IP Addresses" placeholder="Provide your Production IP Addresses"></asp:TextBox>
                        </div>               
                    </div>-->
                     
                                <asp:Button ID="Submit" class="previous action-button" type="submit" value="Submit" runat="server" Text="Submit" OnClientClick="DisableButtons" OnClick="Submit_Click" />               
                               
                    <div class="row form-group">
                        <div class="Label" style="padding-top: 5px; text-align: center">
                            <asp:Label ID="Label_Message" runat="server" ForeColor="red"></asp:Label>
                        </div>
                    </div>
                    <div class="col-lg-8">
                            <asp:Textbox runat="server" ID="TextHidden" autocomplete="off" class="form-control" Style="width: 100%; padding-left: 5px" ToolTip="Project Release Dates" placeholder="Project Release Dates" Visible="false"></asp:Textbox>
                        </div>
                    </fieldset>
       <div runat="server" id="heading" align=center style=text-align:center;background-color:#097F6F; visible="false">Partner Intake Form</div>
        
           </div>    

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
        </div>
    </footer>

</asp:Content>

