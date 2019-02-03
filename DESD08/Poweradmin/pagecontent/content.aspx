<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="content.aspx.cs" Inherits="Poweradmin_pagecontent_content" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- BEGIN PAGE HEADER-->
    <!-- BEGIN PAGE BAR -->
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li>
                <a href="../dashboard.aspx">Home</a>
                <i class="fa fa-circle"></i>
            </li>
            <li>Page Content Management</li>
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
                             <i class="fa fa-file-text-o font-green"></i>
                                <span class="caption-subject font-green sbold uppercase"><asp:Literal ID="ltr_title" runat="server" Text="Add"></asp:Literal> Page Content</span>
                        </div>
                        <div class="actions btn-set">
                            <asp:LinkButton ID="btn_Cancel" runat="server" CssClass="btn btn-secondary-outline" OnClick="btn_Cancel_Click" ><i class="fa fa-angle-left"></i> Back</asp:LinkButton>

                            <asp:LinkButton ID="btn_Submit" runat="server" CssClass="btn btn-success" ValidationGroup="vgValidate" OnClick="btn_Submit_Click" ><i class="fa fa-check"></i> Save</asp:LinkButton>
                            <asp:ValidationSummary ID="vsm1" runat="server" ShowMessageBox="false" ShowSummary="false" HeaderText="Please enter below details properly" ValidationGroup="vgValidate" />
                        </div>
                        
                        </div>
                    <div class="portlet-body">
                           
                                <div class="form-body">

                                   <div class="form-group form-md-line-input form-md-floating-label">
                                    <label class="col-md-12">Browser Title<small>[Maximum 255 characters]</small></label><br />
                                  <div class="col-md-12">
                                        <asp:TextBox ID="txt_Title" runat="server" MaxLength="255" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv1" runat="server" ControlToValidate="txt_Title" ErrorMessage="Browser Title is required" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>                               
                                  </div>
                                </div>   
                                    
                                    <div class="form-group form-md-line-input form-md-floating-label">
                                <label class="col-md-12">Meta Tag</label>
                                        <div class="col-md-12">
                                <asp:TextBox ID="txt_Meta" runat="server"  TextMode="MultiLine" rows="6" CssClass="form-control"></asp:TextBox>                                
                                <small> Write complete meta tag as follows<br />
                                    e.g. &lt;meta name="keywords" content="put your keywords here"  /&gt;<br />
                                    &lt;meta name="description" content="put your page description here" /&gt;</small>
                            </div>                                
                                </div>

                                     
                                    <div class="form-group form-md-line-input form-md-floating-label">
                                <label class="col-md-12">Page Content</label>
                                          <div class="col-md-12">
                                  <CKEditor:Editor ID="Editor1" runat="server" />                                  
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

