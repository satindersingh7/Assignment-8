using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;

public partial class Poweradmin_Newsletter_import_subscriber : System.Web.UI.Page
{
    string strQuery, msg;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack) fill_Group();

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
                        if (DAL.isEmail(dr[1].ToString().Trim()) == true)
                        {
                            string tot = new DAL().ExecuteScalar("select count(*) from newslettersubscriber where Email='" + dr[1].ToString().Trim().Replace("'", "''") + "' and groupid=" + ddl_Group.SelectedValue.ToString(), CommandType.Text, null);
                            if (tot != "0")
                                exists++;
                            else
                            {
                                strQuery = "insert into NewsletterSubscriber(Visible,groupid,Name,Email,AddedDate,AddedIp) values('1','" + ddl_Group.SelectedValue.ToString() + "','" + dr[0].ToString().Trim().Replace("'", "''") + "','" + dr[1].ToString().Trim().Replace("'", "''") + "','" + DAL.GetDateWithFormat() + "','" + DAL.getIP() + "')";
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
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('" + Added + " Subsciber added successfully.');", true);
                }
                if (exists != 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('" + exists + "Subsciber already exists in this group.');", true);
                }
                if (Invalid != 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('" + Invalid + " invalid subsciber email id.');", true);
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

        }
        #endregion


    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewsubscriber.aspx");
    }

    protected void fill_Group()
    {
        string strQuery = "select * from newslettergroup order by Title asc";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            ddl_Group.DataSource = dt;
            ddl_Group.DataTextField = "Title";
            ddl_Group.DataValueField = "id";
            ddl_Group.DataBind();
        }
        ddl_Group.Items.Insert(0, new ListItem("Select", ""));
    }
}