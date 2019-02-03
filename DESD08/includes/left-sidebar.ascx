<%@ Control Language="C#" AutoEventWireup="true" CodeFile="left-sidebar.ascx.cs" Inherits="includes_left_sidebar" %>
<div class="row">

    <div class=" col-md-12 col-sm-6" runat="server" id="divHot">
        <div class="panel">
            <h1 class="left-list">Hot Deals</h1>
            <hr />
            <div id="hot-deal">
                <asp:Repeater runat="server" ID="repHot">
                    <ItemTemplate>
                       
                            <div class="item">
                                <div class="product-image">
                                     <a href="deals-and-offers-detail.aspx?id=<%#Eval("id").ToString() %>">
                                    <img src="webfiles/product/medium/<%#Eval("image").ToString() %>" class="img-responsive" alt="<%#Eval("title").ToString() %>">
                                     </a>
                                </div>
                                <div class="text-center">
                                     <a href="deals-and-offers-detail.aspx?id=<%#Eval("id").ToString() %>"> <a href="deals-and-offers-detail.aspx?id=<%#Eval("id").ToString() %>">
                                    <h3 class="product-name"><%#Eval("title").ToString().Length>30 ? Eval("Title").ToString().Replace("''", "'").Substring(0,27)+"..." : Eval("Title").ToString().Replace("''", "'") %></h3>
                                         </a>
                                    <div class="product-price"><span class="price-before-discount">$<%#double.Parse(Eval("costprice").ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN")) %></span> <span class="price">$<%#double.Parse(Eval("sellprice").ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN")) %> </span></div>
                                </div>
                            </div>
                        
                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </div>
    </div>

    <!--newsletter-->
    <div class=" col-md-12 col-sm-6">
        <div class="panel">
            <h1 class="left-list">Newsletters</h1>
            <hr />
            <div class="inner-product newsletter buttton-file">
                <h3 class="text-left">Sign Up for Our Newsletter!</h3>
                <asp:TextBox ID="tbx_Subscriberemail" runat="server" placeholder="Email Address" MaxLength="100" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbx_Subscriberemail" ErrorMessage="Email" SetFocusOnError="true" Display="None" ValidationGroup="vgSubscribe"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="regex2" runat="server" ControlToValidate="tbx_Subscriberemail" ErrorMessage="Invalid Email" SetFocusOnError="true" Display="None" ValidationGroup="vgSubscribe" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                <asp:ValidationSummary ID="vsm1" runat="server" ShowMessageBox="true" ShowSummary="false" ValidationGroup="vgSubscribe" DisplayMode="List" />
                <asp:Button ID="btnsubscribe" runat="server" CssClass="btn btn-default" Text="SUBSCRIBE"  OnClick="btnsubscribe_Click" ValidationGroup="vgSubscribe" />
            </div>
        </div>
    </div>
    <div class=" col-md-12 col-sm-6" runat="server" id="divSidebanner">
        <div class="panel">
            <a runat="server" id="link">
            <img runat="server" id="img" src="images/side-advertise-banner.png" alt="side-advertise" class="img-responsive" />
                </a>
        </div>
    </div>
</div>
