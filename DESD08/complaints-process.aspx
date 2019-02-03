<%@ Page Title="" Language="C#" MasterPageFile="~/DSED08.master" AutoEventWireup="true" CodeFile="complaints-process.aspx.cs" Inherits="terms_and_onditions" %>

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
                        <li><a href="complaints-process.aspx" class="active">Complaints Process</a></li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
    <!--tearms and conditions content page-->
    <div class="container">
    <div class="panel">
    <div class="section-main-box">
        <h1>Complaints Process</h1>
        <includes:PageContent ID="PageContent" runat="server" />
               
    </div>
    </div>
   </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extraJs" Runat="Server">
</asp:Content>

