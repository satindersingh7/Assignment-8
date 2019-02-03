<%@ Page Title="" Language="C#" MasterPageFile="~/DSED08.master" AutoEventWireup="true" CodeFile="faq.aspx.cs" Inherits="faq_buzz_value" %>

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
                        <li><a href="faq.aspx" class="active">FAQ</a></li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
    <!--faq content page-->
    <div class="container">
        <div class="border-bottom">
            <h1>FAQ</h1>
        </div>
        <div class="main-panel">
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                 <asp:Repeater ID="rep_Faq" runat="server"><ItemTemplate>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="heading<%#Container.ItemIndex %>">
                        <h4 class="panel-title">
                            <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<%#Container.ItemIndex %>" aria-expanded="true" aria-controls="collapse<%#Container.ItemIndex %>">
                                 <%#Eval("question") %>
                            </a>
                        </h4>
                    </div>
                     <div id="collapse<%#Container.ItemIndex %>" class="panel-collapse collapse  <%#Container.ItemIndex==0 ? "in" : "" %>" role="tabpanel" aria-labelledby="heading<%#Container.ItemIndex %>">
                                <div class="panel-body">
                             <%#Eval("answer") %>
                        </div>
                    </div>
                </div>
                       </ItemTemplate></asp:Repeater>
               
            </div>
            <div runat="server" id="noitem" visible="false">
                    <h1>Coming Soon...</h1>
                </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="extraJs" runat="Server">
</asp:Content>

