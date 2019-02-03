<%@ Page Title="" Language="C#" MasterPageFile="~/DSED08.master" AutoEventWireup="true" CodeFile="contact-us.aspx.cs" Inherits="contact_us_buzz_value" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!--breadcrumb here-->
    <div class="container">
        <div class="panel">
            <div class="row">
                <div class="col-sm-12">
                    <ol class="breadcrumb">
                        <li><a href="Default.aspx">Home</a></li>
                        <li><a href="contact-us.aspx" class="active">Contact Us</a></li>
                    </ol>
                </div>
                <%--<div class="col-sm-6 text-right">
                    <div class="breadcrumb">
                        <a href="Default.aspx">
                            <i class="fa fa-angle-double-left"></i> Back to previous page
                        </a>
                    </div>
                </div>--%>
            </div>
        </div>
    </div>
    <!--contact page-->
    <div class="contact-us">
        <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    <div class="panel">
                        <div class="section">
                            <br />
                            <br />
                            <br />
                            <h1>Contact Info</h1>
                            <div class="information">
                                <ul>
                                    <li><span class="icon-soc"><i class="fa fa-phone-square"></i></span><span class="right-write"><a href="telto:+64800848411">+64 800 84 84 11</a><br />
                                        <br />
                                    </span></li>
                                    <li><span class="icon-soc"><i class="fa fa-envelope"></i></span><span class="right-write"><a href="mailto:info@DSED08.co.nz">info@DSED08.co.nz</a><br />
                                        <br />
                                    </span></li>
                                    <li><span class="icon-soc"><i class="fa fa-location-arrow" aria-hidden="true"></i></span><span class="right-write">PO Box 258052, Botany,<br />
                                        Auckland 2163,<br />
                                        New Zealand.</span></li>
                                </ul>
                            </div>
                           <%-- <br />
                            <br />
                            <div class="social-media-contact">
                                <a href="#"><i class="fa fa-twitter"></i></a>
                                <a href="#"><i class="fa fa-facebook"></i></a>
                                <a href="#"><i class="fa fa-google-plus"></i></a>
                                <a href="#"><i class="fa fa-hacker-news"></i></a>
                                <a href="#"><i class="fa fa-pinterest-p"></i></a>
                                <a href="#"><i class="fa fa-linkedin"></i></a>
                            </div>--%>
                        </div>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="map">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d51063.24343843914!2d174.7440634!3d-36.8795167!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x6d0d47fb5a9ce6fb%3A0x500ef6143a29917!2sAuckland%2C+New+Zealand!5e0!3m2!1sen!2sin!4v1494410923844" height="367" frameborder="0" style="border: 0; width: 100%;" allowfullscreen></iframe>
                    </div>
                </div>
            </div>
            <div class="panel">
                <div class="section">
                    <h1>GET IN TOUCH WITH US</h1>
                    <div class="row">
                        <div class="col-sm-6 wow zoomInDown" data-wow-duration="1s">
                            <div class="form-group">
                                <asp:TextBox ID="tbx_Name" CssClass="form-control" runat="server" MaxLength="50" placeholder="Your Name *"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbx_Name" ErrorMessage="Your Name" Display="None" ValidationGroup="vgContact" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-6 wow zoomInDown" data-wow-duration="1s">
                            <div class="form-group">
                                <asp:TextBox ID="tbx_Email" runat="server" CssClass="form-control" MaxLength="50" placeholder="Your Email *"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="Regexp1" runat="server" ControlToValidate="tbx_Email" ErrorMessage="Invalid Email Address" Display="None" ValidationGroup="vgContact" SetFocusOnError="true" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="tbx_Email" ErrorMessage="Your Email" Display="None" ValidationGroup="vgContact" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="col-sm-6 wow zoomInDown" data-wow-duration="1s">
                            <div class="form-group">
                                <asp:TextBox ID="tbx_ContactNo" CssClass="form-control inquire-input" runat="server" MaxLength="15" placeholder="Your Contact Number *"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbx_ContactNo" ErrorMessage="Your Contact Number" Display="None" ValidationGroup="vgContact" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" ValidChars="0123456789+-" FilterMode="ValidChars" TargetControlID="tbx_ContactNo"></asp:FilteredTextBoxExtender>
                            </div>
                        </div>
                        <div class="col-sm-6 wow zoomInDown" data-wow-duration="1s">
                            <div class="form-group">
                                <asp:TextBox ID="txtSubject" CssClass="form-control" runat="server" MaxLength="50" placeholder="Your Subject "></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-sm-12 wow zoomInDown" data-wow-duration="1s">
                            <div class="form-group">
                                <asp:TextBox ID="txtComment" runat="server" CssClass="form-control multiline" TextMode="MultiLine" Rows="3" placeholder="Message"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-sm-2 wow zoomInDown" data-wow-duration="1s">
                            <label for="captchaCode" class="control-label">
                                <asp:Image ID="imgCaptcha" runat="server" alt="" Width="110" Height="45" />
                                <asp:HiddenField ID="hfVerification" runat="server" ClientIDMode="Static" />
                            </label>
                        </div>
                        <div class="col-sm-4 wow zoomInDown" data-wow-duration="1s">
                            <div class="form-group">
                                <asp:TextBox ID="tbx_ContactSecure" runat="server" CssClass="form-control" placeholder="Enter Code Here *" MaxLength="5" ClientIDMode="Static"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="tbx_ContactSecure" ErrorMessage="Security Code" ValidationGroup="vgContact" Display="None"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="costomvalid" runat="server" ControlToValidate="tbx_ContactSecure" ErrorMessage="Value entered doesn't match with the picture, try again" ClientValidationFunction="CheckVarification" ValidationGroup="vgContact" Display="None"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="col-sm-6 text-right wow zoomInDown buttton-file" data-wow-duration="1s">
                            <asp:Literal ID="lbl_Error" runat="server"></asp:Literal>
                            <asp:LinkButton ID="btn_Submit" runat="server" CssClass="btn btn-default" Text="Submit" ValidationGroup="vgContact" OnClick="btn_Submit_Click"></asp:LinkButton>
                            <asp:ValidationSummary ID="ValidationSummary2" runat="server" HeaderText="The system recognized faulty entries for the following fields:"
                                ShowMessageBox="True" ShowSummary="False" ValidationGroup="vgContact" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extraJs" runat="Server">
    <script>
        function CheckVarification(source, arguments) {
            var valcode = document.getElementById("hfVerification");
            var valtext = document.getElementById("tbx_ContactSecure");
            var count = 0;

            if (valcode.value == valtext.value) {
                count++;
            }

            if (count > 0) {
                arguments.IsValid = true;
                return;
            }
            else
                arguments.IsValid = false;
        }


    </script>
</asp:Content>

