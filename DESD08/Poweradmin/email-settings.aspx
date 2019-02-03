<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="email-settings.aspx.cs" Inherits="email_settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   
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
                <span>Settings</span>
            </li>
        </ul>

    </div>
    <%--<div id="div_Error" runat="server" class="alert alert-danger" visible="false">
        <asp:Literal ID="ltr_Error" runat="server"></asp:Literal></div>
    <div id="div_Success" runat="server" class="alert alert-success" visible="false">
        <asp:Literal ID="ltr_Success" runat="server"></asp:Literal></div>--%>
    <!-- END PAGE BAR -->
    <!-- BEGIN PAGE TITLE-->
    <h1 class="page-title">Settings
   </h1>
    <!-- END PAGE TITLE-->
    <!-- END PAGE HEADER-->
    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal form-row-seperated">
                <div class="portlet light portlet-fit portlet-datatable bordered">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="fa fa-envelope"></i>E-MAIL AUTHENTICATION DETAILS
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
                                        <label class="col-md-2 control-label">Host:</label>
                                        <div class="col-md-10">
                                            <asp:TextBox ID="TBx_host" runat="server" MaxLength="50" CssClass="form-control maxlength-handler" ></asp:TextBox><span class="help-block"> max 50 chars </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TBx_host" ErrorMessage="Host" SetFocusOnError="True" ValidationGroup="vgValidate" Display="None"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                      <div class="form-group form-md-line-input form-md-floating-label">
                                        <label class="col-md-2 control-label">Username:</label>
                                        <div class="col-md-10">
                                            <asp:TextBox ID="TBx_musername" runat="server" MaxLength="100" CssClass="form-control maxlength-handler" ></asp:TextBox><span class="help-block"> max 100 chars </span>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TBx_musername" ErrorMessage="Host" SetFocusOnError="True" ValidationGroup="vgValidate" Display="None"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                 
                                    <div class="form-group form-md-line-input form-md-floating-label">
                                        <label class="col-md-2 control-label">Password:</label>
                                        <div class="col-md-10">
                                            <asp:TextBox ID="TBx_hostpassword" runat="server" MaxLength="30" CssClass="form-control maxlength-handler" TextMode="Password"></asp:TextBox><span class="help-block"> max 30 chars </span>
                                              <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TBx_hostpassword" ErrorMessage="Host password" SetFocusOnError="True" ValidationGroup="vgValidate" Display="None"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                       <div class="form-group form-md-line-input form-md-floating-label">
                                        <label class="col-md-2 control-label">To Email:</label>
                                        <div class="col-md-10">
                                            <asp:TextBox ID="TBx_toemail" runat="server" MaxLength="100" CssClass="form-control maxlength-handler"></asp:TextBox><span class="help-block"> max 100 chars </span>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Valid to email id" ValidationGroup="vgValidate" Display="None" ControlToValidate="TBx_toemail" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                       <div class="form-group form-md-line-input form-md-floating-label">
                                        <label class="col-md-2 control-label">CC Email:</label>
                                        <div class="col-md-10">
                                            <asp:TextBox ID="TBx_ccemail" runat="server" MaxLength="100" CssClass="form-control maxlength-handler"></asp:TextBox><span class="help-block"> max 100 chars </span>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Valid CC email id" ValidationGroup="vgValidate" Display="None" ControlToValidate="TBx_ccemail" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>

                                         <div class="form-group form-md-line-input form-md-floating-label">
                                        <label class="col-md-2 control-label">BCC Email:</label>
                                        <div class="col-md-10">
                                            <asp:TextBox ID="TBx_bccemail" runat="server" MaxLength="100" CssClass="form-control maxlength-handler" ></asp:TextBox><span class="help-block"> max 100 chars </span>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Valid BCC email id" ValidationGroup="vgValidate" Display="None" ControlToValidate="TBx_bccemail" SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>

                                </div>

                            </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extrajs" Runat="Server">
   
</asp:Content>

