<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="managepartner.aspx.cs" Inherits="Poweradmin_Partner_managePartner" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />
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
            <li>Brand Partner Management</li>
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
                            <i class="fa fa-suitcase font-green"></i>
                            <span class="caption-subject font-green sbold uppercase">
                                <asp:Literal ID="ltr_title" runat="server" Text="Add"></asp:Literal>
                                Brand Partner</span>
                        </div>
                        <div class="actions btn-set">
                            <asp:LinkButton ID="btn_Cancel" runat="server" CssClass="btn btn-secondary-outline" OnClick="btn_Cancel_Click"><i class="fa fa-angle-left"></i> Back</asp:LinkButton>

                            <asp:LinkButton ID="btn_Submit" ClientIDMode="Static" runat="server" CssClass="btn btn-success" ValidationGroup="vgValidate" OnClick="btn_Submit_Click"><i class="fa fa-check"></i> Save</asp:LinkButton>
                            <asp:ValidationSummary ID="vsm1" runat="server" ShowMessageBox="false" ShowSummary="false" HeaderText="Please enter below details properly" ValidationGroup="vgValidate" />
                        </div>

                    </div>
                    <div class="portlet-body">

                        <div class="form-body">
                            <div class="form-group">
                                <label class="col-md-2 control-label">Visible in Front?</label>
                                <div class="col-md-10">
                                    <asp:RadioButtonList ID="rbl_Visible" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem Value="1" Selected="True"><font color="green">Yes</font></asp:ListItem>
                                        <asp:ListItem Value="0"><font color="red">No</font></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                            
                            <div class="form-group row">
                                <label class="col-md-2 control-label">Image:<span class="red"> * </span></label>
                                <div class="col-md-4">
                                    <small>[File with .jpg, .gif, .png, .jpeg, .bmp extensions / formats only.]<br />
                                        [Maximum Image Size: <%=ConfigurationManager.AppSettings["ImageSize"]%> MB]<br />
                                        [Recommended Dimension - Width : <%=ConfigurationManager.AppSettings["PartnerImgWidth"]%>px - Height :<%=ConfigurationManager.AppSettings["PartnerImgHeight"]%>px]</small><br />
                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                        <div class="fileinput-preview thumbnail" data-trigger="fileinput" style="width: <%=ConfigurationManager.AppSettings["PartnerImgWidth"]%>px; height: <%=ConfigurationManager.AppSettings["PartnerImgHeight"]%>px;">
                                            <img id="img" runat="server" style="padding-bottom: 20px;" class="img-responsive" />
                                        </div>
                                        <div>
                                            <span class="btn btn-green btn-default btn-file"><span class="fileinput-new">Select image</span><span class="fileinput-exists">Change</span>
                                                <asp:FileUpload ID="fulp" runat="server" /></span>
                                            <a href="#" class="btn btn-default fileinput-exists" data-dismiss="fileinput">Remove</a>
                                        </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="fulp" ErrorMessage="Image is required" SetFocusOnError="true" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                                           <h5 style="color: red">
                                    <asp:Literal ID="ltrmessageimage" runat="server" Visible="false"></asp:Literal></h5>
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="imageType" ControlToValidate="fulp" ErrorMessage="Only .jpg, .gif, .png, .jpeg, .bmp extensions are allowed." SetFocusOnError="True" ValidationGroup="vgValidate"></asp:CustomValidator>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group form-md-line-input form-md-floating-label">
                                <label class="col-md-2 control-label">URL:</label>
                                <div class="col-md-10">
                                    <asp:TextBox ID="txtURL" runat="server" CssClass="form-control maxlength-handler"></asp:TextBox>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtURL" ErrorMessage="URL is required" SetFocusOnError="true" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>--%>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" Display="Dynamic" ControlToValidate="txtURL" ErrorMessage="URL Link not valid. Please add link for eg. https://www.google.co.in" ForeColor="Red" SetFocusOnError="True" ToolTip="Please enter Name" ValidationGroup="vgValidate" ValidationExpression="(http(s)?://)?([\w-]+\.)+[\w-]+(/[\w- ;,./?%&=]*)?"></asp:RegularExpressionValidator>
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
    <script src="../assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js" type="text/javascript"></script>
    <script src="../assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
    <script src="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script>$(function () { ReloadDate() });</script>

    <!-- END PAGE LEVEL SCRIPTS -->
</asp:Content>

