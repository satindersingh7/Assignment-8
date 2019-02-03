<%@ Page Title="" Language="C#" MasterPageFile="~/DSED08.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Src="~/includes/left-sidebar.ascx" TagName="leftsidebarIncl" TagPrefix="u3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="js/modernizr-2.8.3.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!--slider here-->
    <div class="slider-area">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-3 hidden-sm hidden-xs"></div>
                <div class="col-lg-9">
                    <div class="main-slider">
                        <div class="slider-container">
                            <!-- Slider Image -->
                            <div id="mainSlider" class="nivoSlider slider-image">
                                <asp:Repeater runat="server" ID="repbanner">
                                    <ItemTemplate>
                                        <a href="<%#Eval("url").ToString()==""?"javascript:;":Eval("url").ToString()%>">
                                            <img src="webfiles/banner/<%#Eval("image").ToString()%>" alt="home-slider-image" class="img-responsive" />
                                        </a>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--main product list content-->
    <div class="section-box product-list">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <u3:leftsidebarIncl ID="leftsidebarInc" runat="server" />
                </div>
                <div class="col-md-9">
                    <div class="panel" runat="server" id="divNew">
                        <div class="section-main-box new-produxts-tab">
                            <div class="border-bottom">
                                <h1>New Products</h1>
                                <!-- Nav tabs -->
                            </div>
                            <div class="tab-content">
                                <!--all-->
                                <div role="tabpanel" class="tab-pane fade in active" id="all">
                                    <div class="section-box">
                                        <div id="all-product" class="new-product">
                                           
                                                <asp:Repeater runat="server" ID="repNewProducts"><ItemTemplate>
                                                    
                                                <div class="item">
                                                    <div class="product-image">
                                                         <a href="product-detail.aspx?id=<%#Eval("id").ToString() %>">
                                                        <img src="webfiles/product/medium/<%#Eval("image").ToString() %>" class="img-responsive" alt="<%#Eval("title").ToString() %>">
                                                             </a>
                                                    </div>
                                                    <div class="text-center">
                                                         <a href="product-detail.aspx?id=<%#Eval("id").ToString() %>">
                                                        <h3 class="product-name"><%#Eval("title").ToString().Length>30 ? Eval("Title").ToString().Replace("''", "'").Substring(0,27)+"..." : Eval("Title").ToString().Replace("''", "'") %></h3>
                                                             </a>
                                                        <div class="product-price">
                                                            <%#double.Parse(Eval("sellprice").ToString())!=double.Parse(Eval("costprice").ToString()) ?"<span class=\"price-before-discount\">$"+double.Parse(Eval("costprice").ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN"))+"</span>":""%> <span class="price">$<%#double.Parse(Eval("sellprice").ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN")) %> </span></div>
                                                        
                                                    </div>
                                                </div>
                                                    </ItemTemplate></asp:Repeater>
                                            
                                        </div>
                                    </div>
                                </div>
                               
                            </div>
                        </div>
                    </div>
                    <!--advertise banner-->
                    <div class="row" runat="server" id="divMiddlebanner">
                        <div class="col-sm-6">
                             <a runat="server" id="link1">
            <img runat="server" id="img1" src="images/side-advertise-banner.png" alt="bottom-advertise" class="img-responsive" />
                </a>
                        </div>
                        <div class="col-sm-6">
                             <a runat="server" id="link2">
            <img runat="server" id="img2" visible="false" alt="bottom-advertise" class="img-responsive" />
                </a>
                        </div>
                    </div>
                    <!--Featured product-->
                    <div class="section-box" runat="server" id="divFeatured">
                        <div class="panel">
                            <div class="section-main-box new-produxts-tab">
                                <div class="border-bottom">
                                    <h1>Featured products</h1>
                                </div>
                                <div class="section-box">
                                    <div id="featured-product">
                                        
                                                <asp:Repeater runat="server" ID="repFeatured">
                                                    <ItemTemplate>
                                                        <%#Container.ItemIndex==0||(Container.ItemIndex+1)%2!=0?"<div class=\"item\"><div class=\"fetured-list\">":"" %>
                                                       
                                                            <div class="featured">
                                                                <div class="row">
                                                                    <div class="col-sm-5">
                                                                        <div class="featured-image">
                                                                             <a href="product-detail.aspx?id=<%#Eval("id").ToString() %>">
                                                                        <img src="webfiles/product/medium/<%#Eval("image").ToString() %>" alt="<%#Eval("title").ToString()%>" class="img-responsive">
                                                                              </a>
                                                                       </div>
                                                                        </div>
                                                                    <div class="col2 col-sm-7">
                                                                        <div class="text-left">
                                                                            <h3 class="product-name"><a href="product-detail.aspx"><%#Eval("title").ToString().Length>30 ? Eval("Title").ToString().Replace("''", "'").Substring(0,27)+"..." : Eval("Title").ToString().Replace("''", "'") %>.</a></h3>
                                                                            <div class="product-price">
                                                                                <%#double.Parse(Eval("sellprice").ToString())!=double.Parse(Eval("costprice").ToString()) ?"<span class=\"price-before-discount\">$"+double.Parse(Eval("costprice").ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN"))+"</span>":""%> <span class="price">$<%#double.Parse(Eval("sellprice").ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN")) %> </span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </a>
                                                        <%#cnt== (Container.ItemIndex + 1)||(Container.ItemIndex+1)%2==0|| cnt==(Container.ItemIndex+1)?"</div></div>":"" %>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                          
                                      
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                  
                    <!--enquiry banner-->
                     <div class="section-box" >
                    <div class="panel"  runat="server" id="divbottombanner">
                        <div class="slider-single-img">
                                     <a runat="server" id="link">
            <img runat="server" id="img" src="images/side-advertise-banner.png" alt="bottom-advertise" class="img-responsive" />
                </a>
                        </div>
                    </div>
                         </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extraJs" runat="Server">
    <script src="js/jquery.nivo.slider.pack.js"></script>
    <script>
        /*----------------------------
      Nivo-Slider
    ------------------------------ */
        (function ($) {
            "use strict";


            $('#mainSlider').nivoSlider({
                effect: 'random',                 // Specify sets like: 'fold,fade,sliceDown' 
                slices: 15,                       // For slice animations 
                boxCols: 8,                       // For box animations 
                boxRows: 4,                       // For box animations 
                animSpeed: 1000,                   // Slide transition speed 
                pauseTime: 5000,                  // How long each slide will show 
                startSlide: 0,                    // Set starting Slide (0 index) 
                directionNav: true,               // Next & Prev navigation 
                controlNav: false,                 // 1,2,3... navigation 
                controlNavThumbs: false,          // Use thumbnails for Control Nav 

                prevText: '<i class="fa fa-angle-left" aria-hidden="true"></i>',                 // Prev directionNav text 
                nextText: '<i class="fa fa-angle-right" aria-hidden="true"></i>'                 // Next directionNav text 


            });
        })(jQuery);
    </script>
    <script>
        $(document).ready(function () {
            $("#hot-deal,#special-deal").owlCarousel({
                autoPlay: 3000,
                singleItem: true,
                pagination: false,
                navigation: true,
                navigationText: ["<i class='fa fa-caret-left'></i>", "<i class='fa fa-caret-right'></i>"]
            });
            $("#all-product,#personal-care-product,#cell-phones-product,#Gaming-product,#Whiteware-product,#kitchen-appliances-product,#audio-visual-product,#all-latest-product").owlCarousel({
                autoPlay: 3000,
                items: 4,
                itemsDesktop: [1199, 3],
                itemsDesktopSmall: [979, 2],
                pagination: false,
                navigation: true,
                navigationText: ["<i class='fa fa-caret-left'></i>", "<i class='fa fa-caret-right'></i>"]
            });
            $("#featured-product").owlCarousel({
                autoPlay: 3000,
                items: 3,
                itemsDesktop: [1199, 3],
                itemsDesktopSmall: [979, 3],
                pagination: false,
                navigation: true,
                navigationText: ["<i class='fa fa-caret-left'></i>", "<i class='fa fa-caret-right'></i>"]
            });
        });
    </script>
    <script src="js/jquery.equalheights.js"></script>
    <script>
        $(document).ready(function () {
            $('.product-image').equalHeights();
            $('.item h3').equalHeights();
        });
    </script>
</asp:Content>

