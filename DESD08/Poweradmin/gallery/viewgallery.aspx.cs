using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class Poweradmin_Gallery_viewGallery : System.Web.UI.Page
{
    int findex, lindex;
    public static int pageindex = 0, Pagesize = 25;
    string strQuery, TableName = "photocategory", MessageNm = "Album";
    PagedDataSource pgsource = new PagedDataSource();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            fill_Data();

            if (Request.QueryString["msg"] != null && Request.QueryString["msg"].ToString() != "")
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('" + Request.QueryString["msg"].ToString() + "');", true);
            if (Request.QueryString["tab"] != null && Request.QueryString["tab"].ToString() != "")
            {

                hfactivetab.Value = Request.QueryString["tab"].ToString();

            }
        }
    }

    #region Change This Part Only

    protected void fill_Data()
    {
        string strQuery = "select *,case id when 19 then 'false' when 20 then 'false' else 'true' end as chvisible from " + TableName + " where id<>0 ";
        if (ddlvisble.SelectedValue.ToString() != "") strQuery += " and Visible=" + ddlvisble.SelectedValue.ToString();
        if (tbx_Search.Text != "") strQuery += " and Title like '%" + tbx_Search.Text.Replace("'", "''") + "%'";
        strQuery += " order by sortorder asc";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        #region Bind Data




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
            tbx_PageNumber.Text = (CurrentPage + 1).ToString();
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





    protected void ddlDisplayOrder_SelectedIndexChanged(object sender, EventArgs e)
    {
        string strsort = "";
        DropDownList ddl = (DropDownList)sender;
        int selectedOrder = int.Parse(ddl.SelectedItem.Value);

        RepeaterItem ri = (RepeaterItem)((DropDownList)sender).Parent;
        int rowIndex1 = ri.ItemIndex;


        HiddenField hdnProId1 = (HiddenField)(rep.Items[rowIndex1].FindControl("hfNewsId"));
        HiddenField hdnDisId1 = (HiddenField)(rep.Items[rowIndex1].FindControl("hdnDisId"));

        string id1 = hdnProId1.Value;
        int oldOrder = int.Parse(hdnDisId1.Value);
        try
        {
            if (oldOrder < selectedOrder)
                strsort = "update " + TableName + " set sortorder = sortorder - 1 where sortorder > " + oldOrder + " and sortorder <= " + selectedOrder;
            else
                strsort = "update " + TableName + " set sortorder = sortorder + 1 where sortorder >= " + selectedOrder + " and sortorder < " + oldOrder;

            new DAL().ExecuteNonQuery(strsort, CommandType.Text, null);
            strsort = "update " + TableName + " set sortorder=" + selectedOrder + " where id=" + id1 + "";
            new DAL().ExecuteNonQuery(strsort, CommandType.Text, null);
        }
        catch (Exception ex)
        {
            throw ex;
        }

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
            string albumimage = new DAL().ExecuteScalar("select count(*) from PhotoGallery where catid=" + id, CommandType.Text, null);
            if (albumimage != "0")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Album Cannot be deleted as there are " + albumimage + " images in this album');", true);
                return false;
            }
            


            string FileName = new DAL().ExecuteScalar("select image from " + TableName + " where id=" + id, CommandType.Text, null);

            strQuery = "update " + TableName + " set sortorder = sortorder - 1 where sortorder >  (select sortorder from (select sortorder from " + TableName + " where id =" + id + ") as sortorder)";
            new DAL().ExecuteNonQuery(strQuery, CommandType.Text, null);

            strQuery = "Delete from " + TableName + " where ID = " + id + "";
            new DAL().ExecuteNonQuery(strQuery, CommandType.Text, null);

            try
            {
                if (File.Exists(DAL.GetRootPath() + "webfiles\\photogallery\\album\\large\\" + FileName))
                    File.Delete(DAL.GetRootPath() + "webfiles\\photogallery\\album\\large\\" + FileName);
                if (File.Exists(DAL.GetRootPath() + "webfiles\\photogallery\\album\\medium\\" + FileName))
                    File.Delete(DAL.GetRootPath() + "webfiles\\photogallery\\album\\medium\\" + FileName);
            }
            catch (Exception ex)
            { }

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
            HiddenField hdnDisId = (HiddenField)e.Item.FindControl("hdnDisId");
            FillingDisplyOrder(ddl, hdnProId.Value, hdnDisId, e.Item.ItemIndex + 1);
        }
        #endregion
    }

    public void FillingDisplyOrder(DropDownList ddl, string val, HiddenField hdnDisId, int newId)
    {
        #region//function to fill the display order drop down

        if (ltr_Total.Text != null && ltr_Total.Text != "")
        {
            double totRecord = double.Parse(ltr_Total.Text);
            for (double i = 1; i <= totRecord; i++)
            {
                ListItem li = new ListItem(i.ToString(), i.ToString());
                if (hdnDisId != null)
                {
                    if (i.ToString() == hdnDisId.Value)
                    {
                        li.Selected = true;
                    }
                }
                ddl.Items.Add(li);
                li = null;
            }
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
        if (cmd == "active")
            this.Hide_Show(1);
        else if (cmd == "deactive")
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

    protected string GetImage(string image)
    {
        string path = "";
        if (image == "")
        {
            path = "<img src='../../webfiles/img_not_available.png' style='height: 100px !Important; width: 200px' class='img-responsive' />";
        }
        else
        {
            path = "<img src='../../webfiles/photogallery/album/medium/" + image + "' class='img-responsive' style='width:100px' />";
        }
        return path;
    }
}