<%@ Page Title="" Language="C#" MasterPageFile="~/DSED08.master" AutoEventWireup="true" CodeFile="about-us.aspx.cs" Inherits="about_us" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <asp:Literal ID="ltr_Meta" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!--breadcrumb here-->
    <div class="container">
        <div class="panel">
            <div class="row">
                <div class="col-sm-12">
                    <ol class="breadcrumb">
                        <li><a href="Default.aspx">Home</a></li>
                        <li><a href="about-us.aspx" class="active">About Us</a></li>
                    </ol>
                </div>
                <%--<div class="col-sm-6 text-right">
                    <div class="breadcrumb">
                        <a href="Default.aspx">
                            <i class="fa fa-angle-double-left"></i>
                             Back to previous page
                        </a>
                    </div>
                </div>--%>
            </div>

        </div>
    </div>
    <!--about us content-->
    <div class="container">
        <div class="panel">
            <div class="section about-us">
            <div class="row">
                <div class="col-md-4">
                    <img src="images/about-us.png" alt="about-us" class="img-responsive center-block" />
                </div>
                <div class="col-md-8">
                    <h1>About us</h1>
                    <includes:PageContent ID="PageContent" runat="server" />
                    
                </div>
            </div>
           </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extraJs" runat="Server">
</asp:Content>

