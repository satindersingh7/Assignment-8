using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class includes_left_sidebar : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            fill_Hot();
            fill_teaser();
        }
    }
    protected void fill_teaser()
    {
        string strQuery = "select top 1 * from teaser where visible=1 and position=1 order by rand()";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            img.Src = "../webfiles/teaser/" + dt.Rows[0]["image"].ToString();
            link.HRef = dt.Rows[0]["url"].ToString();
            divSidebanner.Visible = true;
        }
        else
            divSidebanner.Visible = false;
      
    }
    protected void fill_Hot()
    {
        string strQuery = "select top 6* from deal where visible=1 and featured=1 and (select visible from productcategory where productcategory.id=catid)=1 order by id desc";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            repHot.DataSource = dt;
            repHot.DataBind();
            divHot.Visible = true;
            if (Request.ServerVariables["URL"].ToLower().IndexOf("deals-and-offers.aspx") > 0)
                divHot.Visible = false;
        }
        else
            divHot.Visible = false;
    }

    protected void btnsubscribe_Click(object sender, EventArgs e)
    {
        if ("0" == (new DAL()).ExecuteScalar("select count(*) from newslettersubscriber where groupid=1 and email like '%" + tbx_Subscriberemail.Text.Replace("'", "''").Trim() + "%'", CommandType.Text, null))
        {
            (new DAL()).ExecuteNonQuery("insert into newslettersubscriber (visible,groupid,Name,Email,AddedDate,AddedIp) values ('1','1','','" + tbx_Subscriberemail.Text.Replace("'", "''").Trim() + "','" + DAL.CurrCountryTime().ToString("yyyy-MM-dd") + "','" + DAL.getIP() + "')", CommandType.Text, null);
        }
        Response.Redirect("thank-you.aspx");
    }
}