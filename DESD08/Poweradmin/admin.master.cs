using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["uid"] == null || Session["uid"].ToString() == "")
        {

            string pgUrl = Request.RawUrl;
            if (pgUrl != null)
                Response.Redirect(ConfigurationManager.AppSettings["CMSPath"].ToString() + "/default.aspx?page=" + pgUrl);
            else
                Response.Redirect(ConfigurationManager.AppSettings["CMSPath"].ToString());
        }

      //  if (!this.IsPostBack) ScriptManager.RegisterStartupScript(this, this.GetType(), "Reloaddt", "ReloadDate();", true);
    }
}
