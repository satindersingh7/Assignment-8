<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="manageitem.aspx.cs" Inherits="Poweradmin_Gallery_managePhoto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                                Photo</span>
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
                            <div class="col-md-2">
                                <asp:RadioButtonList ID="rbl_Visible" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Value="1" Selected="True"><font color="green">Yes</font></asp:ListItem>
                                    <asp:ListItem Value="0"><font color="red">No</font></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                       
                            <%--<label class="col-md-2 control-label">Content Type?</label>
                            <div class="col-md-2">
                                <asp:RadioButtonList ID="rbl_Content" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" AutoPostBack="true" OnSelectedIndexChanged="rbl_Content_SelectedIndexChanged">
                                    <asp:ListItem Value="1" Selected="True"><font color="red">Photo</font></asp:ListItem>
                                    <asp:ListItem Value="2"><font color="blue">Video</font></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>--%>
                        </div>
                        <div class="form-group form-md-line-input form-md-floating-label">
                               <label class="col-md-2 control-label">Title</label>
                            <div class="col-md-4">
                                <asp:TextBox ID="tbx_Title" runat="server" MaxLength="255" CssClass="form-control"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbx_Title" ErrorMessage="Select Album" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>--%>
                            </div>
                            <label class="col-md-2 control-label">Album<span class="red"> * </span></label>
                            <div class="col-md-4">
                                <asp:DropDownList ID="ddl_Category" runat="server" CssClass="form-control"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddl_Category" ErrorMessage="Select Album" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                            </div>
                          
                        </div>
                        <asp:Panel ID="ImageContent" runat="server" Visible="true">
                            <div class="form-group form-md-line-input form-md-floating-label">

                                <label class="col-md-2 control-label">Image<span class="red"> * </span></label>
                                <div class="col-md-10">

                                    <small>[File with .jpg, .gif, .png, .jpeg, .bmp extensions / formats only.]<br />
                                        [Maximum Image Size: <%=ConfigurationManager.AppSettings["ImageSize"]%> MB]<br />
                                        [Recommended Dimension - Width : <%=ConfigurationManager.AppSettings["PhotoLargeWidth"]%>px - Height :<%=ConfigurationManager.AppSettings["PhotoLargeHeight"]%>px]</small><br />
                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                        <div class="fileinput-preview thumbnail" data-trigger="fileinput" style="width: <%=ConfigurationManager.AppSettings["PhotoLargeWidth"]%>px; min-height: <%=ConfigurationManager.AppSettings["PhotoLargeHeight"]%>px;">
                                            <img id="img" runat="server" visible="false" style="padding-bottom: 20px;" class="img-responsive" />
                                        </div>
                                        <div>
                                            <span class="btn btn-green btn-default btn-file"><span class="fileinput-new">Select image</span><span class="fileinput-exists">Change</span>
                                                <asp:FileUpload ID="FUplarge" runat="server" /></span>

                                            <a href="#" class="btn btn-default fileinput-exists" data-dismiss="fileinput">Remove</a>
                                        </div>
                                        <h5 style="color: red">
                                            <asp:Literal ID="ltrmessageimage" runat="server" Visible="false"></asp:Literal></h5>
                                        <asp:RequiredFieldValidator ID="rfv_File" runat="server" ControlToValidate="FUplarge" ErrorMessage="Image is required" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="imageType" ControlToValidate="FUplarge" ErrorMessage="Only .jpg, .gif, .png, .jpeg, .bmp extensions are allowed." SetFocusOnError="True" ValidationGroup="vgValidate"></asp:CustomValidator>
                                    </div>

                                </div>
                                
                            </div>
                        </asp:Panel>

                        
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extrajs" runat="Server">
    <script src="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
</asp:Content>

