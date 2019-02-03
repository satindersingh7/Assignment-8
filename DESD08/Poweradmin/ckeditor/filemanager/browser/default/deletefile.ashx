<%@ WebHandler Language="C#" Class="deletefile" %>

using System;
using System.Web;

public class deletefile : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string filePath = Convert.ToString(context.Request["filetodel"]);
        try
        {
            filePath = filePath.Replace('|', '&');
            System.IO.File.Delete(context.Server.MapPath(filePath));
            context.Response.Write("File Deleted Successfully");
        }
        catch (Exception ex)
        {
            context.Response.Write("Below error occured while deleting file" + System.Environment.NewLine + ex.Message);
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}