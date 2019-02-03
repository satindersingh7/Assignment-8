<%@ Control Language="C#" AutoEventWireup="true" CodeFile="left.ascx.cs" Inherits="Poweradmin_include_left" %>
<!-- BEGIN SIDEBAR -->
<div class="page-sidebar-wrapper">
    <!-- BEGIN SIDEBAR -->
    <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
    <!-- DOC: Change data-auto-speed="200" to adjust the sub menu slide up/down speed -->
    <div class="page-sidebar navbar-collapse collapse">
        <!-- BEGIN SIDEBAR MENU -->
        <!-- DOC: Apply "page-sidebar-menu-light" class right after "page-sidebar-menu" to enable light sidebar menu style(without borders) -->
        <!-- DOC: Apply "page-sidebar-menu-hover-submenu" class right after "page-sidebar-menu" to enable hoverable(hover vs accordion) sub menu mode -->
        <!-- DOC: Apply "page-sidebar-menu-closed" class right after "page-sidebar-menu" to collapse("page-sidebar-closed" class must be applied to the body element) the sidebar sub menu mode -->
        <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
        <!-- DOC: Set data-keep-expand="false" to keep the submenues expanded -->
        <!-- DOC: Set data-auto-speed="200" to adjust the sub menu slide up/down speed -->
        <ul class="page-sidebar-menu page-header-fixed page-sidebar-menu-closed" data-keep-expanded="false" data-auto-scroll="false" data-slide-speed="200" style="padding-top: 20px">
            <!-- DOC: To remove the sidebar toggler from the sidebar you just need to completely remove the below "sidebar-toggler-wrapper" LI element -->
            <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
            <li class="sidebar-toggler-wrapper hide">
                <div class="sidebar-toggler">
                    <span></span>
                </div>
            </li>
            <!-- END SIDEBAR TOGGLER BUTTON -->
            <!-- DOC: To remove the search box from the sidebar you just need to completely remove the below "sidebar-search-wrapper" LI element -->
            <li class="nav-item">

                <%--  <a href="javascript:;" class="remove">
                                        <i class="icon-close"></i> 
                                    </a>--%>
                <a href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/dashboard.aspx" class="nav-link nav-toggle <% if (Request.ServerVariables["URL"].ToLower().IndexOf("dashboard.aspx") > 0) { %>active<% } %>">
                    <i class="fa fa-home fa-fw"></i>
                    <span class="title">Dashboard</span>

                    <%-- <span class="arrow open"></span>--%>
                </a>

                <!-- END RESPONSIVE QUICK SEARCH FORM -->
            </li>
            <li class="nav-item">
                <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/order/viewOrder.aspx" class="nav-link  nav-toggle <% if (Request.ServerVariables["URL"].ToLower().IndexOf("order") > 0 || Request.ServerVariables["URL"].ToLower().IndexOf("order") > 0)
                                                                                                                                                      { %>active<% } %>">
                    <i class="fa fa-cubes fa-fw"></i>
                    <span class="title">Manage Orders</span>
                    <span class="selected"></span>
                    <span class="arrow open"></span>
                </a>
                <ul class="sub-menu">
                    <li class="nav-item  ">
                        <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/order/viewOrder.aspx" class="nav-link ">
                            <span class="title">Retail Orders</span>
                        </a>
                    </li>
                    <li class="nav-item  ">
                        <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/order/viewWholesale.aspx" class="nav-link ">
                            <span class="title">Wholesale Inquiry</span>
                        </a>
                    </li>
                    <li class="nav-item  ">
                        <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/order/salesReport.aspx" class="nav-link ">
                            <span class="title">Retail Sales Report</span>
                        </a>
                    </li>
                </ul>
            </li>
            <li class="nav-item" runat="server" id="Li1">
                <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/productenquiry/viewenquiry.aspx" class="nav-link <% if (Request.ServerVariables["URL"].ToLower().IndexOf("/productenquiry/") > 0)
                    { %>active<% } %>">
                    <i class="fa fa-info"></i>
                    <span class="title">Product Enquiry</span>
                    <span class="selected"></span>
                </a>
            </li>
            <li class="nav-item">
                <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/product/viewProduct.aspx" class="nav-link nav-toggle <% if (Request.ServerVariables["URL"].ToLower().IndexOf("/product/viewproduct.aspx") > 0 || Request.ServerVariables["URL"].ToLower().IndexOf("/product/manageproduct.aspx") > 0 || Request.ServerVariables["URL"].ToLower().IndexOf("import-product.aspx") > 0) { %>active<% } %>">
                    <i class="fa fa-tags fa-fw"></i>
                    <span class="title">Product</span>

                </a>
            </li>
            <li class="nav-item">
                <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/product/viewCategory.aspx" class="nav-link nav-toggle <% if (Request.ServerVariables["URL"].ToLower().IndexOf("category.aspx") > 0) { %>active<% } %>">
                    <i class="fa fa-list fa-fw"></i>
                    <span class="title">Product Category</span>

                </a>
            </li>
            <li class="nav-item">
                <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/banner/viewBanner.aspx" class="nav-link nav-toggle <% if (Request.ServerVariables["URL"].ToLower().IndexOf("/banner/") > 0) { %>active<% } %>">
                    <i class="fa fa-image fa-fw"></i>
                    <span class="title">Banner</span>

                </a>
            </li>
            <li class="nav-item">
                <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/deal/viewProduct.aspx" class="nav-link nav-toggle <% if (Request.ServerVariables["URL"].ToLower().IndexOf("/deal/") > 0) { %>active<% } %>">
                    <i class="fa fa-shopping-bag fa-fw"></i>
                    <span class="title">Deal & Offers</span>

                </a>
            </li>
            <li class="nav-item">
                <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/partner/viewPartner.aspx" class="nav-link nav-toggle <% if (Request.ServerVariables["URL"].ToLower().IndexOf("/partner/") > 0) { %>active<% } %>">
                    <i class="fa fa-suitcase fa-fw"></i>
                    <span class="title">Brand Partner</span>

                </a>
            </li>
            <li class="nav-item">
                <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/advt/viewadvt.aspx" class="nav-link nav-toggle <% if (Request.ServerVariables["URL"].ToLower().IndexOf("/advt/") > 0)  { %>active<% } %>">
                    <i class="fa fa-image fa-fw"></i>
                    <span class="title">Advertisment Banner</span>

                </a>
            </li>
            <li class="nav-item">
                <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/faq/viewfaq.aspx" class="nav-link nav-toggle <% if (Request.ServerVariables["URL"].ToLower().IndexOf("/faq/") > 0) { %>active<% } %>">
                    <i class="fa fa-question-circle fa-fw"></i>
                    <span class="title">FAQ</span>

                </a>

            </li>
            <li class="nav-item">
                <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/Newsletter/manage-campaign.aspx" class="nav-link  nav-toggle <% if (Request.ServerVariables["URL"].ToLower().IndexOf("/newsletter/") > 0) { %>active<% } %>">
                    <i class="fa fa-newspaper-o"></i>
                    <span class="title">Newsletter</span>
                    <span class="selected"></span>
                    <span class="arrow open"></span>
                </a>
                <ul class="sub-menu">
                    <li class="nav-item  ">
                        <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/Newsletter/viewgroup.aspx" class="nav-link ">
                            <span class="title">Group</span>
                        </a>
                    </li>
                    <li class="nav-item  ">
                        <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/Newsletter/viewsubscriber.aspx" class="nav-link ">
                            <span class="title">Subscriber</span>
                        </a>
                    </li>
                    <li class="nav-item  ">
                        <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/Newsletter/viewtemplate.aspx" class="nav-link ">
                            <span class="title">Template</span>
                        </a>
                    </li>
                    <li class="nav-item  ">
                        <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/Newsletter/manage-campaign.aspx" class="nav-link ">
                            <span class="title">Add Campaign</span>
                        </a>
                    </li>
                    <li class="nav-item  ">
                        <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/Newsletter/import-subscriber.aspx" class="nav-link ">
                            <span class="title">Import Subscriber</span>
                        </a>
                    </li>
                    <li class="nav-item  ">
                        <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/Newsletter/view-pending-campaign.aspx" class="nav-link ">
                            <span class="title">Pending Campaign</span>
                        </a>
                    </li>
                    <li class="nav-item  ">
                        <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/Newsletter/view-sent-campaign.aspx" class="nav-link ">
                            <span class="title">Sent Campaign</span>
                        </a>
                    </li>
                </ul>
            </li>
            <li class="nav-item" runat="server" id="Li2">
                <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/quickenquiry/viewenquiry.aspx" class="nav-link <% if (Request.ServerVariables["URL"].ToLower().IndexOf("/quickenquiry/") > 0)
                    { %>active<% } %>">
                    <i class="fa fa-info"></i>
                    <span class="title">Quick Enquiry</span>
                    <span class="selected"></span>
                </a>
            </li>
            <li class="nav-item" runat="server" id="pagecontent">
                <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/pagecontent/pagelisting.aspx" class="nav-link <% if (Request.ServerVariables["URL"].ToLower().IndexOf("/pagecontent/") > 0)
                    { %>active<% } %>">
                    <i class="fa fa-file-text"></i>
                    <span class="title">Page Content</span>
                    <span class="selected"></span>
                </a>
            </li>
            <li class="nav-item">
                <a href="<%=ConfigurationManager.AppSettings["cmspath"].ToString() %>/managepdf.aspx" class="nav-link nav-toggle <% if (Request.ServerVariables["URL"].ToLower().IndexOf("managepdf.aspx") > 0)
                    { %>active<% } %>">
                    <i class="fa fa-file-pdf-o fa-fw"></i>
                    <span class="title">Pdf</span>

                </a>
            </li>

        </ul>
        <!-- END SIDEBAR MENU -->
        <!-- END SIDEBAR MENU -->
    </div>
    <!-- END SIDEBAR -->
</div>
<!-- END SIDEBAR -->
