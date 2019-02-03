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

public partial class Poweradmin_teaser_manageteaser : System.Web.UI.Page
{
    string strQuery, msg, filename = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (ddlposition.SelectedValue.ToString() == "1")
        {
            lblWidth.Text = ConfigurationManager.AppSettings["teaserSidewidth"].ToString();
            lblHeight.Text = ConfigurationManager.AppSettings["teaserSideHeight"].ToString();
        }
        else if (ddlposition.SelectedValue.ToString() == "2")
        {
            lblWidth.Text = ConfigurationManager.AppSettings["teaserMiddlewidth"].ToString();
            lblHeight.Text = ConfigurationManager.AppSettings["teaserMiddleHeight"].ToString();
        }
        else if (ddlposition.SelectedValue.ToString() == "3")
        {
            lblWidth.Text = ConfigurationManager.AppSettings["teaserBottomwidth"].ToString();
            lblHeight.Text = ConfigurationManager.AppSettings["teaserBottomHeight"].ToString();
        }
            if (DAL.IsNumeric(Request.QueryString["id"]) == true)
            {
                ltr_title.Text = "Edit";
                rfv_File.Visible = false;
                if (!this.IsPostBack)
                {

                    fill_Data();

                }
            }

    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        #region Resize Image For Website

        if (DAL.IsNumeric(Request.QueryString["id"]))
            filename = ViewState["img"].ToString();

      //  this.Form.Enctype = "multipart/form-data";
        if (FUplarge.HasFile)
        {
            if (FUplarge.PostedFile.ContentLength > (1048576 * int.Parse(ConfigurationManager.AppSettings["ImageSize"].ToString())))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('Image size have exceeded the maximum size limit. Please upload large image below " + ConfigurationManager.AppSettings["Gallerylimittext"].ToString() + " MB size.');", true);
                return;
            }
            Bitmap uploadedImage = new Bitmap(FUplarge.FileContent);


            filename = DateTime.Now.ToString("ddmmyyyyhhmmss") + FUplarge.FileName.ToString();
            filename = filename.Trim().Replace("(", "").Replace(")", "").Replace("[", "").Replace("]", "").Replace("#", "").Replace("$", "").Replace("%", "").Replace("@", "").Replace("&", "").Replace("'", "").Replace(" ", "");
            imageresize imgrez = new imageresize();
            if (ddlposition.SelectedValue.ToString() == "1")
            {
                if (uploadedImage.Width == int.Parse(ConfigurationManager.AppSettings["teaserSidewidth"].ToString()) && uploadedImage.Height == int.Parse(ConfigurationManager.AppSettings["teaserSideHeight"].ToString()))
                { //left teaser
                    int maxWidth = int.Parse(ConfigurationManager.AppSettings["teaserSidewidth"].ToString());
                    int maxHeight = int.Parse(ConfigurationManager.AppSettings["teaserSideHeight"].ToString());
                    imgrez.GetScaledPicture(uploadedImage, maxWidth, maxHeight, "teaser", "", filename);
                }
                else
                {
                    ltrmessageimage.Visible = true;
                    ltrmessageimage.Text = "Advertisement Banner image width and height should be " + ConfigurationManager.AppSettings["teaserSidewidth"].ToString() + "px and " + ConfigurationManager.AppSettings["teaserSideHeight"].ToString() + "px";
                    return;
                }
            }
            else if (ddlposition.SelectedValue.ToString() == "2")
            {
                if (uploadedImage.Width == int.Parse(ConfigurationManager.AppSettings["teaserMiddlewidth"].ToString()) && uploadedImage.Height == int.Parse(ConfigurationManager.AppSettings["teaserMiddleHeight"].ToString()))
                {  //Middle teaser
                    int maxWidth1 = int.Parse(ConfigurationManager.AppSettings["teaserMiddlewidth"].ToString());
                    int maxHeight1 = int.Parse(ConfigurationManager.AppSettings["teaserMiddleHeight"].ToString());
                    imgrez.GetScaledPicture(uploadedImage, maxWidth1, maxHeight1, "teaser", "", filename);
                }
                else
                {
                    ltrmessageimage.Visible = true;
                    ltrmessageimage.Text = "Advertisement Banner image width and height should be " + ConfigurationManager.AppSettings["teaserMiddlewidth"].ToString() + "px and " + ConfigurationManager.AppSettings["teaserMiddleHeight"].ToString() + "px";
                    return;
                }
            }

