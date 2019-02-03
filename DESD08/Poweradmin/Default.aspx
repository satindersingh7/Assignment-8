<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="login" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
     <script type="text/javascript">
         function chk() {
             var username = '<%= Session["uid"] %>';
           if (username != "")
               window.location.assign("dashboard.aspx")
       }
       chk();
        </script>
     <meta charset="utf-8" /> <link rel="icon" href="<%=ConfigurationManager.AppSettings["siteurl"].ToString() %>/images/favicon.ico">
    <title>Welcome to Poweradmin</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta content="Preview page of Metronic Admin Theme #1 for " name="description" />
        <meta content="" name="author" />
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <link href="assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL STYLES -->
        <link href="assets/global/css/components-md.min.css" rel="stylesheet" id="style_components" type="text/css" />
        <link href="assets/global/css/plugins-md.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME GLOBAL STYLES -->
        <!-- BEGIN PAGE LEVEL STYLES -->
        <link href="assets/pages/css/login-3.min.css" rel="stylesheet" type="text/css" />
      <link href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" />
        <!-- END PAGE LEVEL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <!-- END THEME LAYOUT STYLES -->
</head>
 <body class=" login">
    <form id="form1" runat="server">
    

   
        <!-- BEGIN LOGO -->
        <div class="logo">
            <img src="<%=ConfigurationManager.AppSettings["siteurl"].ToString() %>/images/white-logo.png" alt="logo" class="logo-default" />
        </div>
           
        <!-- END LOGO -->
        <!-- BEGIN LOGIN -->
        <div class="content">
              <%--<div id="div_Error" runat="server" class="alert alert-danger" visible="false"><asp:Literal ID="ltr_Error" runat="server"></asp:Literal></div>
                     <div id="div_Success" runat="server" class="alert alert-success" visible="false"><asp:Literal ID="ltr_Success" runat="server"></asp:Literal></div>  --%>
            <!-- BEGIN LOGIN FORM -->
            <div class="login-form">
                <h3 class="form-title">Login to your account</h3>
              
                
                    <div class="form-group form-md-line-input form-md-floating-label">
                                     <asp:TextBox ID="txtUnm" CssClass="form-control" runat="server"  AutoComplete="off"></asp:TextBox>
                          <label class="control-label" for="username"><i class="fa fa-user"></i> Username</label> 
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUnm" ErrorMessage="Username is required" SetFocusOnError="True" ValidationGroup="log_1" Display="Dynamic"></asp:RequiredFieldValidator>                                    
                                </div>
                                <div class="form-group form-md-line-input form-md-floating-label">
                                    <asp:TextBox runat="server" ID="txtPass" CssClass="form-control placeholder-no-fix" TextMode="Password"  AutoComplete="off"></asp:TextBox> <label class="control-label" for="pass"> <i class="fa fa-lock"></i> Password</label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPass" ErrorMessage="Password is required" SetFocusOnError="True" ValidationGroup="log_1" Display="Dynamic"></asp:RequiredFieldValidator>                                    
                                </div>
                <div class="form-actions">
                    <label class="rememberme mt-checkbox mt-checkbox-outline">
                         <asp:CheckBox ID="chkRemember" runat="server" /> Remember me
                        <span></span>
                    </label>
                      <asp:Button ID="Button1"  AlternateText="Login" OnClick="btnLogIn_Click" ValidationGroup="log_1" runat="server" CssClass="btn green pull-right" Text="Login" />
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" HeaderText="You must enter a value in the following fields:" ShowMessageBox="false" ShowSummary="False" ValidationGroup="log_1" />
                            
                    
                </div>
                <div class="forget-password">
                    <h4>Forgot your password ?</h4>
                    <p> no worries, click
                        <a href="javascript:;" id="forget-password"> here </a> to reset your password. </p>
                </div>
            </div>
            <!-- END LOGIN FORM -->
            <!-- BEGIN FORGOT PASSWORD FORM -->
            <div class="forget-form">
                <asp:Panel runat="server" ID="pnlForget" DefaultButton="btn_GetPassword">
                <h3>Forget Password ?</h3>
                <p> Enter your e-mail address below to reset your password. </p>
                 <div class="form-group form-md-line-input form-md-floating-label">
                      <asp:TextBox ID="txtEmail" CssClass="form-control placeholder-no-fix" runat="server" autocomplete="off"></asp:TextBox>
                      <label for="fmail"><i class="fa fa-envelope"></i> Email</label>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic" ControlToValidate="txtEmail" ErrorMessage="Email not valid" ForeColor="Red" SetFocusOnError="True" ToolTip="Please enter Name" ValidationGroup="log_2" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email ID" SetFocusOnError="True" ValidationGroup="log_2" Display="Dynamic"></asp:RequiredFieldValidator>    
                </div>
                <div class="form-actions">
                    <button type="button" id="back-btn" class="btn grey-salsa btn-outline"> Back </button>
                      <asp:Button ID="btn_GetPassword"  AlternateText="Get Password"  ValidationGroup="log_2" runat="server" CssClass="btn green pull-right" Text="Get Password" OnClick="btn_GetPassword_Click"  />
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" HeaderText="You must enter a value in the following fields:" ShowMessageBox="False" ShowSummary="False" ValidationGroup="log_2" />
                
                </div>
                </asp:Panel>
            </div>
            <!-- END FORGOT PASSWORD FORM -->
            <!-- BEGIN REGISTRATION FORM -->
            
            <!-- END REGISTRATION FORM -->
        </div>
        <!-- END LOGIN -->
        <!--[if lt IE 9]>
<script src="assets/global/plugins/respond.min.js"></script>
<script src="assets/global/plugins/excanvas.min.js"></script> 
<script src="assets/global/plugins/ie8.fix.min.js"></script> 
<![endif]-->
        <!-- BEGIN CORE PLUGINS -->
        <script src="assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
        <!-- END CORE PLUGINS -->
        <!-- BEGIN THEME GLOBAL SCRIPTS -->
        <script src="assets/global/scripts/app.min.js" type="text/javascript"></script>
        <!-- END THEME GLOBAL SCRIPTS -->
        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src="assets/pages/scripts/login.min.js" type="text/javascript"></script>
         <script src="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-toastr/toastr.min.js"></script>
        <script type="text/javascript">
            toastr.options = {

                "positionClass": "toast-bottom-full-width"
            }

    </script>
        <!-- END PAGE LEVEL SCRIPTS -->
        <!-- BEGIN THEME LAYOUT SCRIPTS -->
        <!-- END THEME LAYOUT SCRIPTS -->
    </form>
</body>
</html>