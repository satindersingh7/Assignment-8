using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class product_detail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] != null && Request.QueryString["id"].ToString() != "")
        {
            if (DAL.IsNumeric(Request.QueryString["id"]) == true)
            {
                if (!this.IsPostBack)
                {
                    ViewState["perweek"] = "";
                    fill_image();
                    fill_Data();
                    fill_associated();
                }
            }
        }
        else
            Response.Redirect("product.aspx");
    }
    protected void fill_image()
    {

        string strQuery = "select product.image as img, title from product where id=" + Request.QueryString["id"].ToString();
        strQuery += " union all ";
        strQuery += "select product_images.image as img, 0 as title from product_images where product_images.image<>'' and product_images.productid=" + Request.QueryString["id"].ToString();
        DataTable dtImg = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dtImg != null && dtImg.Rows.Count > 0)
        {
            repimgmed.DataSource = dtImg;
            repimgmed.DataBind();
        }
    }
    protected void fill_Data()
    {

        string strQuery = "select * from product where visible=1 and id=" + Request.QueryString["id"].ToString();
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {

            ltrBtitle.Text = ltrTitle.Text = dt.Rows[0]["title"].ToString();
            string category = new DAL().ExecuteScalar("select title from productcategory where id=" + dt.Rows[0]["catid"].ToString(), CommandType.Text, null);
            ltrCat.Text = "<a href='product-listing.aspx?catid=" + dt.Rows[0]["catid"].ToString() + "'>" + category + "</a>";
            if (double.Parse(dt.Rows[0]["costprice"].ToString()) != double.Parse(dt.Rows[0]["sellprice"].ToString()))
            {
                spanCP.Visible = true;
                ltrCostPrice.Text = double.Parse(dt.Rows[0]["costprice"].ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN"));
            }
            else
                spanCP.Visible = false;
            ltrSellPrice.Text = double.Parse(dt.Rows[0]["sellprice"].ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN"));
            if (dt.Rows[0]["perweek"] != null && dt.Rows[0]["perweek"].ToString()!="")
            {
                if (double.Parse(dt.Rows[0]["perweek"].ToString()) != 0)
                {
                    ViewState["perweek"] = dt.Rows[0]["perweek"].ToString();
                    tabAddInfo.Visible = spnperweek.Visible = true;
                    ltrPerweek1.Text = ltrPerweek.Text = double.Parse(dt.Rows[0]["perweek"].ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN"));
                }
                else
                    tabAddInfo.Visible = spnperweek.Visible = false;
            }
            else
                tabAddInfo.Visible = spnperweek.Visible = false;
            ltrPCode.Text = dt.Rows[0]["productcode"].ToString();
            ViewState["img"] = dt.Rows[0]["image"].ToString();
            ltrStockout.Text = dt.Rows[0]["outofstock"].ToString().Replace("False", "In Stock").Replace("True", "Out of Stock");
            ltrdesc.Text = dt.Rows[0]["description"].ToString();
        }
        else
            Response.Redirect("product.aspx");
    }
    protected void lbAddtoCart_Click(object sender, EventArgs e)
    {
        if (Session["Cart"] == null)
        {
            DAL.CreateCart();
        }
        DataTable Cart = (DataTable)Session["Cart"];

        #region Check Existing Product
        foreach (DataRow drex in Cart.Rows)
        {
            if (drex["id"].ToString() == Request.QueryString["id"].ToString()&& drex["deal"].ToString()=="0")
            {
                div_Success.Visible = false;
                div_Error.Visible = true;
                ltr_msg.Text = "Product already exists in Enquiry Cart List. <a href='product-cart.aspx'>View Cart</a>";
                return;
                //}
            }
        }
        #endregion

        #region Add to Cart
        DataRow dr = Cart.NewRow();
        dr["id"] = Request.QueryString["id"].ToString();
        dr["code"] = ltrPCode.Text;
        dr["Name"] = ltrTitle.Text;
        dr["Image"] = ViewState["img"].ToString();
        if (ltrCostPrice.Text == "") dr["costprice"] = ltrSellPrice.Text;
        else dr["costprice"] = ltrCostPrice.Text;
        dr["sellprice"] = ltrSellPrice.Text;
        if( ViewState["perweek"] != "")
            dr["Perweek"] = ViewState["perweek"];
        dr["amount"] = ltrSellPrice.Text;
        dr["deal"] = 0;


        Cart.Rows.Add(dr);
        Session["Cart"] = Cart;
        #endregion
        div_Error.Visible = false;
        div_Success.Visible = true;
        ltr_Success.Text = "Product added to Enquiry Cart List. <a href='product-cart.aspx'>View Cart</a>";
    }
    protected void fill_associated()
    {
        string strQuery = "select top 16 product.* from product inner join AssociatedProduct on product.id=AssociatedProduct.AssociatePID where AssociatedProduct.pid="+Request.QueryString["id"].ToString()+" and product.visible=1 and (select visible from productcategory where productcategory.id=catid)=1 order by product.id desc";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            repassociated.DataSource = dt;
            repassociated.DataBind();
            divassociated.Visible = true;
        }
        else
            divassociated.Visible = false;
    }
}