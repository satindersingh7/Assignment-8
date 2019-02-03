<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ckeditor.ascx.cs" Inherits="Poweradmin_ckeditor_ckeditor" %>

<script src="<%=DAL.GetCMSPath()%>/ckeditor/ckeditor.js"></script>
<textarea name="editor1" id="editor1" runat="server" rows="50" cols="80"></textarea>
<script>
    // Replace the <textarea id="editor1"> with a CKEditor
    // instance, using default configuration.
    CKEDITOR.replace('<%=editor1.ClientID%>', {
        filebrowserBrowseUrl: '<%=DAL.GetCMSPath()%>/CKeditor/filemanager/browser/default/browser.html?Connector=<%=DAL.GetCMSPath()%>/CKeditor/filemanager/connectors/aspx/connector.aspx',
                    filebrowserImageBrowseUrl: '<%=DAL.GetCMSPath()%>/CKeditor/filemanager/browser/default/browser.html?Type=Image&Connector=<%=DAL.GetCMSPath()%>/CKeditor/filemanager/connectors/aspx/connector.aspx',
                    filebrowserFlashBrowseUrl: '<%=DAL.GetCMSPath()%>/CKeditor/filemanager/browser/default/browser.html?Type=Flash&Connector=<%=DAL.GetCMSPath()%>/CKeditor/filemanager/connectors/aspx/connector.aspx',
                    enterMode: CKEDITOR.ENTER_BR,
                    uiColor: '#cccccc'
                });
</script>
