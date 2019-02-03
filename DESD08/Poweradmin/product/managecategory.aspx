<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="managecategory.aspx.cs" Inherits="Poweradmin_Category_manageCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- BEGIN PAGE HEADER-->
    <!-- BEGIN PAGE BAR -->
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li>
                <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/dashboard.aspx">Home</a>
                <i class="fa fa-circle"></i>
            </li>
            <li>Product Category Management</li>
        </ul>

    </div>
    <!-- END PAGE BAR -->
    <!-- BEGIN PAGE TITLE-->
    <br />
    <!-- END PAGE TITLE-->
    <!-- END PAGE HEADER-->
    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal form-row-seperated">
                <div class="portlet light portlet-fit portlet-datatable bordered">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="fa fa-list font-green"></i>
                            <span class="caption-subject font-green sbold uppercase">
                                <asp:Literal ID="ltr_title" runat="server" Text="Add"></asp:Literal>
                                Product Category</span>
                        </div>
                        <div class="actions btn-set">
                            <asp:LinkButton ID="btn_Cancel" runat="server" CssClass="btn btn-secondary-outline" OnClick="btn_Cancel_Click"><i class="fa fa-angle-left"></i> Back</asp:LinkButton>

                            <asp:LinkButton ID="btn_Submit" runat="server" CssClass="btn btn-success" ValidationGroup="vgValidate" OnClick="btn_Submit_Click"><i class="fa fa-check"></i> Save</asp:LinkButton>
                            <asp:ValidationSummary ID="vsm1" runat="server" ShowMessageBox="false" ShowSummary="false" HeaderText="Please enter below details properly" ValidationGroup="vgValidate" />
                        </div>

                    </div>
                    <div class="portlet-body">


                        <div class="form-group form-md-line-input form-md-floating-label">
                            <label class="col-md-2 control-label">Display on Front-End?</label>
                            <div class="col-md-10">
                                <asp:RadioButtonList ID="rbl_Visible" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Value="1" Selected="True"><font color="green">Yes</font></asp:ListItem>
                                    <asp:ListItem Value="0"><font color="red">No</font></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                        <div class="form-group form-md-line-input form-md-floating-label">
                            <label class="col-md-2 control-label">Title<span class="red"> * </span></label>
                            <div class="col-md-4">
                                <asp:TextBox ID="tbx_Title" runat="server" MaxLength="200" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbx_Title" ErrorMessage="Title is required" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                            </div>
                           
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extrajs" runat="Server">
    <script src="../assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
    <script src="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
     <script>$(function () { ReloadDate() });</script>
</asp:Content>

