using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Poweradmin_Newsletter_viewsubscriber : System.Web.UI.Page
{
    int findex, lindex;
    public static int pageindex = 0, Pagesize = 25;
    string strQuery, TableName = "newslettersubscriber", MessageNm = "Subscriber";
    PagedDataSource pgsource = new PagedDataSource();

    protected void Page_Load(object sender, EventArgs e)
    {
        this.Form.DefaultButton = lbSearch.UniqueID;
        if (!this.IsPostBack)
        {
            ViewState["SortName"] = ViewState["SortGroup"] = ViewState["SortEmail"] = "";
            fill_Data();
           
            if (Request.QueryString["msg"] != null && Request.QueryString["msg"].ToString() != "")
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('" + Request.QueryString["msg"].ToString() + "');", true);
        }
    }

    #region Change This Part Only

    protected void fill_Data()
    {
        string strQuery = "select *,(select Title from newslettergroup where newslettergroup.id=" + TableName + ".groupid) as groupnm from " + TableName + " where id<>0";
        if (tbx_Search.Text != "") strQuery += " and Name like '%" + tbx_Search.Text.Replace("'", "''") + "%'";
       if(tbx_SearchEmail.Text!="") strQuery+=" and Email like '%" + tbx_SearchEmail.Text.Replace("'", "''") + "%'";
       if (ddl_Group.Text != "") strQuery += " and groupid='%" + ddl_Group.Text + "%'";
       if (ddl_Subscribe.SelectedValue.ToString() != "") strQuery += " and visible=" + ddl_Subscribe.SelectedValue.ToString();
       if (ViewState["SortName"] != null && ViewState["SortName"] != "") strQuery += " order by Name " + ViewState["SortName"];
       if (ViewState["SortGroup"] != null && ViewState["SortGroup"] != "") strQuery += " order by groupnm " + ViewState["SortGroup"];
       if (ViewState["SortEmail"] != null && ViewState["SortEmail"] != "") strQuery += " order by Email " + ViewState["SortEmail"];
       if (ViewState["SortName"] == "" && ViewState["SortEmail"] == "" && ViewState["SortGroup"] == "") strQuery += " order by id desc";
      
        #region Bind Data
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            ltr_Total.Text = dt.Rows.Count.ToString();
            pgsource.DataSource = dt.DefaultView;
            pgsource.AllowPaging = true;
            pgsource.PageSize = Pagesize;
            pgsource.CurrentPageIndex = CurrentPage;
            ViewState["totpage"] = pgsource.PageCount;
            lnkPrevious.Enabled = !pgsource.IsFirstPage;
            lnkNext.Enabled = !pgsource.IsLastPage;
            rep.DataSource = pgsource;
            rep.DataBind();

            ltr_Start.Text = ((CurrentPage * Pagesize) + 1).ToString();
            ltr_End.Text = ((CurrentPage + 1) * Pagesize).ToString();
            if (((CurrentPage + 1) * Pagesize) > dt.Rows.Count)
                ltr_End.Text = dt.Rows.Count.ToString();

            if (dt.Rows.Count > Pagesize)
            {
                div_Paging.Visible = true;
               
            }
            else
                div_Paging.Visible = false;

            pnl_Record.Visible = rep.Visible = true;
            div_msg.Visible = false;
           
        }
        else
        {
           
                div_Paging.Visible = rep.Visible = false;
                div_msg.Visible = true;
                ltr_msg.Text = MessageNm + " record does not exists.";
           
        }
        #endregion
    }
    protected void lb_name_Click(object sender, EventArgs e)
    {

        lb_Email.CssClass = lb_Group.CssClass="sort";
        ViewState["SortGroup"] = ViewState["SortEmail"] = "";
        if (ViewState["SortName"].ToString() == "")
        {
            lb_name.CssClass = "sort Asc";
            ViewState["SortName"] = "Asc";


        }
        else if (ViewState["SortName"].ToString() == "Asc")
        {
            lb_name.CssClass = "sort Desc";
            ViewState["SortName"] = "Desc";
        }
        else if (ViewState["SortName"].ToString() == "Desc")
        {
            lb_name.CssClass = "sort Asc";
            ViewState["SortName"] = "Asc";

        }

        CurrentPage = 0;
        fill_Data();
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
        string strQuery = "update " + TableName + " set Visible=" + status + " where ID in (" + VisId + ")";
        new DAL().ExecuteNonQuery(strQuery, CommandType.Text, null);

        if (status == 0)
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('Selected " + MessageNm + " record has been successfully set to subscribe.');", true);
        else
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('Selected " + MessageNm + " record has been successfully set to unsubscribe.');", true);

        #endregion

        #endregion
    }

    protected bool Delete_Data(string id)
    {
        try
        {
            strQuery = "Delete from " + TableName + " where ID = " + id + "";
            new DAL().ExecuteNonQuery(strQuery, CommandType.Text, null);

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
        ViewState["SortName"] = ViewState["SortGroup"] = ViewState["SortEmail"] = "";
        ddl_Group.Text = tbx_Search.Text = tbx_SearchEmail.Text = "";
        CurrentPage = 0;
        fill_Data();
    }

    #endregion

    #region do not change

    protected void rep_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

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
        if (cmd == "active")
            this.Hide_Show(1);
        else if (cmd == "deactive")
            this.Hide_Show(0);
        else if (cmd == "delete")
            this.Deleted_Selected();

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
    protected void lb_Group_Click(object sender, EventArgs e)
    {
        lb_Email.CssClass = lb_name.CssClass = "sort";
        ViewState["SortName"] = ViewState["SortEmail"] = "";
        if (ViewState["SortGroup"].ToString() == "")
        {
            lb_name.CssClass = "sort Asc";
            ViewState["SortGroup"] = "Asc";


        }
        else if (ViewState["SortGroup"].ToString() == "Asc")
        {
            lb_name.CssClass = "sort Desc";
            ViewState["SortGroup"] = "Desc";
        }
        else if (ViewState["SortGroup"].ToString() == "Desc")
        {
            lb_name.CssClass = "sort Asc";
            ViewState["SortGroup"] = "Asc";

        }

        CurrentPage = 0;
        fill_Data();
    }
    protected void lb_Email_Click(object sender, EventArgs e)
    {
        lb_name.CssClass = lb_Group.CssClass = "sort";
        ViewState["SortName"] = ViewState["SortGroup"] = "";
        if (ViewState["SortEmail"].ToString() == "")
        {
            lb_name.CssClass = "sort Asc";
            ViewState["SortEmail"] = "Asc";


        }
        else if (ViewState["SortEmail"].ToString() == "Asc")
        {
            lb_name.CssClass = "sort Desc";
            ViewState["SortEmail"] = "Desc";
        }
        else if (ViewState["SortEmail"].ToString() == "Desc")
        {
            lb_name.CssClass = "sort Asc";
            ViewState["SortEmail"] = "Asc";

        }

        CurrentPage = 0;
        fill_Data();
    }
}