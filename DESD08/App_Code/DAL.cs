using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
//using System.Net.Mail;
//using System.Web.Mail;
using System.Net;
using System.IO;
using System.Text.RegularExpressions;
using System.Net.Mail;
using System.Data.SqlClient;

/// <summary>
/// Summary description for DAL
/// </summary>
public class DAL
{
    private readonly static string dbconnectionstring = ConfigurationManager.ConnectionStrings["connection"].ConnectionString;
    public DAL()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    #region Main Datbase Related Function

    /// <summary>
    /// Use null for Parameters if you dont have any parameters to pass
    /// </summary>
    public DataSet GetDataSet(String cmdText, CommandType cmdType, SqlParameter[] parameters)
    {        
        try
        {
            string conString = dbconnectionstring;            
            using (SqlConnection con = new SqlConnection(conString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(cmdText, con))
                {
                    cmd.CommandType = cmdType;
                    if (parameters != null)
                    {
                        foreach (SqlParameter parameter in parameters)
                        {
                            if (null != parameter) cmd.Parameters.Add(parameter);
                        }
                    }
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataSet ds = new DataSet();
                        da.Fill(ds);
                        return ds;
                    }
                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    /// <summary>
    /// Use null for Parameters if you dont have any parameters to pass
    /// </summary>
    public DataTable GetDataTable(String cmdText, CommandType cmdType, SqlParameter[] parameters)
    {
        try
        {
            string conString = dbconnectionstring;
            using (SqlConnection con = new SqlConnection(conString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(cmdText, con))
                {
                    cmd.CommandType = cmdType;
                    if (parameters != null)
                    {
                        foreach (SqlParameter parameter in parameters)
                        {
                            if (null != parameter) cmd.Parameters.Add(parameter);
                        }
                    }
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }
        catch (Exception ex)
        {
           throw ex;
        }
       
    }
    public static string FormateText(string input)
    {
        //Regex URLValidator = new Regex(@"[()<>"";+\n\r`]|^&+|&+$");
        //string ModifiedURL = URLValidator.Replace(input, "-");
        //ModifiedURL.Replace("--", "-");

        //replace blank with -
        string ModifiedURL = input.Trim();

        // replace with null
        ModifiedURL = ModifiedURL.Replace(",", "").Replace("'", "").Replace("~", "").Replace("`", "").Replace("@", "").Replace("!", "").Replace("#", "").Replace("$", "").Replace("^", "").Replace("&", "").Replace("*", "").Replace("(", "").Replace(")", "").Replace("[", "").Replace("]", "").Replace("{", "").Replace("}", "").Replace(":", "").Replace(";", "").Replace("'", "").Replace(".", "").Replace("?", "").Replace("/", "").Replace("\\", "").Replace("|", "").Replace("-", " ").Replace("_", " ").Replace("+", " ").Replace("=", " ").Replace("%", "");

        ModifiedURL = ModifiedURL.Replace(" ", "-");
        //replace multiple -- with -

        ModifiedURL = Regex.Replace(ModifiedURL, @"\-+", "-");

        //ModifiedURL = ModifiedURL.Replace("--", "-").Replace("---", "-").Replace("---", "-").Replace("----", "-").Replace("-----", "-");
        char[] charecters = new char[20];
        charecters[0] = '-';
        charecters[1] = ' ';
        ModifiedURL = ModifiedURL.TrimEnd(charecters);
        return ModifiedURL;
    }
    /// <summary>
    /// Use null for Parameters if you dont have any parameters to pass
    /// </summary>    
    public int ExecuteNonQuery(String cmdText, CommandType cmdType, SqlParameter[] parameters)
    {
        //SqlCommand cmd = null;
        SqlCommand cmd = null;
        int queryResult = 0;
        try
        {
             string conString = dbconnectionstring;
             //using (SqlConnection con = new SqlConnection(conString))
             //{
             //    con.Open();
             //    cmd = new SqlCommand(cmdText, con);
             //    cmd.CommandType = cmdType;
             //    if (parameters != null)
             //    {
             //        foreach (SqlParameter parameter in parameters)
             //        {
             //            if (null != parameter) cmd.Parameters.Add(parameter);
             //        }
             //    }
             //    return (queryResult = cmd.ExecuteNonQuery());
             //}
             using (SqlConnection con = new SqlConnection(conString))
             {
                 con.Open();
                 //cmd = new SqlCommand(cmdText, con);
                 cmd = new SqlCommand(cmdText, con);
                 cmd.CommandType = cmdType;
                 if (parameters != null)
                 {
                     foreach (SqlParameter parameter in parameters)
                     {
                         if (null != parameter) cmd.Parameters.Add(parameter);
                     }
                 }
                 return (queryResult = cmd.ExecuteNonQuery());
             }
        }
        catch (Exception ex)
        {
            //HttpContext.Current.Response.Write(ex.StackTrace + "<BR>" + ex.Message);
            //return -100;
            throw ex;
        }
        finally
        {
            if (cmd != null)
            {
                cmd.Parameters.Clear();
                cmd.Dispose();
            }
        }
    }
    
    /// <summary>
    /// Use null for Parameters if you dont have any parameters to pass
    /// </summary>
    public string ExecuteScalar(String cmdText, CommandType cmdType, SqlParameter[] parameters)
    {
        try
        {
            string RetStr = "";
            string conString = dbconnectionstring;           
            using (SqlConnection con = new SqlConnection(conString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand(cmdText, con))
                {
                    cmd.CommandType = cmdType;
                    if (parameters != null)
                    {
                        foreach (SqlParameter parameter in parameters)
                        {
                            if (null != parameter) cmd.Parameters.Add(parameter);
                        }
                    }

                    object obj = cmd.ExecuteScalar();
                    if (obj != null) RetStr = obj.ToString();
                    return RetStr;
                }
            }
        }
        catch (Exception ex)
        {
            return "";
            throw ex;
        }
       
    }
    public int MailToSendSite(string tomail, string mailsubject, string frommail, string bodymail, string ccmail, string bccmail, string fromname)
    {

        try
        {
            bool adminflag = false;
            DataTable dt = new DataTable();
            string HostName = "", User = "", password = "", DBCCEmail = "", DBBCCEmail = "";
            dt = (new DAL()).GetDataTable("select * from siteprofile", CommandType.Text, null);
            if (dt != null && dt.Rows.Count > 0)
            {
                HostName = dt.Rows[0]["mshost"].ToString();
                User = dt.Rows[0]["msusername"].ToString();
                password = dt.Rows[0]["mspass"].ToString();
                DBCCEmail = dt.Rows[0]["contccemail"].ToString();
                DBBCCEmail = dt.Rows[0]["contbccemail"].ToString();
                if (tomail == "")
                {
                    adminflag = true;
                    tomail = dt.Rows[0]["contemail"].ToString();
                }
                if (frommail == "")
                    frommail = dt.Rows[0]["contemail"].ToString();
                if (fromname == "")
                    fromname = ConfigurationManager.AppSettings["SiteName"].ToString();
            }

            SmtpClient smtpClientC = new SmtpClient();
            MailMessage objMailC = new MailMessage();
            MailAddress objMailC_fromaddress = new MailAddress(frommail, fromname);


            objMailC.From = objMailC_fromaddress;
            if (tomail.IndexOf(";") > 0)
            {
                string[] toemailid = tomail.Split(';');
                for (int i = 0; i < toemailid.Length; i++)
                {
                    objMailC.To.Add(toemailid[i].ToString());
                }

            }
            else
                objMailC.To.Add(tomail);


            objMailC.IsBodyHtml = true;

            objMailC.Subject = mailsubject;

            objMailC.Body = bodymail;

            if (ccmail != null)
            {
                if (ccmail.IndexOf(";") > 0)
                {
                    string[] ccmailid = ccmail.Split(';');
                    for (int i = 0; i < ccmailid.Length; i++)
                    {
                        objMailC.CC.Add(ccmailid[i].ToString());
                    }

                }
                else
                    objMailC.CC.Add(ccmail);
            }
            else if (DBCCEmail != null && DBCCEmail != "" && adminflag == true)
                objMailC.CC.Add(DBCCEmail);

            if (bccmail != null)
            {
                if (bccmail.IndexOf(";") > 0)
                {
                    string[] bccmailid = bccmail.Split(';');
                    for (int i = 0; i < bccmailid.Length; i++)
                    {
                        objMailC.Bcc.Add(bccmailid[i].ToString());
                    }

                }
                else
                    objMailC.Bcc.Add(bccmail);
            }
            else if (DBBCCEmail != null && DBBCCEmail != "" && adminflag == true)
                objMailC.Bcc.Add(DBBCCEmail);


            smtpClientC.Host = HostName;
            smtpClientC.Credentials = new System.Net.NetworkCredential(User, password);
            smtpClientC.Send(objMailC);
            return 1;

        }
        catch (Exception ex)
        {

            return 0;

        }


    }
    public int MailToSendSiteattach(string tomail, string mailsubject, string frommail, string bodymail, string ccmail, string bccmail, string fromname, FileUpload FileName)
    {

        try
        {
            bool adminflag = false;
            DataTable dt = new DataTable();
            string HostName = "", User = "", password = "", DBCCEmail = "", DBBCCEmail = "";
            dt = (new DAL()).GetDataTable("select * from siteprofile", CommandType.Text, null);
            if (dt != null && dt.Rows.Count > 0)
            {
                HostName = dt.Rows[0]["mshost"].ToString();
                User = dt.Rows[0]["msusername"].ToString();
                password = dt.Rows[0]["mspass"].ToString();
                DBCCEmail = dt.Rows[0]["contccemail"].ToString();
                DBBCCEmail = dt.Rows[0]["contbccemail"].ToString();
                if (tomail == "")
                {
                    adminflag = true;
                    tomail = dt.Rows[0]["contemail"].ToString();
                }
                if (frommail == "")
                    frommail = dt.Rows[0]["contemail"].ToString();
                if (fromname == "")
                    fromname = ConfigurationManager.AppSettings["SiteName"].ToString();
            }
            SmtpClient smtpClientC = new SmtpClient();
            MailMessage objMailC = new MailMessage();
            MailAddress objMailC_fromaddress = new MailAddress(frommail);
            MailAddress objMailC_toaddress = new MailAddress(tomail);


            objMailC.From = objMailC_fromaddress;
            objMailC.To.Add(objMailC_toaddress);


            objMailC.IsBodyHtml = true;

            objMailC.Subject = mailsubject;

            objMailC.Body = bodymail;


            if (FileName.HasFile)
            {
                Attachment at = new Attachment(FileName.PostedFile.InputStream, FileName.FileName);
                objMailC.Attachments.Add(at);

            }
          
            if (ccmail != null)
            {
                objMailC.CC.Add(ccmail);
            }

            if (bccmail != null)
            {
                objMailC.Bcc.Add(bccmail);
            }


            smtpClientC.Host = HostName;
            smtpClientC.Credentials = new System.Net.NetworkCredential(User, password);
            smtpClientC.Send(objMailC);
            return 1;

        }
        catch (Exception ex)
        {

            return 0;
        }


    }


    #endregion

    #region Page Content 
    public DataTable getFullPageDetails(string pagename)
    {
        DataTable dt =(new DAL()).GetDataTable("Select * from insidepage where pagename='"+ pagename +"'", CommandType.Text, null);
        return dt;
    }

    public DataTable getFullPageDetails(int pageid)
    {
        DataTable dt = (new DAL()).GetDataTable("Select * from insidepage where id=" + pageid, CommandType.Text, null);
        return dt;
    }

    #endregion


    public string GetMailTemplates(string templatePath)
    {
        string mailTemplate = "";
        if (System.IO.File.Exists(GetRootPath() + templatePath))
        {
            mailTemplate = System.IO.File.ReadAllText(GetRootPath() + templatePath);
        }
        return mailTemplate;
    }

    public bool IsSQLInjection(string str)
    {
        if (str.Contains("'") == true || str.Contains(" ") == true || str.Contains("(") == true || str.Contains(")") == true || str.Contains("\"") == true || str.Contains("*") == true || str.Contains("$") == true || str.Contains("&") == true || str.Contains("-") == true || str.Contains(";") == true || str.Contains("[") == true || str.Contains("]") == true || str.Contains("}") == true || str.Contains("{") == true || str.Contains("<") == true || str.Contains(">") == true || str.Contains("=") == true)
            return true;
        else
            return false;
    }

    public static string GetCMSPath()
    {
        return ConfigurationManager.AppSettings["CMSPath"].ToString();
    }

    public static string GetPostBackControl(Page page)
    {
        Control control = null;

        string ctrlname = page.Request.Params.Get("__EVENTTARGET");
        if (ctrlname != null && ctrlname != string.Empty)
        {
            control = page.FindControl(ctrlname);
        }
        else
        {
            foreach (string ctl in page.Request.Form)
            {
                Control c = page.FindControl(ctl);
                if (c is System.Web.UI.WebControls.Button)
                {
                    control = c;
                    break;
                }
            }
        }
        return control.ID;
    }

    public static string GetRootPath()
    {
        string completePath = HttpContext.Current.Server.MapPath(HttpContext.Current.Request.ApplicationPath).Replace("/", "\\");
        string rootPath = completePath ;
        return rootPath;
    }

    public static string getIP()
    {
        string strHostName = "";
        strHostName = HttpContext.Current.Request.UserHostAddress;
        return strHostName;
    }

    public static bool ValidatePrice(string input)
    {
        int nnum = 0;
        foreach (char c in input)
        {

            if (c.ToString() != ".")
            {
                if (!Char.IsNumber(c))
                {
                    return false;
                    break;
                }
            }
            else
            {
                nnum = nnum + 1;
            }
        }

        if (nnum > 1)
        {
            return false;
        }
        else
        {

            return true;
        }
    }

    public static bool IsNumeric(string str)
    {
        if (str == null)
            return false;
        return (System.Text.RegularExpressions.Regex.IsMatch(str, @"^\d+$"));

    }

    public static bool isEmail(string inputEmail)
    {

        string strRegex = @"^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$";

        Regex reg = new Regex(strRegex);
        if (reg.IsMatch(inputEmail))
            return true;
        else
            return false;
    }

    public static DateTime CurrCountryTime()
    {
        return DateTime.UtcNow.AddHours(1);
    }

    public static string GetDateWithFormat(string onlydate = "")
    {
        if (onlydate == "")
            return DateTime.UtcNow.AddHours(5).AddMinutes(30).ToString("yyyy-MM-dd HH:mm:ss");
        else
            return DateTime.UtcNow.AddHours(5).AddMinutes(30).ToString("dd-MMM-yyyy");
    }

    public static void CreateCart()
    {
        DataTable Cart = new DataTable("Cart"); // Create a new DataTable titled 'airCart'
        DataColumn[] primaykey = new DataColumn[1];

        DataColumn idColumn = new DataColumn();
        idColumn.DataType = System.Type.GetType("System.Int32");
        idColumn.ColumnName = "loop";
        idColumn.AutoIncrement = true;
        idColumn.AutoIncrementSeed = 1;
        idColumn.Unique = true;
        Cart.Columns.Add(idColumn);
        primaykey[0] = idColumn;
        Cart.PrimaryKey = primaykey;

        Cart.Columns.Add("id", System.Type.GetType("System.Int32"));
        Cart.Columns.Add("code", System.Type.GetType("System.String"));
        Cart.Columns.Add("Name", System.Type.GetType("System.String"));
        Cart.Columns.Add("Image", System.Type.GetType("System.String"));
        Cart.Columns.Add("costprice", System.Type.GetType("System.Double"));
        Cart.Columns.Add("sellprice", System.Type.GetType("System.Double"));
        Cart.Columns.Add("perweek", System.Type.GetType("System.Double"));
        Cart.Columns.Add("amount", System.Type.GetType("System.Double"));
        Cart.Columns.Add("deal", System.Type.GetType("System.Int32"));
        HttpContext.Current.Session["Cart"] = Cart;
    }

    public static string RandomPassword()
    {
        string _allowedChars = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        Random randNum = new Random();
        char[] chars = new char[6];
        int allowedCharCount = _allowedChars.Length;

        for (int i = 0; i < 6; i++)
        {
            chars[i] = _allowedChars[(int)((_allowedChars.Length) * randNum.NextDouble())];
        }
        return new string(chars);
    }

    public static int Setimage(Literal ltrlCaptcha)
    {
        Random rn = new Random();
        int n1 = rn.Next(0, 9);
        if (n1 == null || n1 < 0 || n1 > 9)
            n1 = 1;

        int n2 = rn.Next(0, 9);
        if (n2 == null || n2 < 0 || n2 > 9)
            n2 = 1;

        int op = rn.Next(1, 2);
        string[] strOp = { "+", "-" };//, "X" };
        string curOp = strOp[op - 1];

        string optext = "";

        if (n1 > n2)
            optext = Convert.ToString(n1) + " " + curOp + " " + Convert.ToString(n2) + " = ";
        else
            optext = Convert.ToString(n2) + " " + curOp + " " + Convert.ToString(n1) + " = ";

        ltrlCaptcha.Text = optext;


        int intRes = 0;

        if (curOp == "+")
            intRes = n1 + n2;
        else if (curOp == "-")
            intRes = n1 - n2;
        else if (curOp == "X")
            intRes = n1 * n2;

        return intRes;
    }

    public static bool CheckCaptcha(int CapNum, string CapStr)
    {
        bool ReturnVal = false;

        int intEn = 0;
        if (int.TryParse(CapStr, out intEn))
        {
            if (CapNum == intEn)
                ReturnVal = true;
        }

        return ReturnVal;
    }

    public string compare(string id)
    {
       
        string msg = "";
        if (HttpContext.Current.Request.Cookies["ShopexCompare"] != null)
        {
            string[] comp = HttpContext.Current.Request.Cookies["ShopexCompare"].Value.Split(',');
            for (int i = 0; i < comp.Length; i++)
            {
                if (comp[i] != "" && comp[i] == id)
                {
                    msg = "Product already added to compare";
                    return msg;
                }
            }
            if (comp.Length < 5)
            {
                HttpContext.Current.Response.Cookies["ShopexCompare"].Value = HttpContext.Current.Request.Cookies["ShopexCompare"].Value + id + ",";
                HttpContext.Current.Response.Cookies["ShopexCompare"].Expires = DateTime.Now.AddHours(3);
            }
            else
            {
                msg = "Sorry you Can compare 4 products at a time";
                return msg;
            }
        }
        else
            HttpContext.Current.Response.Cookies["ShopexCompare"].Value = id + ",";

        return msg;
    }
    public bool comparedelete(string pid)
    {
        if (HttpContext.Current.Request.Cookies["ShopexCompare"] != null)
        {
            HttpContext.Current.Response.Cookies["ShopexCompare"].Value = HttpContext.Current.Request.Cookies["ShopexCompare"].Value.Replace(pid + ",", "");
            HttpContext.Current.Response.Cookies["ShopexCompare"].Expires = DateTime.Now.AddDays(1);
        }

        return true;
    }
    

   
    
}
public enum CampaignStatus : int
{
    Pending,
    Sent
}
