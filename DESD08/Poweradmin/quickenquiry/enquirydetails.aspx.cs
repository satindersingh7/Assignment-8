using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Poweradmin_Enquiry_enquirydetails : System.Web.UI.Page
{
    string strQuery, msg;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (DAL.IsNumeric(Request.QueryString["id"]) == true)
        {
            new DAL().ExecuteScalar("update contactus set unread=0 where id=" + Convert.ToInt32(Request.QueryString["id"]), CommandType.Text, null);
            fill_Data();
        }
        else
            Response.Redirect("viewenquiry.aspx");

    }

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewenquiry.aspx");
    }

    protected void fill_Data()
    {
        string strQuery = "select * from contactus where id=" + Request.QueryString["id"].ToString();
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {

            ltr_Date.Text = DateTime.Parse(dt.Rows[0]["EDate"].ToString()).ToString("dd-MMM-yyyy");
            ltr_Name.Text = dt.Rows[0]["Name"].ToString();
            ltr_email.Text = dt.Rows[0]["Email"].ToString();
            ltr_Contact.Text = dt.Rows[0]["phone"].ToString();
            ltr_Subject.Text = dt.Rows[0]["subject"].ToString();
            ltr_Comment.Text = dt.Rows[0]["Message"].ToString();
        }
        else
            Response.Redirect("viewenquiry.aspx");
    }
}