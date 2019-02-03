<%@ Page Title="" Language="C#" MasterPageFile="~/DSED08.master" AutoEventWireup="true" CodeFile="product.aspx.cs" Inherits="product_buzz_value" %>

<%@ Register Src="~/includes/left-sidebar.ascx" TagName="leftsidebarIncl" TagPrefix="u3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script >
        function reload() {
            $(".Carousel").owlCarousel({
                autoPlay: 3000,
                items: 4,
                itemsDesktop: [1199, 3],
                itemsDesktopSmall: [979, 2],
                pagination: false,
                navigation: true,
                navigationText: ["<i class='fa fa-caret-left'></i>", "<i class='fa fa-caret-right'></i>"]
            });
            $('.product-image').equalHeights();
            $('.item h3').equalHeights();
        }
    </script>
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
                                <li><a href="product.aspx" class="active">product</a></li>
                            </ol>
                        </div>
                    </div>
                </div>
                <!--kids-->
                  <asp:UpdatePanel ID="upnl1" runat="server">
        <ContentTemplate>           
                        <script type="text/javascript">    Sys.Application.add_load(reload);</script>
            <asp:UpdateProgress AssociatedUpdatePanelID="upnl1" ID="UP_product" runat="server">

                <ProgressTemplate>
                    <div id="loading" class="loadingimg" style="height: 100%; width: 100%;" align="center">
                        <img src="images/loader.gif" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
    <asp:HiddenField runat="server" ID="hfPagination" />
                <asp:Repeater runat="server" ID="repCat" OnItemDataBound="repCat_ItemDataBound"><ItemTemplate>
                    <div class="panel">
                        <div class="section-main-box new-produxts-tab">
                            <div class="border-bottom">
                                <div class="row">
                                    <div class="col-sm-9">
                                        <asp:HiddenField runat="server" ID="hfcatid" Value='<%#Eval("id").ToString() %>' />
                                        <h1><%#Eval("title").ToString() %></h1>
                                         <div class="view-all"><a href="product-listing.aspx?catid=<%#Eval("id").ToString() %>">View All</a></div>
                                    </div>
                                   <%-- <div class="col-sm-3">
                                        <div class="view-all"><a href="product-listing.aspx?catid=<%#Eval("id").ToString() %>">View All</a></div>
                                    </div>--%>
                                </div>
                            </div>
                            <!--kids-->
                            <div class="section-box">
                                <div id="kids" class="new-product Carousel">
                                    <asp:Repeater runat="server" ID="repProduct">
                                        <ItemTemplate>
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
                                                            <%#double.Parse(Eval("sellprice").ToString())!=double.Parse(Eval("costprice").ToString()) ?"<span class=\"price-before-discount\">$"+double.Parse(Eval("costprice").ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN"))+"</span>":""%> <span class="price">$<%#double.Parse(Eval("sellprice").ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN")) %> </span>
                                                        </div>
                                                    </div>
                                                </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </div>
                    </ItemTemplate></asp:Repeater>
            
                <!--load more button-->
                <div class="load-more buttton-file">
                    <asp:LinkButton runat="server" CssClass="btn btn-default col-sm-12 " Visible="false" id="lbPagination" OnClick="lbPagination_Click">Load More</asp:LinkButton>
                </div>
            </ContentTemplate></asp:UpdatePanel>
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
            $("#kids").owlCarousel({
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
</asp:Content>

