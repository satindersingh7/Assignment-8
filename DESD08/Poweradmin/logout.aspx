<%@ Page Title="" Language="C#" MasterPageFile="~/Poweradmin/admin.master" AutoEventWireup="true" CodeFile="logout.aspx.cs" Inherits="Poweradmin_logout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">LOGOUT</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
     <div class="row">
        <div class="col-lg-12" style="text-align:center;">
            
         <h4>   You have successfully logout.<br /><br />
           
             You are being redirected to login page. Please wait....<br /><br />

               <img src="images/wait.gif" /><br /><br />
         </h4>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extrajs" Runat="Server">
</asp:Content>

