<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="viewtemplate.aspx.cs" Inherits="Poweradmin_Newsletter_viewtemplate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <link href="../assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- BEGIN PAGE HEADER-->
    <!-- BEGIN PAGE BAR -->
    <div class="page-bar">
        <ul class="page-breadcrumb">
            <li>
                 <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/dashboard.aspx">Home</a>
                <i class="fa fa-circle"></i>
            </li>
            <li>
                <span>Newsletter Management</span>
            </li>
        </ul>

    </div>
    <!-- END PAGE BAR -->
    <!-- BEGIN PAGE TITLE-->
    <h1 class="page-title">Newsletter Management
                            
    </h1>
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
                    <!-- Begin: life time stats -->
                    <div class="portlet light portlet-fit portlet-datatable bordered">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-user font-green"></i>
                                <span class="caption-subject font-green sbold uppercase">View Template</span>
                            </div>
                            <div class="actions"> 
                                <a  href="manage-template.aspx" class="btn btn-circle btn-info"><i class="fa fa-plus"></i><span class="hidden-xs">New Template </span></a>                            
                                <div class="btn-group">                                      
                                    <a class="btn red btn-outline btn-circle" href="javascript:;" data-toggle="dropdown"><i class="fa fa-share"></i><span class="hidden-xs">Tools </span><i class="fa fa-angle-down"></i></a>
                                    <ul class="dropdown-menu pull-right">                                       
                                        <li><asp:LinkButton ID="lb_Delete" OnClientClick="return confirm('Are you sure you want to delete selected record?');" runat="server" CommandName="delete" Text="Delete Selected" OnClick="lb_Action_Click"></asp:LinkButton></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="portlet-body">

                            <div class="row">
                                <div class="col-sm-5">
                                    <div class="dataTables_length" id="dataTables-example_length">
                                        <label>
                                            Show
                         <asp:DropDownList ID="ddl_Rows" runat="server" AutoPostBack="true" aria-controls="dataTables-example" CssClass="form-control input-sm" OnSelectedIndexChanged="ddl_Rows_SelectedIndexChanged">
                             <asp:ListItem Text="25" Value="25"></asp:ListItem>
                             <asp:ListItem Text="50" Value="50"></asp:ListItem>
                             <asp:ListItem Text="75" Value="75"></asp:ListItem>
                             <asp:ListItem Text="100" Value="100"></asp:ListItem>
                             <asp:ListItem Text="200" Value="200"></asp:ListItem>
                         </asp:DropDownList></label>
                                    </div>
                                </div>

                            </div>

                            <div class="table-container">
                                
                                <table class="table table-striped table-bordered table-hover table-checkable" id="">
                                    <thead>
                                        <tr role="row" class="heading">
                                            <td>
                                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                    <input type="checkbox" id="ckbCheckAll" onclick="updatechk(this)" />
                                                    <span></span>
                                                </label>
                                            </td>
                                              <th width="80%">Title</th>  
                                                <th></th>
                                        </tr>
                                        <tr role="row" class="filter">
                                            <td></td>
                                            <td><asp:TextBox ID="tbx_Search" runat="server"  CssClass="form-control input-sm" placeholder="" aria-controls="dataTables-example"></asp:TextBox></td>
                                            <td>
                                                <div class="margin-bottom-5">
                                                    <asp:LinkButton runat="server" ID="lbSearch" OnClick="lbSearch_Click" class="btn btn-sm btn-success filter-submit margin-bottom">
                                                                    <i class="fa fa-search"></i> Search</asp:LinkButton>
                                                </div>
                                                   <asp:LinkButton runat="server" ID="lbReset" OnClick="lbReset_Click" Visible="true" class="btn btn-sm btn-default filter-cancel">
                                                                <i class="fa fa-times"></i> Reset</asp:LinkButton>
                                            </td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Panel ID="pnl_Record" runat="server">
                                            <asp:Repeater ID="rep" runat="server" OnItemCommand="rep_ItemCommand"  OnItemDataBound="rep_ItemDataBound">
                                                <ItemTemplate>
                                                     <tr role="row" class="odd">
                                                       <td>
                                                        <asp:HiddenField ID="hfNewsId" runat="server" Value='<%#Eval("id") %>' />
                                                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                            <asp:CheckBox ID="checkboxDelete" runat="server" /><span></span></label>
                                                    </td>
                                                     <td data-th="Title"><%#Eval("Title").ToString()%></td>
                                                   <td class="dt-body-right sorting_1">
                                                            <div class="btn-group"><a class="btn red btn-outline btn-circle" href="javascript:;" data-toggle="dropdown"><i class="fa fa-share"></i><span class="hidden-xs">Action </span><i class="fa fa-angle-down"></i></a>
                                                            <ul class="dropdown-menu pull-right">
                                        <li><a href='manage-template.aspx?id=<%#Eval("id") %>'>Edit</a></li>                                          
                                        <li><asp:LinkButton ID="ibDelete" OnClientClick="return confirm('Are you sure you want to delete this record?');" CommandName="Delete" CommandArgument='<%#Eval("id")%>' runat="server" Text="Delete"></asp:LinkButton></li>                                       
                                    </ul>
                                </div>
                                                            </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </asp:Panel>
                                           
                                        
                                        <tr id="div_msg" runat="server" visible="false">
                                               <td colspan="3">
                                                                               <label>
                                <asp:Literal ID="ltr_msg" runat="server"></asp:Literal></label>
                                               </td>
</tr>

                                    </tbody>
                                </table>
                                      <strong>
                                    <br />
                                    <asp:Literal ID="ltr_msg2" runat="server"></asp:Literal></strong>
                                <div class="row">
                                    <div class="col-sm-5">
                                        &nbsp;
                                    </div>
                                    <div class="col-sm-7" style="text-align: right;">
                                        <div class="dataTables_paginate paging_simple_numbers" id="div_Paging" runat="server" visible="false">
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
                                        Showing
                                            <asp:Literal ID="ltr_Start" runat="server"></asp:Literal>
                                        to
                                            <asp:Literal ID="ltr_End" runat="server"></asp:Literal>
                                        of
                                            <asp:Literal ID="ltr_Total" runat="server"></asp:Literal>
                                        entries
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
<asp:Content ID="Content3" ContentPlaceHolderID="extrajs" Runat="Server">
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






