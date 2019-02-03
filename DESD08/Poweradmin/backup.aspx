<%@ Page Language="C#" AutoEventWireup="true" CodeFile="backup.aspx.cs" Inherits="backup" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
     <meta charset="utf-8" />
        <title>Backup</title>
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
        <!-- END PAGE LEVEL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <!-- END THEME LAYOUT STYLES -->
</head>
 <body class=" login">
    <form id="form1" runat="server">
    

   
        <!-- BEGIN LOGO -->
        <div class="logo">
           <img src="<%=ConfigurationManager.AppSettings["siteurl"].ToString() +ConfigurationManager.AppSettings["logo"].ToString() %>" >
        </div>
        <!-- END LOGO -->
        <!-- BEGIN LOGIN -->
        <div class="content">
            <!-- BEGIN LOGIN FORM -->
            <div class="login-form">
                <h3 class="form-title">Database Backup</h3>
                <div class="alert alert-danger display-hide">
                    <button class="close" data-close="alert"></button>
                    
                </div>
                <fieldset id="fs1" runat="server">
                <div class="form-group form-md-line-input form-md-floating-label">
                  <div id="div_Error" runat="server" class="alert alert-danger">You did not have tack backup from last 7 days. Please click on below button to take your database backup.</div>

                </div>
               
                <div class="form-actions">
                          <!-- Change this to a button or input when using this as a form -->
                                <asp:Button ID="btn_Backup"  AlternateText="Take Backup"  ValidationGroup="log_1" runat="server" CssClass="btn green" Text="Take Backup" OnClick="btn_Backup_Click"  />

                </div>
               </fieldset>
                <fieldset id="fs2" runat="server" visible="false">
                                 <div class="form-group form-md-line-input form-md-floating-label">
                                     <div id="div_Success" runat="server" class="alert alert-success">Backup was created successfully.</div>  
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                               <div class="form-group">
                                   <asp:LinkButton ID="lb_Download" runat="server" Text="Click Here to Download Backup File" OnClick="lb_Download_Click"></asp:LinkButton><br />
                          <a href="default.aspx">Get Back to Login Page</a>
                               </div></fieldset>
            </div>
            <!-- END LOGIN FORM -->
          
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
        <!-- END PAGE LEVEL SCRIPTS -->
        <!-- BEGIN THEME LAYOUT SCRIPTS -->
        <!-- END THEME LAYOUT SCRIPTS -->
    </form>
</body>
</html>