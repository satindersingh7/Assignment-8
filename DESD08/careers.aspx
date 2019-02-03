<%@ Page Title="" Language="C#" MasterPageFile="~/DSED08.master" AutoEventWireup="true" CodeFile="careers.aspx.cs" Inherits="careers_buzz_value" %>

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
                        <li><a href="careers.aspx" class="active">Careers</a></li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
    <!--careers content page-->
    <div class="container">
    <div class="panel">
    <div class="section-main-box">
        <h1>Careers</h1>
        <includes:PageContent ID="PageContent" runat="server" />
       </div>
    </div>
   </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extraJs" Runat="Server">
</asp:Content>

