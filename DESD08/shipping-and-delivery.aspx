﻿<%@ Page Title="" Language="C#" MasterPageFile="~/DSED08.master" AutoEventWireup="true" CodeFile="shipping-and-delivery.aspx.cs" Inherits="shipping_and_delivery" %>

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
                        <li><a href="shipping-and-delivery.aspx" class="active">Shipping & Delivery</a></li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
    <!--shipping-and-delivery content page-->
    <div class="container">
    <div class="panel">
    <div class="section-main-box">
        <h1>Shipping & Delivery</h1>
        <includes:PageContent ID="PageContent" runat="server" />
                 
    </div>
    </div>
   </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extraJs" Runat="Server">
</asp:Content>

