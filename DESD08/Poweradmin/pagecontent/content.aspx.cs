using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;

public partial class Poweradmin_pagecontent_content : System.Web.UI.Page
{
    string strQuery, msg;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Page"] == null || Request.QueryString["Page"].ToString() == "")
            Response.Redirect("pagelisting.aspx?msg=Page name require for update the content");
        if (Request.QueryString["Page"].ToString() == "donate-now")
        {
            //txt_Meta.Visible = false;
            //txt_Title.Visible = false;
            rfv1.Visible = false;            
        }
        ltr_title.Text = "Manage " + Server.UrlDecode(Request.QueryString["Page"].ToString());

        if (!this.IsPostBack)
            fill_Data();

    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {

        strQuery = "update InsidePage set PageIETitle='" + txt_Title.Text.Replace("'", "''") + "',Meta='" + txt_Meta.Text.Replace("'", "''") + "',PageDesc='" + Editor1.Text.Replace("'", "''") + "',ModifyDate='" + DAL.GetDateWithFormat() + "',ModifyIp='" + DAL.getIP() + "' where PageName='" + Server.UrlDecode(Request.QueryString["Page"].ToString().Replace("'", "''")) + "'";
        (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
        msg = "Page details has been modified successfully.";

        Response.Redirect("pagelisting.aspx?msg=" + msg);
    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("pagelisting.aspx");
    }

    protected void fill_Data()
    {
        string strQuery = "select * from insidepage where PageName='" + Server.UrlDecode(Request.QueryString["Page"].ToString()).Replace("'", "''") + "'";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {


            txt_Title.Text = dt.Rows[0]["PageIETitle"].ToString();
            txt_Meta.Text = dt.Rows[0]["Meta"].ToString();
            Editor1.Text = dt.Rows[0]["PageDesc"].ToString();
            if (txt_Title.Text == "") txt_Title.Text = ConfigurationManager.AppSettings["PageTitle"].ToString();
        }
        else
            Response.Redirect("pagelisting.aspx");
    }
}