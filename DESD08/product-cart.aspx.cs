using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class product_cart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            fill_Cart();
            ImageVarification.setImage1(imgCaptcha, hfVerification);
        }
    }
    protected void fill_Cart()
    {
        if (Session["Cart"] != null)
        {
            DataTable Cart = (DataTable)Session["Cart"];
            if (Cart != null && Cart.Rows.Count > 0)
            {
                repcart.Visible = true;
                noitem.Visible = false;
                repcart.DataSource = Cart;
                repcart.DataBind();
                divForm.Visible = true;
                tdtotal.Visible = true;
                object sumObject = Cart.Compute("Sum(amount)", "id > -1");
                ViewState["gt"] = sumObject.ToString();
                ltrtotal.Text = Convert.ToDouble((Convert.ToDouble(sumObject.ToString())).ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN"));
                object sumObjectweek = Cart.Compute("Sum(perweek)", "id > -1");
                ViewState["gtPerweek"] = sumObjectweek.ToString();
                ltrTotPerweek.Text = Convert.ToDouble((Convert.ToDouble(sumObjectweek.ToString())).ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN"));
            }
            else
            {
                repcart.Visible = false;
                divForm.Visible = false;
                tdtotal.Visible = false;
                noitem.Visible = true;
            }
        }
        else
        {
            repcart.Visible = false;
            divForm.Visible = false;
            tdtotal.Visible = false;
            noitem.Visible = true;
        }
    }
    protected void repcart_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName.ToString() == "remove")
        {
            DataTable Cart = new DataTable();
            Cart = (DataTable)Session["Cart"];
            if (e.Item.ItemIndex < Cart.Rows.Count)
                Cart.Rows.Remove((Cart.Select("id =" + e.CommandArgument.ToString()))[0]);

            
            div_Error.Visible = false;
            div_Success.Visible = true;
            ltr_Success.Text = "Product removed from Cart.";
            fill_Cart();
        }
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        if (tbx_ContactSecure.Text == hfVerification.Value)
        {
            string cart = "";
            if (Session["Cart"] != null && Session["Cart"].ToString() != "")
            {
                DataTable Cart = (DataTable)Session["Cart"];
                ViewState["orderid"] = Generating_Code();
                int total = Convert.ToInt32(ViewState["gt"]);
                int totPerweek = Convert.ToInt32(ViewState["gtPerweek"]);
                string strQuery = "";
                strQuery = "insert into ordermaster(OrderNumber,Name,Email,Phone,Subject,Comments,orderDate,orderIp,grandtotal,orderstatus) values(";
                strQuery += "'" + ViewState["orderid"] + "','" + tbx_Name.Text.Replace("'", "''") + "','" + tbx_Email.Text.Replace("'", "''") + "',";
                strQuery += "'" + tbx_ContactNo.Text.Replace("'", "''") + "','" + txtSubject.Text.Replace("'", "''") + "','" + txtComment.Text.Replace("'", "''") + "',";
                strQuery += "'" + DAL.GetDateWithFormat() + "','" + DAL.getIP() + "'," + total + ",'Pending');" + Environment.NewLine;
                strQuery += "SELECT LAST_INSERT_ID();";
                string max = (new DAL()).ExecuteScalar(strQuery, CommandType.Text, null);
                strQuery = "";
               
                foreach (RepeaterItem dli in repcart.Items)
                {
                    double perweek = 0;
                    int loop = Convert.ToInt32(((HiddenField)(dli.FindControl("hdnLoopId"))).Value);
                    DataRow dr = Cart.Rows.Find(loop);
                    if (dr["perweek"].ToString() != "")
                        perweek = double.Parse(dr["perweek"].ToString());
                    strQuery += "insert into orderitems(orderid,OrderNumber,Name,pid,productcode,Image,price,perweek,qty,Total,deal) values(";
                    strQuery += "" + max + ",'" + ViewState["orderid"].ToString()+ "','" + dr["name"].ToString().Replace("'", "''") + "','" + dr["id"].ToString() + "','" + dr["code"].ToString() + "',";
                    strQuery += "'" + dr["Image"].ToString() + "','" + dr["sellprice"].ToString() + "'," + perweek + ",0,'" + dr["sellprice"].ToString() + "'," + dr["deal"].ToString() + ");" + Environment.NewLine;
                    cart += " <tr >";
                    cart += "<td style='border-bottom:1px solid #ccc;padding:10px 0;'><img width='100' style='height: 100px' class='img-responsive' src= '" + ConfigurationManager.AppSettings["siteurl"].ToString() + "/webfiles/product/medium/" + dr["Image"].ToString() + "'></td>";
                    cart += "<td style='max-width:200px; padding:10px;border-bottom:1px solid #ccc;padding:10px 0;'><span style='font-size:12px;'>Product Code: " + dr["code"].ToString() + "</span><br />" + (dr["name"].ToString().Length > 50 ? dr["name"].ToString().Substring(0, 47) + "..." : dr["name"].ToString()) + dr["deal"].ToString().Replace("1", " (Deal)").Replace("0", "") + "</td>";
                    cart += "<td style='padding:10px;text-align: right;border-bottom:1px solid #ccc;padding:10px 0;'>$" + double.Parse(dr["perweek"].ToString()).ToString("0.00") + "</td>";
                    cart += "<td style='padding:10px;text-align: right;border-bottom:1px solid #ccc;padding:10px 0;'>$" + double.Parse(dr["sellprice"].ToString()).ToString("0.00") + "";
                    cart+="</td>";
                    cart += "</tr>";
                }
                (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
                Session["Cart"] = null;
                #region Send Email
                string StrMailBody = "";
                StrMailBody = new DAL().GetMailTemplates("mailtemplates\\contactus.htm");
                StrMailBody = StrMailBody.Replace("_LOGOURL_", ConfigurationManager.AppSettings["siteurl"].ToString() + ConfigurationManager.AppSettings["logo"].ToString());
                StrMailBody = StrMailBody.Replace("_Name_", tbx_Name.Text);
                StrMailBody = StrMailBody.Replace("_Cart_", cart);
                StrMailBody = StrMailBody.Replace("_totPerweek_", Convert.ToDouble(totPerweek.ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN")));
                StrMailBody = StrMailBody.Replace("_total_", Convert.ToDouble(total.ToString()).ToString("N", new System.Globalization.CultureInfo("hi-IN")));
                StrMailBody = StrMailBody.Replace("_Sitename_", ConfigurationManager.AppSettings["Sitename"].ToString());
                StrMailBody = StrMailBody.Replace("_Phone_", tbx_ContactNo.Text);
                StrMailBody = StrMailBody.Replace("_Email_", tbx_Email.Text);
                StrMailBody = StrMailBody.Replace("_Subject_", txtSubject.Text);
                StrMailBody = StrMailBody.Replace("_Message_", txtComment.Text);
                #endregion
                new DAL().MailToSendSite("", "Product Enquiry from " + ConfigurationManager.AppSettings["sitename"].ToString(), tbx_Email.Text, StrMailBody, null, null, tbx_Name.Text);
                Response.Redirect("thank-you.aspx");
            }
            
        }
        else
        {

            tbx_ContactSecure.Text = "";
           // ImageVarification.setImage1(imgCaptcha, hfVerification);
            lbl_Error.Text = "<div class='text-center contact-to-content' style='color:red;'>Please Enter valid security code.</div>";
            return;
        }
    }
    protected string Generating_Code()
    {
        int vcode = 0;
        string strQuery = "Select max(id) as mxid from ordermaster";
        string max = new DAL().ExecuteScalar(strQuery, CommandType.Text, null);
        if (max != null && max != "") vcode = int.Parse(max);
        vcode = vcode + 1;
        string code = "OD" + DateTime.Now.ToString("ddMMyyhhss") + vcode;
        return code;
    }
}