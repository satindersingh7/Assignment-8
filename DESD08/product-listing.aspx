<%@ Page Title="" Language="C#" MasterPageFile="~/DSED08.master" AutoEventWireup="true" CodeFile="product-listing.aspx.cs" Inherits="product_listing" %>

<%@ Register Src="~/includes/left-sidebar.ascx" TagName="leftsidebarIncl" TagPrefix="u3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        function reload() {
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
                        <!--breadcrumb here-->
                        <div class="panel">
                            <div class="row">
                                <div class="col-sm-12">
                                    <ol class="breadcrumb">
                                        <li><a href="Default.aspx">Home</a></li>
                                        <li><a href="product.aspx">product</a></li>
                                        <li><a href="javascript:;" class="active">
                                            <asp:Literal runat="server" ID="ltrBtitle"></asp:Literal></a></li>
                                    </ol>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="section-main-box">
                                        <div class="sort-by">
                                            <span>SORT BY</span>
                                            <asp:DropDownList ID="ddlsortby" runat="server" CssClass="all-department" OnSelectedIndexChanged="ddlsortby_SelectedIndexChanged" AutoPostBack="true">
                                                <asp:ListItem Value="id desc">Newest First</asp:ListItem>
                                                <asp:ListItem Value="sellprice">Price - Low to High</asp:ListItem>
                                                <asp:ListItem Value="sellprice desc">Price - High to Low</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="section-main-box">
                                        <div class="sort-by">
                                            <span>SHOW</span>
                                            <asp:DropDownList ID="ddlsort" runat="server" CssClass="all-department" OnSelectedIndexChanged="ddlsort_SelectedIndexChanged" AutoPostBack="true">
                                                <asp:ListItem Value="30">30</asp:ListItem>
                                                <asp:ListItem Value="60">60</asp:ListItem>
                                                <asp:ListItem Value="90">90</asp:ListItem>

                                            </asp:DropDownList>
                                            <span>PER PAGE</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="section-main-box">
                                        <div class="sort-by">
                                            <span>FILTER</span>
                                            <asp:DropDownList ID="ddl_Category" AutoPostBack="true" runat="server" CssClass="all-department" OnSelectedIndexChanged="ddl_Category_SelectedIndexChanged"></asp:DropDownList>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="brand-partners">
                            <div class="border-bottom">
                                <h1>
                                    <asp:Literal runat="server" ID="ltrTitle"></asp:Literal></h1>
                            </div>
                        </div>
                        <!--product-list-->
                        <div class="product-deals-offers">
                            <div class="row">
                                <asp:Repeater runat="server" ID="repProduct">
                                    <ItemTemplate>
                                        <div class="col-sm-4">
                                            <div class="panel">
                                                <div class="section-main-box">
                                                   
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
                                                    
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>

                            </div>
                            <div runat="server" id="trNoitem" visible="false">
                                <h2>No Products Available</h2>
                            </div>
                        </div>

                        <div class="text-center">
                            <nav aria-label="Page navigation">
                                <ul class="pagination" id="div_Paging" runat="server" visible="false">
                                    <li>
                                        <asp:LinkButton ID="lnkPrevious" runat="server" aria-label="Previous" OnClick="lnkPrevious_Click">  <span aria-hidden="true">&laquo;</span></asp:LinkButton>
                                    </li>
                                    <asp:Repeater ID="RepeaterPaging" runat="server" OnItemCommand="RepeaterPaging_ItemCommand" OnItemDataBound="RepeaterPaging_ItemDataBound">
                                        <ItemTemplate>
                                            <li>
                                                <asp:LinkButton ID="Pagingbtn" runat="server" ClientIDMode="AutoID" CommandArgument='<%# Eval("PageIndex") %>' CommandName="newpage"><%# Eval("PageText") %></asp:LinkButton></li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <li>
                                        <asp:LinkButton ID="lnkNext" runat="server" aria-label="Next" OnClick="lnkNext_Click"> <span aria-hidden="true">&raquo;</span></asp:LinkButton>

                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
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

