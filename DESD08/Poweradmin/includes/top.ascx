<%@ Control Language="C#" AutoEventWireup="true" CodeFile="top.ascx.cs" Inherits="Poweradmin_includes_top" %>

<!-- BEGIN HEADER -->
            <div class="page-header navbar navbar-fixed-top">
                <!-- BEGIN HEADER INNER -->
                <div class="page-header-inner ">
                    <!-- BEGIN LOGO -->
                    <div class="page-logo">
                        <a href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/dashboard.aspx">
                           
                            <img src="<%=ConfigurationManager.AppSettings["siteurl"].ToString() %><%=ConfigurationManager.AppSettings["AdminLogo"].ToString() %>" alt="logo" class="logo-default" style="height:40px;"/> </a>
                        <div class="menu-toggler sidebar-toggler">
                            <span></span>
                        </div>
                    </div>
                    <!-- END LOGO -->
                    <!-- BEGIN RESPONSIVE MENU TOGGLER -->
                    <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse">
                        <span></span>
                    </a>
                    <!-- END RESPONSIVE MENU TOGGLER -->
                    <!-- BEGIN TOP NAVIGATION MENU -->
                    <div class="top-menu">
                        <ul class="nav navbar-nav pull-right">
                            <!-- BEGIN NOTIFICATION DROPDOWN -->
                            <!-- DOC: Apply "dropdown-dark" class after "dropdown-extended" to change the dropdown styte -->
                            <!-- DOC: Apply "dropdown-hoverable" class after below "dropdown" and remove data-toggle="dropdown" data-hover="dropdown" data-close-others="true" attributes to enable hover dropdown mode -->
                            <!-- DOC: Remove "dropdown-hoverable" and add data-toggle="dropdown" data-hover="dropdown" data-close-others="true" attributes to the below A element with dropdown-toggle class -->
                           
                            <!-- END TODO DROPDOWN -->
                            <!-- BEGIN USER LOGIN DROPDOWN -->
                            <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                          
                            <li class="dropdown dropdown-user">
                                <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                     <i class="fa fa-user fa-fw"></i> 
                                    <i class="fa fa-angle-down"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-default">
                                    <li>
                                        <a href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/changepassword.aspx">
                                            <i class="icon-user"></i> My Profile </a>
                                    </li>
                                    <%--<li>
                                        <a href="#">
                                            <i class="icon-calendar"></i> My Calendar </a>
                                    </li>--%>
                                    <li runat="server" id="settings">
                                        <a href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/email-settings.aspx"><i class="fa fa-gear fa-fw"></i> Settings</a>
                                  
                                    </li>
                                 <%--   <li>
                                        <a href="#">
                                            <i class="icon-rocket"></i> My Tasks
                                            <span class="badge badge-success"> 7 </span>
                                        </a>
                                    </li>
                                    <li class="divider"> </li>
                                    <li>
                                        <a href="#">
                                            <i class="icon-lock"></i> Lock Screen </a>
                                    </li>--%>
                                    <li>
                                       <a href="<%=ConfigurationManager.AppSettings["CMSPath"].ToString() %>/logout.aspx">
                                            <i class="icon-key"></i> Log Out </a>
                                    </li>
                                </ul>
                            </li>
                            <!-- END USER LOGIN DROPDOWN -->
                            <!-- BEGIN QUICK SIDEBAR TOGGLER -->
                            <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                          <%--  <li >
                                <a href="javascript:;">
                                    <i class="icon-logout"></i>
                                </a>
                            </li>--%>
                            <!-- END QUICK SIDEBAR TOGGLER -->
                        </ul>
                    </div>
                    <!-- END TOP NAVIGATION MENU -->
                </div>
                <!-- END HEADER INNER -->
            </div>
            <!-- END HEADER -->

