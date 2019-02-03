<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="campaignDetail.aspx.cs" Inherits="Poweradmin_Newsletter_campaignDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- BEGIN PAGE HEADER-->
    <!-- BEGIN PAGE BAR -->
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li>
                 <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/dashboard.aspx">Home</a>
                <i class="fa fa-circle"></i>
            </li>
            <li>Newsletter Management</li>
        </ul>

    </div>   
    <!-- END PAGE BAR -->
    <!-- BEGIN PAGE TITLE-->
    <h1 class="page-title">Newsletter Management
   </h1>
    <!-- END PAGE TITLE-->
    <!-- END PAGE HEADER-->
    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal form-row-seperated">
                <div class="portlet light portlet-fit portlet-datatable bordered">
                    <div class="portlet-title">
                        <div class="caption">
                             <i class="icon-user font-green"></i>
                                <span class="caption-subject font-green sbold uppercase">View  Campaign Details</span>
                        </div>
                        <div class="actions btn-set">
                            <asp:LinkButton ID="btn_Cancel" runat="server" CssClass="btn btn-secondary-outline"><i class="fa fa-angle-left"></i> Back</asp:LinkButton>
                        </div>
                        </div>
                    <div class="portlet-body">
                                                   
                        <div class="form-group form-md-line-input form-md-floating-label">
                                <label class="col-md-2 control-label">From Email</label>
                                <div class="col-lg-10"><asp:Literal ID="ltrFromEmail" runat="server"></asp:Literal></div>
                            </div>
                           <div class="form-group form-md-line-input form-md-floating-label">
                                <label class="col-md-2 control-label">Send to</label>
                                <div class="col-lg-10">( <asp:Literal ID="ltrTotalSubscriber" runat="server"></asp:Literal> ) Subscribers</div>
                            </div>
                            <div class="form-group form-md-line-input form-md-floating-label">
                                <label class="col-md-2 control-label">Subject</label>
                                <div class="col-lg-10"><asp:Literal ID="ltrSubject" runat="server"></asp:Literal></div>
                            </div>
                            
                            
                            <div class="form-group form-md-line-input form-md-floating-label">
                                <label class="col-md-12 control-label">Campaign Template Body : </label>
                                <div class="col-lg-12"><asp:Literal ID="ltrBody" runat="server"></asp:Literal></div>
                            </div>
                          
                          
                            
                                </div>

                            </div>
                    </div>
                </div>
            </div>
        
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="extrajs" Runat="Server">
</asp:Content>

