using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Poweradmin_Newsletter_manage_subscriber : System.Web.UI.Page
{
    string strQuery, msg;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack) fill_Group();
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
            #region check email
            string tot = new DAL().ExecuteScalar("select count(*) from newslettersubscriber where Email='" + tbx_Email.Text.Replace("'", "''") + "' and groupid=" + ddl_Group.SelectedValue.ToString(), CommandType.Text, null);
            if (tot != "0")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('This email already exists in " + ddl_Group.SelectedItem.ToString() + " group. please enter another email.');", true);
                return;
            }
            #endregion
            strQuery = "insert into NewsletterSubscriber(Visible,groupid,Name,Email,AddedDate,AddedIp) values('" + rbl_Visible.SelectedValue.ToString() + "','" + ddl_Group.SelectedValue.ToString() + "','" + tbx_Title.Text.Replace("'", "''") + "','" + tbx_Email.Text.Replace("'", "''") + "','" + DAL.GetDateWithFormat() + "','" + DAL.getIP() + "')";
            (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
            msg = "Subsciber details has been added successully.";

        }
        else
        {
            #region check email
            string tot = new DAL().ExecuteScalar("select count(*) from newslettersubscriber where Email='" + tbx_Email.Text.Replace("'", "''") + "' and groupid=" + ddl_Group.SelectedValue.ToString() + " and id<>" + Request.QueryString["id"].ToString(), CommandType.Text, null);
            if (tot != "0")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('This email already exists in " + ddl_Group.SelectedItem.ToString() + " group. please enter another email.');", true);
                return;
            }
            #endregion
            strQuery = "update NewsletterSubscriber set Visible='" + rbl_Visible.SelectedValue.ToString() + "',groupid='" + ddl_Group.SelectedValue.ToString() + "',Name='" + tbx_Title.Text.Replace("'", "''") + "',Email='" + tbx_Email.Text.Replace("'", "''") + "',ModifyDate='" + DAL.GetDateWithFormat() + "',ModifyIp='" + DAL.getIP() + "' where id=" + Request.QueryString["id"].ToString();
            (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
            msg = "Subscriber details has been modified successfully.";
        }
        Response.Redirect("viewsubscriber.aspx?msg=" + msg);
    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewsubscriber.aspx");
    }

    protected void fill_Data()
    {
        string strQuery = "select * from NewsletterSubscriber where id=" + Request.QueryString["id"].ToString();
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            rbl_Visible.SelectedValue = dt.Rows[0]["Visible"].ToString().Replace("True", "1").Replace("False", "0");
            ddl_Group.SelectedValue = dt.Rows[0]["groupid"].ToString();
            tbx_Title.Text = dt.Rows[0]["Name"].ToString();
            tbx_Email.Text = dt.Rows[0]["Email"].ToString();
        }
    }

    protected void fill_Group()
    {
        string strQuery = "select * from newslettergroup order by Title asc";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            ddl_Group.DataSource = dt;
            ddl_Group.DataTextField = "Title";
            ddl_Group.DataValueField = "id";
            ddl_Group.DataBind();
        }
        ddl_Group.Items.Insert(0, new ListItem("Select", ""));
    }
}