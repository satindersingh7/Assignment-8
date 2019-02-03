<%@ Control Language="C#" AutoEventWireup="true" CodeFile="header.ascx.cs" Inherits="includes_header" %>
<!--top header here-->
<div class="top-header">
    <div class="container">
        <div class="row">
            <div class="hidden-sm hidden-md hidden-lg">
                <div class="main-icon icon-top">
                    <i class="fa fa-phone icon" aria-hidden="true"></i>&nbsp;<a href="telto:0800848411"><span class="top">0800 84 84 11</span></a>
                    <i class="fa fa-envelope-o icon" aria-hidden="true"></i>&nbsp;
        <a href="mailto:info@DSED08.co.nz"><span class="top">info@DSED08.co.nz</span></a>
                </div>
            </div>
            <div class="col-md-3">
                <a href="default.aspx">
                    <img src="images/logo.png" alt="logo" title="Buzz Value" class="logo img-responsive" />
                </a>
            </div>
            <div class="col-md-9 text-right">
                <div class="main-icon">
                    <i class="fa fa-phone icon hidden-xs" aria-hidden="true"></i>&nbsp;<a href="telto:0800848411" class="hidden-xs"><span class="top">0800 84 84 11</span></a>
                    <i class="fa fa-envelope-o icon hidden-xs" aria-hidden="true"></i>&nbsp;
        <a href="mailto:info@DSED08.co.nz" class="hidden-xs"><span class="top">info@DSED08.co.nz</span></a>
                    <asp:Literal runat="server" ID="ltrdownload"></asp:Literal>
                </div>
                <div class="row">
                    <div class="col-lg-11 col-sm-10">
                        <!--search here-->
                         <div class="search-wrap">
                        <asp:Panel runat="server" DefaultButton="btnSearch" ID="btnSearchpenal">
                <div class="input-group search">
                    <div class="input-group-btn">
                        <asp:DropDownList runat="server" CssClass="btn btn-default dropdown-toggle all-department" ID="ddl_Category"  ClientIDMode="Static">

                        </asp:DropDownList>
                       
                    </div>
                    <!-- /btn-group -->
                    <div style="position:relative;">
                    <asp:TextBox runat="server" ID="txtsearch" ClientIDMode="Static" CausesValidation="true" AutoPostBack="false" AutoComplete="off" placeholder="Search by Product Code or Product Name" CssClass="form-control autotxtsearch"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtsearch" Display="Dynamic" ErrorMessage="" SetFocusOnError="True" ToolTip="Please enter Name" ValidationGroup="vgsearch"></asp:RequiredFieldValidator>
                            
                        <div class="test">
                        <ul class="ui-autocomplete ui-front ui-menu ui-widget ui-widget-content ui-corner-all"><li></li></ul>
                    </div>
                        </div>
                    <span class="input-group-btn">
                        <asp:LinkButton runat="server" ID="btnSearch" OnClick="btnSearch_Click" class="btn btn-default" ValidationGroup="vgsearch"><i class="fa fa-search search-ico"></i></asp:LinkButton>
                            <asp:ValidationSummary ID="ValidationSummary2" runat="server" HeaderText="Please correct the following entries" ShowMessageBox="false" ShowSummary="False" ValidationGroup="vgsearch" />
                            <asp:HiddenField ID="hfProductId" runat="server" />
                      
                    </span>
                </div>
                            </asp:Panel>
                             </div>
                        
                <!--search end-->
                    </div>
                    <div class="col-lg-1 col-sm-2">
                        <a href="product-cart.aspx" class="cartbtn">
                           <i class="fa fa-shopping-cart"></i>
                        </a>
                    </div>
                </div>
               
            </div>
        </div>
    </div>
