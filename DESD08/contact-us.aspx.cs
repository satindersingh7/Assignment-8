using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class contact_us_buzz_value : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            ImageVarification.setImage1(imgCaptcha, hfVerification);
    }

    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        if (tbx_ContactSecure.Text == hfVerification.Value)
        {
            string strQuery = "";
            strQuery = "insert into contactus (Name,Email,Phone,Subject,message,Edate,Eip,unread) values(";
            strQuery += "'" + tbx_Name.Text.Replace("'", "''") + "','" + tbx_Email.Text.Replace("'", "''") + "',";
            strQuery += "'" + tbx_ContactNo.Text.Replace("'", "''") + "','" + txtSubject.Text.Replace("'", "''") + "','" + txtComment.Text.Replace("'", "''") + "',";
            strQuery += "'" + DAL.GetDateWithFormat() + "','" + DAL.getIP() + "',1);" + Environment.NewLine;
            (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);

            #region Send Email
            string StrMailBody = "";
            StrMailBody = new DAL().GetMailTemplates("\\mailtemplates\\contactusenquiry.htm");
            StrMailBody = StrMailBody.Replace("_LOGOURL_", ConfigurationManager.AppSettings["siteurl"].ToString() + ConfigurationManager.AppSettings["logo"].ToString());
            StrMailBody = StrMailBody.Replace("_Name_", tbx_Name.Text);
            StrMailBody = StrMailBody.Replace("_Sitename_", ConfigurationManager.AppSettings["Sitename"].ToString());
            StrMailBody = StrMailBody.Replace("_Phone_", tbx_ContactNo.Text);
            StrMailBody = StrMailBody.Replace("_Email_", tbx_Email.Text);
            StrMailBody = StrMailBody.Replace("_Subject_", txtSubject.Text);
            StrMailBody = StrMailBody.Replace("_Message_", txtComment.Text);
            #endregion
            new DAL().MailToSendSite("", "New Contact Enquiry from " + ConfigurationManager.AppSettings["sitename"].ToString(), tbx_Email.Text, StrMailBody, null, null, tbx_Name.Text);
            Response.Redirect("thank-you.aspx");

        }
        else
        {

            tbx_ContactSecure.Text = "";
            // ImageVarification.setImage1(imgCaptcha, hfVerification);
            lbl_Error.Text = "<div class='text-center contact-to-content' style='color:red;'>Please Enter valid security code.</div>";
            return;
        }
    }
}