<%@ Page Title="" Language="C#" MasterPageFile="~/DSED08.master" AutoEventWireup="true" CodeFile="thank-you.aspx.cs" Inherits="thank_you" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <asp:Literal ID="ltr_Meta" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <!--breadcrumb here-->
    <div class="container">
        <div class="panel">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb">
                        <li><a href="Default.aspx">Home</a></li>
                        <li><a href="thank-you.aspx" class="active">Thank You</a></li>
                    </ol>
                </div>
                <div class="col-sm-6 text-right">
                   
                </div>
            </div>
        </div>
    </div>
    <!--about us content-->
    <div class="container">
        <div class="panel">
            <div class="section about-us">
                    <h1 class="text-center">Thank You</h1>
                    <p class="content text-center">
        <includes:PageContent ID="PageContent" runat="server" />
        <includes:PageContent ID="PageContent1" runat="server" />
                      
                    </p>
                </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extraJs" Runat="Server">
</asp:Content>

