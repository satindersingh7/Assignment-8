<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="manage-group.aspx.cs" Inherits="Poweradmin_Newsletter_manage_group" %>

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
                                <span class="caption-subject font-green sbold uppercase"><asp:Literal ID="ltr_title" runat="server" Text="Add"></asp:Literal> Group</span>
                        </div>
                        <div class="actions btn-set">
                            <asp:LinkButton ID="btn_Cancel" runat="server" CssClass="btn btn-secondary-outline" OnClick="btn_Cancel_Click"><i class="fa fa-angle-left"></i> Back</asp:LinkButton>

                            <asp:LinkButton ID="btn_Submit" runat="server" CssClass="btn btn-success" ValidationGroup="vgValidate" OnClick="btn_Submit_Click" ><i class="fa fa-check"></i> Save</asp:LinkButton>
                            <asp:ValidationSummary ID="vsm1" runat="server" ShowMessageBox="false" ShowSummary="false" HeaderText="Please enter below details properly" ValidationGroup="vgValidate" />
                        </div>
                        
                        </div>
                    <div class="portlet-body">
                           
                               
                        <div class="form-group form-md-line-input form-md-floating-label">
                                 <label class="col-md-2 control-label">Name</label>
                                  <div class="col-md-5">
                                  <asp:TextBox ID="tbx_Title" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv1" runat="server" ControlToValidate="tbx_Title" ErrorMessage="Name is Required" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>                               
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

