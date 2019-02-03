using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Drawing;
using System.IO;

public partial class Poweradmin_Category_manageCategory : System.Web.UI.Page
{
    string strQuery, msg, filename = "", filenamemobile = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (DAL.IsNumeric(Request.QueryString["id"]) == true)
        {
            ltr_title.Text = "Edit";
            if (!this.IsPostBack)
            {
                fill_Data();
            }
        }

    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        try
        {
            



            
            if (!DAL.IsNumeric(Request.QueryString["id"]))
            {
               
                #region ManageSortOrder
                int sortorder = 1;
                object maxnum = (new DAL()).ExecuteScalar("Select max(sortorder) from ProductCategory ", CommandType.Text, null); // this query will fetch the maximum display order number from db
                if (maxnum != null && maxnum.ToString() != "")
                    sortorder = int.Parse(maxnum.ToString()) + 1;

                #endregion
                strQuery = "insert into ProductCategory (Visible,Title,AddedDate,AddedIp,sortorder) values(" + rbl_Visible.SelectedValue.ToString() + ",'" + tbx_Title.Text.Replace("'", "''") + "','" + DAL.GetDateWithFormat() + "','" + DAL.getIP() + "'," + sortorder + ")";
                msg = "Product Category information has been added successfully.";
                (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);

            }
            else
            {
                strQuery = "update ProductCategory set Visible=" + rbl_Visible.SelectedValue.ToString() + ",Image='" + filename.Replace("'", "''") + "',title='" + tbx_Title.Text.Replace("'", "''") + "',ModifyDate='" + DAL.GetDateWithFormat() + "',ModifyIp='" + DAL.getIP() + "' where id=" + Request.QueryString["id"].ToString();
                msg = "Product Category information has been modified successfully.";
                (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);

                
            }
            msg = "Product Category information has been modified successfully.";
            Response.Redirect("viewCategory.aspx?msg=" + msg);


        }
        catch (Exception ex)
        {
            Response.Write(ex.Message + "==" + ex.StackTrace);
        }

    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewCategory.aspx?msg=Product Category process has been cancelled successfully.");
    }
   
    protected void fill_Data()
    {

        try
        {
            strQuery = "select * from ProductCategory where id=" + Request.QueryString["id"].ToString();
            DataTable dt = new DataTable();
            dt = (new DAL()).GetDataTable(strQuery, CommandType.Text, null);
            
            if (dt != null && dt.Rows.Count > 0)
            {
                tbx_Title.Text = dt.Rows[0]["title"].ToString();
                rbl_Visible.SelectedValue = dt.Rows[0]["Visible"].ToString().Replace("True", "1").Replace("False", "0");
               
               
            }
            else
                Response.Redirect("viewCategory.aspx");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}