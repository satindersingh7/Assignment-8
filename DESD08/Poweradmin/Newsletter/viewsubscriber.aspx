<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="viewsubscriber.aspx.cs" Inherits="Poweradmin_Newsletter_viewsubscriber" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <link href="../assets/global/plugins/datatables/datatables.min.css" rel="stylesheet" type="text/css" />
    <link href="../assets/global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.css" rel="stylesheet" type="text/css" />   
    <script>
        function ValidateBoxes(source, arguments) {
            var a = document.getElementById('<%=tbx_Search.ClientID%>').value;
         var b = document.getElementById('<%=tbx_SearchEmail.ClientID%>').value;
         var c = document.getElementById('<%=ddl_Group.ClientID%>').value;
            var d = document.getElementById('<%=ddl_Subscribe.ClientID%>').value;
            if (a == "" && b == "" && c == "" && d == "") {

             arguments.IsValid = false;/* your validation logic */
         }
         else
             arguments.IsValid = true;
     }
    </script>
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
                                <i class="icon-user font-green"></i>
                                <span class="caption-subject font-green sbold uppercase">View Subscriber</span>
                            </div>
                            <div class="actions"> 
                                <a  href="manage-subscriber.aspx" class="btn btn-circle btn-info"><i class="fa fa-plus"></i><span class="hidden-xs">New Subscriber </span></a>                            
                                <div class="btn-group">                                      
                                    <a class="btn red btn-outline btn-circle" href="javascript:;" data-toggle="dropdown"><i class="fa fa-share"></i><span class="hidden-xs">Action </span><i class="fa fa-angle-down"></i></a>
                                    <ul class="dropdown-menu pull-right">     
                                         <li><asp:Button ID="lb_Active" OnClientClick="return SelectAction(this,'Are you sure you want to change status to active selected record?');"  runat="server" CommandName="active" Text="Subscribe Selected" OnClick="lb_Action_Click" CssClass="link-button"></asp:Button></li>
                                        <li><asp:Button ID="lb_Deactive" OnClientClick="return SelectAction(this,'Are you sure you want to change status to block selected record?');"  runat="server" CommandName="deactive" Text="Unsubscribe Selected" OnClick="lb_Action_Click" CssClass="link-button"></asp:Button></li>                                                                         
                                        <li><asp:Button ID="lb_Delete" OnClientClick="return SelectAction(this,'Are you sure you want to delete selected record?');" runat="server" CommandName="delete" Text="Delete Selected" OnClick="lb_Action_Click" CssClass="link-button"></asp:Button></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="portlet-body">

                            
                            <div class="table-container">
                                
                               <div class="table-scrollable">
                                <table class="table table-striped table-bordered table-hover table-checkable" id="" style="border: none;">
                                    <thead>
                                           <tr role="row" class="filter form-group form-md-line-input " >
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
                                                   <asp:TextBox ID="ddl_Group" runat="server" CssClass="form-control input-sm" placeholder="Group"></asp:TextBox></td>
                                                     <td style="border: none;" runat="server" visible="false">
                                                   <asp:TextBox ID="tbx_Search" runat="server"  CssClass="form-control input-sm" placeholder="Name" aria-controls="dataTables-example"></asp:TextBox>
                                                   <small>
                                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="ValidateBoxes" ControlToValidate="tbx_SearchEmail" Display="Dynamic" ErrorMessage="fill atleast one field." SetFocusOnError="True" ValidateEmptyText="true" ValidationGroup="vgSearchValidate11"></asp:CustomValidator>
                                                    </small>
                                             </td>
                                                <td style="border: none;">
                                                    <asp:TextBox ID="tbx_SearchEmail" runat="server"  CssClass="form-control input-sm" placeholder="Email" aria-controls="dataTables-example"></asp:TextBox>
                                                </td>
                                                <td style="border: none;"><asp:DropDownList ID="ddl_Subscribe" runat="server" CssClass="form-control input-sm">
                                                <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                                </asp:DropDownList></td>
                                               <td style="border: none;">
                                                      <span style="position: relative;" class="btn btn-sm btn-success filter-submit margin-bottom">
                                                            <i class="fa fa-search"></i>
                                                            <asp:Button runat="server" ID="lbSearch" OnClick="lbSearch_Click" class="movedown" ValidationGroup="vgSearchValidate11"></asp:Button></span>
                                                   <asp:ValidationSummary ID="vsm1" runat="server" ShowMessageBox="false" ShowSummary="false" HeaderText="Please enter below details properly" ValidationGroup="vgSearchValidate11" />
                                              <asp:LinkButton runat="server" ID="lbReset" OnClick="lbReset_Click" Visible="true" class="btn btn-sm btn-default filter-cancel">
                                                                <i class="fa fa-times"></i></asp:LinkButton>
                                               </td>
                                               </tr>
                                        <tr role="row" class="heading">
                                            <td>
                                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                    <input type="checkbox" id="ckbCheckAll" onclick="updatechk(this)" />
                                                    <span></span>
                                                </label>
                                            </td>
                                                 <th><asp:LinkButton ID="lb_Group" runat="server" CssClass="sort" OnClick="lb_Group_Click">Group</asp:LinkButton></th>      
                                            <th runat="server" visible="false"><asp:LinkButton ID="lb_name" runat="server" CssClass="sort" OnClick="lb_name_Click">Name</asp:LinkButton></th>                                                                                                                          
                                            <th><asp:LinkButton ID="lb_Email" runat="server" CssClass="sort" OnClick="lb_Email_Click">Email</asp:LinkButton></th> 
                                            <th>Subscribed</th>  
                                                <th></th>
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
                                                       <td data-th="Group"><%#Eval("groupnm").ToString()%></td>
                                           <td data-th="Name" runat="server" visible="false"><%#Eval("Name").ToString()%></td>
                                            <td data-th="Email"><%#Eval("Email").ToString()%></td>
                                          <td data-th="Block"><%#Eval("Visible").ToString().Replace("True","<span class='label label-info label-sm'>Yes</span>").Replace("False","<span class='label label-danger label-sm'>No</span>") %></td>
                                                   <td class="dt-body-right sorting_1">
                                                          <div class="mt-action-buttons ">
                                                                <div class="btn-group btn-group-circle">
                                                                      <a href='manage-subscriber.aspx?id=<%#Eval("id") %>' class="btn btn-outline green btn-sm"><i class="fa fa-pencil"></i></a>
                                                                  <span  style="position:relative;" class="btn btn-outline red btn-sm">
                                                                    <i class="fa fa-trash"></i>
                                                                    <asp:Button ID="ibDelete" OnClientClick="return modalurl(this,'Are you sure you want to delete this record?');"  class="movedown" CommandName="Delete" CommandArgument='<%#Eval("id")%>' runat="server" Text=""></asp:Button></span>
                                                                 </div>
                                                            </div>
                                                            </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </asp:Panel>
                                           
                                        
                                        <tr id="div_msg" runat="server" visible="false">
                                               <td colspan="6">
                                                                               <label>
                                <asp:Literal ID="ltr_msg" runat="server"></asp:Literal></label>
                                               </td>
