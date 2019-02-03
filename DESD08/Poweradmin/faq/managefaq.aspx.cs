using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Drawing;

public partial class Poweradmin_faq_managefaq : System.Web.UI.Page
{
    string strQuery, msg, filename = "";
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
            int sortorder = 1;
            #region ManageSortOrder

            string maxnum = (new DAL()).ExecuteScalar("Select max(sortorder) from FAQ", CommandType.Text, null); // this query will fetch the maximum display order number from db
            if (maxnum != null && maxnum != "")
                sortorder = int.Parse(maxnum.ToString()) + 1;
            #endregion
            strQuery = "insert into faq(Visible,question,answer,sortorder,AddedDate,AddedIp) values('" + rbl_Visible.SelectedValue.ToString() + "','" + tbxQues.Text.Replace("'", "''") + "','" + Editor1.Text.Replace("'", "''") + "','" + sortorder + "','" + DAL.GetDateWithFormat() + "','" + DAL.getIP() + "')";
            (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
            msg = "FAQ details has been added successully.";

        }
        else
        {
            strQuery = "update FAQ set Visible='" + rbl_Visible.SelectedValue.ToString() + "',question='" + tbxQues.Text.Replace("'", "''") + "', answer='" + Editor1.Text.Replace("'", "''") + "',ModifyDate='" + DAL.GetDateWithFormat() + "',ModifyIp='" + DAL.getIP() + "' where id=" + Request.QueryString["id"].ToString();
            (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
            msg = "FAQ details has been modified successfully.";
           
        }
        Response.Redirect("viewfaq.aspx?msg=" + msg);
    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewfaq.aspx");
    }

    protected void fill_Data()
    {
        string strQuery = "select * from faq where id=" + Request.QueryString["id"].ToString();
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
           
            rbl_Visible.SelectedValue = dt.Rows[0]["Visible"].ToString().Replace("True", "1").Replace("False", "0");           
            tbxQues.Text = dt.Rows[0]["question"].ToString();
            Editor1.Text = dt.Rows[0]["answer"].ToString();
        }
    }
}