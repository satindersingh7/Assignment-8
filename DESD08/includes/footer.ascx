<%@ Control Language="C#" AutoEventWireup="true" CodeFile="footer.ascx.cs" Inherits="includes_footer" %>
<%if (!(Request.ServerVariables["URL"].ToString().ToLower().Contains("brand-partners.aspx")))
  { %>
<!--partners here-->
<div class="partners section-box" runat="server" id="divPartner">
    <div class="container">
        <div id="logo-slide">
            <asp:Repeater runat="server" ID="reppartner">
                <ItemTemplate>
                    <div class="item">
                        <div class="brand-partner-image">

                            <a href="<%#Eval("url").ToString()==""?"javascript:;":Eval("url").ToString()%>" target="_blank">
                                <img src="webfiles/partner/<%#Eval("image").ToString()%>" class="img-responsive center-block inactive" alt="partners" />
                                </a>

                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

</div>
<!--footer link here-->
<%} %>
<footer>
    <div class="footer-link">
        <div class="container">
            <div class="row">
                <div class="col-lg-5 col-md-8">
                    <img src="images/buzz-value-white-logo.png" alt="buzz-value-white-logo" class="img-responsive logo" />
                    <p><asp:Literal runat="server" ID="ltrAbout"></asp:Literal>...<a href="about-us.aspx">Read More</a></p>
                </div>
                <div class="col-md-3 col-sm-4 col-sm-offset-1">
                    <h1>Information </h1>
                    <div class="information">
                        <ul>
                            <li><a href="about-us.aspx">Our Story</a></li>
                            <li><a href="warranties.aspx">Warranties</a></li>
                            <li><a href="complaints-process.aspx">Complaints Process</a></li>
                            <li><a href="shipping-and-delivery.aspx">Shipping & Delivery</a></li>
                            <li><a href="careers.aspx">Careers</a></li>
                            <li><a href="faq.aspx">FAQs</a></li>
                        </ul>
                    </div>
                </div>
               <%-- <div class="col-md-2 col-sm-4">
                    <h1>Our Social </h1>
                    <div class="information mini-info">
                        <ul>
                            <li><span class="icon-soc"><i class="fa fa-google-plus"></i></span><span class="right-write"><a href="#">Google+</a></span></li>
                            <li><span class="icon-soc"><i class="fa fa-pinterest-p"></i></span><span class="right-write"><a href="#">Pinterest</a></span></li>
                            <li><span class="icon-soc"><i class="fa fa-vimeo"></i></span><span class="right-write"><a href="#">Vimeo</a></span></li>
                            <li><span class="icon-soc"><i class="fa fa-instagram"></i></span><span class="right-write"><a href="#">Instagram</a></span></li>
                        </ul>
                    </div>
                </div>--%>
                <div class="col-md-3 col-sm-4">
                    <h1>Contact Us</h1>
                    <div class="information">
                        <ul>
                            <li><span class="icon-soc"><i class="fa fa-map-marker" aria-hidden="true"></i></span><span class="right-write">PO Box 258052, Botany, 
Auckland 2163, New Zealand</span></li>
                            <li><span class="icon-soc"><i class="fa fa-phone"></i></span><span class="right-write"><a href="telto:+64800848411">+64 800 84 84 11</a></span></li>
                            <li><span class="icon-soc"><i class="fa fa-envelope"></i></span><span class="right-write"><a href="mailto:info@DSED08.co.nz">info@DSED08.co.nz</a></span></li>
                        </ul>
                        <!-- button pdf-->
                        <div class="buttton-file">
                            <asp:Literal runat="server" ID="ltrdownload"></asp:Literal>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="copyright-and-links">
        <div class="container">
            <div class="text-center">
                <span><a href="Default.aspx" <%if (Request.ServerVariables["URL"].ToString().ToLower().Contains("default.aspx"))
                                               {%> class="active" <%}%>>Home</a></span>
                <span><a href="product.aspx" <%if (Request.ServerVariables["URL"].ToString().ToLower().Contains("product.aspx") || Request.ServerVariables["URL"].ToString().ToLower().Contains("product-listing.aspx") || Request.ServerVariables["URL"].ToString().ToLower().Contains("product-detail.aspx"))
                                                          {%> class="active" <%}%>>Products</a></span>
                <span><a href="deals-and-offers.aspx" <%if (Request.ServerVariables["URL"].ToString().ToLower().Contains("deals-and-offers.aspx"))
                                                        {%> class="active" <%}%>>Deals & Offers</a></span>
                <span><a href="brand-partners.aspx" <%if (Request.ServerVariables["URL"].ToString().ToLower().Contains("brand-partners.aspx"))
                                                                 {%> class="active" <%}%>>Brand Partners</a></span>
                <span><a href="about-us.aspx" <%if (Request.ServerVariables["URL"].ToString().ToLower().Contains("about-us.aspx"))
                                                {%> class="active" <%}%>>About Us</a></span>
                <span><a href="contact-us.aspx" <%if (Request.ServerVariables["URL"].ToString().ToLower().Contains("contact-us.aspx"))
                                                             {%> class="active" <%}%>>Contact Us</a></span><br />
                <span>Copyright &copy; 2017, DSED08,Botany, Auckland 2163, New Zealand<br /> All Rights Reserved.</span><span style="color:#fff;">|</span><span><a href="sitemap.html">Sitemap</a></span>
            </div>
        </div>
    </div>
</footer>
