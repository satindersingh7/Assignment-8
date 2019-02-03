using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Poweradmin_PEnquiry_enquirydetails : System.Web.UI.Page
{
    string strQuery, msg;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {

            if (DAL.IsNumeric(Request.QueryString["id"]) == true)
            {
                new DAL().ExecuteScalar("update ordermaster set unread=0 where id=" + Convert.ToInt32(Request.QueryString["id"]), CommandType.Text, null);
                fill_Data();
            }
            else
                Response.Redirect("viewenquiry.aspx");
        }
    }

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewenquiry.aspx");
    }

    protected void fill_Data()
    {
        string strQuery = "select * from ordermaster where id=" + Request.QueryString["id"].ToString();
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {

            ltr_Date.Text = DateTime.Parse(dt.Rows[0]["orderDate"].ToString()).ToString("dd-MMM-yyyy");
            ltr_Name.Text = dt.Rows[0]["Name"].ToString();
            ltr_email.Text = dt.Rows[0]["Email"].ToString();
            ltr_Comment.Text = dt.Rows[0]["comments"].ToString();
            ltrSubject.Text = dt.Rows[0]["subject"].ToString();
            ltrNumber.Text = dt.Rows[0]["phone"].ToString();
            ddlstatus.SelectedValue = dt.Rows[0]["orderstatus"].ToString();
            if (ddlstatus.SelectedValue == "Completed" || ddlstatus.SelectedValue == "Cancelled")
                ddlstatus.Enabled = false;
            ltrtotal.Text = double.Parse(dt.Rows[0]["grandtotal"].ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN"));
            strQuery = "select * from orderitems where orderid=" + Request.QueryString["id"].ToString();
            DataTable dtmsds = new DAL().GetDataTable(strQuery, CommandType.Text, null);
            if (dtmsds != null && dtmsds.Rows.Count > 0)
            {
                divmsds.Visible = true;
                repproduct.DataSource = dtmsds;
                repproduct.DataBind();
            }
            else
                divmsds.Visible = false;
        
        }
        else
            Response.Redirect("viewenquiry.aspx");
    }
    protected string GetImage(string image)
    {
        string path = "";
        if (image == "")
        {
            path = "<img src='../../webfiles/img_not_available.png' style='height: 100px !Important; width: 200px' class='img-responsive' />";
        }
        else
        {
            path = "<img src='../../webfiles/product/medium/" + image + "' class='img-responsive' style='width:100px' />";
        }
        return path;
    }
    protected void ddlstatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        strQuery = "update ordermaster set orderstatus='"+ddlstatus.SelectedValue.ToString()+"' where id="+Request.QueryString["id"].ToString();
        new DAL().ExecuteNonQuery(strQuery, CommandType.Text, null);
        Response.Redirect("viewenquiry.aspx?msg=Product Enquiry Status changed successfully");
        Response.Write(strQuery);
    }
}