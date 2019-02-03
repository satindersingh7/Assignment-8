using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Poweradmin_Newsletter_campaignDetail : System.Web.UI.Page
{
    string strQuery, msg;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!DAL.IsNumeric(Request.QueryString["id"]))
        {
            Response.Redirect("../dashboard.aspx");
        }
        if (!this.IsPostBack)
        {
            fill_CampaignDetails();
        }
    }

    protected void fill_CampaignDetails()
    {
        string strQuery = "select * from newslettercampaign where id=" + Request.QueryString["id"].ToString();
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            ltrFromEmail.Text = dt.Rows[0]["fromemail"].ToString();
            ltrSubject.Text = dt.Rows[0]["subject"].ToString();
            ltrBody.Text = dt.Rows[0]["body"].ToString();
            ltrTotalSubscriber.Text = dt.Rows[0]["subscribercnt"].ToString();
            if (dt.Rows[0]["status"].ToString() == "0")
                btn_Cancel.PostBackUrl = "view-pending-campaign.aspx";
            else
                btn_Cancel.PostBackUrl = "view-sent-campaign.aspx";
        }
    }


    
}