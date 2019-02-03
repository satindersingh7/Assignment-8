using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class email_settings : System.Web.UI.Page
{
    #region//general variables

    string strQuery = "", strQuery1 = "";
    DataTable dt;

    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            this.Mail_Authentication_Details();
        }


    }

    protected void Mail_Authentication_Details()
    {
        try
        {
            //this query will fetch the mail authenticaion details from db based on the id passed in query string

            strQuery = "select * from siteprofile";
            dt = new DataTable();
            dt = (new DAL()).GetDataTable(strQuery, CommandType.Text, null);
            if (dt != null && dt.Rows.Count > 0)
            {

                TBx_host.Text = dt.Rows[0]["mshost"].ToString();
                TBx_hostpassword.Attributes.Add("value", dt.Rows[0]["mspass"].ToString());
                TBx_musername.Text = dt.Rows[0]["msusername"].ToString();
                TBx_toemail.Text = dt.Rows[0]["contemail"].ToString();
                TBx_ccemail.Text = dt.Rows[0]["contccemail"].ToString();
                TBx_bccemail.Text = dt.Rows[0]["contbccemail"].ToString();


            }
            else
            {
                Response.Redirect("dashboard.aspx");
            }
        }
        catch (Exception ex)
        {
            //this will throw the exception

            throw ex;
        }
        finally
        {
            //this will free the resource

            strQuery = "";
            if (dt != null)
            {
                dt.Dispose();
            }
        }
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        #region//validations

        if (TBx_host.Text == "")
        {
            //div_Error.Visible = true;
            //ltr_Error.Text = "Please enter the host as it can't be left blank.";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please enter the host as it can't be left blank.');", true);
            return;
        }
        if (TBx_musername.Text == "")
        {
            //div_Error.Visible = true;
            //ltr_Error.Text = "Please enter the host username as it can't be left blank.";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please enter the host username as it can't be left blank.');", true);
            return;
        }
        if (TBx_hostpassword.Text == "")
        {
            //div_Error.Visible = true;
            //ltr_Error.Text = "Please enter the host password as it can't be left blank.";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please enter the host password as it can't be left blank.');", true);
            return;
        }
        if (TBx_toemail.Text == "")
        {
            //div_Error.Visible = true;
            //ltr_Error.Text = "Please enter the to email id as it can't be left blank.";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please enter the to email id as it can't be left blank.');", true);
            return;
        }
        if (DAL.isEmail(TBx_toemail.Text) == false)
        {
            //div_Error.Visible = true;
            //ltr_Error.Text = "Please enter the valid to email id.";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please enter the valid to email id.');", true);
            return;
        }
        if (TBx_ccemail.Text != "")
        {
            if (DAL.isEmail(TBx_ccemail.Text) == false)
            {
                //div_Error.Visible = true;
                //ltr_Error.Text = "Please enter the valid cc email id.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please enter the valid cc email id.');", true);
                return;
            }
        }
        if (TBx_bccemail.Text != "")
        {
            if (DAL.isEmail(TBx_bccemail.Text) == false)
            {
                //div_Error.Visible = true;
                //ltr_Error.Text = "Please enter the valid bcc email id.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please enter the valid bcc email id.');", true);
                return;
            }
        }
        #endregion

        #region//saving record in db

        try //this portion will try to execute the process
        {


            #region//query to modify record into db

            strQuery = "update siteprofile set mshost='" + TBx_host.Text.Replace("'", "''") + "',";
            strQuery = strQuery + "msusername='" + TBx_musername.Text.Replace("'", "''") + "',";
            strQuery = strQuery + "mspass='" + TBx_hostpassword.Text.Replace("'", "''") + "',";
            strQuery = strQuery + "contemail='" + TBx_toemail.Text.Replace("'", "''") + "',";
            strQuery = strQuery + "contccemail='" + TBx_ccemail.Text.Replace("'", "''") + "',";
            strQuery = strQuery + "contbccemail='" + TBx_bccemail.Text.Replace("'", "''") + "'";
            strQuery = strQuery += ",modifyip='" + DAL.getIP() + "',modifydate='" + DAL.GetDateWithFormat() + "'";
            #endregion

            #region//this block will execute the query and after redirect to faq category listing page after successfull execution

            (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);

            Response.Redirect("dashboard.aspx?msg=The mail authentication details has been successfully modified.");

            #endregion

        }
        catch (Exception ex) //this portion will throw the exception / error
        {
            //div_Error.Visible = true;
            //ltr_Error.Text = "Error : " + ex.Message;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Error : " + ex.Message+"');", true);
            throw ex;
        }
        finally // this portion will clear the various parameters used in try block
        {
            strQuery = "";



        }

        #endregion
    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("dashboard.aspx?msg=Mail authentication modification process has been cancelled.");
    }
}