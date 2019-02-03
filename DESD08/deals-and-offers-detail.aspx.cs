using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class product_deals_and_offersdetail : System.Web.UI.Page
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
            Response.Redirect("deals-and-offers.aspx");
    }
    protected void fill_image()
    {

        string strQuery = "select deal.image as img, title from deal where id=" + Request.QueryString["id"].ToString();
        strQuery += " union all ";
        strQuery += "select deal_images.image as img, 0 as title from deal_images where deal_images.image<>'' and deal_images.productid=" + Request.QueryString["id"].ToString();
        DataTable dtImg = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dtImg != null && dtImg.Rows.Count > 0)
        {
            repimgmed.DataSource = dtImg;
            repimgmed.DataBind();
        }
    }
    protected void fill_Data()
    {

        string strQuery = "select * from deal where visible=1 and id=" + Request.QueryString["id"].ToString();
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {

            ltrBtitle.Text = ltrTitle.Text = dt.Rows[0]["title"].ToString();
            string category = new DAL().ExecuteScalar("select title from productcategory where id=" + dt.Rows[0]["catid"].ToString(), CommandType.Text, null);
            if (double.Parse(dt.Rows[0]["costprice"].ToString()) != double.Parse(dt.Rows[0]["sellprice"].ToString()))
            {
                spanCP.Visible = true;
                ltrCostPrice.Text = double.Parse(dt.Rows[0]["costprice"].ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN"));
            }
            else
                spanCP.Visible = false;
            if (dt.Rows[0]["perweek"] != null && dt.Rows[0]["perweek"].ToString() != "")
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
            ltrSellPrice.Text = double.Parse(dt.Rows[0]["sellprice"].ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN"));
            ltrPCode.Text = dt.Rows[0]["productcode"].ToString();
            ViewState["img"] = dt.Rows[0]["image"].ToString();
            ltrdesc.Text = dt.Rows[0]["description"].ToString();
        }
        else
        {
            Response.Redirect("deals-and-offers.aspx");
        }
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
            if (drex["id"].ToString() == Request.QueryString["id"].ToString() && drex["deal"].ToString() == "1")
            {
                div_Success.Visible = false;
                div_Error.Visible = true;
                ltr_msg.Text = "Deal already exists in Enquiry Cart List. <a href='product-cart.aspx'>View Cart</a>";
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
        if (ViewState["perweek"] != "")
            dr["Perweek"] = ViewState["perweek"];
        else
            dr["Perweek"] = "0";
        dr["amount"] = ltrSellPrice.Text;
        dr["deal"] = 1;

        Cart.Rows.Add(dr);
        Session["Cart"] = Cart;
        #endregion
        div_Error.Visible = false;
        div_Success.Visible = true;
        ltr_Success.Text = "Deal added to Enquiry Cart List. <a href='product-cart.aspx'>View Cart</a>";
    }
    protected void fill_associated()
    {
        string strQuery = "select top 16 Product.* from Product inner join Associateddeal on Product.id=Associateddeal.AssociatePID where Associateddeal.pid=" + Request.QueryString["id"].ToString()+ " and Product.visible=1 and (select visible from productcategory where productcategory.id=catid)=1 order by Product.id desc";
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