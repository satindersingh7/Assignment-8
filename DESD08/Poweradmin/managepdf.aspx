<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="managepdf.aspx.cs" Inherits="Poweradmin_termsandconditions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />
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
            <li>
                <span>PDF Management</span>
            </li>
        </ul>

    </div>
    <!-- END PAGE BAR -->
    <!-- BEGIN PAGE TITLE-->
    <br />
    <!-- END PAGE TITLE-->
    <!-- END PAGE HEADER-->
    <asp:UpdatePanel ID="upnl1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress AssociatedUpdatePanelID="upnl1" ID="UP_product" runat="server">

                <ProgressTemplate>
                    <div id="loading" class="loadingimg" style="height: 100%; width: 100%;" align="center">
                        <img src="../images/loader.gif" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="row">
                <div class="col-md-12">
                    <!-- Begin: life time stats -->
                    <div class="portlet light portlet-fit portlet-datatable bordered">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="fa fa-image font-green"></i>
                                <span class="caption-subject font-green sbold uppercase">View Pdfs</span>
                            </div>
                            <div class="actions">
                                <asp:LinkButton ID="btn_Cancel" runat="server" CssClass="btn btn-secondary-outline" OnClick="btn_Cancel_Click"><i class="fa fa-angle-left"></i> Back</asp:LinkButton>
                            </div>
                        </div>
                        <div class="portlet-title">
                            <div class="form-group  form-md-radios">
                                <div class="col-md-4">
                                    <div class="form-group form-md-line-input form-md-floating-label">
                                        <asp:TextBox ID="tbx_PDFTitle" runat="server" CssClass="form-control" placeholder="Title" MaxLength="255"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbx_PDFTitle" Display="Dynamic" ValidationGroup="vgValidate"><span class="help-block text-danger"> Pdf Title </span></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-4">

                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                        <div class="input-group input-large">
                                            <div class="form-control uneditable-input input-fixed input-medium" data-trigger="fileinput">
                                                <i class="fa fa-file fileinput-exists"></i>&nbsp;
                                                                    <span class="fileinput-filename"></span>
                                            </div>
                                            <span class="input-group-addon btn default btn-file">
                                                <span class="fileinput-new">Select file </span>
                                                <span class="fileinput-exists">Change </span>
                                                <asp:FileUpload ID="fulp" runat="server" />

                                            </span>
                                            <a href="javascript:;" class="input-group-addon btn red fileinput-exists" data-dismiss="fileinput">Remove </a>
                                        </div>
                                        <p class="help-block">
                                            <small>[File with .pdf extensions / formats only.]<br />
                                                [Maximum File Size: <%=ConfigurationManager.AppSettings["FileSize"]%> MB]</small>
                                        </p>
                                        <asp:RequiredFieldValidator ID="rfv_File" runat="server" ControlToValidate="fulp" Display="Dynamic" ValidationGroup="vgValidate"><span class="help-block text-danger">Pdf File Required</span></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="documentPDF" ControlToValidate="fulp" Display="Dynamic" SetFocusOnError="True" ValidationGroup="vgValidate"><span class="help-block text-danger">Only .pdf extensions are allowed</span></asp:CustomValidator>
                                    </div>

                                </div>
                                <div class="col-md-4">
                                    <asp:LinkButton ID="btn_Submit" runat="server" CssClass="btn btn-success" ValidationGroup="vgValidate" OnClick="btn_Submit_Click"><i class="fa fa-check"></i> Save</asp:LinkButton>
                                    <asp:ValidationSummary ID="vsm1" runat="server" ShowMessageBox="false" ShowSummary="false" HeaderText="Please enter below details properly" ValidationGroup="vgValidate" />
                                </div>
                            </div>
                        </div>

                        <div class="portlet-body">
                            <div class="table-container  table-responsive">
                                <table class="table table-striped table-bordered table-hover table-checkable " id="">
                                    <thead>
                                        <tr role="row" class="heading">
                                            <th style="border: none;">
                                               Active
                                            </th>
                                            <th>Title</th>
                                            <th>PDF</th>
                                            <th>Added Date</th>
                                            <th>Delete</th>
                                        </tr>

                                    </thead>
                                    <tbody>
                                        <asp:Panel ID="pnl_Record" runat="server">
                                            <asp:Repeater ID="rep" runat="server" OnItemDataBound="rep_ItemDataBound" OnItemCommand="rep_ItemCommand">
                                                <ItemTemplate>
                                                    <tr role="row" class="odd" <%# Eval("id").ToString() == Request.QueryString["id"] ? "style='background-color: lightyellow;'":"" %>>
                                                        <td>
                                                            <asp:HiddenField ID="hfNewsId" runat="server" Value='<%#Eval("id") %>' />
                                                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                                <asp:CheckBox ID="checkboxDelete" runat="server"  Checked='<%# Eval("active").ToString() == "True" ? true : false %>' OnCheckedChanged="checkboxDelete_CheckedChanged" AutoPostBack="true"  /><span></span></label>
                                                        </td>

                                                        <td data-th="Title"><b class="<%# Eval("active").ToString() == "True" ? "text-success" : "text-danger"%>"><%# Eval("Title").ToString().Length>20 ? Eval("title").ToString().Substring(0,20)+"..." : Eval("Title").ToString() %></b></td>
                                                        <td data-th="PDF File"><a href='<%#ConfigurationManager.AppSettings["siteurl"].ToString()+"/webfiles/TNC/"+Eval("filename").ToString() %>' target="_blank">Click Here</a> to view PDF</td>
                                                        <td data-th="Added Date"><%# Convert.ToDateTime(Eval("addeddate").ToString()).ToString("dd-MMM-yyyy hh:mm tt") %></td>
                                                        <td class="dt-body-right sorting_1">
                                                            <span style="position: relative;" class="btn btn-outline red btn-sm">
                                                                <i class="fa fa-trash"></i>
                                                                <asp:Button ID="ibDelete" OnClientClick="return modalurl(this,'Are you sure you want to delete this record?');" class="movedown" CommandName="Delete" CommandArgument='<%#Eval("id")%>' runat="server" Text=""></asp:Button></span>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </asp:Panel>


                                        <tr class="panel-body" id="div_msg" runat="server" visible="false">
                                            <td colspan="3">
                                                <label>
                                                    <asp:Literal ID="ltr_msg" runat="server"></asp:Literal></label>
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                                <div class="row" id="div_Paging" runat="server" visible="false">
                                    <div class="col-md-6 col-sm-12">
                                        Showing
                                            <asp:Literal ID="ltr_Start" runat="server"></asp:Literal>
                                        to
                                            <asp:Literal ID="ltr_End" runat="server"></asp:Literal>
                                        of
                                            <asp:Literal ID="ltr_Total" runat="server"></asp:Literal>
                                        records
                                    </div>
                                    <div class="col-md-6 col-sm-12 text-right">
                                        <div class="dataTables_paginate paging_bootstrap_extended">
                                            <div class="pagination-panel">
                                                Page 
                                                    <asp:LinkButton ID="lnkPrevious" runat="server" CssClass="btn btn-sm default prev" aria-label="Previous" OnClick="lnkPrevious_Click"><i class="fa fa-angle-left"></i></asp:LinkButton></li>
                                                     <asp:TextBox ID="tbx_PageNumber" runat="server" AutoPostBack="false" CssClass="pagination-panel-input form-control input-sm input-inline input-mini" MaxLength="5" Style="text-align: center; margin: 0 5px;" OnTextChanged="tbx_PageNumber_TextChanged"></asp:TextBox>
                                                <asp:LinkButton ID="lnkNext" runat="server" CssClass="btn btn-sm default next" OnClick="lnkNext_Click"><i class="fa fa-angle-right"></i></asp:LinkButton></li> of <span class="pagination-panel-total"><%=ViewState["totpage"] %></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End: life time stats -->
                </div>

            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btn_Submit" />
        </Triggers>
    </asp:UpdatePanel>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extrajs" runat="Server">
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script src="../assets/global/scripts/datatable.js" type="text/javascript"></script>
    <script src="../assets/global/plugins/datatables/datatables.min.js" type="text/javascript"></script>
    <script src="../assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js" type="text/javascript"></script>
    <script src="../assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
    <script src="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>

    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="../assets/pages/scripts/ecommerce-orders.min.js" type="text/javascript"></script>
    <!-- END PAGE LEVEL SCRIPTS -->
    <script type="text/javascript">
        function updatechk(involker) {
            var inputElements = document.getElementsByTagName('input');
            for (var i = 0; i < inputElements.length; i++) {
                var myElement = inputElements[i];
                if (myElement.type === "checkbox" && myElement.id != 'ckbCheckAll')
                    myElement.checked = involker.checked;
            }
        }

        function documentPDF(src, arg) {

            var fileName = arg.Value;
            var ext;
            ext = fileName.substr(fileName.lastIndexOf('.')).toLowerCase();
            if (fileName == '') {
                arg.IsValid = false;
            }
            if ('.pdf,.PDF'.indexOf(ext + ',') < 0) {
                arg.IsValid = false;
            }
            else
                arg.IsValid = true;
        }
    </script>
</asp:Content>
