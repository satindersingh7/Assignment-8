<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="dashboard.aspx.cs" Inherits="dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <!-- BEGIN PAGE LEVEL PLUGINS -->
        <link href="assets/global/plugins/bootstrap-daterangepicker/daterangepicker.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/fullcalendar/fullcalendar.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/global/plugins/jqvmap/jqvmap/jqvmap.css" rel="stylesheet" type="text/css" />
        <!-- END PAGE LEVEL PLUGINS -->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <!-- BEGIN PAGE HEADER-->
                        <!-- BEGIN PAGE BAR -->
                        <div class="page-bar">
                            <ul class="page-breadcrumb">
                              
                                <li>
                                    <span>Dashboard</span>
                                </li>
                            </ul>
                            
                        </div>
                        <!-- END PAGE BAR -->
                        <!-- BEGIN PAGE TITLE-->
                        <br />
                        <!-- END PAGE TITLE-->
                        <!-- END PAGE HEADER-->
                        <div class="row">
                               <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/productenquiry/viewenquiry.aspx"> 
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                <div class="dashboard-stat blue">
                                    <div class="visual">
                                        <i class="fa fa-info fa-icon-medium"></i>
                                    </div>
                                    <div class="details">
                                        <div class="number">
                                            <span data-counter="counterup" data-value="1349"><asp:Literal runat="server"  Text="0" ID="ltrinquiry"></asp:Literal></span>
                                        </div>
                                       <div class="desc"> Product Enquiry </div>
                                    </div>
                                    <a class="more" href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/productenquiry/viewenquiry.aspx"> View more
                                        <i class="m-icon-swapright m-icon-white"></i>
                                    </a>
                                </div>
                            </div>
                                   </a>
                            <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/pagecontent/pagelisting.aspx">
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                <div class="dashboard-stat red">
                                    <div class="visual">
                                        <i class="fa fa-file-text fa-icon-medium"></i>
                                    </div>
                                    <div class="details">
                                        <div class="number">
                                            <span data-counter="counterup" data-value="1349"></span>
                                        </div>
                                        <div class="desc"> Page Content </div>
                                    </div>
                                     <a class="more" href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/pagecontent/pagelisting.aspx"> View more
                                        <i class="m-icon-swapright m-icon-white"></i>
                                    </a>
                                </div>
                            </div>
                                </a>
                             <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/faq/viewfaq.aspx">
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                <div class="dashboard-stat green">
                                    <div class="visual">
                                        <i class="fa fa-question-circle fa-icon-medium"></i>
                                    </div>
                                    <div class="details">
                                         <div class="number">
                                            <span data-counter="counterup" data-value="1349"><asp:Literal runat="server"  Text="0" ID="ltrfaq"></asp:Literal></span>
                                        </div>
                                        <div class="desc"> FAQ </div>
                                    </div>
                                     <a class="more" href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/faq/viewfaq.aspx"> View more
                                        <i class="m-icon-swapright m-icon-white"></i>
                                    </a>
                                </div>
                            </div>
                                 </a>
                            <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/product/viewProduct.aspx">
                            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                                <div class="dashboard-stat yellow">
                                    <div class="visual">
                                        <i class="fa fa-tags fa-icon-medium"></i>
                                    </div>
                                    <div class="details">
                                        <div class="number">
                                            <span data-counter="counterup" data-value="1349"><asp:Literal runat="server"  Text="0" ID="ltrProduct"></asp:Literal></span>
                                        </div>
                                        <div class="desc"> Products </div>
                                    </div>
                                     <a class="more" href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/product/viewProduct.aspx"> View more
                                        <i class="m-icon-swapright m-icon-white"></i>
                                    </a>
                                </div>
                            </div>
                                </a>
                          </div>
      
                        
                        
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extrajs" Runat="Server">
    <!-- BEGIN PAGE LEVEL PLUGINS -->
      
        <!-- END PAGE LEVEL PLUGINS -->
   
</asp:Content>

