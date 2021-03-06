﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="viewProduct.aspx.cs" Inherits="merchant_product_viewProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet" type="text/css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- BEGIN PAGE HEADER-->
    <!-- BEGIN PAGE BAR -->
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li>
                <a href="../dashboard.aspx">Home</a>
                <i class="fa fa-circle"></i>
            </li>
            <li>
                <span>Deal & Offers Management</span>
            </li>
        </ul>

    </div>
    <br />
    <asp:UpdatePanel ID="upnl1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress AssociatedUpdatePanelID="upnl1" ID="UP_product" runat="server">

                <ProgressTemplate>
                    <div id="loading" class="loadingimg" style="height: 100%; width: 100%;" align="center">
                        <img src="../../images/loader.gif" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div id="div_Error" runat="server" class="alert alert-danger" visible="false">
                <asp:Literal ID="ltr_Error" runat="server"></asp:Literal>
            </div>
            <div id="div_Success" runat="server" class="alert alert-success" visible="false">
                <asp:Literal ID="ltr_Success" runat="server"></asp:Literal>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <!-- Begin: life time stats -->
                    <div class="portlet light portlet-fit portlet-datatable bordered">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="fa fa-shopping-bag font-green"></i>
                                <span class="caption-subject font-green sbold uppercase">View Deal & Offers </span>
                            </div>

                            <div class="actions">


                                <a href="manageproduct.aspx" class="btn btn-circle btn-info">
                                    <i class="fa fa-plus"></i>
                                    <span class="hidden-xs">Add New Deal & Offers </span>
                                </a>
                                <div class="btn-group" runat="server" id="btnActions">
                                    <a class="btn red btn-outline btn-circle" href="javascript:;" data-toggle="dropdown">
                                        <i class="fa fa-share"></i>
                                        <span class="hidden-xs">Tools </span>
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                    <ul class="dropdown-menu pull-right">
                                        <li>
                                            <asp:Button ID="lb_Active" OnClientClick="return modalurl(this,'Are you sure you want to change status to Visible selected record?')" runat="server" CommandName="visible" Text='Visible Selected' OnClick="lb_Action_Click" CssClass="link-button"></asp:Button></li>
                                        <li>
                                            <asp:Button ID="lb_Deactive" OnClientClick="return modalurl(this,'Are you sure you want to change status to Hide selected record?');" runat="server" CommandName="hide" Text="Hide Selected" OnClick="lb_Action_Click" CssClass="link-button"></asp:Button></li>

                                        <li>
                                            <asp:Button ID="lb_Delete" OnClientClick="return modalurl(this,'Are you sure you want to delete selected record?');" runat="server" CommandName="delete" Text="Delete Selected" OnClick="lb_Action_Click" CssClass="link-button"></asp:Button></li>
                                    </ul>
                                </div>
                            </div>

                        </div>

                        <div class="portlet-body">

                            <div class="table-container">
                                <div class="table-scrollable">
                                    <table class="table table-striped table-bordered table-hover table-checkable" id="" style="border: none;">

                                        <thead>
                                            <asp:Panel runat="server" ID="pnlSearch" DefaultButton="lbSearch">
                                                <tr role="row" class="filter form-group form-md-line-input ">
                                                    <td style="border: none;">
                                                        <div class="dataTables_length" id="dataTables-example_length">
                                                            <label>
                                                                <asp:DropDownList ID="ddl_Rows" runat="server" AutoPostBack="true" aria-controls="dataTables-example" CssClass="form-control input-sm" OnSelectedIndexChanged="ddl_Rows_SelectedIndexChanged">
                                                                    <asp:ListItem Text="25" Value="25"></asp:ListItem>
                                                                    <asp:ListItem Text="50" Value="50"></asp:ListItem>
                                                                    <asp:ListItem Text="75" Value="75"></asp:ListItem>
                                                                    <asp:ListItem Text="100" Value="100"></asp:ListItem>
                                                                    <asp:ListItem Text="200" Value="200"></asp:ListItem>
                                                                </asp:DropDownList></label>
                                                        </div>
                                                    </td>
                                                    <td style="border: none;"></td>
                                                    <td style="border: none;">
                                                        <asp:TextBox ID="tbx_Search" runat="server" placeholder="Deal & Offers name" CssClass="form-control form-filter input-sm"></asp:TextBox>

                                                    </td>
                                                    <td style="border: none;">
                                                        <asp:DropDownList ID="ddl_Category" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddl_Category_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                    </td>
                                                    <td style="border: none;">
                                                        <asp:DropDownList ID="ddlvisble" runat="server" aria-controls="dataTables-example" CssClass="form-control input-sm">
                                                            <asp:ListItem Value="">Select</asp:ListItem>
                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                        </asp:DropDownList></td>
                                                     <td style="border: none;">
                                                        <asp:DropDownList ID="ddlFeatured" runat="server" aria-controls="dataTables-example" CssClass="form-control input-sm">
                                                            <asp:ListItem Value="">Select</asp:ListItem>
                                                            <asp:ListItem Value="1">Yes</asp:ListItem>
                                                            <asp:ListItem Value="0">No</asp:ListItem>
                                                        </asp:DropDownList></td>
                                                    
                                                    <%if(ddl_Category.SelectedValue.ToString()!=""){ %>
                                                    <td style="border: none;">&nbsp;</td>
                                                    <%} %>
                                                    <td style="border: none;">
                                                        <div class="margin-bottom-5">
                                                            <asp:LinkButton runat="server" ID="lbSearch" OnClick="btnSubmit_Click" class="btn btn-sm btn-success filter-submit margin-bottom">
                                                                    <i class="fa fa-search"></i> Search</asp:LinkButton>

                                                            <asp:LinkButton runat="server" ID="lbReset" OnClick="lbReset_Click" Visible="false" class="btn btn-sm btn-default filter-cancel">
                                                                <i class="fa fa-times"></i></asp:LinkButton>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </asp:Panel>

                                            <tr role="row" class="heading">
                                                <td>
                                                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                        <input type="checkbox" id="ckbCheckAll" onclick="updatechk(this)" />
                                                        <span></span>
                                                    </label>
                                                </td>
                                                <th></th>
                                                <th>Deal & Offers Name</th>
                                                <th>Category</th>
                                                <th>Visible</th>
                                                 <th>Hot Deal</th>
                                                <%if(ddl_Category.SelectedValue.ToString()!=""){ %>
                                                <th>Sort order</th>
                                                <%} %>
                                                <th>Action</th>
                                            </tr>

                                        </thead>
                                        <tbody>
                                            <asp:Panel ID="pnl_Record" runat="server">
                                                <asp:Repeater ID="rep" runat="server" OnItemCommand="rep_ItemCommand" OnItemDataBound="rep_ItemDataBound">
                                                    <ItemTemplate>
                                                        <tr role="row" class="odd">

                                                            <td>
                                                                <asp:HiddenField ID="hfNewsId" runat="server" Value='<%#Eval("id") %>' />
                                                                <asp:HiddenField ID="hfCatid" runat="server" Value='<%#Eval("catid") %>' />

                                                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                                    <asp:CheckBox ID="checkboxDelete" runat="server" /><span></span></label>
                                                            </td>
                                                            <td><%# GetImage(Eval("image").ToString()) %></td>
                                                            <td data-th="Deal & Offers Name"><%#Eval("Title").ToString().Length>30 ? Eval("Title").ToString().Replace("''", "'").Substring(0,27)+"..." : Eval("Title").ToString().Replace("''", "'") %></td>
                                                            <td data-th="Category Name"><%#Eval("category").ToString().Length>30 ? Eval("category").ToString().Replace("''", "'").Substring(0,27)+"..." : Eval("category").ToString().Replace("''", "'") %></td>
                                                            <td data-th="Visible"><%#Eval("Visible").ToString().Replace("True","<span class='label label-info label-sm'>Yes</span>").Replace("False","<span class='label label-danger label-sm'>No</span>") %></td>
                                                            <td data-th="Featured"><%#Eval("featured").ToString().Replace("True","<span class='label label-info label-sm'>Yes</span>").Replace("False","<span class='label label-danger label-sm'>No</span>") %></td>
                                                             <%if(ddl_Category.SelectedValue.ToString()!=""){ %>
                                                            <td data-th="Sortorder" class="center">
                                                                <asp:HiddenField ID="hdnDisId" runat="server" Value='<%#Eval("sortorder") %>' />
                                                                <asp:DropDownList ID="ddlDisplayOrder" runat="server" AutoPostBack="true" CommandName="ChangeDisplayStatus" CommandArgument='<%#Eval("id")%>' OnSelectedIndexChanged="ddlDisplayOrder_SelectedIndexChanged" />
                                                             </td>
                                                               <%} %>
                                                            <td class="dt-body-right sorting_1">
                                                                <div class="mt-action-buttons ">
                                                                    <div class="btn-group btn-group-circle">
                                                                        <a href='manageproduct.aspx?id=<%#Eval("id") %>' class="btn btn-outline green btn-sm"><i class="fa fa-pencil"></i></a>
                                                                        <span style="position: relative;" class="btn btn-outline red btn-sm">
                                                                            <i class="fa fa-trash"></i>
                                                                            <asp:Button ID="ibDelete" OnClientClick="return modalurl(this,'Are you sure you want to delete this record?');" class="movedown" CommandName="Delete" CommandArgument='<%#Eval("id")%>' runat="server" Text=""></asp:Button></span>
                                                                    </div>
                                                                </div>
                                                            </td>

                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </asp:Panel>


                                            <tr class="panel-body" id="div_msg" runat="server" visible="false">
                                                <td colspan="9">
                                                    <label>
                                                        <asp:Literal ID="ltr_msg" runat="server"></asp:Literal></label>
                                                </td>

                                            </tr>

                                        </tbody>
                                    </table>
                                </div>
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
                                                     <asp:TextBox ID="tbx_PageNumber" runat="server" AutoPostBack="true" CssClass="pagination-panel-input form-control input-sm input-inline input-mini" MaxLength="5" Style="text-align: center; margin: 0 5px;" OnTextChanged="tbx_PageNumber_TextChanged"></asp:TextBox>
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
    </asp:UpdatePanel>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extrajs" runat="Server">
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script src="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/scripts/datatable.js" type="text/javascript"></script>
    <script src="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/datatables/datatables.min.js" type="text/javascript"></script>
    <script src="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js" type="text/javascript"></script>
    <script src="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
    <script src="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js" type="text/javascript"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/pages/scripts/ecommerce-orders.min.js" type="text/javascript"></script>
    <!-- END PAGE LEVEL SCRIPTS -->
    <script>
        //$(document).ready(function () {
        //    function chk() {
        //        $("input[type=checkbox]").addClass("make-switch");

        //    }
        //    chk();
        //});
        $(document).ready(function () {
            $(document).ready(function () {
                start_switch();
            });

            function start_switch() {
                $(".custom_check input").bootstrapSwitch();
            }
            //$('#cblive').bootstrapSwitch();
            //$("input[type=checkbox]").addClass("make-switch");
        });
    </script>
    <script type="text/javascript">
        function updatechk(involker) {
            var inputElements = document.getElementsByTagName('input');
            for (var i = 0; i < inputElements.length; i++) {
                var myElement = inputElements[i];
                if (myElement.type === "checkbox" && myElement.id != 'ckbCheckAll')
                    myElement.checked = involker.checked;
            }
        }
    </script>
</asp:Content>

