using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class product_buzz_value : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hfPagination.Value = "5";
            fill_category();
        }
    }
    protected void fill_category()
    {
        string TotQuery = "select count(*) from productcategory where visible=1 and (select count(*) from product where visible=1 and product.catid=productcategory.id)>0 ";
         string tot = new DAL().ExecuteScalar(TotQuery, CommandType.Text, null);
        if (int.Parse(tot) > int.Parse(hfPagination.Value))
            lbPagination.Visible = true;
        else
            lbPagination.Visible = false;

        string strQuery = "select " + " top " + hfPagination.Value + " * from productcategory where visible=1 and (select count(*) from product where visible=1 and product.catid=productcategory.id)>0 order by sortorder ";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            
            repCat.DataSource = dt;
            repCat.DataBind();
        }
    }
    protected void repCat_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        HiddenField hfcatid = (HiddenField)e.Item.FindControl("hfcatid");
        Repeater repProduct = (Repeater)e.Item.FindControl("repProduct");
        string strQuery = "select top 8 * from product where visible=1 and catid=" + hfcatid.Value + " order by sortorder";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {

            repProduct.DataSource = dt;
            repProduct.DataBind();
        }
    }
    protected void lbPagination_Click(object sender, EventArgs e)
    {
        hfPagination.Value = (int.Parse(hfPagination.Value) + 5).ToString();
        fill_category();
    }
}