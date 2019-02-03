using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class includes_footer : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            fill_partner();
            string aboutus = new DAL().ExecuteScalar("Select PageDesc from insidepage where pagename='About us'", CommandType.Text, null);
            if (aboutus.Length > 325)
                aboutus = aboutus.Substring(0, 325) + "...";
            ltrAbout.Text = StripHTML(aboutus);
            string title = new DAL().ExecuteScalar("select title from termsandconfition where active=1", CommandType.Text, null);
            string pdf = new DAL().ExecuteScalar("select filename from termsandconfition where active=1", CommandType.Text, null);
            if(pdf!="") ltrdownload.Text = "<a target='_blank' href='" + ConfigurationManager.AppSettings["siteurl"].ToString() + "webfiles/TNC/" + pdf + "'  class='btn btn-default'><i class='fa fa-file-pdf-o pdf-right'></i>PDF " + title + "</a>";
        }
    }
    public static string StripHTML(string input)
    {
        return Regex.Replace(input, "<.*?>", String.Empty);
    }
    protected void fill_partner()
    {
        string strQuery = "select * from partner where visible=1 order by sortorder ";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            reppartner.DataSource = dt;
            reppartner.DataBind();
            divPartner.Visible = true;
        }
        else
            divPartner.Visible = false;
    }
}