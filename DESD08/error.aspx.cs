using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class about_us : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Application["Exception"] != null && Application["Exception"].ToString() != "")
        {
            try
            {
                string mbody = System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath(HttpContext.Current.Request.ApplicationPath).Replace("/", "\\") + "\\mailtemplates\\error.htm");

                mbody = mbody.Replace("_ERRROLINK", Application["errorurl"].ToString());
                mbody = mbody.Replace("_ERRRODATE", Application["errortime"].ToString());
                mbody = mbody.Replace("_ERRORBROWSER", Application["browser"].ToString());
                mbody = mbody.Replace("_ERRORDETAILS", Application["Exception"].ToString());
                mbody = mbody.Replace("_ERRORIP", Application["clientip"].ToString());
                mbody = mbody.Replace("_YELLOWPAGE", Application["actualerrorpage"].ToString());


                if (Application["actualerrorpage"].ToString().IndexOf("Validation of viewstate MAC failed") <= 0 && Application["errorurl"].ToString().IndexOf("ScriptResource.axd") <= 0 && Application["errorurl"].ToString().IndexOf("WebResource.axd") <= 0 && Application["actualerrorpage"].ToString().IndexOf("The state information is invalid for this page and might be corrupted") <= 0)
                    MailToSendSite("testing@yourwebsitepreview.com", "Error Buzz Value", "info@DSED08.co.nz", mbody.ToString(), null, null, "mail.yourwebsitepreview.com", "forms@yourwebsitepreview.com", "forms123");
                //testing@yourwebsitepreview.com
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
    public int MailToSendSite(string tomail, string mailsubject, string frommail, string bodymail, string ccmail, string bccmail, string hostname, string musername, string mpass)
    {
        try
        {
            SmtpClient smtpClientC = new SmtpClient();
            MailMessage objMailC = new MailMessage();
            MailAddress objMailC_fromaddress = new MailAddress(frommail);
            MailAddress objMailC_toaddress = new MailAddress(tomail);

            objMailC.From = objMailC_fromaddress;
            objMailC.To.Add(objMailC_toaddress);


            objMailC.IsBodyHtml = true;

            objMailC.Subject = mailsubject;

            objMailC.Body = bodymail;

            if (ccmail != null)
            {
                if (ccmail != "")
                    objMailC.CC.Add(ccmail);
            }

            if (bccmail != null)
            {
                if (bccmail != "")
                    objMailC.Bcc.Add(bccmail);
            }

            smtpClientC.Host = hostname;
            smtpClientC.Credentials = new System.Net.NetworkCredential(musername, mpass);
            smtpClientC.Send(objMailC);
            return 1;

        }
        catch (Exception ex)
        {
            HttpContext.Current.Response.Write(ex.StackTrace + "<BR>" + ex.Message + "<BR>" + ex.InnerException);
            return 0;
        }


    }
}