</div>
<!---navigation-->
<div class="mainmenu-area mainmenu-area-4 bg-color-4 hidden-xs hidden-sm">
    <div class="container">
        <div class="row">
            <div class="col-lg-3  col-md-3">
                <div class="mainmenu-left  visible-lg  visible-md">
                    <div class="product-menu-title">
                        <h2>All categories</h2>
                    </div>
                    <div class="product_vmegamenu" <%if (Request.ServerVariables["URL"].ToString().ToLower().Contains("brand-partners.aspx") || Request.ServerVariables["URL"].ToString().ToLower().Contains("about-us.aspx") || Request.ServerVariables["URL"].ToString().ToLower().Contains("contact-us.aspx") || Request.ServerVariables["URL"].ToString().ToLower().Contains("thank-you.aspx") || Request.ServerVariables["URL"].ToString().ToLower().Contains("warranties.aspx") || Request.ServerVariables["URL"].ToString().ToLower().Contains("complaints-process.aspx") || Request.ServerVariables["URL"].ToString().ToLower().Contains("shipping-and-delivery.aspx") || Request.ServerVariables["URL"].ToString().ToLower().Contains("careers.aspx") || Request.ServerVariables["URL"].ToString().ToLower().Contains("faq.aspx") || Request.ServerVariables["URL"].ToString().ToLower().Contains("product-cart.aspx"))
                        { %> style="display: none;" <%}%>>
                        <ul>
                            <asp:Repeater runat="server" ID="repCategory"><ItemTemplate>
                            <li>
                                <a href="product-listing.aspx?catid=<%#Eval("id").ToString() %>"><i class="fa fa-play-circle-o img_icon" aria-hidden="true"></i><%#Eval("title").ToString() %></a></li>
                            </ItemTemplate></asp:Repeater>
                           
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-lg-9 col-md-9">
                <div class="mainmenu bg-color-4 ">
                    <nav>
                        <ul>
                            <li <%if (Request.ServerVariables["URL"].ToString().ToLower().Contains("default.aspx")) {%> class="active" <%}%>><a href="Default.aspx">Home</a></li>
                            <li <%if (Request.ServerVariables["URl"].ToString().ToLower().Contains("product.aspx") || Request.ServerVariables["URl"].ToString().ToLower().Contains("product-listing.aspx") || Request.ServerVariables["URl"].ToString().ToLower().Contains("product-detail.aspx") || Request.ServerVariables["URl"].ToString().ToLower().Contains("product-cart.aspx")) {%> class="active" <%}%>><a href="product.aspx">Products</a></li>
                            <li <%if (Request.ServerVariables["URl"].ToString().ToLower().Contains("deals-and-offers.aspx")||Request.ServerVariables["URl"].ToString().ToLower().Contains("deals-and-offers-detail.aspx")) {%> class="active" <%}%>><a href="deals-and-offers.aspx">Deals & Offers</a></li>
                            <li <%if (Request.ServerVariables["URl"].ToString().ToLower().Contains("brand-partners.aspx")) {%> class="active" <%}%>><a href="brand-partners.aspx">Brand Partners</a></li>
                            <li <%if (Request.ServerVariables["URl"].ToString().ToLower().Contains("about-us.aspx")) {%> class="active" <%}%>><a href="about-us.aspx">About Us</a></li>
                            <li <%if (Request.ServerVariables["URl"].ToString().ToLower().Contains("contact-us.aspx")) {%> class="active" <%}%>><a href="contact-us.aspx">Contact Us</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- mobile-menu-start -->
<div class="mobile-menu-area hidden-md hidden-lg">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="mobile-menu">
                    <nav id="mobile-menu">
                        <ul>
                            <li class="active"><a href="Default.aspx">Home</a></li>
                            <li><a href="product.aspx">Products</a>
                                <ul>
                                    <asp:Repeater runat="server" ID="repmbmenu"><ItemTemplate>
                                    <li><a href="product-listing.aspx?catid=<%#Eval("id").ToString() %>"><%#Eval("title").ToString() %></a>
</li>
                                    </ItemTemplate></asp:Repeater>
                                    
                                </ul>
                            </li>
                            <li><a href="deals-and-offers.aspx">Deals & Offers</a></li>
                            <li><a href="brand-partners.aspx">Brand Partners</a></li>
                            <li><a href="about-us.aspx">About Us</a></li>
                            <li><a href="contact-us.aspx">Contact Us</a>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>
<!--mobile-menu-end-->
