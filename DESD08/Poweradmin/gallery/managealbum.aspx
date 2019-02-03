<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="managealbum.aspx.cs" Inherits="Poweradmin_Album_manageAlbum" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function ReloadDate() {
            $(".date-picker").datepicker({ rtl: App.isRTL(), autoclose: !0 })
        }
    </script>
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
            <li>Gallery Management</li>
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
                            <i class="fa fa-image font-green"></i>
                            <span class="caption-subject font-green sbold uppercase">
                                <asp:Literal ID="ltr_title" runat="server" Text="Add"></asp:Literal>
                                Album</span>
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
                                <asp:TextBox ID="tbx_Title" runat="server" MaxLength="255" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbx_Title" ErrorMessage="Title is required" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                            </div>
                           
                        </div>
                         <div class="form-group form-md-line-input form-md-floating-label" runat="server" visible="false">
                              <label class="col-md-2 control-label">Date:</label>
                                <div class="col-md-2">
                                    <div class="input-group date-picker input-daterange" data-date-format="dd-M-yyyy">
                                        <asp:TextBox ID="tbx_FromDate" runat="server" class="form-control form-filter input-sm" placeholder="Date"></asp:TextBox>
                                       </div>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="tbx_FromDate" ErrorMessage="Date is required" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>--%>
                                 </div>
                             </div>
                        <div class="form-group form-md-line-input form-md-floating-label" runat="server" visible="false">

                            <label class="col-md-2 control-label">Existing  Album Cover</label>
                            <div class="col-md-10">

                                <small>[File with .jpg, .gif, .png, .jpeg, .bmp extensions / formats only.]<br />
                                    [Maximum Image Size: <%=ConfigurationManager.AppSettings["ImageSize"]%> MB]<br />
                                    [Recommended Dimension - Width : <%=ConfigurationManager.AppSettings["AlbumLargeWidth"]%>px - Height :<%=ConfigurationManager.AppSettings["AlbumLargeHeight"]%>px]</small><br />
                                <div class="fileinput fileinput-new" data-provides="fileinput">
                                    <div class="fileinput-preview thumbnail" data-trigger="fileinput" style="width: <%=ConfigurationManager.AppSettings["AlbumSmallWidth"]%>px; min-height: <%=ConfigurationManager.AppSettings["AlbumSmallHeight"]%>px;">
                                        <img id="img" runat="server" visible="false" style="padding-bottom: 20px;" class="img-responsive" />
                                    </div>
                                    <div>
                                        <span class="btn btn-green btn-default btn-file"><span class="fileinput-new">Select image</span><span class="fileinput-exists">Change</span>
                                            <asp:FileUpload ID="FUplarge" runat="server" /></span>

                                        <a href="#" class="btn btn-default fileinput-exists" data-dismiss="fileinput">Remove</a>
                                    </div>
                                    <h5 style="color: red">
                                        <asp:Literal ID="ltrmessageimage" runat="server" Visible="false"></asp:Literal></h5>
                                    <asp:RequiredFieldValidator ID="rfv_File" runat="server" ControlToValidate="FUplarge" ErrorMessage="Photo is required" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="imageType" ControlToValidate="FUplarge" ErrorMessage="Only .jpg, .gif, .png, .jpeg, .bmp extensions are allowed." SetFocusOnError="True" ValidationGroup="vgValidate"></asp:CustomValidator>
                                </div>

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

