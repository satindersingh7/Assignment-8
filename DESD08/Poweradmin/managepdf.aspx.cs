using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Configuration;

public partial class Poweradmin_termsandconditions : System.Web.UI.Page
{
    int findex, lindex;
    public static int pageindex = 0, Pagesize = 25;
    string strQuery, TableName = "termsandconfition", MessageNm = "PDF";
    PagedDataSource pgsource = new PagedDataSource();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            fill_Data();
            if (Request.QueryString["msg"] != null && Request.QueryString["msg"].ToString() != "")
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('" + Request.QueryString["msg"].ToString() + "');", true);
        }
    }

    #region Change This Part Only

    protected void fill_Data()
    {

        string strQuery = "select * from " + TableName + " where id<>0 ";
        strQuery += " order by addeddate desc";

        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        #region Bind Data




        if (dt != null && dt.Rows.Count > 0)
        {
            ltr_Total.Text = dt.Rows.Count.ToString();
            pgsource.DataSource = dt.DefaultView;
            pgsource.AllowPaging = true;
            pgsource.PageSize = Pagesize;
            pgsource.CurrentPageIndex = CurrentPage;
            ViewState["totpage"] = pgsource.PageCount;
            lnkPrevious.Enabled = !pgsource.IsFirstPage;
            lnkNext.Enabled = !pgsource.IsLastPage;
            rep.DataSource = pgsource;
            rep.DataBind();
            tbx_PageNumber.Text = (CurrentPage + 1).ToString();
            ltr_Start.Text = ((CurrentPage * Pagesize) + 1).ToString();
            ltr_End.Text = ((CurrentPage + 1) * Pagesize).ToString();
            if (((CurrentPage + 1) * Pagesize) > dt.Rows.Count)
                ltr_End.Text = dt.Rows.Count.ToString();

            if (dt.Rows.Count > Pagesize)
            {
                div_Paging.Visible = true;

            }
            else
                div_Paging.Visible = false;

            pnl_Record.Visible = true;
            div_msg.Visible = false;

        }
        else
        {
            pnl_Record.Visible = false;
            div_msg.Visible = true;
            ltr_msg.Text = MessageNm + " record does not exists.";
        }
        #endregion
    }

    protected void Hide_Show(int status)
    {
        #region//this block will set visibility status to show for the selected grid view records
        string VisId = "0";
        foreach (RepeaterItem Ri in rep.Items)
        {
            CheckBox CkbSelect = (CheckBox)Ri.FindControl("checkboxDelete");//this will find the check box control 'checkboxDelete'
            HiddenField hfNewsId = (HiddenField)Ri.FindControl("hfNewsId");//this will find the hidden control 'hfNewsId'
            if (CkbSelect != null && hfNewsId != null && CkbSelect.Checked == true && hfNewsId.Value != "")
                VisId += "," + hfNewsId.Value.Trim();
        }

        if (VisId == "0")
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please select atleast one record.');", true);
            return;
        }

        #region //Hidden
        string strQuery = "update " + TableName + " set Visible=" + status + " where ID in (" + VisId + ")";
        new DAL().ExecuteNonQuery(strQuery, CommandType.Text, null);

        if (status == 0)
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('Selected " + MessageNm + " record has been successfully set to hidden.');", true);
        else
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('Selected " + MessageNm + " record has been successfully set to visible.');", true);

        #endregion

        #endregion
    }

    protected bool Delete_Data(string id)
    {
        try
        {

            string FileName = new DAL().ExecuteScalar("select filename from " + TableName + " where id=" + id, CommandType.Text, null);

            strQuery = "Delete from " + TableName + " where ID = " + id + "";
            new DAL().ExecuteNonQuery(strQuery, CommandType.Text, null);

            try
            {
                if (File.Exists(@"" + DAL.GetRootPath() + "\\webfiles\\TNC\\" + FileName.ToString()))
                    File.Delete(@"" + DAL.GetRootPath() + "\\webfiles\\TNC\\" + FileName.ToString());
            }
            catch (Exception ex)
            { }

            return true;
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            strQuery = "";
        }
    }

    protected void lbSearch_Click(object sender, EventArgs e)
    {
        CurrentPage = 0;
        fill_Data();
    }

    protected void lbReset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.RawUrl);
    }

    #endregion

    #region do not change

    protected void rep_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        #region//this block will fill the disply order drop down

        //if (e.Item.ItemType.ToString().ToLower() == "item" || e.Item.ItemType.ToString().ToLower() == "alternatingitem")
        //{
        //    DropDownList ddl = (DropDownList)e.Item.FindControl("ddlDisplayOrder");
        //    HiddenField hdnProId = (HiddenField)e.Item.FindControl("hfNewsId");
        //    HiddenField hdnDisId = (HiddenField)e.Item.FindControl("hdnDisId");
        //    FillingDisplyOrder(ddl, hdnProId.Value, hdnDisId, e.Item.ItemIndex + 1);
        //}
        #endregion
    }

    public void FillingDisplyOrder(DropDownList ddl, string val, HiddenField hdnDisId, int newId)
    {
        #region//function to fill the display order drop down

        if (ltr_Total.Text != null && ltr_Total.Text != "")
        {
            double totRecord = double.Parse(ltr_Total.Text);
            for (double i = 1; i <= totRecord; i++)
            {
                ListItem li = new ListItem(i.ToString(), i.ToString());
                if (hdnDisId != null)
                {
                    if (i.ToString() == hdnDisId.Value)
                    {
                        li.Selected = true;
                    }
                }
                ddl.Items.Add(li);
                li = null;
            }
        }
        #endregion

    }

    protected void rep_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName.ToString() == "Delete")
        {
            if (!Delete_Data(e.CommandArgument.ToString()))
                return;

            fill_Data();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('" + MessageNm + " Record has been successfully deleted.');", true);
        }
    }

    protected void lb_Action_Click(object sender, EventArgs e)
    {
        string cmd = ((Button)sender).CommandName.ToString();
        if (cmd == "active")
            this.Hide_Show(1);
        else if (cmd == "deactive")
            this.Hide_Show(0);
        else if (cmd == "delete")
            this.Deleted_Selected();

        fill_Data();
    }

    protected void tbx_Search_TextChanged(object sender, EventArgs e)
    {
        CurrentPage = 0;
        fill_Data();
    }

    protected void Deleted_Selected()
    {
        #region//this block will delete the selected grid view records
        bool flag = false;
        foreach (RepeaterItem Ri in rep.Items)
        {
            CheckBox CkbSelect = (CheckBox)Ri.FindControl("checkboxDelete");//this will find the check box control 'checkboxDelete'
            HiddenField hfNewsId = (HiddenField)Ri.FindControl("hfNewsId");//this will find the hidden control 'hfNewsId'
            if (CkbSelect != null && hfNewsId != null && CkbSelect.Checked == true && hfNewsId.Value != "")
            {
                flag = true;
                if (!Delete_Data(hfNewsId.Value))
                    return;
            }
        }

        if (flag)
        {
            fill_Data();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('Selected " + MessageNm + "record has been successfully deleted.');", true);
        }
        else
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Please select atleast one record.');", true);

        #endregion
    }

    #region Pagination

    private int CurrentPage
    {
        get
        {   //Check view state is null if null then return current index value as "0" else return specific page viewstate value
            if (ViewState["CurrentPage"] == null)
            {
                return 0;
            }
            else
            {
                return ((int)ViewState["CurrentPage"]);
            }
        }
        set
        {
            //Set View statevalue when page is changed through Paging "RepeaterPaging" DataList
            ViewState["CurrentPage"] = value;
        }
    }



    protected void lnkPrevious_Click(object sender, EventArgs e)
    {
        //If user click Previous Link button assign current index as -1 it reduce existing page index.
        CurrentPage -= 1;
        //refresh "Repeater1" Data
        fill_Data();
    }

    protected void lnkNext_Click(object sender, EventArgs e)
    {
        //If user click Next Link button assign current index as +1 it add one value to existing page index.
        CurrentPage += 1;

        //refresh "Repeater1" Data
        fill_Data();
    }

    protected void tbx_PageNumber_TextChanged(object sender, EventArgs e)
    {
        if (int.Parse(tbx_PageNumber.Text) > 0 && int.Parse(tbx_PageNumber.Text) <= int.Parse(ViewState["totpage"].ToString()))
            CurrentPage = int.Parse(tbx_PageNumber.Text) - 1;

        fill_Data();
    }


    #endregion

    #endregion




    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        if (fulp.HasFile)
        {
            FileInfo FILE = new FileInfo(fulp.FileName);
            if (fulp.PostedFile.ContentLength > (1048576 * int.Parse(ConfigurationManager.AppSettings["FileSize"].ToString())))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('pdf file size have exceeded the maximum size limit. Please upload file below " + ConfigurationManager.AppSettings["FileSize"].ToString() + " MB size.');", true);
                return;
            }
            if (FILE.Extension.ToLower() == ".pdf")
            {
                string filenm = "Product_" + DateTime.Now.ToString("dd_MMM_yyyy_HH_mm_ss") + "_" + fulp.FileName.ToString().Replace("&", "-").Replace(" ", "-");
                fulp.SaveAs(DAL.GetRootPath() + "\\webfiles\\TNC\\" + filenm);
                strQuery = "insert into termsandconfition (title,filename,addeddate,addedip) values('" + tbx_PDFTitle.Text.Replace("'", "''") + "','" + filenm.Replace("'", "''") + "','" + DAL.GetDateWithFormat() + "','" + DAL.getIP() + "')";
                new DAL().ExecuteNonQuery(strQuery, CommandType.Text, null);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('Document PDF has been added successfully.');", true);
                tbx_PDFTitle.Text = "";
                fill_Data();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Files with .pdf extensions are allowed only.');", true);
                return;
            }
        }
    }

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("dashboard.aspx?msg=PDF modification process has been cancelled successfully.");
    }


    protected void checkboxDelete_CheckedChanged(object sender, EventArgs e)
    {
        string strsort = "";
        CheckBox chk = (CheckBox)sender;

        RepeaterItem ri = (RepeaterItem)((CheckBox)sender).Parent;
        int rowIndex = ri.ItemIndex;
        HiddenField hfNewsId = (HiddenField)(rep.Items[rowIndex].FindControl("hfNewsId"));

        string id = hfNewsId.Value;
        try
        {

            if (chk.Checked)
            {
                strsort = "update " + TableName + " set active=0; update " + TableName + " set active=1 where id=" + id;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('Selected PDf file successfully set to active.');", true);
            }
            else
            {
                string maxid = new DAL().ExecuteScalar("select max(id) from " + TableName, CommandType.Text, null);
                strsort = "update " + TableName + " set active=0; update " + TableName + " set active=1 where id=" + maxid;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('Default recently added PDf file successfully set to active.');", true);
            }
            new DAL().ExecuteNonQuery(strsort, CommandType.Text, null);
        }
        catch (Exception ex)
        {
            throw ex;
        }

        fill_Data();
    }
}