<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="pagelisting.aspx.cs" Inherits="Poweradmin_pagecontent_pagelisting" %>

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
                <span>Page Content Management</span>
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
                                <i class="fa fa-file-text-o font-green"></i>
                                <span class="caption-subject font-green sbold uppercase">View Pages</span>
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
                                            
                                                <th style="text-align:left;padding-left:5px;" width="80%">Page Name</th>                                                                                    
                                                <th>Edit</th>     
                                        </tr>
                                        
                                    </thead>
                                    <tbody>
                                        <asp:Panel ID="pnl_Record" runat="server">
                                            <asp:Repeater ID="rep" runat="server" OnItemCommand="rep_ItemCommand">
                                                <ItemTemplate>
                                                     <tr role="row" class="odd">                                                       
                                                  <td style="text-align:left;;padding-left:5px;"><a href="Content.aspx?Page=<%#Server.UrlEncode(Eval("PageName").ToString()) %>"> <%#Eval("PageName") %></a>
                                                 <asp:HiddenField ID="HiddenField1" runat="server" Value='<%#Eval("id") %>' /> 
                                            </td>                                            
                                            <td class="dt-body-right sorting_1"><a href='Content.aspx?Page=<%#Server.UrlEncode(Eval("PageName").ToString()) %>' ><i class="fa fa-pencil"></i></a></td>                                            
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



