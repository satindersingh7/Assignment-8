<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="enquirydetails.aspx.cs" Inherits="Poweradmin_Enquiry_enquirydetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
            <li>Enquiry Management</li>
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
                            <i class="fa fa-info font-green"></i>
                            <span class="caption-subject font-green sbold uppercase">View Enquiry Details</span>
                        </div>
                        <div class="actions btn-set">
                            <asp:LinkButton ID="btn_Cancel" runat="server" CssClass="btn btn-secondary-outline" OnClick="btn_Cancel_Click"><i class="fa fa-angle-left"></i> Back</asp:LinkButton>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="form-group bold">
                            <label class="col-md-2 text-right bold">Subject: </label>
                            <div class="col-lg-4">
                                <asp:Literal ID="ltr_Subject" runat="server"></asp:Literal></div>
                        </div>
                        <hr />
                        <div class="form-group">
                            <label class="col-md-2 text-right bold">Name: </label>
                            <div class="col-lg-4">
                                <asp:Literal ID="ltr_Name" runat="server"></asp:Literal></div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 text-right bold">Email: </label>
                            <div class="col-lg-4">
                                <asp:Literal ID="ltr_email" runat="server"></asp:Literal></div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 text-right bold">Phone: </label>
                            <div class="col-lg-4">
                                <asp:Literal ID="ltr_Contact" runat="server"></asp:Literal></div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 text-right bold">Message: </label>
                            <div class="col-lg-10">
                                <asp:Literal ID="ltr_Comment" runat="server"></asp:Literal></div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 text-right bold">Date: </label>
                            <div class="col-lg-4">
                                <asp:Literal ID="ltr_Date" runat="server"></asp:Literal></div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="extrajs" runat="Server">
</asp:Content>

