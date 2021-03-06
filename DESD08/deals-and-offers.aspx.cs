﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class deals_and_offers : System.Web.UI.Page
{
    int findex, lindex;
    public static int pageindex = 0, Pagesize = 30;
    PagedDataSource pgsource = new PagedDataSource();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            fill_Product();
            fill_teaser();
        }
    }
    protected void fill_Product()
    {
        string strQuery = "select top 18 * from deal where visible=1 and (select visible from productcategory where productcategory.id=catid)=1 order by id desc";
        DataTable dt = null;
        dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {

            trNoitem.Visible = false;
            repProduct.Visible = true;
            pgsource.DataSource = dt.DefaultView;
            pgsource.AllowPaging = true;
            pgsource.PageSize = Pagesize;
            pgsource.CurrentPageIndex = CurrentPage;
            ViewState["totpage"] = pgsource.PageCount;
            lnkPrevious.Enabled = !pgsource.IsFirstPage;
            lnkNext.Enabled = !pgsource.IsLastPage;
            repProduct.DataSource = pgsource;
            repProduct.DataBind();
            if (dt.Rows.Count > Pagesize)
            {
                div_Paging.Visible = true;
                doPaging();
            }
            else
                div_Paging.Visible = false;
        }
        else
        {
            repProduct.Visible = false;
            trNoitem.Visible = true;
            div_Paging.Visible = false;
        }
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
        findex = CurrentPage - 1;

        //Set Last index value if current page less than 5 then last index added "5" values to the Current page else it set "10" for last page number
        if (CurrentPage >= 2)
        {
            lindex = CurrentPage + 2;

        }
        else
        {
            lindex = 3;
        }

        //Check last page is greater than total page then reduced it to total no. of page is last index
        if (lindex > Convert.ToInt32(ViewState["totpage"]))
        {
            lindex = Convert.ToInt32(ViewState["totpage"]);
            findex = lindex - 3;

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
        fill_Product();
    }

    protected void lnkNext_Click(object sender, EventArgs e)
    {
        //If user click Next Link button assign current index as +1 it add one value to existing page index.
        CurrentPage += 1;

        //refresh "Repeater1" Data
        fill_Product();
    }

    protected void RepeaterPaging_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName.Equals("newpage"))
        {
            //Assign CurrentPage number when user click on the page number in the Paging "RepeaterPaging" DataList
            CurrentPage = Convert.ToInt32(e.CommandArgument.ToString());
            //Refresh "Repeater1" control Data once user change page
            fill_Product();
        }
    }

    protected void RepeaterPaging_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        LinkButton lnkPage = (LinkButton)e.Item.FindControl("Pagingbtn");
        if (lnkPage.CommandArgument.ToString() == CurrentPage.ToString())
        {
            lnkPage.Enabled = false;
            lnkPage.CssClass = "active";
        }
        else
            lnkPage.CssClass = "";
    }

    protected void lbLastpg_Click(object sender, EventArgs e)
    {
        CurrentPage = Convert.ToInt32(ViewState["totpage"]) - 1;
        fill_Product();
    }

    #endregion
    protected void fill_teaser()
    {
        string strQuery = "select top 1 * from teaser where visible=1 and position=3 order by rand()";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            img.Src = "webfiles/teaser/" + dt.Rows[0]["image"].ToString();
            link.HRef = dt.Rows[0]["url"].ToString();
            divbottombanner.Visible = true;
        }
        else
            divbottombanner.Visible = false;

        strQuery = "select * from teaser where visible=1 and position=2 order by rand() limit 4";
        DataTable dt1 = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt1 != null && dt1.Rows.Count > 0)
        {
            img1.Src = "webfiles/teaser/" + dt1.Rows[0]["image"].ToString();
            link1.HRef = dt1.Rows[0]["url"].ToString();
            if (dt1.Rows.Count >= 2)
            {
                img2.Visible = true;
                img2.Src = "webfiles/teaser/" + dt1.Rows[1]["image"].ToString();
                link2.HRef = dt1.Rows[1]["url"].ToString();
            }
            divmiddlebanner1.Visible = divMiddlebanner.Visible = true;
            if (dt1.Rows.Count >= 3)
            {
                img3.Visible = true;
                img3.Src = "webfiles/teaser/" + dt1.Rows[2]["image"].ToString();
                link3.HRef = dt1.Rows[2]["url"].ToString();
            }
            if (dt1.Rows.Count >= 4)
            {
                img4.Visible = true;
                img4.Src = "webfiles/teaser/" + dt1.Rows[3]["image"].ToString();
                link4.HRef = dt1.Rows[3]["url"].ToString();
            }
        }
        else
            divMiddlebanner.Visible = false;


    }
}