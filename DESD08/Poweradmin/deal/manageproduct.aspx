<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="manageproduct.aspx.cs" Inherits="Poweradmin_Product_manageProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />

    <link href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-multiselect/css/bootstrap-multiselect.css" rel="stylesheet" type="text/css" />
    <script src="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-multiselect/js/bootstrap-multiselect.js" type="text/javascript"></script>

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
            <li>Deal & Offers Management</li>
        </ul>

    </div>
    <!-- END PAGE BAR -->
    <!-- BEGIN PAGE TITLE-->
    <br />
    <!-- END PAGE TITLE-->
    <!-- END PAGE HEADER-->
    <div class="row">
        <div class="col-md-12">
            <div class="portlet light bordered">
                <div class="portlet-title tabbable-line">
                    <ul class="nav nav-tabs pull-left">
                        <li class="<%=Detail.ToString()%>">
                            <a href="#portlet_tab2_1" data-toggle="tab">Details</a>
                        </li>
                        <li class="<%=Image.ToString()%>" runat="server" id="tabimg">
                            <a href="#portlet_tab2_2" data-toggle="tab">Images</a>
                        </li>
                        <li class="<%=Associate.ToString()%>" runat="server" id="tabAssociate">
                            <a href="#portlet_tab2_3" data-toggle="tab">Associate Deal & Offers</a>
                        </li>
                    </ul>
                </div>
                <div class="portlet-body">
                    <div class="tab-content">
                        <div class="tab-pane <%=Detail.ToString()%>" id="portlet_tab2_1">
                            <div class="form-horizontal form-row-seperated">
                                <div class="portlet light portlet-fit portlet-datatable bordered">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="fa fa-tags font-green"></i>
                                            <span class="caption-subject font-green sbold uppercase">
                                                <asp:Literal ID="ltr_title" runat="server" Text="Add"></asp:Literal>
                                                Deal & Offers</span>
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
                                                <div class="col-md-2">
                                                    <asp:RadioButtonList ID="rbl_Visible" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                                        <asp:ListItem Value="1" Selected="True"><font color="green">Yes</font></asp:ListItem>
                                                        <asp:ListItem Value="0"><font color="red">No</font></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <label class="col-md-2 control-label" runat="server" visible="false">Out of Stock?</label>
                                                <div class="col-md-2" runat="server" visible="false">
                                                    <asp:RadioButtonList ID="rblstockout" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                                        <asp:ListItem Value="1"><font color="red">Yes</font></asp:ListItem>
                                                        <asp:ListItem Value="0" Selected="True"><font color="green">No</font></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                                <label class="col-md-2 control-label">Hot Deal?</label>
                                                <div class="col-md-2">
                                                    <asp:RadioButtonList ID="rblFeatured" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                                        <asp:ListItem Value="1" Selected="True"><font color="green">Yes</font></asp:ListItem>
                                                        <asp:ListItem Value="0"><font color="red">No</font></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                            </div>


                                            <div class="row">
                                                <div class="col-sm-6">
                                                    <div class="form-group form-md-line-input form-md-floating-label">
                                                        <label class="col-md-4 control-label">Title:<span class="red"> * </span></label>
                                                        <div class="col-md-8">
                                                            <asp:TextBox ID="txtTitle" runat="server" MaxLength="500" CssClass="form-control maxlength-handler"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtTitle" ErrorMessage="Title is required" SetFocusOnError="true" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>

                                                        </div>

                                                    </div>
                                                    <div class="form-group form-md-line-input form-md-floating-label">
                                                        <label class="col-md-4 control-label">Deal & Offers Code:<span class="red"> * </span></label>
                                                        <div class="col-md-8">
                                                            <asp:TextBox ID="txtProductCode" runat="server" MaxLength="50" CssClass="form-control maxlength-handler"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtProductCode" ErrorMessage="Product Code is required" SetFocusOnError="true" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>
                                                    <div class="form-group form-md-line-input form-md-floating-label">
                                                        <label class="col-md-4 control-label">Category:<span class="red"> * </span></label>
                                                        <div class="col-md-8">
                                                            <asp:DropDownList ID="ddl_Category" runat="server" CssClass="form-control"></asp:DropDownList>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtProductCode" ErrorMessage="Product Category is required" SetFocusOnError="true" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row form-md-line-input form-md-floating-label">
                                                        <label class="col-md-4 control-label">Cost Price:<span class="red"> * </span></label>
                                                        <div class="col-md-8">
                                                            <div class="input-group">
                                                                <span class="input-group-addon"><i class="fa fa-usd"></i></span>
                                                                <asp:TextBox ID="txtCostPrice" runat="server" CssClass="form-control maxlength-handler" MaxLength="10"></asp:TextBox>
                                                                <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" ValidChars="0123456789." FilterMode="ValidChars" TargetControlID="txtCostPrice"></asp:FilteredTextBoxExtender>
                                                            </div>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCostPrice" ErrorMessage="Cost Price is required" SetFocusOnError="true" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row form-md-line-input form-md-floating-label">
                                                        <label class="col-md-4 control-label">Sell Price:</label>
                                                        <div class="col-md-8">
                                                            <div class="input-group">
                                                                <span class="input-group-addon"><i class="fa fa-usd"></i></span>
                                                                <asp:TextBox ID="txtSellPrice" runat="server" CssClass="form-control maxlength-handler" MaxLength="10"></asp:TextBox>
                                                                <asp:FilteredTextBoxExtender ID="ex1" runat="server" ValidChars="0123456789." FilterMode="ValidChars" TargetControlID="txtSellPrice"></asp:FilteredTextBoxExtender>
                                                            </div>
                                                        </div>
                                                    </div>
                                                     <div class="form-group row form-md-line-input form-md-floating-label">
                                                        <label class="col-md-4 control-label">Per Week:</label>
                                                        <div class="col-md-8">
                                                            <div class="input-group">
                                                                <span class="input-group-addon"><i class="fa fa-usd"></i></span>
                                                                <asp:TextBox ID="txtPerweek" runat="server" CssClass="form-control maxlength-handler" MaxLength="10"></asp:TextBox>
                                                                <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" ValidChars="0123456789." FilterMode="ValidChars" TargetControlID="txtPerweek"></asp:FilteredTextBoxExtender>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-6">
                                                    <div class="form-group row form-md-line-input form-md-floating-label">

                                                        <label class="col-md-4 control-label">Image:<span class="red"> * </span></label>
                                                        <div class="col-md-8">
                                                            <small>[File with .jpg, .gif, .png, .jpeg, .bmp extensions / formats only.]<br />
                                                                [Maximum Image Size: <%=ConfigurationManager.AppSettings["ImageSize"]%> MB]<br />
                                                                [Recommended Dimension - Width : <%=ConfigurationManager.AppSettings["ProductImgWidth"]%>px - Height :<%=ConfigurationManager.AppSettings["ProductImgHeight"]%>px]</small><br />
                                                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                                                <div class="fileinput-preview thumbnail" data-trigger="fileinput" style="width: <%=ConfigurationManager.AppSettings["ProductImgWidth"]%>px; height: <%=ConfigurationManager.AppSettings["ProductImgHeight"]%>px;">
                                                                    <img id="img" runat="server" visible="false" style="padding-bottom: 20px;" class="img-responsive" />
                                                                </div>
                                                                <div>
                                                                    <span class="btn btn-green btn-default btn-file"><span class="fileinput-new">Select image</span><span class="fileinput-exists">Change</span>
                                                                        <asp:FileUpload ID="fulp" runat="server" /></span>
                                                                    <a href="#" class="btn btn-default fileinput-exists" data-dismiss="fileinput">Remove</a>
                                                                </div>
                                                                <asp:RequiredFieldValidator ID="rfv_ProductImage" runat="server" ControlToValidate="fulp" ErrorMessage="Deal & Offers Image is required" SetFocusOnError="true" Display="Dynamic" ValidationGroup="vgValidate"></asp:RequiredFieldValidator>
                                                                <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="imageType" ControlToValidate="fulp" ErrorMessage="Only .jpg, .gif, .png, .jpeg, .bmp extensions are allowed." SetFocusOnError="True" ValidationGroup="vgValidate"></asp:CustomValidator>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="form-group row form-md-line-input form-md-floating-label" id="div_description" runat="server" visible="false">

                                                <label class="col-md-2 control-label">Deal & Offers Description</label>
                                                <br />
                                                <div class="col-md-10">
                                                                                           <asp:TextBox runat="server" ID="Editor_Description" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="tab-pane <%=Image.ToString()%>" id="portlet_tab2_2">
                            <div class="form-horizontal form-row-seperated">
                                <div class="portlet light portlet-fit portlet-datatable bordered">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="fa fa-tags font-green"></i>
                                            <span class="caption-subject font-green sbold uppercase">Existing Deal & Offers Images </span>
                                        </div>
                                        <div class="actions btn-set">
                                            <asp:LinkButton ID="Button2" runat="server" CssClass="btn btn-secondary-outline" OnClick="btn_Cancel_Click"><i class="fa fa-angle-left"></i> Back</asp:LinkButton>
                                            <asp:LinkButton ID="btn_Submit_Images" runat="server" CssClass="btn btn-success" ValidationGroup="vgImages" OnClick="btn_Submit_Images_Click"><i class="fa fa-check"></i> Save </asp:LinkButton>
                                            <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="false" ShowSummary="false" HeaderText="Please enter below details properly" ValidationGroup="vgImages" />
                                        </div>

                                    </div>
                                    <div class="portlet-body">

                                        <div class="form-body">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="row" id="existing" runat="server">
                                                        <div class="col-lg-12">
                                                        </div>
                                                        <asp:Repeater ID="RepExistingImages" runat="server" OnItemCommand="RepExistingImages_ItemCommand">
                                                            <ItemTemplate>
                                                                <div class="col-lg-3">
                                                                    <div class="panel panel-default">
                                                                        <div class="panel-body imgthumb">
                                                                            <asp:Image ID="img" runat="server" class="img-responsive" src='<%# ConfigurationManager.AppSettings["siteurl"]+"/webfiles/product/medium/"+Eval("image") %>' />
                                                                            <asp:ImageButton CssClass="delete" ID="btnDelete" runat="server" CommandName="DELETEIMG" CommandArgument='<%# Eval("id") %>' ImageUrl="../images/close.png" OnClientClick="return confirm('Are you sure you want to delete this image?');" />
                                                                        </div>

                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label class="col-md-2 control-label">Upload Multiple Deal & Offers Images</label>
                                                        <div class="col-md-10">
                                                            <small>[File with .jpg, .gif, .png, .jpeg, .bmp extensions / formats only.]<br />
                                                                [Maximum Image Size: <%= ConfigurationManager.AppSettings["ImageSize"]%> MB]<br />
                                                                [Recommended Dimension - Width : <%=ConfigurationManager.AppSettings["ProductImgWidth"]%>px - Height :<%=ConfigurationManager.AppSettings["ProductImgHeight"]%>px]</small><br />
                                                            &nbsp;
                                 <img id="Product_img" runat="server" visible="false" style="padding-bottom: 20px;" class="img-responsive" />

                                                            <asp:FileUpload ID="fulp_Images" runat="server" class="multi" />
                                                            <%--<asp:RequiredFieldValidator ID="rfv_File1" runat="server" ControlToValidate="fulp_Images" ErrorMessage="Product Images  is required" SetFocusOnError="true" Display="Dynamic" ValidationGroup="vgImages"></asp:RequiredFieldValidator>--%>
                                                            <asp:CustomValidator ID="CustomValidator11" runat="server" ClientValidationFunction="imageType" ControlToValidate="fulp_Images" ErrorMessage="Only .jpg, .gif, .png, .jpeg, .bmp extensions are allowed." SetFocusOnError="True" ValidationGroup="vgImages"></asp:CustomValidator>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane <%=Associate.ToString()%>" id="portlet_tab2_3">
                             <asp:UpdatePanel ID="upnl1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress AssociatedUpdatePanelID="upnl1" ID="UP_product" runat="server">

                <ProgressTemplate>
                    <div id="loading" class="loadingimg" style="height: 100%; width: 100%;" align="center">
                        <img src="../../images/loader.gif" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
                            <div class="form-horizontal form-row-seperated">
                                <div class="portlet light portlet-fit portlet-datatable bordered">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="fa fa-tags font-green"></i>
                                            <span class="caption-subject font-green sbold uppercase">Associate Deal & Offers</span>
                                        </div>
                                        <div class="actions btn-set">
                                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-secondary-outline" OnClick="btn_Cancel_Click"><i class="fa fa-angle-left"></i> Back</asp:LinkButton>
                                            <asp:LinkButton ID="Button1" runat="server" CssClass="btn btn-success" ValidationGroup="vgValidate1" OnClick="Button1_Click"><i class="fa fa-check"></i> Save </asp:LinkButton>
                                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true" ShowSummary="false" HeaderText="Please enter below details properly" ValidationGroup="vgValidate1" />
                                        </div>

                                    </div>
                                    <div class="portlet-body">
                                        <div class="form-body">
                                                    <div class="form-group">
                                                        <div class="col-sm-4" >


                                                            <div id="dataTables-example_filter" class="dataTables_filter">
                                                                <label>
                                                                    Search:
                                 <div class="col-lg-12 input-group">
                                     <asp:TextBox ID="tbx_Search" runat="server" AutoPostBack="true" CssClass="form-control input-sm" placeholder="" aria-controls="dataTables-example" OnTextChanged="tbx_Search_TextChanged"></asp:TextBox>
                                     <label runat="server" id="lbl_date" for="tbx_PublishDate" class="input-group-addon btn"><span class="fa fa-search"></span></label>
                                 </div>
                                                                </label>
                                                            </div>

                                                        </div>
                                                        <div class="col-sm-4" >
                                                            Category:
                                                              <asp:DropDownList ID="ddlAssCategory" AutoPostBack="true" OnSelectedIndexChanged="ddlAssCategory_SelectedIndexChanged" runat="server" CssClass="form-control"></asp:DropDownList>
                                                            </div>
                                                    </div>


                                                    <div class="form-group">
                                                        <div class="col-lg-5">
                                                            <label>Product</label>
                                                            <div class="col-lg-12  input-group">

                                                                <asp:ListBox ID="lbproduct" runat="server" Height="150" Width="300" SelectionMode="Multiple"></asp:ListBox>
                                                            </div>

                                                        </div>
                                                        <div class="form-group col-lg-2" style="padding-left: 0px">
                                                            <br />
                                                            <div class="row">
                                                                <ul class="pagination">
                                                                    <li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next">
                                                                        <asp:LinkButton ID="btnAddstyle" runat="server" aria-label="Next"
                                                                            ToolTip="Add to List" OnClick="btnAddstyle_Click"><span aria-hidden="true">>></span></asp:LinkButton></li>
                                                                </ul>
                                                            </div>
                                                            <div class="row">
                                                                <ul class="pagination">
                                                                    <li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="Li1">
                                                                        <asp:LinkButton ID="btnRemovestyle"
                                                                            runat="server" Text="<<" ToolTip="Remove from List"
                                                                            OnClick="btnRemovestyle_Click" /></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-lg-5" style="padding-left: 0px">
                                                            <label>Associated Product</label>
                                                            <div class="col-lg-12  input-group">
                                                                <asp:ListBox ID="lbassociate" runat="server" Height="150" Width="300" SelectionMode="Multiple"></asp:ListBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                               </div>
                                    </div>
                                </div>
                            </div>
              </ContentTemplate>
    </asp:UpdatePanel>
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
    <script type="text/javascript" src="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/layouts/global/scripts/jquery.MultiFile.js"></script>
    <script src="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-multiselect/js/bootstrap-multiselect.js" type="text/javascript"></script>

</asp:Content>

