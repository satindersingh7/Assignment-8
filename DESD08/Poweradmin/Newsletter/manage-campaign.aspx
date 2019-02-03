<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="manage-campaign.aspx.cs" Inherits="Poweradmin_Newsletter_manage_campaign" %>

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
  <br />
    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal form-row-seperated">
                <div class="portlet light portlet-fit portlet-datatable bordered">
                    <div class="portlet-title">
                        <div class="caption">
                             <i class="icon-user font-green"></i>
                                <span class="caption-subject font-green sbold uppercase"><asp:Literal ID="ltr_title" runat="server" Text="Add"></asp:Literal> Campaign</span>
                        </div>
                        <div class="actions btn-set">
                              <a href="view-sent-Campaign.aspx" class="btn btn-info">View Campaigns</a>
                            <asp:LinkButton ID="btn_Cancel" runat="server" CssClass="btn btn-secondary-outline" OnClick="btn_Cancel_Click" ><i class="fa fa-angle-left"></i> Back</asp:LinkButton>
                            
                            <asp:LinkButton ID="btn_Next" runat="server" CssClass="btn btn-success" ValidationGroup="vgValidate" OnClick="btn_Next_Click" ><i class="fa fa-check"></i> Next</asp:LinkButton>
                            <asp:LinkButton ID="btn_Send" runat="server" CssClass="btn btn-success" Visible="false" ValidationGroup="vgValidate" OnClick="btn_Send_Click" ><i class="fa fa-check"></i> Send</asp:LinkButton>
                            <asp:ValidationSummary ID="vsm1" runat="server" ShowMessageBox="false" ShowSummary="false" HeaderText="Please enter below details properly" ValidationGroup="vgValidate" />
                        </div>
                        
                        </div>
                    <div class="portlet-body" id="DivAddCampaign" runat="server" visible="false">
                        <div class="form-group form-md-line-input form-md-floating-label">
                            <label class="col-md-2 control-label">Template</label>
                            <div class="col-md-5">
                                <asp:DropDownList ID="ddl_Template" runat="server" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddl_Template_SelectedIndexChanged"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddl_Template" ErrorMessage="Template is required" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                            </div>
                            <label class="col-md-2 control-label"><a href="manage-template.aspx" class="btn btn-info"><i class="fa fa-plus fa-fw"></i> Add Template</a></label>
                        </div> 
                        <div class="form-group form-md-line-input form-md-floating-label">
                            <label class="col-md-2 control-label">From Email</label>
                            <div class="col-md-5">
                                <asp:TextBox ID="tbx_Email" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbx_Email" ErrorMessage="Email is required" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbx_Email" ErrorMessage="Valid Email" Display="Dynamic" ValidationGroup="vgValidate" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-group form-md-line-input form-md-floating-label">
                            <label class="col-md-2 control-label">To Group</label>
                            <div class="col-md-5">
                                <asp:DropDownList ID="ddlGroup" runat="server" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlGroup" ErrorMessage="Group is required" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                            </div>
                             <label class="col-md-2 control-label"><a href="manage-group.aspx" class="btn btn-info"><i class="fa fa-plus fa-fw"></i> Add Group</a></label>
                        </div>
                        <div class="form-group form-md-line-input form-md-floating-label">
                            <label class="col-md-2 control-label">Subject</label>
                            <div class="col-md-10">
                                <asp:TextBox ID="tbx_Subject" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv1" runat="server" ControlToValidate="tbx_Subject" ErrorMessage="Subject is required" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group form-md-line-input form-md-floating-label">
                            <label class="col-md-12">News Template</label>
                            <div class="col-md-12">
                                <CKEditor:Editor ID="Editor1" runat="server" />
                            </div>
                        </div>
                    </div>

                    <div class="portlet-body" id="DivStartCampaign" runat="server" visible="false">
                           <div class="form-group form-md-line-input form-md-floating-label">
                                <label class="col-md-2 control-label">From Email : </label> 
                               <div class="col-md-10"><asp:Literal ID="ltrFromEmail" runat="server"></asp:Literal></div>
                            </div>
                            <div class="form-group form-md-line-input form-md-floating-label">
                                <label class="col-md-2 control-label">Send to : </label>
                                <div class="col-md-10"> ( <asp:Literal ID="ltrTotalSubscriber" runat="server"></asp:Literal> ) Subscribers</div>
                            </div>
                            <div class="form-group form-md-line-input form-md-floating-label">
                                <label class="col-md-2 control-label">Subject : </label>
                                <div class="col-md-10"> <asp:Literal ID="ltrSubject" runat="server"></asp:Literal></div>
                            </div>
                            <div class="form-group form-md-line-input form-md-floating-label">
                                <label class="col-md-12">Campaign Template Body :</label> 
                               <div class="col-md-12"> <asp:Literal ID="ltrBody" runat="server"></asp:Literal></div>
                            </div>
                    </div>

                            
                    </div>
                </div>
            </div>
    </div>
       
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="extrajs" Runat="Server">
</asp:Content>

