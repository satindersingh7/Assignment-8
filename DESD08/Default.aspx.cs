using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    public static int cnt = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            fill_banner();
            fill_new();
            fill_featured();
            fill_teaser();
        }
    }
    protected void fill_banner()
    {
        string strQuery = "select * from banner where visible=1 order by sortorder ;";
        //strQuery += "select * from Product where visible=1";
         DataSet ds = new DAL().GetDataSet(strQuery, CommandType.Text, null);
         if (ds != null && ds.Tables[0].Rows.Count > 0)
         {
             repbanner.DataSource = ds.Tables[0];
             repbanner.DataBind();
             //DataTable dtnews = new DataView(ds.Tables[1], "id<>0", "id desc", DataViewRowState.CurrentRows).ToTable();
             //if (dtnews != null && dtnews.Rows.Count > 0)
             //{
             //    DataTable dtnew = dtnews.Clone();
             //    dtnews.AsEnumerable().Take(16).CopyToDataTable(dtnew, LoadOption.OverwriteChanges);
             //    repNewProducts.DataSource = dtnew;
             //    repNewProducts.DataBind();
             //}
             //DataTable dtfeatured = new DataView(ds.Tables[1], "featured=1", "id desc", DataViewRowState.CurrentRows).ToTable();
             //if (dtfeatured != null && dtfeatured.Rows.Count > 0)
             //{

             //    DataTable dtnew = dtfeatured.Clone();
             //    dtfeatured.AsEnumerable().Take(16).CopyToDataTable(dtnew, LoadOption.OverwriteChanges);
             //    cnt = dtnew.Rows.Count;
             //    repFeatured.DataSource = dtnew;
             //    repFeatured.DataBind();
             //}
         }
    }
    protected void fill_new()
    {
        string strQuery = "select top 16 * from product where visible=1 and (select visible from productcategory where productcategory.id=catid)=1 order by id desc";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            repNewProducts.DataSource = dt;
            repNewProducts.DataBind();

            divNew.Visible = true;
        }
        else
            divNew.Visible = false;
    }
    protected void fill_teaser()
    {
        string strQuery = "select  top 1 * from teaser where visible=1 and position=3 order by rand()";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            img.Src = "webfiles/teaser/" + dt.Rows[0]["image"].ToString();
            link.HRef = dt.Rows[0]["url"].ToString();
            divbottombanner.Visible = true;
        }
        else
            divbottombanner.Visible = false;

        strQuery = "select top 2 * from teaser where visible=1 and position=2 order by rand()";
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
            divMiddlebanner.Visible = true;
        }
        else
            divMiddlebanner.Visible = false;


    }
    protected void fill_featured()
    {
        string strQuery = "select top 18 * from product where visible=1 and featured=1 and (select visible from productcategory where productcategory.id=catid)=1 order by id desc";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            cnt = dt.Rows.Count;
            repFeatured.DataSource = dt;
            repFeatured.DataBind();
            divFeatured.Visible = true;
        }
        else
            divFeatured.Visible = false;
    }
    #region AutoComplete
    [WebMethod]
    public static List<Products> GetProducts(string prefix, string selval)
    {
        
        string strQuery = "";
        strQuery += "select * from(";
        string where = "";
        where = "((product.Title like '%" + prefix.Replace("'", "''") + "%' and product.visible=1 and productcategory.visible=1) or (product.productcode = '" + prefix.Replace("'", "''") + "' and product.visible=1 and productcategory.visible=1)  or (productcategory.Title like '%" + prefix.Replace("'", "''") + "%' and productcategory.visible=1) ";

        strQuery += "(select Product.title as ptitle, Product.id as pid, productcategory.title as brand, Product.image as img,product.catid as category1,  match (Product.title) against('') as score from Product inner join productcategory on product.catid=productcategory.id where " + where + " ) union ";//" + prefix.Replace("'", "''") + "

        prefix = prefix.Trim();

        List<Products> products = new List<Products>();
        string[] result = Regex.Split(prefix, @" ");
        foreach (string s in result)
        {
            where = "((product.Title like '%" + prefix.Replace("'", "''") + "%' and product.visible=1 and productcategory.visible=1) or (product.productcode = '" + prefix.Replace("'", "''") + "' and product.visible=1 and productcategory.visible=1)  or (productcategory.Title like '%" + prefix.Replace("'", "''") + "%' and productcategory.visible=1) ";
            strQuery += "((select top 20 Product.title as ptitle, Product.id as pid, productcategory.title as brand, Product.image as img,product.catid as category1,  match (Product.title) against('') as score from Product inner join productcategory on product.catid=productcategory.id where " + where + " )))  union ";
        }
        strQuery = strQuery.Substring(0, strQuery.Trim().Length - 5);
        strQuery += ")as t)";
        if (selval != "0") strQuery += " where t.category1=" + selval + " ";
        strQuery += " order by score desc";
        //new DAL().ExecuteNonQuery("insert into msg(msgnm) value('" + strQuery.Replace("'", "''") + "')", CommandType.Text, null);
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        DataView view = new DataView(dt);
        DataTable distinctValues = view.ToTable(true);
        dt = new DataTable();
        dt = distinctValues;
        if (dt != null && dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {

                products.Add(new Products() { ProductId = dt.Rows[i]["pid"].ToString(), ProductName = dt.Rows[i]["ptitle"].ToString().Length > 100 ? dt.Rows[i]["ptitle"].ToString().Substring(0, 97) + "..." : dt.Rows[i]["ptitle"].ToString(), ProductImage = "webfiles/product/small/" + dt.Rows[i]["img"].ToString(), brand = dt.Rows[i]["brand"].ToString() });
                // products.Add(string.Format("{0}-{1}",( dt.Rows[i]["ptitle"].ToString().Length>20 ? dt.Rows[i]["ptitle"].ToString().Substring(0,17)+"..." : dt.Rows[i]["ptitle"].ToString() ) + " in <img ID=\"img\" src=\"webfiles/banner/category/"+dt.Rows[i]["img"].ToString()+"\" style=\"padding-bottom:20px; width:10px; height:10px\" class=\"img-responsive\" />" + dt.Rows[i]["ctitle"].ToString(), dt.Rows[i]["ptitle"].ToString()));//.Length > 13 ? dt.Rows[i]["ptitle"].ToString().Substring(0, 10) + "..." : dt.Rows[i]["ptitle"].ToString()
            }
        }
        else
        {
            products.Add(new Products() { ProductName = "Not found" });
        }

        return products;
    }
    #endregion
}
public class Products
{
    public string ProductId { get; set; }
    public string ProductName { get; set; }
    public string ProductImage { get; set; }
    public string brand { get; set; }

}