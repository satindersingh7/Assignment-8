<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="manageadvt.aspx.cs" Inherits="Poweradmin_teaser_manageteaser" %>

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
            <li>Advertisement Banner Management</li>
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
                        <img src="../../images/loader.gif" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
    <div class="row">
        <div class="col-md-12">
            <div class="form-horizontal form-row-seperated">
                <div class="portlet light portlet-fit portlet-datatable bordered">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="fa fa-object-group font-green"></i>
                            <span class="caption-subject font-green sbold uppercase">
                                <asp:Literal ID="ltr_title" runat="server" Text="Add"></asp:Literal>
                                Advertisement Banner</span>
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
                            <label class="col-md-2 control-label">Position<span class="red"> * </span></label>
                            <div class="col-md-4">
                                <asp:DropDownList ID="ddlposition" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlposition_SelectedIndexChanged">
                                      <asp:ListItem Value="1">Side</asp:ListItem>
                                    <asp:ListItem Value="2">Middle</asp:ListItem>
                                    <asp:ListItem Value="3">Bottom</asp:ListItem>
                                </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ddlposition" ErrorMessage="Postion is required" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                            </div>
                       
                            <label class="col-md-2 control-label">Url<span class="red"> * </span></label>
                            <div class="col-md-4">
                                <asp:TextBox ID="txturl" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txturl" ErrorMessage="Url is required" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        
                        <div class="form-group form-md-line-input form-md-floating-label">
                            <label class="col-md-2 control-label">Image For Advertisement Banner<span class="red"> * </span></label>
                            <div class="col-md-10">
                                <small>[File with .jpg, .gif, .png, .jpeg, extensions / formats only.]<br />
                                    [Maximum Image Size: <%=ConfigurationManager.AppSettings["ImageSize"]%> MB]<br />
                                    [Recommended Dimension - Width :
                                    <asp:Label runat="server" ID="lblWidth"></asp:Label>
                                    px - Max Height :<asp:Label runat="server" ID="lblHeight"></asp:Label>px]</small><br />
                                <div class="fileinput fileinput-new" data-provides="fileinput">
                                    <div class="fileinput-preview thumbnail" data-trigger="fileinput" style="width: 300px; ">
                                        <img id="img" runat="server" visible="false" style="padding-bottom: 20px;" class="img-responsive" />
                                    </div>
                                    <div>
                                        <span class="btn btn-green btn-default btn-file"><span class="fileinput-new">Select image</span><span class="fileinput-exists">Change</span>
                                            <asp:FileUpload ID="FUplarge" runat="server" /></span>

                                        <a href="#" class="btn btn-default fileinput-exists" data-dismiss="fileinput">Remove</a>
                                    </div>
                                    <h5 style="color: red">
                                        <asp:Literal ID="ltrmessageimage" runat="server" Visible="false"></asp:Literal></h5>
                                </div>
                                <asp:RequiredFieldValidator ID="rfv_File" runat="server" ControlToValidate="FUplarge" ErrorMessage="Image is required" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="imageType" ControlToValidate="FUplarge" ErrorMessage="Only .jpg, .gif, .png, .jpeg, .bmp extensions are allowed." SetFocusOnError="True" ValidationGroup="vgValidate"></asp:CustomValidator>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
        </ContentTemplate>
        <Triggers>
         <asp:PostBackTrigger ControlID="btn_Submit" />
      </Triggers>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extrajs" runat="Server">
     <script src="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
</asp:Content>