</tr>

                                    </tbody>
                                </table>
                                      <strong>
                                   
                                
                            </div>
                                <div class="row">
                                        <div class="col-md-6 col-sm-12" >
                                            Showing
                                            <asp:Literal ID="ltr_Start" runat="server"></asp:Literal>
                                        to
                                            <asp:Literal ID="ltr_End" runat="server"></asp:Literal>
                                        of
                                            <asp:Literal ID="ltr_Total" runat="server"></asp:Literal>
                                        records
                                        </div>
                                        <div class="col-md-6 col-sm-12 text-right"  id="div_Paging" runat="server" visible="false">
                                            <div class="dataTables_paginate paging_bootstrap_extended"  >
                                                <div class="pagination-panel">Page 
                                                    <asp:LinkButton ID="lnkPrevious" runat="server" CssClass="btn btn-sm default prev" aria-label="Previous" OnClick="lnkPrevious_Click"><i class="fa fa-angle-left"></i></asp:LinkButton></li>
                                                     <asp:TextBox id="tbx_PageNumber" runat="server" AutoPostBack="true" CssClass="pagination-panel-input form-control input-sm input-inline input-mini" MaxLength="5" style="text-align: center; margin: 0 5px;" OnTextChanged="tbx_PageNumber_TextChanged"></asp:TextBox>                                                    
                                                 <asp:LinkButton ID="lnkNext" runat="server" CssClass="btn btn-sm default next" OnClick="lnkNext_Click"><i class="fa fa-angle-right"></i></asp:LinkButton></li> of <span class="pagination-panel-total"><%=ViewState["totpage"] %></span></div>
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






