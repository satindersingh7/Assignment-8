using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class includes_header : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            fill_category();
            string title = new DAL().ExecuteScalar("select title from termsandconfition where active=1", CommandType.Text, null);
            string pdf = new DAL().ExecuteScalar("select filename from termsandconfition where active=1", CommandType.Text, null);
            if (pdf != "") ltrdownload.Text = "<i class='fa fa-download icon' aria-hidden='true'></i>&nbsp;<a target='_blank' href='" + ConfigurationManager.AppSettings["siteurl"].ToString() + "/webfiles/TNC/" + pdf + "'><span class='top border-top'>Download PDF " + title + "</span></a>";
        }
    }
    protected void fill_category()
    {
        string strQuery = "select * from productcategory where visible=1  order by sortorder ";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            
            repCategory.DataSource = dt;
            repCategory.DataBind();

            repmbmenu.DataSource = dt;
            repmbmenu.DataBind();

            ddl_Category.DataSource = dt;
            ddl_Category.DataTextField = "Title";
            ddl_Category.DataValueField = "id";
            ddl_Category.DataBind();
        }
        ddl_Category.Items.Insert(0, new ListItem("ALL Categories", "0"));
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (ddl_Category.Visible == true)
            Response.Redirect("product-listing.aspx?key=" + Server.UrlEncode(txtsearch.Text) + "&catid=" + ddl_Category.SelectedValue.ToString());
        else
            Response.Redirect("product-listing.aspx?key=" + Server.UrlEncode(txtsearch.Text) + "&catid=0");


    }
}