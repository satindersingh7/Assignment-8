<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="manage-subscriber.aspx.cs" Inherits="Poweradmin_Newsletter_manage_subscriber" %>

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
   <br />
    <!-- END PAGE TITLE-->
    <!-- END PAGE HEADER-->
    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal form-row-seperated">
                <div class="portlet light portlet-fit portlet-datatable bordered">
                    <div class="portlet-title">
                        <div class="caption">
                             <i class="icon-user font-green"></i>
                                <span class="caption-subject font-green sbold uppercase"><asp:Literal ID="ltr_title" runat="server" Text="Add"></asp:Literal> Subscriber</span>
                        </div>
                        <div class="actions btn-set">
                            <asp:LinkButton ID="btn_Cancel" runat="server" CssClass="btn btn-secondary-outline" OnClick="btn_Cancel_Click" OnClientClick="return confirm('Are you sure you want to cancel this process')" ><i class="fa fa-angle-left"></i> Back</asp:LinkButton>

                            <asp:LinkButton ID="btn_Submit" runat="server" CssClass="btn btn-success" ValidationGroup="vgValidate" OnClick="btn_Submit_Click" ><i class="fa fa-check"></i> Save</asp:LinkButton>
                            <asp:ValidationSummary ID="vsm1" runat="server" ShowMessageBox="true" ShowSummary="false" HeaderText="Please enter below details properly" ValidationGroup="vgValidate" />
                        </div>
                        
                        </div>
                    <div class="portlet-body">
                           
                               
                      
                           <div class="form-group form-md-line-input form-md-floating-label">                               
                                <label class="col-md-2 control-label">is Subscriber?</label> 
                                <div class="col-md-10">
                          <asp:RadioButtonList ID="rbl_Visible" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Value="1" Selected="True"><font color="green">Yes</font></asp:ListItem>
                                    <asp:ListItem Value="0"><font color="red">No</font></asp:ListItem>
                                </asp:RadioButtonList>                               
                            </div>                              
                          </div>     
                               <div class="form-group form-md-line-input form-md-floating-label">
                                 <label class="col-md-2 control-label">Name</label>
                                  <div class="col-md-10">
                                  <asp:TextBox ID="tbx_Title" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv1" runat="server" ControlToValidate="tbx_Title" ErrorMessage="Name" Display="None" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>                               
                                </div>
                           </div>                            
                           <div class="form-group form-md-line-input form-md-floating-label">
                                <label class="col-md-2 control-label">Group</label>
                                <div class="col-md-10"><asp:DropDownList ID="ddl_Group" runat="server" CssClass="form-control"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddl_Group" ErrorMessage="Group" Display="None" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>                               
                                </div>
                            </div>                              
                            
                              <div class="form-group form-md-line-input form-md-floating-label">
                                <label class="col-md-2 control-label">Email</label>
                               <div class="col-md-10"> <asp:TextBox ID="tbx_Email" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbx_Email" ErrorMessage="Email" Display="None" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>                               
                                 <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbx_Email" ErrorMessage="Valid Email" Display="None" ValidationGroup="vgValidate" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>                               
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

