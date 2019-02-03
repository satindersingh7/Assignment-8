<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="viewenquiry.aspx.cs" Inherits="Poweradmin_PEnquiry_viewenquiry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
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
            <li>
                <span>Product Enquiry Management</span>
            </li>
        </ul>

    </div>
    <!-- END PAGE BAR -->
    <!-- BEGIN PAGE TITLE-->
    <br />
    <!-- END PAGE TITLE-->
    <!-- END PAGE HEADER-->



    <div class="row">
        <div class="col-md-12">
            <!-- Begin: life time stats -->
            <div class="portlet light portlet-datatable bordered">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-info font-green"></i>
                        <span class="caption-subject font-green sbold uppercase">View Product Enquiry</span>
                    </div>
                    <div class="actions">

                        <div class="btn-group">
                            
                            <a class="btn red btn-outline btn-circle" href="javascript:;" data-toggle="dropdown"><i class="fa fa-share"></i><span class="hidden-xs">Tools </span><i class="fa fa-angle-down"></i></a>
                            <ul class="dropdown-menu pull-right">
                                <li>
                                    <asp:Button ID="lb_Delete" CssClass="link-button" OnClientClick="return modalurl(this,'Are you sure you want to delete selected record?');" runat="server" CommandName="delete" Text="Delete Selected" OnClick="lb_Action_Click"></asp:Button></li>
                            </ul>
                        </div>
                    </div>
                </div>
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
                        <div class="portlet-body">
                           
     <div class="table-container">
          <div class="table-scrollable">
                                <table class="table table-striped table-bordered table-hover table-checkable" id="" style="border: none;">
                                    <thead>
                                        <tr role="row" class="filter form-group form-md-line-input ">
                                            <td style="border: none;">
                                                <asp:DropDownList ID="ddl_Rows" runat="server" AutoPostBack="true" aria-controls="dataTables-example" CssClass="form-control input-sm" OnSelectedIndexChanged="ddl_Rows_SelectedIndexChanged">
                                                    <asp:ListItem Text="25" Value="25"></asp:ListItem>
                                                    <asp:ListItem Text="50" Value="50"></asp:ListItem>
                                                    <asp:ListItem Text="75" Value="75"></asp:ListItem>
                                                    <asp:ListItem Text="100" Value="100"></asp:ListItem>
                                                    <asp:ListItem Text="200" Value="200"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td style="border: none;">
                                                <asp:TextBox ID="tbx_Search" runat="server" CssClass="form-control input-sm" placeholder="Name" aria-controls="dataTables-example"></asp:TextBox></td>
                                            <td style="border: none;">
                                                <asp:TextBox ID="tbx_SearchLastName" runat="server" CssClass="form-control input-sm" placeholder="Email" aria-controls="dataTables-example"></asp:TextBox></td>
                                            <td style="border: none;">
                                                <div class="input-group date date-picker margin-bottom-5" data-date-format="dd-M-yyyy">
                                                    <asp:TextBox ID="tbx_Date" runat="server" class="form-control form-filter input-sm" placeholder="Date"></asp:TextBox>

                                                    <span class="input-group-btn">
                                                        <button class="btn btn-sm default" type="button">
                                                            <i class="fa fa-calendar"></i>
                                                        </button>
                                                    </span>
                                                </div>
                                            </td>
                                             <td style="border: none;">
                                                        <asp:DropDownList ID="ddlstatus" runat="server" aria-controls="dataTables-example" CssClass="form-control input-sm">
                                                            <asp:ListItem Value="">Select</asp:ListItem>
                                                            <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                                            <asp:ListItem Value="Completed">Completed</asp:ListItem>
                                                            <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
                                                        </asp:DropDownList></td>
                                            <td style="border: none;">
                                                <div class="margin-bottom-5">
                                                    <asp:LinkButton runat="server" ID="lbSearch" OnClick="lbSearch_Click" class="btn btn-sm btn-success filter-submit margin-bottom">
                                                                    <i class="fa fa-search"></i> Search</asp:LinkButton>

                                                    <asp:LinkButton runat="server" ID="lbReset" OnClick="lbReset_Click" Visible="true" class="btn btn-sm btn-default filter-cancel">
                                                                <i class="fa fa-times"></i></asp:LinkButton>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr role="row" class="heading">
                                            <td>
                                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                    <input type="checkbox" id="ckbCheckAll" onclick="updatechk(this)" />
                                                    <span></span>
                                                </label>
                                            </td>
                                            <th>Name</th>   
                                            <th>Email</th>
                                            <th>Date</th>
                                            <th>Status</th>
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
                                                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                                <asp:CheckBox ID="checkboxDelete" runat="server" /><span></span></label>
                                                        </td>
                                                        <td data-th="Name"><%#Eval("Name").ToString() + ((Eval("unread").ToString() == "True")? "<div class='tooltip right' role='tooltip' style='opacity:100;display:inline-block;'> <div class='tooltip-arrow'></div> <div class='tooltip-inner'> New ! </div> </div>" : "") %></td>
                                                        
                                                         <td data-th="Email"><%#Eval("email").ToString() %></td>
                                                        <td data-th="Date"><%#DateTime.Parse(Eval("orderDate").ToString()).ToString("dd-MMM-yyyy") %></td>
                                                         <td data-th="Email"><%#Eval("orderstatus").ToString().Replace("Pending","<span class='label label-warning label-sm'>Pending</span>").Replace("Completed","<span class='label label-success label-sm'>Completed</span>").Replace("Cancelled","<span class='label label-danger label-sm'>Cancelled</span>") %></td>
                                                        <td class="dt-body-right sorting_1">
                                                            <div class="mt-action-buttons ">
                                                                <div class="btn-group btn-group-circle">
                                                                    <a href='enquirydetails.aspx?id=<%#Eval("id") %>' class="btn btn-outline green btn-sm"><i class="fa fa-pencil"></i></a>
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
                                            <td colspan="8">
                                                <label>
                                                    <asp:Literal ID="ltr_msg" runat="server"></asp:Literal></label>
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
         </div>
                                <strong>
                                    <br />
                                    <asp:Literal ID="ltr_msg2" runat="server"></asp:Literal></strong>
                                <div class="row" >
                                    <div class="col-sm-5">
                                       Showing
                                            <asp:Literal ID="ltr_Start" runat="server"></asp:Literal>
                                        to
                                            <asp:Literal ID="ltr_End" runat="server"></asp:Literal>
                                        of
                                            <asp:Literal ID="ltr_Total" runat="server"></asp:Literal>
                                        entries
                                    </div>
                                    <div class="col-sm-7" style="text-align: right;" runat="server" visible="false" id="div_Paging" >
                                        <div class="dataTables_paginate paging_simple_numbers">
                                            <ul class="pagination">
                                                <li class="paginate_button previous disabled" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous">
                                                    <asp:LinkButton ID="lnkPrevious" runat="server" aria-label="Previous" OnClick="lnkPrevious_Click"><span aria-hidden="true">«</span></asp:LinkButton></li>

                                                <asp:Repeater ID="RepeaterPaging" runat="server" OnItemCommand="RepeaterPaging_ItemCommand" OnItemDataBound="RepeaterPaging_ItemDataBound">
                                                    <ItemTemplate>
                                                        <asp:Literal ID="ltrli" runat="server"></asp:Literal>
                                                        <asp:LinkButton ID="Pagingbtn" runat="server" ClientIDMode="AutoID" CommandArgument='<%# Eval("PageIndex") %>' CommandName="newpage"><span><%# Eval("PageText") %></span></asp:LinkButton>
                                                        </li>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                <li class="paginate_button next" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_next">
                                                    <asp:LinkButton ID="lnkNext" runat="server" aria-label="Next" OnClick="lnkNext_Click"> <span aria-hidden="true">»</span></asp:LinkButton></li>
                                            </ul>
                                        </div>
                                       
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>

                </asp:UpdatePanel>
            </div>
        </div>
        <!-- End: life time stats -->
    </div>




</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extrajs" runat="Server">
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script src="../assets/global/scripts/datatable.js" type="text/javascript"></script>
    <script src="../assets/global/plugins/datatables/datatables.min.js" type="text/javascript"></script>
    <script src="../assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js" type="text/javascript"></script>
    <script src="../assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
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
    </script>
</asp:Content>



