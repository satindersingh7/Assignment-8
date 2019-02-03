<%@ Page Title="" Language="C#" MasterPageFile="~/DSED08.master" AutoEventWireup="true" CodeFile="brand-partners.aspx.cs" Inherits="brand_partners_buzz_value" %>

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
                        <li><a href="brand-partners.aspx" class="active">Brand Partners</a></li>
                    </ol>
                </div>

            </div>
        </div>
    </div>
    <!--brand-partners-->
    <div class="container">
        <div class="brand-partners">
            <div class="border-bottom">
                <h1>Brand Partners</h1>
            </div>
            <div class="row">
                <asp:Repeater runat="server" ID="reppartner">
                    <ItemTemplate>
                        <div class="col-sm-2">
                            <div class="brand-partner-image">
                                <a href="<%#Eval("url").ToString()==""?"javascript:;":Eval("url").ToString()%>" target="_blank">
                                    <img src="webfiles/partner/<%#Eval("image").ToString()%>" class="img-responsive center-block inactive" alt="partners" />
                                </a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="col-sm-12" runat="server" id="divNoPartner">
                    <br />
                    <p>Currently there are no Partners</p>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extraJs" runat="Server">
    <script src="js/jquery.equalheights.js"></script>
    <script>
        $(document).ready(function () {
            $('.brand-partner-image').equalHeights();
        });
    </script>
</asp:Content>

