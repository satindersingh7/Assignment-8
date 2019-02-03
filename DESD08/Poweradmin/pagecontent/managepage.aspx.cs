using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Poweradmin_pagecontent_managepage : System.Web.UI.Page
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
            #region//verifying the existence of the same page name
            strQuery = "select count(*) from InsidePage where lcase(PageName)='" + Tbx_cname.Text.ToString().ToLower().Replace("'", "''") + "'";
            string max = new DAL().ExecuteScalar(strQuery, CommandType.Text, null);
            if (max != "" && max != "0")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('The page name: " + Tbx_cname.Text + " is already exist. Please enter the different page name');", true);
                return;
            }
            #endregion

            #region//saving record in db

            try //this portion will try to execute the process
            {
                int sortorder = 1;
                string maxnum = (new DAL()).ExecuteScalar("Select max(sortorder) as dnumber from InsidePage", CommandType.Text, null); // this query will fetch the maximum display order number from db
                if (maxnum != null && maxnum != "")
                    sortorder = int.Parse(maxnum.ToString()) + 1;

                strQuery = "Insert into InsidePage (PageName,sortorder) values ('" + Tbx_cname.Text.Replace("'", "''") + "','" + sortorder + "')";
                (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
                msg = "The page record has been successfully added.";
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Error: " + ex.Message + "');", true);
            }
            #endregion
        }
        else
        {
            #region//verifying the existence of the same page name
            strQuery = "select count(*) from InsidePage where id<>" + Request.QueryString["id"].ToString() + " and lcase(PageName)='" + Tbx_cname.Text.ToString().ToLower().Replace("'", "''") + "'";
            string max = new DAL().ExecuteScalar(strQuery, CommandType.Text, null);
            if (max != "0")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('The page name: " + Tbx_cname.Text + " is already exist. Please enter the different page name');", true);
                return;
            }
            #endregion

            strQuery = "update InsidePage set PageName='" + Tbx_cname.Text.Replace("'", "''") + "' where id=" + Request.QueryString["id"].ToString();
            (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
            msg = "Page details has been modified successfully.";
        }

        Response.Redirect("viewpage.aspx?msg=" + msg);
    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewpage.aspx");
    }

    protected void fill_Data()
    {
        string strQuery = "select * from InsidePage where id=" + Request.QueryString["id"].ToString();
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            Tbx_cname.Text = dt.Rows[0]["PageName"].ToString();
        }
    }
}