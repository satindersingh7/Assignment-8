using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class product_listing : System.Web.UI.Page
{
    int findex, lindex;
    public static int pageindex = 0, Pagesize = 30;
    PagedDataSource pgsource = new PagedDataSource();
    protected void Page_Load(object sender, EventArgs e)
    {
        string searchkeyword = "";
        if (!this.IsPostBack)
        {
            ViewState["sortby"] = ViewState["catid"] = "";
            fill_category();
            if (Request.QueryString["catid"] != null && Request.QueryString["catid"].ToString() != "" && Request.QueryString["catid"].ToString() != "0")
            {
                ViewState["catid"] = Request.QueryString["catid"].ToString();
                ddl_Category.SelectedValue = Request.QueryString["catid"].ToString();
            }
            if (Request.QueryString["key"] != null && Request.QueryString["key"].ToString() != "")
            {
                searchkeyword = Server.UrlDecode(Request.QueryString["key"].ToString().TrimEnd().Replace("'", "''"));
                ltrTitle.Text = ltrBtitle.Text = "Search results for '" + searchkeyword + "' ";
                this.Page.Title = "Search results";
            }
            fill_Product();
        }
    }
    protected void fill_category()
    {
        

        string strQuery = "select * from productcategory where visible=1 and (select count(*) from product where visible=1 and product.catid=productcategory.id)>0 order by sortorder ";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
             ddl_Category.DataSource = dt;
            ddl_Category.DataTextField = "Title";
            ddl_Category.DataValueField = "id";
            ddl_Category.DataBind();
        }
    }
    protected void fill_Product()
    {
        string strQuery = "";
        if (Request.QueryString["key"] != null && Request.QueryString["key"].ToString() != "")
        {
            string prefix = Server.UrlDecode(Request.QueryString["key"].ToString().TrimEnd().Replace("'", "''"));
            strQuery = "";
            strQuery += "select * from(";
            string where = "";
            where = "((product.Title like '%" + prefix.Replace("'", "''") + "%' and product.visible=1 and productcategory.visible=1) or (product.productcode = '" + prefix.Replace("'", "''") + "' and product.visible=1 and productcategory.visible=1)  or (productcategory.Title like '%" + prefix.Replace("'", "''") + "%' and productcategory.visible=1) ";

            strQuery += "(select Product.title as title, Product.id as id, product.sellprice as sellprice,product.costprice as costprice, Product.image as image,product.catid as category1,  match (Product.title) against('') as score from Product inner join productcategory on product.catid=productcategory.id where " + where + " ) union ";//" + prefix.Replace("'", "''") + "

            prefix = prefix.Trim();


            string[] result = Regex.Split(prefix, @" ");
            foreach (string s in result)
            {
                where = "((product.Title like '%" + prefix.Replace("'", "''") + "%' and product.visible=1 and productcategory.visible=1) or (product.productcode = '" + prefix.Replace("'", "''") + "' and product.visible=1 and productcategory.visible=1)  or (productcategory.Title like '%" + prefix.Replace("'", "''") + "%' and productcategory.visible=1) ";
                strQuery += "((select Product.title as title, Product.id as id, product.sellprice as sellprice,product.costprice as costprice, Product.image as image,product.catid as category1,  match (Product.title) against('') as score from Product inner join productcategory on product.catid=productcategory.id where " + where + " ))) union ";
            }
            strQuery = strQuery.Substring(0, strQuery.Trim().Length - 5);
            strQuery += ")as t)";
            if (Request.QueryString["catid"] != null && Request.QueryString["catid"].ToString() != "" && ViewState["catid"].ToString() != "") strQuery += " where t.category1=" + ViewState["catid"] + " ";
            if (ViewState["sortby"] != null && ViewState["sortby"].ToString() != "")
                strQuery += " order by " + ViewState["sortby"].ToString();
            else
            strQuery += " order by score desc";
        }
        else
        {
            strQuery = "Select * from product where visible=1 and (select visible from productcategory where  productcategory.id=catid)=1 ";
            if (ViewState["catid"] != null && ViewState["catid"].ToString() != "")
            {
                ltrBtitle.Text = ltrTitle.Text = new DAL().ExecuteScalar("select title from productcategory where visible=1 and id=" + ViewState["catid"].ToString(), CommandType.Text, null);
                if (ltrBtitle.Text == "") Response.Redirect("product.aspx");
                strQuery += " and catid=" + ViewState["catid"].ToString();
            }
            if (ViewState["sortby"] != null && ViewState["sortby"].ToString() != "")
                strQuery += " order by " + ViewState["sortby"].ToString();
            else
                strQuery += " order by sortorder";
        }
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
    protected void ddl_Category_SelectedIndexChanged(object sender, EventArgs e)
    {
        ViewState["catid"] = ddl_Category.SelectedValue.ToString();
        CurrentPage = 0;
        fill_Product();
    }
    protected void ddlsort_SelectedIndexChanged(object sender, EventArgs e)
    {
        Pagesize = Convert.ToInt32(ddlsort.SelectedValue.ToString());
        CurrentPage = 0;
        fill_Product();
    }
    protected void ddlsortby_SelectedIndexChanged(object sender, EventArgs e)
    {
        ViewState["sortby"] = ddlsortby.SelectedValue.ToString();
        CurrentPage = 0;
        fill_Product();
    }
}