            else if (ddlposition.SelectedValue.ToString() == "3")
            {
                if (uploadedImage.Width == int.Parse(ConfigurationManager.AppSettings["teaserBottomwidth"].ToString()) && uploadedImage.Height == int.Parse(ConfigurationManager.AppSettings["teaserBottomHeight"].ToString()))
                {  //Right teaser
                    int maxWidth2 = int.Parse(ConfigurationManager.AppSettings["teaserBottomwidth"].ToString());
                    int maxHeight2 = int.Parse(ConfigurationManager.AppSettings["teaserBottomHeight"].ToString());
                    imgrez.GetScaledPicture(uploadedImage, maxWidth2, maxHeight2, "teaser", "", filename);
                }
                else
                {
                    ltrmessageimage.Visible = true;
                    ltrmessageimage.Text = "Advertisement Banner image width and height should be " + ConfigurationManager.AppSettings["teaserBottomwidth"].ToString() + "px and " + ConfigurationManager.AppSettings["teaserBottomHeight"].ToString() + "px";
                    return;
                }
            }



        }
        #endregion

        if (!DAL.IsNumeric(Request.QueryString["id"]))
        {

           
            strQuery = "insert into teaser(Visible,url,image,position,AddedDate,AddedIp) ";//stateid,cityid,
           
            strQuery += "values('" + rbl_Visible.SelectedValue.ToString() + "','" + txturl.Text.Replace("'", "''") + "','" + filename.Replace("'", "''") + "','" + ddlposition.SelectedValue.ToString() + "',";
            strQuery += "'" + DAL.GetDateWithFormat() + "','" + DAL.getIP() + "')";
            (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
            msg = "Teaser details has been added successully.";
            Response.Redirect("viewadvt.aspx?msg=" + msg);

        }
        else
        {

            strQuery = "update teaser set Visible='" + rbl_Visible.SelectedValue.ToString() + "',position='" + ddlposition.SelectedValue.ToString() + "',";
            strQuery += "Image='" + filename.Replace("'", "''") + "',url='" + txturl.Text.Replace("'", "''") + "',";
            strQuery += "ModifyDate='" + DAL.GetDateWithFormat() + "',ModifyIp='" + DAL.getIP() + "' where id=" + Request.QueryString["id"].ToString();
            (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
            msg = "Advertisement Banner details has been modified successfully.";
            #region Delete Image
            if (ViewState["img"] != null && ViewState["img"].ToString() != "" && filename != "" && ViewState["img"].ToString() != filename)
            {
                try
                {
                    if (File.Exists(DAL.GetRootPath() + "\\webfiles\\teaser\\" + ViewState["img"].ToString()))

                        File.Delete(DAL.GetRootPath() + "\\webfiles\\teaser\\" + ViewState["img"].ToString());


                }
                catch (Exception ex)
                {
                    // do nothing
                }
            }
            #endregion
        }

        Response.Redirect("viewadvt.aspx?msg=" + msg);
    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewadvt.aspx");
    }
    
    protected void fill_Data()
    {

        string strQuery = "select * from teaser where id=" + Request.QueryString["id"].ToString();
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {

            rbl_Visible.SelectedValue = dt.Rows[0]["Visible"].ToString().Replace("True", "1").Replace("False", "0");           
            ddlposition.SelectedValue = dt.Rows[0]["position"].ToString();
           
            if (ddlposition.SelectedValue.ToString() == "1")
            {
                lblWidth.Text = ConfigurationManager.AppSettings["teaserSidewidth"].ToString();
                lblHeight.Text = ConfigurationManager.AppSettings["teaserSideHeight"].ToString();
            }
            else if (ddlposition.SelectedValue.ToString() == "2")
            {
                lblWidth.Text = ConfigurationManager.AppSettings["teaserMiddlewidth"].ToString();
                lblHeight.Text = ConfigurationManager.AppSettings["teaserMiddleHeight"].ToString();
            }
            else if (ddlposition.SelectedValue.ToString() == "3")
            {
                lblWidth.Text = ConfigurationManager.AppSettings["teaserBottomwidth"].ToString();
                lblHeight.Text = ConfigurationManager.AppSettings["teaserBottomHeight"].ToString();
            }
            txturl.Text = dt.Rows[0]["url"].ToString();
            img.Visible = true;
            img.Src = ConfigurationManager.AppSettings["siteurl"].ToString() + "/webfiles/teaser/" + dt.Rows[0]["Image"].ToString();

            ViewState["img"] = dt.Rows[0]["Image"].ToString();
        }
    }


    protected void ddlposition_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlposition.SelectedValue.ToString() != "")
        {
            rfv_File.Visible = true;
            if (ddlposition.SelectedValue.ToString() == "1")
            {
                lblWidth.Text = ConfigurationManager.AppSettings["teaserSidewidth"].ToString();
                lblHeight.Text = ConfigurationManager.AppSettings["teaserSideHeight"].ToString();
            }
            else if (ddlposition.SelectedValue.ToString() == "2")
            {
                lblWidth.Text = ConfigurationManager.AppSettings["teaserMiddlewidth"].ToString();
                lblHeight.Text = ConfigurationManager.AppSettings["teaserMiddleHeight"].ToString();
            }
            else if (ddlposition.SelectedValue.ToString() == "3")
            {
                lblWidth.Text = ConfigurationManager.AppSettings["teaserBottomwidth"].ToString();
                lblHeight.Text = ConfigurationManager.AppSettings["teaserBottomHeight"].ToString();
            }
        }
    }
   
       
}