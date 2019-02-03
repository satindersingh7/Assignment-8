using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Poweradmin_Newsletter_manage_campaign : System.Web.UI.Page
{
    string strQuery, msg;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {

            if (DAL.IsNumeric(Request.QueryString["id"]) == true)
            {
                ddl_Template.SelectedValue = "3";
            }
            DivAddCampaign.Visible = true;
            DivStartCampaign.Visible = false;
            fill_Template();
            fill_Group();
        }
    }
    protected void fill_voucher()
    {
        string strQuery = "select * from Voucher where id=" + Request.QueryString["id"].ToString();
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {

        }
    }
    private void fill_Group()
    {
        string strQuery = "select * from newslettergroup where id in (select distinct groupid from newslettersubscriber) order by Title asc";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            ddlGroup.DataSource = dt;
            ddlGroup.DataTextField = "Title";
            ddlGroup.DataValueField = "id";
            ddlGroup.DataBind();
        }
        ddlGroup.Items.Insert(0, new ListItem("Select", ""));
    }

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("view-pending-campaign.aspx");
    }

    protected void fill_Template()
    {
        string strQuery = "select * from newslettertemplate order by Title asc";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            ddl_Template.DataSource = dt;
            ddl_Template.DataTextField = "Title";
            ddl_Template.DataValueField = "id";
            ddl_Template.DataBind();
        }
        ddl_Template.Items.Insert(0, new ListItem("Select", ""));
        string desc = "";
        if (Request.QueryString["id"] != null && Request.QueryString["id"].ToString() != "")
        {
            strQuery = "select * from Voucher where id=" + Request.QueryString["id"].ToString();
            DataTable dt1 = new DAL().GetDataTable(strQuery, CommandType.Text, null);
            if (dt1 != null && dt.Rows.Count > 0)
            {
                desc = new DAL().ExecuteScalar("select Description from newslettertemplate where id=" + ddl_Template.SelectedValue.ToString(), CommandType.Text, null);
                Editor1.Text = desc.Replace("_CouponCode", dt1.Rows[0]["code"].ToString()).Replace("_CouponTitle", dt1.Rows[0]["Title"].ToString()).Replace("_CouponCode", dt1.Rows[0]["code"].ToString()).Replace("_Discount", dt1.Rows[0]["amttype"].ToString() == "valuebased" ? "Rs. " + double.Parse(dt1.Rows[0]["amount"].ToString()) : dt1.Rows[0]["amount"].ToString() + "%").Replace("_MINSAMT", "Rs." + dt1.Rows[0]["shopamount"].ToString()).Replace("_VTILL", DateTime.Parse(dt1.Rows[0]["ExpiryDate"].ToString()).ToString("dd-MMM-yyyy"));
            }
        }
    }

    protected void ddl_Template_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddl_Template.SelectedValue.ToString() == "")
            Editor1.Text = "";
        else
        {
            string desc = "";
            if (Request.QueryString["id"] != null && Request.QueryString["id"].ToString() != "")
            {
                string strQuery = "select * from Voucher where id=" + Request.QueryString["id"].ToString();
                DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
                if (dt != null && dt.Rows.Count > 0)
                {
                    desc = new DAL().ExecuteScalar("select Description from newslettertemplate where id=" + ddl_Template.SelectedValue.ToString(), CommandType.Text, null);
                    Editor1.Text = desc.Replace("_CouponCode", dt.Rows[0]["code"].ToString()).Replace("_CouponTitle", dt.Rows[0]["Title"].ToString()).Replace("_CouponCode", dt.Rows[0]["code"].ToString()).Replace("_Discount", dt.Rows[0]["amttype"].ToString() == "valuebased" ? "Rs. " + double.Parse(dt.Rows[0]["amount"].ToString()) : dt.Rows[0]["amount"].ToString() + "%").Replace("_MINSAMT", "Rs." + dt.Rows[0]["shopamount"].ToString()).Replace("_VTILL", DateTime.Parse(dt.Rows[0]["ExpiryDate"].ToString()).ToString("dd-MMM-yyyy"));
                }
            }
            else
                Editor1.Text = new DAL().ExecuteScalar("select Description from newslettertemplate where id=" + ddl_Template.SelectedValue.ToString(), CommandType.Text, null);
        }

    }

    protected void btn_Next_Click(object sender, EventArgs e)
    {
        DivAddCampaign.Visible = false;
        DivStartCampaign.Visible = true;

        ltrFromEmail.Text = tbx_Email.Text;
        ltrSubject.Text = tbx_Subject.Text;
        ltrBody.Text = Editor1.Text;

        ltrTotalSubscriber.Text = new DAL().ExecuteScalar("select count(id) from newslettersubscriber where groupid=" + ddlGroup.SelectedValue + " and visible=1", CommandType.Text, null);
        btn_Next.Visible = false;
        btn_Send.Visible = true;
    }

    protected void btn_Send_Click(object sender, EventArgs e)
    {
        string strQuery = "insert into newslettercampaign(fromEmail,subject,body,status,subscriberCnt,AddedDate,AddedIp) values('" + tbx_Email.Text.Replace("'", "''") + "','" + tbx_Subject.Text.Replace("'", "''") + "','" + Editor1.Text.Replace("'", "''") + "'," + (int)CampaignStatus.Pending + "," + ltrTotalSubscriber.Text + ",'" + DAL.GetDateWithFormat() + "','" + DAL.getIP() + "')";
        (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
        strQuery = "select max(id) from newslettercampaign";
        string campaignid = (new DAL()).ExecuteScalar(strQuery, CommandType.Text, null);

        DataTable dt = new DataTable();
        dt = new DAL().GetDataTable("select * from newslettersubscriber where groupid=" + ddlGroup.SelectedValue + " and visible=1", CommandType.Text, null);
        foreach (DataRow dr in dt.Rows)
        {
            string Query = "insert into newslettersendhistory(CampaignId,ToMail, ToName) values(" + campaignid + ",'" + dr["email"].ToString().Replace("'", "''") + "','" + dr["name"].ToString().Replace("'", "''") + "');";
            (new DAL()).ExecuteNonQuery(Query, CommandType.Text, null);
        }



        Response.Redirect("view-pending-campaign.aspx?msg=Campaign has been started successfully.");
    }

}