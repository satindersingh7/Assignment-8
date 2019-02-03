using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Poweradmin_Newsletter_manage_group : System.Web.UI.Page
{
    string strQuery, msg;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (DAL.IsNumeric(Request.QueryString["id"]) == true)
        {
            ltr_title.Text = "Edit";
            if (!this.IsPostBack)
                fill_Data();
        }

    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {

        if (!DAL.IsNumeric(Request.QueryString["id"]))
        {
            strQuery = "insert into NewsletterGroup(Title,AddedDate,AddedIp) values('" + tbx_Title.Text.Replace("'", "''") + "','" + DAL.GetDateWithFormat() + "','" + DAL.getIP() + "')";
            (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
            msg = "Group details has been added successully.";

        }
        else
        {
            strQuery = "update NewsletterGroup set Title='" + tbx_Title.Text.Replace("'", "''") + "',ModifyDate='" + DAL.GetDateWithFormat() + "',ModifyIp='" + DAL.getIP() + "' where id=" + Request.QueryString["id"].ToString();
            (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
            msg = "Group details has been modified successfully.";
        }
        Response.Redirect("viewgroup.aspx?msg=" + msg);
    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewgroup.aspx");
    }

    protected void fill_Data()
    {
        string strQuery = "select * from NewsletterGroup where id=" + Request.QueryString["id"].ToString();
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            tbx_Title.Text = dt.Rows[0]["Title"].ToString();
        }
    }
}