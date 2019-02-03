<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="import-product.aspx.cs" Inherits="Poweradmin_product_import_product" %>

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
            <li>Product Management</li>
        </ul>

    </div>    
    <!-- END PAGE BAR -->
    <br />
    <!-- END PAGE HEADER-->
    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal form-row-seperated">
                <div class="portlet light portlet-fit portlet-datatable bordered">
                    <div class="portlet-title">
                        <div class="caption">
                             <i class="fa fa-tags font-green"></i>
                                <span class="caption-subject font-green sbold uppercase"><asp:Literal ID="ltr_title" runat="server" Text="Import"></asp:Literal> Products</span>
                        </div>
                        <div class="actions btn-set">
                                 <a href="product.xls" class="btn btn-secondary-outline" target="_blank"><i class='fa fa-download icon' aria-hidden='true'></i> Download sample file</a>
                            <asp:LinkButton ID="btn_Cancel" runat="server" CssClass="btn btn-secondary-outline" OnClick="btn_Cancel_Click" ><i class="fa fa-angle-left"></i> Back</asp:LinkButton>

                            <asp:LinkButton ID="btn_Submit" runat="server" CssClass="btn btn-success" ValidationGroup="vgValidate" OnClick="btn_Submit_Click" ><i class="fa fa-check"></i> Save</asp:LinkButton>
                            <asp:ValidationSummary ID="vsm1" runat="server" ShowMessageBox="true" ShowSummary="false" HeaderText="Please enter below details properly" ValidationGroup="vgValidate" />
                        </div>
                        
                        </div>
                    <div class="portlet-body">
                           
                               
                        <div class="form-group form-md-line-input form-md-floating-label">
                                 <label class="col-md-2 control-label">Category</label>
                                  <div class="col-md-5">
                                   <asp:DropDownList ID="ddl_Category" runat="server" CssClass="form-control"></asp:DropDownList>
                                   <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddl_Category" ErrorMessage="Categroy is required" Display="None" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>                               
                                </div>
                           </div>                            
                          <div class="form-group form-md-line-input form-md-floating-label">
                                 <label class="col-md-2 control-label">Excel File</label>
                              <div class="col-md-4">
                                <small>[File with .xls extensions / formats only.]<br /> [Maximum File Size: <%=ConfigurationManager.AppSettings["ImageSize"]%> MB]</small><br />&nbsp;
                                  <small>[You Can upload basic text details. You need to add image and other details after import. By default Product will be Hidden in front-end]</small>
                                 <asp:FileUpload ID="fulp" runat="server" />                                
                                 <asp:RequiredFieldValidator ID="rfv_File" runat="server" ControlToValidate="fulp" ErrorMessage="Excel is required" Display="None" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>                               
                                <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="documentExcel" ControlToValidate="fulp" ErrorMessage="Only .xls extensions are allowed." SetFocusOnError="True" ValidationGroup="vgValidate"></asp:CustomValidator>
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

