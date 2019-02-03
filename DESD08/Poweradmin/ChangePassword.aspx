<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="changepassword123" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- BEGIN PAGE HEADER-->
    <!-- BEGIN PAGE BAR -->
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li>
                <a href="dashboard.aspx">Home</a>
                <i class="fa fa-circle"></i>
            </li>
            <li>
                <span>My Profile</span>
            </li>
        </ul>

    </div>
  <%--  <div id="div_Error" runat="server" class="alert alert-danger" visible="false">
        <asp:Literal ID="ltr_Error" runat="server"></asp:Literal></div>
    <div id="div_Success" runat="server" class="alert alert-success" visible="false">
        <asp:Literal ID="ltr_Success" runat="server"></asp:Literal></div>--%>
    <!-- END PAGE BAR -->
    <!-- BEGIN PAGE TITLE-->
    <h1 class="page-title">My Profile
   </h1>
    <!-- END PAGE TITLE-->
    <!-- END PAGE HEADER-->
    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal form-row-seperated">
                <div class="portlet">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="fa fa-user fa-fw"></i>Change Password
                        </div>
                        <div class="actions btn-set">
                            <asp:LinkButton ID="btn_Cancel" runat="server" CssClass="btn btn-secondary-outline" OnClientClick="return confirm('Are you sure you want to cancel this process')" OnClick="btn_Cancel_Click"><i class="fa fa-angle-left"></i> Back</asp:LinkButton>

                            <asp:LinkButton ID="btn_Submit" runat="server" CssClass="btn btn-success" ValidationGroup="vgValidate" OnClick="btn_Submit_Click"><i class="fa fa-check"></i> Save</asp:LinkButton>
                            <asp:ValidationSummary ID="vsm1" runat="server" ShowMessageBox="true" ShowSummary="false" HeaderText="Please enter below details properly" ValidationGroup="vgValidate" />
                        </div>
                        
                        </div>
                    <div class="portlet-body">
                           
                                <div class="form-body">
                                    <div class="form-group form-md-line-input form-md-floating-label">
                                        <label class="col-md-2 control-label">Username:</label>
                                        <div class="col-md-10">
                                            <asp:TextBox ID="Tbx_username" runat="server" MaxLength="30" CssClass="form-control maxlength-handler" Enabled="false"></asp:TextBox><span class="help-block"> max 30 chars </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Tbx_username" ErrorMessage="Username" SetFocusOnError="True" ValidationGroup="vgValidate" Display="None" ToolTip="Enter the username"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="form-group form-md-line-input form-md-floating-label">
                                        <label class="col-md-2 control-label">Email:</label>
                                        <div class="col-md-10">
                                            <asp:TextBox ID="TBx_email" runat="server" MaxLength="100" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TBx_email" ErrorMessage="Email id" SetFocusOnError="True" ValidationGroup="vgValidate" Display="None" ToolTip="Enter the email"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Valid email id" ValidationGroup="vgValidate" Display="None" ControlToValidate="TBx_email" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                    <div class="form-group form-md-line-input form-md-floating-label">
                                        <label class="col-md-2 control-label">Old Password:</label>
                                        <div class="col-md-10">
                                            <asp:TextBox ID="TBx_oldpassword" runat="server" MaxLength="30" CssClass="form-control maxlength-handler" TextMode="Password"></asp:TextBox><span class="help-block"> max 30 chars </span>
                                        </div>
                                    </div>
                                    <div class="form-group form-md-line-input form-md-floating-label">
                                        <label class="col-md-2 control-label">New Password:</label>
                                        <div class="col-md-10">
                                            <asp:TextBox ID="TBx_password" runat="server" TextMode="Password" MaxLength="30" CssClass="form-control maxlength-handler"></asp:TextBox><span class="help-block"> max 30 chars </span>
                                        </div>
                                    </div>
                                     <div class="form-group form-md-line-input form-md-floating-label">
                                        <label class="col-md-2 control-label">ReType Password:</label>
                                        <div class="col-md-10">
                                            <asp:TextBox ID="txtNewPass" runat="server" TextMode="Password" MaxLength="30" CssClass="form-control maxlength-handler"></asp:TextBox><span class="help-block"> max 30 chars </span>
                                        <asp:CompareValidator ID="jsdkj" runat="server" ControlToValidate="txtNewPass"  ControlToCompare="TBx_password" ErrorMessage="Password mismatched" Display="None" ValidationGroup="vgValidate" SetFocusOnError="true"></asp:CompareValidator>
            </div>
                                    </div>
                                </div>

                            </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extrajs" runat="Server">
</asp:Content>

