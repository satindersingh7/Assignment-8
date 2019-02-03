using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class changepassword123 : System.Web.UI.Page
{
    string strQuery;
    DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            this.Profile_Details();

        }
    }

    protected void Profile_Details()
    {
        try
        {
            //this query will fetch the profile details from db based on the id passed in query string

            if (Session["uid"] == null || Session["uid"].ToString() == "")
            {
                Response.Redirect("default.aspx");
            }

            strQuery = "select * from admin where id=" + Session["uid"].ToString();
            dt = new DataTable();
            dt = (new DAL()).GetDataTable(strQuery, CommandType.Text, null);
            if (dt != null && dt.Rows.Count > 0)
            {
                TBx_email.Text = dt.Rows[0]["Email"].ToString();
                Tbx_username.Text = dt.Rows[0]["unm"].ToString();
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

    protected Boolean Password_checking()
    {
        Boolean fcheck = false;

        try
        {
            //this query will fetch the profile details from db based on the id passed in query string

            string strQuery1 = "select * from admin where id=" + Session["uid"].ToString() + " and pwd='" + TBx_oldpassword.Text + "'";
            dt = new DataTable();
            dt = (new DAL()).GetDataTable(strQuery1, CommandType.Text, null);
            if (dt != null && dt.Rows.Count > 0)
                fcheck = true;
        }
        catch (Exception ex)
        {
            //this will throw the exception
            throw ex;
        }
        finally
        {
            //this will free the resource
            if (dt != null)
            {
                dt.Dispose();
            }
        }
        return fcheck;
    }

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("dashboard.aspx?msg=Profile modification process has been cancelled.");
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        #region//blank field validations


        if (Tbx_username.Text == "")
        {
            //div_Error.Visible = true;
            //ltr_Error.Text = "Please enter the username as it can't be left blank.";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please enter the username as it can't be left blank.');", true);
            return;
        }
        if (TBx_email.Text == "")
        {
            //div_Error.Visible = true;
            //ltr_Error.Text = "Please enter the email id as it can't be left blank.";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please enter the email id as it can't be left blank.');", true);
            return;
        }
        if (TBx_oldpassword.Text != "")
        {
            if (TBx_password.Text == "")
            {
                //div_Error.Visible = true;
                //ltr_Error.Text = "Please enter the new password as it can't be left blank.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please enter the new password as it can't be left blank.');", true);
                return;
            }
            if (TBx_password.Text.Length < 5)
            {
                //div_Error.Visible = true;
                //ltr_Error.Text = "Please enter the new password with minimum 5 characters.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please enter the new password with minimum 5 characters.');", true);
                return;
            }
        }

        if (TBx_password.Text != "")
        {
            if (TBx_oldpassword.Text == "")
            {
                //div_Error.Visible = true;
                //ltr_Error.Text = "Please enter the old password as it can't be left blank.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please enter the old password as it can't be left blank.');", true);
                return;
            }
        }

        if (TBx_oldpassword.Text != "" && TBx_password.Text != "")
        {

            if (this.Password_checking() == false)
            {
                //div_Error.Visible = true;
                //ltr_Error.Text = "Old password does not match with our records. Please enter the correct old password.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error(Old password does not match with our records. Please enter the correct old password.');", true);
                return;
            }
        }


        #endregion

        #region//saving record in db

        try //this portion will try to execute the process
        {

            #region//query to modify record into db

            strQuery = "update admin set unm='" + Tbx_username.Text.Replace("'", "''") + "',Email='" + TBx_email.Text.Replace("'", "''") + "'";

            if (TBx_oldpassword.Text != "" && TBx_password.Text != "")
            {
                if (this.Password_checking() == true)
                {
                    strQuery = strQuery + ", pwd='" + TBx_password.Text.Replace("'", "''") + "'";
                }
            }

            strQuery = strQuery + " where id=" + Session["uid"].ToString();

            #endregion

            #region//this block will execute the query and after redirect to faq category listing page after successfull execution

            (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
            Session.Clear();
            Session.Abandon();
            Response.Redirect("default.aspx?msg=The profile details has been successfully modified.");

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

}