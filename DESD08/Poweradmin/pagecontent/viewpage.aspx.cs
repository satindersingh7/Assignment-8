﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Poweradmin_pagecontent_viewpage : System.Web.UI.Page
{
    int findex, lindex;
    public static int pageindex = 0, Pagesize = 25;
    string strQuery, TableName = "InsidePage", MessageNm = "Page";
    PagedDataSource pgsource = new PagedDataSource();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            fill_Data();
            if (Request.QueryString["msg"] != null && Request.QueryString["msg"].ToString() != "")
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('" + Request.QueryString["msg"].ToString() + "');", true);
        }
    }

    #region Change This Part Only

    protected void fill_Data()
    {
        string strQuery = "select * from " + TableName;
        strQuery += " order by sortorder asc";

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
                doPaging();
            }
            else
                div_Paging.Visible = false;

            pnl_Record.Visible = rep.Visible = true;
            div_msg.Visible = false;
            ltr_msg2.Text = "";
        }
        else
        {
           
                div_Paging.Visible = rep.Visible = false;
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

   

    protected bool Delete_Data(string id)
    {
        try
        {
            strQuery = "update " + TableName + " set sortorder = sortorder - 1 where sortorder >  (select sortorder from (select sortorder from " + TableName + " where id =" + id + ") as sortorder)";
            new DAL().ExecuteNonQuery(strQuery, CommandType.Text, null);

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
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please select atleast one record.');", true);
        }

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

    private void doPaging()
    {
        DataTable dt = new DataTable();
        //Add two column into the DataTable "dt" 
        //First Column store page index default it start from "0"
        //Second Column store page index default it start from "1"
        dt.Columns.Add("PageIndex");
        dt.Columns.Add("PageText");

        //Assign First Index starts from which number in paging data list
        findex = CurrentPage - 2;

        //Set Last index value if current page less than 5 then last index added "5" values to the Current page else it set "10" for last page number
        if (CurrentPage >= 3)
        {
            lindex = CurrentPage + 3;
        }
        else
        {
            lindex = 5;
        }

        //Check last page is greater than total page then reduced it to total no. of page is last index
        if (lindex > Convert.ToInt32(ViewState["totpage"]))
        {
            lindex = Convert.ToInt32(ViewState["totpage"]);
            findex = lindex - 5;
        }

        if (findex < 0)
        {
            findex = 0;
        }

        //Now creating page number based on above first and last page index
        for (int i = findex; i < lindex; i++)
        {
            DataRow dr = dt.NewRow();
            dr[0] = i;
            dr[1] = i + 1;
            dt.Rows.Add(dr);
        }

        //Finally bind it page numbers in to the Paging DataList "RepeaterPaging"

        //Finally bind it page numbers in to the Paging DataList "RepeaterPaging"
        RepeaterPaging.DataSource = dt;
        RepeaterPaging.DataBind();
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

    protected void RepeaterPaging_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName.Equals("newpage"))
        {
            //Assign CurrentPage number when user click on the page number in the Paging "RepeaterPaging" DataList
            CurrentPage = Convert.ToInt32(e.CommandArgument.ToString());
            //Refresh "Repeater1" control Data once user change page
            fill_Data();
        }
    }

    protected void RepeaterPaging_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        LinkButton lnkPage = (LinkButton)e.Item.FindControl("Pagingbtn");
        Literal li = (Literal)e.Item.FindControl("ltrli");
        if (lnkPage.CommandArgument.ToString() == CurrentPage.ToString())
        {
            lnkPage.Enabled = false;
            li.Text = "<li class='paginate_button active' aria-controls='dataTables-example' tabindex='0'>";
        }
        else
            li.Text = " <li class='paginate_button' aria-controls='dataTables-example' tabindex='0'>";
    }

    protected void ddl_Rows_SelectedIndexChanged(object sender, EventArgs e)
    {
        CurrentPage = 0;
        Pagesize = int.Parse(ddl_Rows.SelectedValue.ToString());
        this.fill_Data();
    }
    #endregion

    #endregion
}