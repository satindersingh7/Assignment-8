﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="viewOrder.aspx.cs" Inherits="Poweradmin_order_viewOrde" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
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
                <a href="../dashboard.aspx">Home</a>
                <i class="fa fa-circle"></i>
            </li>
            <li>
                <span>Order Management</span>
            </li>
        </ul>

    </div>
    <br />
    <asp:UpdatePanel ID="upnl1" runat="server">
        <ContentTemplate>
            <script type="text/javascript">    Sys.Application.add_load(ReloadDate);</script>
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
                                <i class="fa fa-tags font-green"></i>
                                <span class="caption-subject font-green sbold uppercase">View Orders </span>
                            </div>

                            <div class="actions">

                                <div class="btn-group">
                                    <a class="btn red btn-outline btn-sm btn-circle" href="javascript:;" data-toggle="dropdown"><i class="fa fa-share"></i><span class="hidden-xs">Tools </span><i class="fa fa-angle-down"></i></a>
                                    <ul class="dropdown-menu pull-right">
                                        <%--<li>
                                            <asp:Button ID="lb_Active" OnClientClick="return modalurl(this,'Are you sure you want to change status to visible selected record?');" runat="server" CommandName="active" Text="Visible Selected" CssClass="link-button" OnClick="lb_Action_Click"></asp:Button></li>
                                        <li>
                                            <asp:Button ID="lb_Deactive" OnClientClick="return modalurl(this,'Are you sure you want to change status to hide selected record?');" runat="server" CommandName="deactive" Text="Hide Selected" CssClass="link-button" OnClick="lb_Action_Click"></asp:Button></li>--%>
                                        <li>
                                            <asp:Button ID="lb_Delete" OnClientClick="return modalurl(this,'Are you sure you want to delete selected record?');" runat="server" CommandName="delete" Text="Delete Selected" CssClass="link-button" OnClick="lb_Action_Click"></asp:Button></li>
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
                                                    <td style="border: none;">
                                                        <asp:TextBox ID="tbx_Search" runat="server" placeholder="Name" CssClass="form-control form-filter input-sm"></asp:TextBox>

                                                    </td>
                                                    <td style="border: none;">
                                                        <div class="input-group date date-picker margin-bottom-5" data-date-format="dd-M-yyyy">
                                                            <asp:TextBox ID="tbx_FromDate" runat="server" class="form-control form-filter input-sm" placeholder="From Date"></asp:TextBox>

                                                            <span class="input-group-btn">
                                                                <button class="btn btn-sm default" type="button">
                                                                    <i class="fa fa-calendar"></i>
                                                                </button>
                                                            </span>
                                                        </div>
                                                    </td>
                                                    <td style="border: none;">
                                                        <div class="input-group date date-picker margin-bottom-5" data-date-format="dd-M-yyyy">
                                                            <asp:TextBox ID="tbx_ToDate" runat="server" class="form-control form-filter input-sm" placeholder="To Date"></asp:TextBox>

                                                            <span class="input-group-btn">
                                                                <button class="btn btn-sm default" type="button">
                                                                    <i class="fa fa-calendar"></i>
                                                                </button>
                                                            </span>
                                                        </div>
                                                    </td>
                                                    <%--<td style="border:none"></td>--%>

                                                    <td style="border: none"></td>
                                                    <td style="border: none;">
                                                        <asp:DropDownList ID="ddlStatus" runat="server" aria-controls="dataTables-example" CssClass="form-control input-sm">
                                                        </asp:DropDownList></td>
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
                                                <th>OrderID</th>
                                                <th>Order Date</th>
                                                <th>Customer Name</th>
                                                <%-- <th>Instructions</th>--%>
                                                <th>Amount</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                                <th>Print</th>
                                            </tr>

                                        </thead>
                                        <tbody>
                                            <asp:Panel ID="pnl_Record" runat="server">
                                                <asp:Repeater ID="rep" runat="server" OnItemCommand="rep_ItemCommand" OnItemDataBound="rep_ItemDataBound">
                                                    <ItemTemplate>
                                                        <tr role="row" class="odd">

                                                            <td>
                                                                <asp:HiddenField ID="hfNewsId" runat="server" Value='<%#Eval("id") %>' />

                                                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                                    <asp:CheckBox ID="checkboxDelete" runat="server" /><span></span></label>
                                                            </td>
                                                            <td data-th="OrderID"><%#Eval("orderid").ToString()%></td>
                                                            <td data-th="Orderdate"><%#Convert.ToDateTime(Eval("orderdate")).ToString("MM-dd-yyyy hh:mm")%></td>
                                                            <td data-th="CustomerName"><%#Eval("sname").ToString()%></td>
                                                            <%-- <td data-th="Instructions"><%#Eval("specialins").ToString().Length>30?Eval("specialins").ToString().Substring(0, 27)+"...":Eval("specialins")+""%></td>--%>
                                                            <td data-th="Amount"><%#Eval("finalamount").ToString()%></td>
                                                            <td data-th="Amount"><%#Convert.ToInt32(Eval("status"))== 5 ?"<span class='label label-danger label-sm'>"+Eval("statusname")+"</span>":"<span class='label label-info label-sm'>"+Eval("statusname")+"</span>" %></td>
                                                            <td class="dt-body-right sorting_1">
                                                                <div class="mt-action-buttons ">
                                                                    <div class="btn-group btn-group-circle">
                                                                        <a href='manageorder.aspx?id=<%#Eval("id") %>' class="btn btn-outline green btn-sm"><i class="fa fa-eye"></i></a>
                                                                        <span id="Span1" style="position: relative;" class="btn btn-outline red btn-sm" runat="server">
                                                                            <i class="fa fa-trash"></i>
                                                                            <asp:Button ID="ibDelete" OnClientClick="return modalurl(this,'Are you sure you want to delete this record?');" class="movedown" CommandName="Delete" CommandArgument='<%#Eval("id")%>' runat="server" Text=""></asp:Button></span>

                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td data-th="Print"><a href='printbillpreview.aspx?id=<%#Eval("id")%>' class="btn btn-default" target="_blank">Print</a></td>
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
        $(document).ready(function () {
            $(document).ready(function () {
                start_switch();
            });

            function start_switch() {
                $(".custom_check input").bootstrapSwitch();
            }
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

