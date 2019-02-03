using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;

public partial class Poweradmin_product_import_product : System.Web.UI.Page
{
    string strQuery, msg;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack) fill_category();

    }
    protected void fill_category()
    {
        string strQuery = "select * from productcategory order by sortorder ";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            ddl_Category.DataSource = dt;
            ddl_Category.DataTextField = "Title";
            ddl_Category.DataValueField = "id";
            ddl_Category.DataBind();
        }
        ddl_Category.Items.Insert(0, new ListItem("Select Category", ""));
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {

        #region Check Excel File Format
        if (fulp.HasFile == false)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please select Excel file to upload.');", true);
            return;
        }
        else
        {
            string strExtn = System.IO.Path.GetExtension(fulp.FileName).ToLower();
            if (strExtn != ".xls")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please upload file with .xls extension.');", true);
                return;
            }
        }
        #endregion

        #region Save File & Record
        string filenm = DateTime.Now.ToString("ddMMyyhhmmss") + fulp.FileName;
        fulp.SaveAs(Request.PhysicalApplicationPath.ToString() + "webfiles\\" + filenm);
        OleDbConnection xlsConn;
        OleDbDataAdapter adap;
        string connString = "Provider=Microsoft.Jet.OleDb.4.0;" + "data source=" + Request.PhysicalApplicationPath.ToString() + "webfiles\\" + filenm + ";Extended Properties=Excel 8.0;";
        xlsConn = new OleDbConnection(connString);
        if (xlsConn.State == ConnectionState.Open)
            xlsConn.Close();
        xlsConn.Open();

        DataTable dt = new DataTable();
        adap = new OleDbDataAdapter("select * from [sheet1$]", xlsConn);
        adap.Fill(dt);

        int exists = 0, Invalid = 0, Added = 0;
        try
        {
            if (dt != null && dt.Rows.Count > 0)
            {
                #region Check and insert data
                foreach (DataRow dr in dt.Rows)
                {
                    if (dr[1].ToString().Trim() != "")
                    {
                        if (DAL.IsNumeric(dr[3].ToString().Trim()) == true || DAL.IsNumeric(dr[4].ToString().Trim()) == true)
                        {
                            string tot = new DAL().ExecuteScalar("select count(*) from product where productcode='" + dr[0].ToString().Trim().Replace("'", "''") + "'", CommandType.Text, null);
                            if (tot != "0")
                                exists++;
                            else
                            {
                                #region ManageSortOrder
                                int sortorder = 1;
                                string maxnum = (new DAL()).ExecuteScalar("Select max(sortorder) from Product where catid=" + ddl_Category.SelectedValue.ToString() + "", CommandType.Text, null); // this query will fetch the maximum display order number from db
                                if (maxnum != null && maxnum != "")
                                    sortorder = int.Parse(maxnum.ToString()) + 1;
                                #endregion
                                strQuery = "insert into product(Visible,outofstock,featured,Title,productcode,catid,image,costprice,sellprice,description,Perweek,sortorder,AddedDate,AddedIp) values(";
                                strQuery += "'0','0','0','" + dr[1].ToString().Trim().Replace("'", "''") + "','" + dr[0].ToString().Trim().Replace("'", "''") + "','" + ddl_Category.SelectedValue.ToString() + "',";
                                strQuery += "'',";
                                strQuery += "'" + dr[3].ToString().Trim().Replace("'", "''") + "','" + dr[3].ToString().Trim().Replace("'", "''") + "','" + dr[2].ToString().Trim().Replace("'", "''") + "','" + dr[4].ToString().Trim().Replace("'", "''") + "',";
                                strQuery += ""+sortorder+",'" + DAL.GetDateWithFormat() + "','" + DAL.getIP() + "')";
                                (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
                                Added++;
                            }
                        }
                        else
                            Invalid++;
                    }
                }
                #endregion
                if (Added != 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('" + Added + " Product added successfully.');", true);
                }
                if (exists != 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('" + exists + " product already exists.');", true);
                }
                if (Invalid != 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('" + Invalid + " invalid Price.');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('No Record exists in excel file. please enter at least one record in excel file.');", true);
            }

            xlsConn.Close();
            xlsConn.Dispose();
            xlsConn = null;

            if (System.IO.File.Exists(Request.PhysicalApplicationPath.ToString() + "webfiles\\" + filenm))
                System.IO.File.Delete(Request.PhysicalApplicationPath.ToString() + "webfiles\\" + filenm);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        #endregion


    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewproduct.aspx");
    }

}