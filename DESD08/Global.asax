<%@ Application Language="C#" %>

<script RunAt="server">

    void Application_Start(object sender, EventArgs e)
    {
        //Application["NoOfVisitors"] = 0;
        //Application["NoOfBookings"] = 0;
        // Code that runs on application startup
        Scheduler.Run("DSED08", 1, RunScheduledTasks);
        
    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }

    void Application_Error(object sender, EventArgs e)
    {
        HttpUnhandledException httpUnhandledException = new HttpUnhandledException(Server.GetLastError().Message, Server.GetLastError());

        Application["Exception"] = HttpContext.Current.Server.GetLastError();
        Application["actualerrorpage"] = httpUnhandledException.GetHtmlErrorMessage();

        Application["errortime"] = DateTime.Now.ToLocalTime().ToString();
        Application["errorurl"] = Request.Url.AbsoluteUri.ToString();
        Application["browser"] = Request.Browser.Browser.ToString() + " ( " + Request.Browser.Type.ToString() + " )";
        Application["clientip"] = Request.UserHostAddress.ToString();
        if (Request.UrlReferrer != null)
        {
            Application["referurl"] = Request.UrlReferrer.AbsoluteUri.ToString();
        }
        else
        {
            Application["referurl"] = "None";
        }
    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started
        //Scheduler.Run("DRAmin", 1, RunScheduledTasks);
        //Application.Lock();
        //Application["NoOfVisitors"] = (int)Application["NoOfVisitors"] + 1;
        //Application.UnLock();
    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
    

    public void RunScheduledTasks()
    {

        try
        {
            string msg;
            string query = "select *,(select fromemail from newslettercampaign where id=campaignId) as fromemail,(select subject from newslettercampaign where id=campaignId) as subject,(select body from newslettercampaign where id=campaignId) as body from newslettersendhistory order by id asc ";
            System.Data.DataTable dt = new System.Data.DataTable();
            dt = new DAL().GetDataTable(query.ToString(), System.Data.CommandType.Text, null);
            if (dt.Rows.Count > 0)
            {
                try
                {
                    if (dt.Rows[0]["fromemail"].ToString() != null && dt.Rows[0]["fromemail"].ToString().Trim() != "")
                    {
                        string StrMailBody = dt.Rows[0]["body"].ToString().Replace("&#39;", "'");
                        StrMailBody = StrMailBody.Replace("_Customer_Name_", dt.Rows[0]["ToName"].ToString().Replace("&#39;", "'"));
                        StrMailBody = StrMailBody.Replace("/webfiles/image/", System.Configuration.ConfigurationManager.AppSettings["siteurl"].ToString() + "webfiles/image/");
                        StrMailBody = StrMailBody.Replace("#Unsubscribe_Link#", System.Configuration.ConfigurationManager.AppSettings["siteurl"].ToString() + "subscriber.aspx?email=" + dt.Rows[0]["toMail"].ToString());
                        StrMailBody = StrMailBody.Replace("#Unsubscribe#", "Click Here To Unsubscribe Our Newsletter");

                        (new DAL()).MailToSendSite(dt.Rows[0]["toMail"].ToString(), dt.Rows[0]["subject"].ToString(), dt.Rows[0]["fromemail"].ToString(), StrMailBody, null, null, "");
                    }
                    (new DAL()).ExecuteNonQuery("delete from newslettersendhistory where id=" + dt.Rows[0]["id"].ToString(), System.Data.CommandType.Text, null);

                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
</script>
