<%@ Page Title="" Language="C#" MasterPageFile="~/DSED08.master" AutoEventWireup="true" CodeFile="deals-and-offers.aspx.cs" Inherits="deals_and_offers" %>
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
    <!--deals and offers page-->
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-3 hidden-sm hidden-xs">
                 <div class="hidden-height"></div>
                  <div class="section-box product-list">
                 <u3:leftsidebarIncl ID="leftsidebarInc" runat="server" />
                      </div>
            </div>
            <div class="col-lg-9 col-md-9">
                <!--breadcrumb here-->
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
                <div class="panel">
                    <div class="row">
                        <div class="col-sm-12">
                            <ol class="breadcrumb">
                                <li><a href="Default.aspx">Home</a></li>
                                <li><a href="deals-and-offers.aspx" class="active">Deals & Offers</a></li>
                            </ol>
                        </div>
                    </div>
                </div>
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
                <div class="product-deals-offers" runat="server" id="divOffers">
                    <div class="row">
                        <asp:Repeater runat="server" ID="repProduct">
                            <ItemTemplate>
                                <div class="col-sm-4">
                                    <div class="panel">
                                        <div class="section-main-box">
                                                <div class="item">
                                                    <div class="product-image">
                                                        <a href="deals-and-offers-detail.aspx?id=<%#Eval("id").ToString() %>">
                                                        <img src="webfiles/product/medium/<%#Eval("image").ToString() %>" class="img-responsive center-block" alt="<%#Eval("title").ToString() %>">
                                                            </a>
                                                    </div>
                                                    <div class="text-center">
                                                        <a href="deals-and-offers-detail.aspx?id=<%#Eval("id").ToString() %>">
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
                </div>
                  <div class="row" runat="server" id="trNoitem" visible="false">
                                                        <h2>
                                                            No Deals & Offers Available
                                                        </h2>
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
                <div class="row" runat="server" id="divmiddlebanner1">
                    <div class="col-sm-6">
                        <a runat="server" id="link3">
                            <img runat="server" id="img3" visible="false" alt="bottom-advertise" class="img-responsive" />
                        </a>
                    </div>
                    <div class="col-sm-6">
                        <a runat="server" id="link4">
                            <img runat="server" id="img4" visible="false" alt="bottom-advertise" class="img-responsive" />
                        </a>
                    </div>
                </div>
                <div class="section-box" runat="server" id="divbottombanner">
                    <div class="panel">
                        <a runat="server" id="link">
                            <img runat="server" id="img" src="images/side-advertise-banner.png" alt="bottom-advertise" class="img-responsive" />
                        </a>
                    </div>
                </div>
                  </ContentTemplate></asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extraJs" runat="Server">
    <script src="js/jquery.equalheights.js"></script>
    <script>
        $(document).ready(function () {
            $('.product-image').equalHeights();
            $('.item h3').equalHeights();
        });
    </script>
</asp:Content>

