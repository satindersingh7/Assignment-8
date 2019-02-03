<%@ Page Title="" Language="C#" MasterPageFile="~/DSED08.master" AutoEventWireup="true" CodeFile="product-cart.aspx.cs" Inherits="product_cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!--breadcrumb here-->
    <div class="container">
        <div class="panel">
            <div class="row">
                <div class="col-sm-12">
                    <ol class="breadcrumb">
                        <li><a href="Default.aspx">Home</a></li>
                        <li><a href="brand-partners.aspx" class="active">Cart</a></li>
                    </ol>
                </div>
                <%--<div class="col-sm-6 text-right">
                    <div class="breadcrumb">
                        <a href="Default.aspx">
                            <i class="fa fa-angle-double-left"></i>Back to previous page
                        </a>
                    </div>
                </div>--%>
            </div>
        </div>
    </div>

    <div class="container">
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
                <div id="div_Success" runat="server" class="alert alert-success" visible="false">
                    <asp:Literal ID="ltr_Success" runat="server"></asp:Literal>
                </div>
                <div id="div_Error" runat="server" class="alert alert-danger" visible="false">
                    <asp:Literal ID="ltr_msg" runat="server"></asp:Literal>
                </div>
                <div class="panel">
                    <div class="section-main-box">
                        <div class="product-cart">
                            <div class="border-bottom">
                                <h1>Cart</h1>
                            </div>
                            <div class="table-responsive">
                            <table class="table table-hover">
                                <tbody>
                                    <tr class="border-bottom">
                                        <td class="text-left col-sm-2"></td>
                                        <td class="text-left col-sm-4">Product Info</td>
                                        <td class="text-right col-sm-2">Per Week</td>
                                        <td class="text-right col-sm-2">Price</td>
                                        <td class="text-center col-sm-2"></td>
                                    </tr>
                                    <asp:Repeater runat="server" ID="repcart" OnItemCommand="repcart_ItemCommand">
                                        <ItemTemplate>
                                            <tr class="border-bottom">
                                                <asp:HiddenField runat="server" ID="hdnLoopId" Value='<%#Eval("loop")%>' />
                                                <td>
                                                    <a class="thumbnail pull-left" href="product-detail.aspx?id=<%#Eval("id").ToString() %>">
                                                        <div class="product-image-small">
                                                            <img class="media-object" src="webfiles/product/medium/<%#Eval("image").ToString() %>">
                                                        </div>
                                                    </a>
                                                </td>
                                                <td>
                                                    <div class="media">
                                                        <div class="media-body">
                                                             <div class="prie-range-review">
                                                                <span>Product code:</span> <span>
                                                                    <%#Eval("code") %></span>
                                                            </div>
                                                            <h4 class="media-heading">
                                                                <%#Eval("deal").ToString()=="0"? "<a href=\"product-detail.aspx?id="+Eval("id").ToString()+"\">":"<a href=\"deals-and-offers-detail.aspx?id="+Eval("id").ToString()+"\">" %>

                                                                <%#Eval("Name").ToString() %><%#Eval("deal").ToString()=="1"?" (Deal)":""%> </a></h4>
                                                           
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="text-right">
                                                    <h5 class="media-heading">
                                                        <div class="product-price">
                                                            <%#(Eval("perweek")!=null && Eval("perweek").ToString()!="" && Eval("perweek").ToString()!="0")?"$"+double.Parse(Eval("perweek").ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN"))+"</span>":""%>
                                                        </div>
                                                    </h5>
                                                </td>
                                                <td class="text-right">
                                                     <h5 class="media-heading">
                                                        <div class="product-price">
                                                    <%#double.Parse(Eval("sellprice").ToString())!=double.Parse(Eval("costprice").ToString()) ?"<span class=\"price-before-discount\">$"+double.Parse(Eval("costprice").ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN"))+"</span>":""%> <span>$<%#double.Parse(Eval("sellprice").ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN")) %> </span>
                                                      </div>
                                                         </h5>
                                                </td>
                                                <td class="col-sm-2 text-center">
                                                    <asp:LinkButton runat="server" ID="lbremove" CommandArgument='<%#Eval("id").ToString() %>' CommandName="remove" title="Click here to delete this product from the cart." class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span>Remove</asp:LinkButton>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <tr class="border-bottom" runat="server" id="tdtotal">
                                        <td class="text-right col-sm-2" colspan="2">
                                            <div class="media">
                                                <div class="media-body">
                                                    <h5 class="media-heading"><b>Total</b></h5>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="text-right">
                                            <h5 class="media-heading"><b>$<asp:Literal runat="server" ID="ltrTotPerweek"></asp:Literal></b></h5>
                                        </td>
                                        <td class="text-right">
                                            <h5 class="media-heading"><b>$<asp:Literal runat="server" ID="ltrtotal"></asp:Literal></b></h5>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr class="border-bottom" runat="server" id="noitem">
                                        <td colspan="3">
                                            <div class="media">

                                                <div class="media-body">
                                                    <h5 class="media-heading">Your cart is empty</h5>
                                                </div>
                                            </div>
                                        </td>
                                        <td></td>
                                        <td>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                                </div>
                        </div>
                    </div>
                </div>

                <div class="contact-us" runat="server" id="divForm">
                    <div class="panel">
                        <div class="section">
                            <h1>GET IN TOUCH WITH US</h1>
                            <div class="row">
                                <div class="col-sm-6 wow zoomInDown" data-wow-duration="1s">
                                    <div class="form-group">
                                        <asp:TextBox ID="tbx_Name" CssClass="form-control" runat="server" MaxLength="50" placeholder="Your Name *"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbx_Name" ErrorMessage="Your Name" Display="None" ValidationGroup="vgContact" SetFocusOnError="true"></asp:RequiredFieldValidator>

                                    </div>
                                </div>
                                <div class="col-sm-6 wow zoomInDown" data-wow-duration="1s">
                                    <div class="form-group">
                                        <asp:TextBox ID="tbx_Email" runat="server" CssClass="form-control" MaxLength="50" placeholder="Your Email *"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="Regexp1" runat="server" ControlToValidate="tbx_Email" ErrorMessage="Invalid Email Address" Display="None" ValidationGroup="vgContact" SetFocusOnError="true" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="tbx_Email" ErrorMessage="Your Email" Display="None" ValidationGroup="vgContact" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-6 wow zoomInDown" data-wow-duration="1s">
                                    <div class="form-group">
                                        <asp:TextBox ID="tbx_ContactNo" CssClass="form-control inquire-input" runat="server" MaxLength="15" placeholder="Your Contact Number *"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tbx_ContactNo" ErrorMessage="Your Contact Number" Display="None" ValidationGroup="vgContact" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" ValidChars="0123456789+-" FilterMode="ValidChars" TargetControlID="tbx_ContactNo"></asp:FilteredTextBoxExtender>
                                    </div>
                                </div>
                                <div class="col-sm-6 wow zoomInDown" data-wow-duration="1s">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtSubject" CssClass="form-control" runat="server" MaxLength="50" placeholder="Your Subject "></asp:TextBox>

                                    </div>
                                </div>
                                <div class="col-sm-12 wow zoomInDown" data-wow-duration="1s">
                                    <div class="form-group">
                                        <asp:TextBox ID="txtComment" runat="server" CssClass="form-control multiline" TextMode="MultiLine" Rows="3" placeholder="Message"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-sm-2 wow zoomInDown" data-wow-duration="1s">
                                    <label for="captchaCode" class="control-label">
                                        <asp:Image ID="imgCaptcha" runat="server" alt="" Width="110" Height="45" />
                                        <asp:HiddenField ID="hfVerification" runat="server" />
                                    </label>
                                </div>
                                <div class="col-sm-4 wow zoomInDown" data-wow-duration="1s">
                                    <div class="form-group">
                                        <asp:TextBox ID="tbx_ContactSecure" runat="server" CssClass="form-control" placeholder="Enter Code Here *"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="tbx_ContactSecure" ErrorMessage="Security Code" ValidationGroup="vgContact" Display="None"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-sm-6 text-right wow zoomInDown buttton-file" data-wow-duration="1s">
                                    <asp:Literal ID="lbl_Error" runat="server"></asp:Literal>
                                    <asp:Button ID="btn_Submit" runat="server" CssClass="btn btn-default" Text="Submit" ValidationGroup="vgContact" OnClick="btn_Submit_Click" />
                                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" HeaderText="The system recognized faulty entries for the following fields:"
                                        ShowMessageBox="True" ShowSummary="False" ValidationGroup="vgContact" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extraJs" runat="Server">
</asp:Content>

