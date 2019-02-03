<%@ Page Title="" Language="C#" MasterPageFile="~/DSED08.master" AutoEventWireup="true" CodeFile="product-detail.aspx.cs" Inherits="product_detail" %>

<%@ Register Src="~/includes/left-sidebar.ascx" TagName="leftsidebarIncl" TagPrefix="u3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="css/lightslider.min.css" />
    <link rel="stylesheet" href="css/jquery.fancybox.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-3">
                <div class="hidden-height hidden-sm hidden-xs"></div>
                <div class="section-box product-list">
                    <u3:leftsidebarIncl ID="leftsidebarInc" runat="server" />
                </div>
            </div>
            <div class="col-lg-9 col-md-9">
                <!--breadcrumb here-->
                <div class="panel">
                    <div class="row">
                        <div class="col-sm-12">
                            <ol class="breadcrumb">
                                <li><a href="Default.aspx">Home</a></li>
                                <li><a href="product.aspx">product</a></li>
                                <li><asp:Literal runat="server" ID="ltrCat"></asp:Literal></li>
                                <li><a href="javascript:;" class="active"><asp:Literal runat="server" ID="ltrBtitle"></asp:Literal></a></li>
                            </ol>
                        </div>
                    </div>
                </div>
                   <div id="div_Success" runat="server" class="alert alert-success" visible="false">
                <asp:Literal ID="ltr_Success" runat="server"></asp:Literal>
            </div>
            <div id="div_Error" runat="server" class="alert alert-danger" visible="false">
                <asp:Literal ID="ltr_msg" runat="server"></asp:Literal>
            </div>
                <div class="panel">
                    <div class="container-fluid">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="section-main-box sect">
                                <ul id="image-gallery" class="gallery list-unstyled cS-hidden">
                                    <asp:Repeater ID="repimgmed" runat="server">
                            <ItemTemplate>
                                    <li data-thumb='webfiles/product/small/<%#Eval("img").ToString()%>'>
                                        <div class="img-wrap">
                                            <img src="webfiles/product/medium/<%#Eval("img").ToString()%>" alt="<%#Eval("title").ToString()%>" class='img-responsive'/>
                                            <a href="webfiles/product/large/<%#Eval("img").ToString()%>" data-fancybox-group="gallery" class="fancybox-effects-c zoom-trigger">
                                                <img src="images/zoom.png" class="img-responsive" alt="Zoom" />
                                            </a>
                                        </div>
                                    </li>
                                     </ItemTemplate>
                        </asp:Repeater>
                                    
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <div class="section sect">
                                <div class="product-detail-right">
                                   <div class="prie-range-review">
                                         <span>Product code:</span> <span><asp:Literal runat="server" ID="ltrPCode"></asp:Literal></span>
                                        </div>
                                    <h1 class="product-title"><asp:Literal runat="server" ID="ltrTitle"></asp:Literal></h1>
                                 
                                    <div class="price">
                                       <span class="discount-price">Price: $<asp:Literal runat="server" ID="ltrSellPrice"></asp:Literal></span>
                                        <span class="actually-price" runat="server" id="spanCP">$<asp:Literal runat="server" ID="ltrCostPrice"></asp:Literal></span>
                                       <span class="product-code" runat="server" id="spnperweek"><br />Per Week: $<asp:Literal runat="server" ID="ltrPerweek"></asp:Literal></span>
                                    </div>
                                </div>
                                <div class="product-code-availability border-bottom">
                                   
                                 <span class="product-code">Availability:</span> <span><asp:Literal runat="server" ID="ltrStockout"></asp:Literal></span>
                                </div>
                                <div class="quick-review border-bottom">
                                    <h2>Description</h2>
                                    <p class="content">
                                        <asp:Literal runat="server" ID="ltrdesc"></asp:Literal>
                                    </p>
                                </div>
                                <div class="buttton-file">
                                    <asp:LinkButton runat="server" ID="lbAddtoCart" OnClick="lbAddtoCart_Click" CssClass="btn btn-default">ADD TO ENQUIRY CART LIST</asp:LinkButton>
                                                                    </div>
                            </div>
                        </div>
                    </div>
                        </div>
                </div>
                <div class="panel" runat="server" id="tabAddInfo">
                    <div class="section-main-box">
                        <div class="product-information">
                            <!-- Nav tabs -->
                            <ul class="nav nav-tabs" role="tablist">
                                <li role="presentation" class="active"><a href="#additional-information" aria-controls="additional-information" role="tab" data-toggle="tab">Additional Information</a></li>
                                
                            </ul>
                            <!-- Tab panes -->
                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane active" id="additional-information">
                                    <h4>Additional Information</h4>
                                    <table class="table table-bordered table-striped table-responsive">
                                        <tbody>
                                        <tr>
                                            <td><b>Per Week :</b></td>
                                            <td>$<asp:Literal runat="server" ID="ltrPerweek1"></asp:Literal></td>
                                        </tr>
                                            </tbody>
                                    </table>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
                 <!--Healthy and Beauty You might also like-->
                <div class="panel" runat="server" id="divassociated">
                   <div class="section-main-box new-produxts-tab">
                            <div class="border-bottom">
                                <div class="row">
                                    <div class="col-sm-9">
                                        <h1>You might also like</h1>
                                    </div>
                                   
                                </div>  
                            </div>
                            
                        <div class="section-box">
                            <div id="healthy-beauty" class="new-product">
                                <asp:Repeater runat="server" ID="repassociated">
                                    <ItemTemplate>
                                        <a href="product-detail.aspx?id=<%#Eval("id").ToString() %>">
                                            <div class="item">
                                                <div class="product-image">
                                                    <img src="webfiles/product/medium/<%#Eval("image").ToString() %>" class="img-responsive" alt="<%#Eval("title").ToString() %>">
                                                </div>
                                                <div class="text-center">
                                                    <h3 class="product-name"><%#Eval("title").ToString().Length>30 ? Eval("Title").ToString().Replace("''", "'").Substring(0,27)+"..." : Eval("Title").ToString().Replace("''", "'") %></h3>
                                                    <div class="product-price">
                                                        <%#double.Parse(Eval("sellprice").ToString())!=double.Parse(Eval("costprice").ToString()) ?"<span class=\"price-before-discount\">$"+double.Parse(Eval("costprice").ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN"))+"</span>":""%> <span class="price">$<%#double.Parse(Eval("sellprice").ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN")) %> </span>
                                                    </div>
                                                </div>
                                            </div>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extraJs" runat="Server">
    <script src="js/owl.carousel.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#hot-deal,#special-deal").owlCarousel({
                autoPlay: 3000,
                singleItem: true,
                pagination: false,
                navigation: true,
                navigationText: ["<i class='fa fa-caret-left'></i>", "<i class='fa fa-caret-right'></i>"]
            });
            $("#kids,#personal-care,#healthy-beauty,#audio-visual").owlCarousel({
                autoPlay: 3000,
                items: 4,
                itemsDesktop: [1199, 3],
                itemsDesktopSmall: [979, 2],
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
    <!--lighterbox-->
    <script src="js/lightslider.min.js"></script>
    <script>
        $(document).ready(function () {
            //$("#content-slider").lightSlider({
            //    loop: true,
            //    keyPress: true
            //});
            $('#image-gallery').lightSlider({
                gallery: true,
                item: 1,
                thumbItem: 5,
                slideMargin: 0,
                speed: 500,
                auto: true,
                loop: true,
                thumbMargin: 5,
                controls: false,
                //prevHtml: "<img src='images/prev-btn.png' class='img-responsive' alt='prev-btn' />",
                //nextHtml: "<img src='images/next-btn.png' class='img-responsive' alt='prev-btn' />",
                onSliderLoad: function () {
                    $('#image-gallery').removeClass('cS-hidden');
                }
            });
        });
    </script>
    <!--fancybox-->
    <script type="text/javascript" src="js/jquery.fancybox.pack.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //$('.fancybox').fancybox();
            $(".fancybox-effects-c").fancybox({
                wrapCSS: 'fancybox-custom',
                closeClick: true,

                openEffect: 'none',

                helpers: {
                    title: {
                        type: 'inside'
                    },
                    overlay: {
                        css: {
                            'background': 'rgba(0,0,0,0.85)'
                        }
                    }
                }
            });
        });
    </script>
</asp:Content>

