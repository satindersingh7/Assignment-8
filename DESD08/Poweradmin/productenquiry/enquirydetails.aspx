<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="enquirydetails.aspx.cs" Inherits="Poweradmin_PEnquiry_enquirydetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
            <li>Product Enquiry Management</li>
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
                            <i class="fa fa-info font-green"></i>
                            <span class="caption-subject font-green sbold uppercase">View Product Enquiry Details</span>
                        </div>
                        <div class="actions btn-set">
                            <asp:LinkButton ID="btn_Cancel" runat="server" CssClass="btn btn-secondary-outline" OnClick="btn_Cancel_Click"><i class="fa fa-angle-left"></i> Back</asp:LinkButton>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="form-group" runat="server" visible="false" id="divmsds">
                            <label class="col-md-2 text-right bold">Products: </label>
                            <div class="col-lg-10">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Product Name </th>
                                            <th>Price </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater runat="server" ID="repproduct">
                                            <ItemTemplate>
                                                <tr>
                                                   <td><%# GetImage(Eval("image").ToString()) %></td>
                                                    <td> <span>Product code:</span> <span><%#Eval("Productcode") %></span><br />
                                                        <%#Eval("Name").ToString().Length>30 ? Eval("Name").ToString().Substring(0,27)+"..." : Eval("Name").ToString() %> <%#Eval("deal").ToString()=="1"?" (Deal)":""%>
                                                      <%#(Eval("perweek")!=null && Eval("perweek").ToString()!="" && Eval("perweek").ToString()!="0")?" <br/>Per week <b>$"+double.Parse(Eval("perweek").ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN"))+"</span>":""%>
</td>
                                                    <td>$<%#Eval("total").ToString()!=null ? double.Parse(Eval("total").ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN")): ""%>  </td>
                                                   
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                         <tr>
                                                   <td></td>
                                             <td><b>Total</b></td>
                                             <td>$<asp:Literal runat="server" ID="ltrtotal"></asp:Literal></td>
                                             </tr>
                                    </tbody>
                                </table>
                            </div>
                                </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 text-right bold">Status: </label>
                            <div class="col-lg-4">
                                 <asp:DropDownList ID="ddlstatus" runat="server"  CssClass="form-control" OnSelectedIndexChanged="ddlstatus_SelectedIndexChanged" AutoPostBack="true">
                                                            <asp:ListItem Value="">Select</asp:ListItem>
                                                            <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                                            <asp:ListItem Value="Completed">Completed</asp:ListItem>
                                                            <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
                                                        </asp:DropDownList></div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 text-right bold">Name: </label>
                            <div class="col-lg-4">
                                <asp:Literal ID="ltr_Name" runat="server"></asp:Literal></div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-2 text-right bold">Email: </label>
                            <div class="col-lg-4">
                                <asp:Literal ID="ltr_email" runat="server"></asp:Literal></div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 text-right bold">Contact Number: </label>
                            <div class="col-lg-4">
                                <asp:Literal ID="ltrNumber" runat="server"></asp:Literal></div>
                        </div>


                        

                        <div class="form-group">
                            <label class="col-md-2 text-right bold">Subject: </label>
                            <div class="col-lg-10">
                                <asp:Literal ID="ltrSubject" runat="server"></asp:Literal></div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 text-right bold">Message: </label>
                            <div class="col-lg-10">
                                <asp:Literal ID="ltr_Comment" runat="server"></asp:Literal></div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-2 text-right bold">Date: </label>
                            <div class="col-lg-4">
                                <asp:Literal ID="ltr_Date" runat="server"></asp:Literal></div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="extrajs" runat="Server">
</asp:Content>

