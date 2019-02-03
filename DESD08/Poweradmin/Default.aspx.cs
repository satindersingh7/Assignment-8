using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class login : System.Web.UI.Page
{
    string strQuery = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        txtUnm.Focus();
        if (!IsPostBack)
        {
            getRememberMe();
        }

        if (Request.QueryString["msg"] != null)
        {
            if (Request.QueryString["msg"].ToString() != "")
            {
                //div_Success.Visible = true;
                //ltr_Success.Visible = true;
                //ltr_Success.Text = Request.QueryString["msg"].ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('" + Request.QueryString["msg"].ToString() + "');", true);
            }
        }
    }
   
    protected void btnLogIn_Click(object sender, EventArgs e)
    {
        if (txtUnm.Text != "" && txtPass.Text != "")
        {
            DataTable dt = new DataTable();
            strQuery = "Select * from admin where unm = '" + txtUnm.Text.Replace("'", "''") + "' and pwd = '" + txtPass.Text.Replace("'", "''") + "'";
            try
            {
                dt = (new DAL()).GetDataTable(strQuery, CommandType.Text, null);

                if (dt.Rows.Count > 0)
                {
                    //string backupdt = dt.Rows[0]["Backupdt"].ToString();
                    //if (backupdt != "")
                    //{
                    //    DateTime dtTime = DateTime.Parse(backupdt);
                    //    TimeSpan currtime = DAL.CurrCountryTime().Subtract(dtTime);
                    //    if (currtime.Days >= 7)
                    //    {
                    //        Session["Backup"] = "1";
                    //        Response.Redirect("backup.aspx");
                    //    }
                    //}

                    Session["unm"] = dt.Rows[0]["unm"].ToString();
                    Session["uid"] = dt.Rows[0]["ID"].ToString();
                    Session.Timeout = 60;
                    remember();
                    this.recordinserion("1");
                    if (Request["page"] != null)
                        Response.Redirect(Request["page"].ToString());
                    else
                        Response.Redirect("dashboard.aspx");

                }
                else
                {
                    //div_Success.Visible = false;
                    //div_Error.Visible = true;
                    //ltr_Error.Text = "Login credentials seems to be incorrect.";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Login credentials seems to be incorrect.');", true);
                    this.recordinserion("0");
                }
            }
            catch (Exception ex)
            {
                throw ex;

            }
            finally
            {
                strQuery = "";
            }

        }
        else
        {
            //div_Success.Visible = false;
            //div_Error.Visible = true;
            //ltr_Error.Text = "Username or password required.";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Username or password required.');", true);
        }
    }
    protected void btn_GetPassword_Click(object sender, EventArgs e)
    {
        string strQuery = "select * from admin where Email='" + txtEmail.Text.Replace("'", "''") + "'";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            #region forgot password mail
            int mailSucessC = 0;
            string towhom = txtEmail.Text;


            string strBody = (new DAL()).GetMailTemplates("//poweradmin//mailtemplates//ForgetPasswordTemplate.htm");
            strBody = strBody.Replace("_DATE", DateTime.Now.ToString("dd-MMMM-yyyy"));
            strBody = strBody.Replace("_IP", DAL.getIP());
            strBody = strBody.Replace("_ADMIN", dt.Rows[0]["unm"].ToString());
            strBody = strBody.Replace("_PASSWORD", dt.Rows[0]["pwd"].ToString());
            strBody = strBody.Replace("_SITENAME", ConfigurationManager.AppSettings["SiteName"].ToString());
            strBody = strBody.Replace("_URL", DAL.GetCMSPath());
            strBody = strBody.Replace("_KPL", ConfigurationManager.AppSettings["siteurl"].ToString());
            strBody = strBody.Replace("_TOPLOGOURL", ConfigurationManager.AppSettings["siteurl"].ToString()+ConfigurationManager.AppSettings["Logo"].ToString());

            strBody = strBody.Replace("_BOTTOMLINK", "<a target='_blank' href='" + ConfigurationManager.AppSettings["siteurl"].ToString() + "'>" + ConfigurationManager.AppSettings["SiteName"].ToString() + "</a>");



            mailSucessC = (new DAL()).MailToSendSite(towhom, "Your " + ConfigurationManager.AppSettings["SiteName"].ToString() + " Details", towhom, strBody, null, null, ConfigurationManager.AppSettings["SiteName"].ToString());
            if (mailSucessC == 1)
            {
                Response.Redirect("default.aspx?msg=Your Password has been sent to your email id");
            }
            else
            {
                //div_Error.Visible = true;
                //ltr_Error.Text = "Mail Sending Failed.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Mail Sending Failed.');", true);
            }
            #endregion
        }
        else
        {
            //div_Error.Visible = true;
            //div_Success.Visible = false;
            //ltr_Error.Text = "This email does not exists in our system.";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('This email does not exists in our system.');", true);
        }
    }
    private void recordinserion(string val)
    {
        int result = 0;
        try
        {
            strQuery = "Insert into AdminLog(unm,password,aip,adate,asucess) values('" + txtUnm.Text.Replace("'", "''") + "','" + txtPass.Text.Replace("'", "''") + "','" + HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] + "','" + DAL.GetDateWithFormat() + "','" + val + "') ";
            result = (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            strQuery = "";
        }
    }

    private void getRememberMe()
    {
        try
        {
            if (Request.Cookies.Get(ConfigurationManager.AppSettings["SiteName"].ToString() + "Checked") != null)
            {
                string ckRememberme = Request.Cookies.Get(ConfigurationManager.AppSettings["SiteName"].ToString() + "Checked").Value;
                string[] chk = ckRememberme.Split('=');
                if (chk.Length > 1)
                {
                    if (chk[1] == "1")
                        chkRemember.Checked = true;
                }
            }
        }
        catch (Exception ex1)
        {
            throw ex1;
        }

        try
        {
            if (Request.Cookies.Get(ConfigurationManager.AppSettings["SiteName"].ToString() + "Username") != null)
            {
                string ckUsername = Request.Cookies.Get(ConfigurationManager.AppSettings["SiteName"].ToString() + "Username").Value;
                string[] chk = ckUsername.Split('=');
                if (chk.Length > 1)
                {
                    txtUnm.Text = chk[1];
                }
            }
        }
        catch (Exception ex2) { throw ex2; }

        try
        {
            if (Request.Cookies.Get(ConfigurationManager.AppSettings["SiteName"].ToString() + "Password") != null)
            {
                string ckPassword = Request.Cookies.Get(ConfigurationManager.AppSettings["SiteName"].ToString() + "Password").Value;
                string[] chk = ckPassword.Split('=');
                if (chk.Length > 1)
                {
                    txtPass.Attributes.Add("value", chk[1]);
                }
            }
        }
        catch (Exception ex3) { throw ex3; }
    }

    void remember()
    {
        if (chkRemember.Checked)
        {
            remembermefunction(ConfigurationManager.AppSettings["SiteName"].ToString() + "Username", txtUnm.Text, 365);//Save Username
            remembermefunction(ConfigurationManager.AppSettings["SiteName"].ToString() + "Password", txtPass.Text, 365);//Save Password                    
            remembermefunction(ConfigurationManager.AppSettings["SiteName"].ToString() + "Checked", "1", 365);//Save rememberme
        }
        else
        {
            Response.Cookies[ConfigurationManager.AppSettings["SiteName"].ToString() + "Username"].Expires = DateTime.Now;
            Response.Cookies[ConfigurationManager.AppSettings["SiteName"].ToString() + "Password"].Expires = DateTime.Now;
            Response.Cookies[ConfigurationManager.AppSettings["SiteName"].ToString() + "Checked"].Expires = DateTime.Now;
        }
    }

    void remembermefunction(string cookiename, string cookievalue, int iDaysToExpire)
    {
        try
        {
            if (cookievalue != "")
            {
                HttpCookie objCookie = new HttpCookie(cookiename);
                HttpContext.Current.Response.Cookies.Add(objCookie);
                objCookie.Values.Add(cookiename, cookievalue);
                DateTime dtExpiry = DateTime.Now.AddDays(iDaysToExpire);
                HttpContext.Current.Response.Cookies[cookiename].Expires = dtExpiry;
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    
}

