using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Poweradmin_order_viewOrde : System.Web.UI.Page
{
    int findex, lindex;
    public static int pageindex = 0, Pagesize = 25;
    string strQuery, TableName = "ordermaster", MessageNm = "Order";
    PagedDataSource pgsource = new PagedDataSource();

    protected void Page_Load(object sender, EventArgs e)
    {
        this.Form.DefaultButton = lbSearch.UniqueID;
        if (!this.IsPostBack)
        {
            fill_Data();
            fill_Status();
            if (Request.QueryString["msg"] != null && Request.QueryString["msg"].ToString() != "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('" + Request.QueryString["msg"].ToString() + "');", true);
            }
        }
    }

    private void fill_Status()
    {
        strQuery = @"select * from status";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            ddlStatus.DataSource = dt;
            ddlStatus.DataTextField = "status";
            ddlStatus.DataValueField = "id";
            ddlStatus.DataBind();
        }
        ddlStatus.Items.Insert(0, new ListItem("Select Status", ""));
    }

    #region Change This Part Only

    protected void fill_Data()
    {

        strQuery = "select t.id,t.orderid,t.sname,t.finalamount,t.status,t.statustime, s.status as statusname,t.orderdate from " + TableName + " t LEFT JOIN status s on t.status=s.id  where t.id<>0";
        if (tbx_Search.Text != "") strQuery += " and (t.orderid like '%" + tbx_Search.Text.Replace("'", "''") + "%' or t.sname like '%" + tbx_Search.Text.Replace("'", "''") + "%')";
        if (ddlStatus.SelectedValue.ToString() != "") strQuery += " and t.status = " + ddlStatus.SelectedValue.ToString() + "";
        if (tbx_FromDate.Text != "" && tbx_ToDate.Text == "")
            strQuery += " and date(t.orderdate)='" + DateTime.Parse(tbx_FromDate.Text.Replace("'", "''")).ToString("yyyy-MM-dd") + "' ";
        else if (tbx_ToDate.Text != "" && tbx_FromDate.Text == "")
            strQuery += " and date(t.orderdate)='" + DateTime.Parse(tbx_ToDate.Text.Replace("'", "''")).ToString("yyyy-MM-dd") + "' ";
        else if (tbx_ToDate.Text != "" && tbx_FromDate.Text != "" && tbx_FromDate.Text == tbx_ToDate.Text)
            strQuery += " and date(t.orderdate)='" + DateTime.Parse(tbx_ToDate.Text.Replace("'", "''")).ToString("yyyy-MM-dd") + "' ";
        else if (tbx_ToDate.Text != "" && tbx_FromDate.Text != "")
            strQuery += " and date(t.orderdate)>='" + DateTime.Parse(tbx_FromDate.Text.Replace("'", "''")).ToString("yyyy-MM-dd") + "' and date(t.orderdate)<='" + DateTime.Parse(tbx_ToDate.Text.Replace("'", "''")).ToString("yyyy-MM-dd") + "' ";
        strQuery += " group by t.id,t.orderid,t.sname,t.finalamount,t.status,t.statustime,s.status,t.orderdate";
        strQuery += " order by t.id desc OFFSET 0 Rows Fetch Next " + Pagesize + " Rows Only  ";


        strQuery += strQuery.Replace("t.id,t.orderid,t.sname,t.finalamount,t.status,t.statustime, s.status as statusname", "count(t.id) as count");

        #region Bind Data
        DataSet ds = new DAL().GetDataSet(strQuery, CommandType.Text, null);
        DataTable dt = ds.Tables[0];
        DataTable dtpage = ds.Tables[1];

        if (dt != null && dt.Rows.Count > 0)
        {
            double totalrecords = Convert.ToDouble(dtpage.Rows[0]["count"] + "");
            double totalpages = Math.Ceiling(totalrecords / Pagesize);
            ltr_Total.Text = totalrecords.ToString();
            ViewState["totpage"] = totalpages;

            lnkPrevious.Enabled = lnkPrevious.Enabled = !(CurrentPage == 0);
            lnkNext.Enabled = lnkNext.Enabled = ((CurrentPage + 1) < totalpages);
            rep.DataSource = dt;
            rep.DataBind();
            tbx_PageNumber.Text = (CurrentPage + 1).ToString();
            ltr_Start.Text = ((CurrentPage * Pagesize) + 1).ToString();
            if ((CurrentPage + 1) != totalpages)
            {
                ltr_End.Text = ((CurrentPage + 1) * Pagesize).ToString();
            }
            else
            {
                ltr_End.Text = totalrecords.ToString();
            }
            if (totalrecords > Pagesize)
            {
                div_Paging.Visible = true;
            }
            else
            {
                div_Paging.Visible = false;
            }

            pnl_Record.Visible = true;
            div_msg.Visible = false;
        }
        else
        {


            pnl_Record.Visible = false;
            div_msg.Visible = true;
            ltr_msg.Text = MessageNm + " record does not exists.";
        }
        #endregion
    }


    protected void Hide_Show(int status)
    {
        #region//this block will set visibility status to show for the selected grid view records
        string VisId = "0";
        foreach (RepeaterItem Ri in rep.Items)
        {
            CheckBox CkbSelect = (CheckBox)Ri.FindControl("checkboxDelete");//this will find the check box control 'checkboxDelete'
            HiddenField hfNewsId = (HiddenField)Ri.FindControl("hfNewsId");//this will find the hidden control 'hfNewsId'
            if (CkbSelect != null && hfNewsId != null && CkbSelect.Checked == true && hfNewsId.Value != "")
                VisId += "," + hfNewsId.Value.Trim();
        }

        if (VisId == "0")
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please select atleast one record.');", true);
            return;
        }

        #region //Hidden
        string strQuery = "update " + TableName + " set active=" + status + " where id in (" + VisId + ")";
        new DAL().ExecuteNonQuery(strQuery, CommandType.Text, null);

        if (status == 0)
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('Selected " + MessageNm + " record has been successfully set to hidden.');", true);
        else
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('Selected " + MessageNm + " record has been successfully set to visible.');", true);

        #endregion

        #endregion
    }

    protected bool Delete_Data(string id)
    {
        try
        {

            #region Delete Attributes
            strQuery = "DELETE FROM orderitems WHERE orderid=" + id;
            new DAL().ExecuteNonQuery(strQuery, CommandType.Text, null);

            strQuery = "Delete from " + TableName + " where id = " + id + "";
            new DAL().ExecuteNonQuery(strQuery, CommandType.Text, null);

            #endregion
            return true;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            strQuery = "";
        }
    }

    protected void lbSearch_Click(object sender, EventArgs e)
    {
        CurrentPage = 0;
        fill_Data();
    }
    protected void lbReset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.RawUrl);
    }

    #endregion

    #region do not change

    protected void rep_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        #region//this block will fill the disply order drop down

        if (e.Item.ItemType.ToString().ToLower() == "item" || e.Item.ItemType.ToString().ToLower() == "alternatingitem")
        {

            DropDownList ddl = (DropDownList)e.Item.FindControl("ddlDisplayOrder");
            HiddenField hdnProId = (HiddenField)e.Item.FindControl("hfNewsId");
        }
        #endregion
    }


    protected void rep_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName.ToString() == "Delete")
        {
            if (!Delete_Data(e.CommandArgument.ToString()))
                return;

            fill_Data();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('" + MessageNm + " Record has been successfully deleted.');", true);
        }
    }

    protected void lb_Action_Click(object sender, EventArgs e)
    {
        string cmd = ((Button)sender).CommandName.ToString();
        if (cmd == "visible")
            this.Hide_Show(1);
        else if (cmd == "hide")
            this.Hide_Show(0);
        else if (cmd == "delete")
            this.Deleted_Selected();

        fill_Data();
    }

    protected void tbx_Search_TextChanged(object sender, EventArgs e)
    {
        CurrentPage = 0;
        fill_Data();
    }

    protected void Deleted_Selected()
    {
        #region//this block will delete the selected grid view records
        bool flag = false;
        foreach (RepeaterItem Ri in rep.Items)
        {
            CheckBox CkbSelect = (CheckBox)Ri.FindControl("checkboxDelete");//this will find the check box control 'checkboxDelete'
            HiddenField hfNewsId = (HiddenField)Ri.FindControl("hfNewsId");//this will find the hidden control 'hfNewsId'
            //this will find the hidden control 'hfNewsId'
            if (CkbSelect != null && hfNewsId != null && CkbSelect.Checked == true && hfNewsId.Value != "")
            {
                flag = true;
                if (!Delete_Data(hfNewsId.Value))
                    return;
            }
        }

        if (flag)
        {
            fill_Data();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('Selected " + MessageNm + "record has been successfully deleted.');", true);
        }
        else
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please select atleast one record.');", true);

        #endregion
    }

    #region Pagination

    private int CurrentPage
    {
        get
        {   //Check view state is null if null then return current index value as "0" else return specific page viewstate value
            if (ViewState["CurrentPage"] == null)
            {
                return 0;
            }
            else
            {
                return ((int)ViewState["CurrentPage"]);
            }
        }
        set
        {
            //Set View statevalue when page is changed through Paging "RepeaterPaging" DataList
            ViewState["CurrentPage"] = value;
        }
    }



    protected void lnkPrevious_Click(object sender, EventArgs e)
    {
        //If user click Previous Link button assign current index as -1 it reduce existing page index.
        CurrentPage -= 1;
        //refresh "Repeater1" Data
        fill_Data();
    }

    protected void lnkNext_Click(object sender, EventArgs e)
    {
        //If user click Next Link button assign current index as +1 it add one value to existing page index.
        CurrentPage += 1;

        //refresh "Repeater1" Data
        fill_Data();
    }

    protected void tbx_PageNumber_TextChanged(object sender, EventArgs e)
    {
        if (int.Parse(tbx_PageNumber.Text) > 0 && int.Parse(tbx_PageNumber.Text) <= int.Parse(ViewState["totpage"].ToString()))
            CurrentPage = int.Parse(tbx_PageNumber.Text) - 1;

        fill_Data();
    }

    protected void ddl_Rows_SelectedIndexChanged(object sender, EventArgs e)
    {
        CurrentPage = 0;
        Pagesize = int.Parse(ddl_Rows.SelectedValue.ToString());
        this.fill_Data();
    }
    #endregion

    #endregion

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        lbReset.Visible = true;
        CurrentPage = 0;
        fill_Data();
    }


    protected void ddl_Category_SelectedIndexChanged(object sender, EventArgs e)
    {
        CurrentPage = 0;
        fill_Data();
    }
}