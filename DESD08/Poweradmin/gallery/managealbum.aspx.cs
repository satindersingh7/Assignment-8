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

public partial class Poweradmin_Album_manageAlbum : System.Web.UI.Page
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
            #region Resize Image For Website

            //if (DAL.IsNumeric(Request.QueryString["id"]))
            //    filename = ViewState["img"].ToString();

            //if (FUplarge.HasFile)
            //{
            //    if (FUplarge.PostedFile.ContentLength > (1048576 * int.Parse(ConfigurationManager.AppSettings["ImageSize"].ToString())))
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Image size have exceeded the maximum size limit. Please upload large image below " + ConfigurationManager.AppSettings["ImageSize"].ToString() + " MB size.');", true);
            //        return;
            //    }
            //    Bitmap uploadedImage = new Bitmap(FUplarge.FileContent);

            //    //if (uploadedImage.Width >= Convert.ToInt16(ConfigurationManager.AppSettings["AlbumLargeWidth"].ToString()) && uploadedImage.Height >= Convert.ToInt16(ConfigurationManager.AppSettings["AlbumLargeHeight"].ToString()))
            //    //{

            //        filename = DateTime.Now.ToString("ddmmyyyyhhmmss") + FUplarge.FileName.ToString();
            //        filename = filename.Trim().Replace("(", "").Replace(")", "").Replace("[", "").Replace("]", "").Replace("#", "").Replace("$", "").Replace("%", "").Replace("@", "").Replace("&", "").Replace("'", "").Replace(" ", "");
            //        imageresize imgrez = new imageresize();

            //        int maxWidth = int.Parse(ConfigurationManager.AppSettings["AlbumLargeWidth"].ToString());
            //        int maxHeight = int.Parse(ConfigurationManager.AppSettings["AlbumLargeHeight"].ToString());
            //        imgrez.GetScaledPicture(uploadedImage, maxWidth, maxHeight, "photogallery", "album/large", filename);

            //        maxWidth = int.Parse(ConfigurationManager.AppSettings["AlbumSmallWidth"].ToString());
            //        maxHeight = int.Parse(ConfigurationManager.AppSettings["AlbumSmallHeight"].ToString());
            //        imgrez.GetScaledPicture(uploadedImage, maxWidth, maxHeight, "photogallery", "album/medium", filename);
            //    //}
            //    //else
            //    //{
            //    //    ltrmessageimage.Visible = true;
            //    //    ltrmessageimage.Text = "Album image width and height should greater than " + ConfigurationManager.AppSettings["AlbumLargeWidth"].ToString() + " and " + ConfigurationManager.AppSettings["AlbumLargeHeight"].ToString() + "";
            //    //    return;
            //    //}

            //}
            #endregion



            
            if (!DAL.IsNumeric(Request.QueryString["id"]))
            {
               
                #region ManageSortOrder
                int sortorder = 1;
                object maxnum = (new DAL()).ExecuteScalar("Select max(sortorder) from PhotoCategory ", CommandType.Text, null); // this query will fetch the maximum display order number from db
                if (maxnum != null && maxnum.ToString() != "")
                    sortorder = int.Parse(maxnum.ToString()) + 1;

                #endregion
                strQuery = "insert into PhotoCategory (Visible,Image,Title,AddedDate,AddedIp,sortorder) values(" + rbl_Visible.SelectedValue.ToString() + ",'" + filename.Replace("'", "''") + "','" + tbx_Title.Text.Replace("'", "''") + "','" + DAL.GetDateWithFormat() + "','" + DAL.getIP() + "'," + sortorder + ")";
                msg = "Album information has been added successfully.";
                (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);

            }
            else
            {
                strQuery = "update PhotoCategory set Visible=" + rbl_Visible.SelectedValue.ToString() + ",Image='" + filename.Replace("'", "''") + "',title='" + tbx_Title.Text.Replace("'", "''") + "',ModifyDate='" + DAL.GetDateWithFormat() + "',ModifyIp='" + DAL.getIP() + "' where id=" + Request.QueryString["id"].ToString();
                msg = "Album information has been modified successfully.";
                (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);

                #region Delete Image
                if (ViewState["img"] != null && ViewState["img"].ToString() != "" && filename != "" && ViewState["img"].ToString() != filename)
                {
                    try
                    {
                        if (File.Exists(DAL.GetRootPath() + "\\webfiles\\photocategory\\album\\large\\" + ViewState["img"].ToString()))
                            File.Delete(DAL.GetRootPath() + "\\webfiles\\photocategory\\album\\large\\" + ViewState["img"].ToString());

                        if (File.Exists(DAL.GetRootPath() + "\\webfiles\\photocategory\\album\\medium\\" + ViewState["img"].ToString()))
                            File.Delete(DAL.GetRootPath() + "\\webfiles\\photocategory\\album\\medium\\" + ViewState["img"].ToString());


                    }
                    catch (Exception ex)
                    {
                        // do nothing
                    }
                }
                #endregion
            }
            msg = "Album information has been modified successfully.";
            Response.Redirect("viewgallery.aspx?msg=" + msg);


        }
        catch (Exception ex)
        {
            Response.Write(ex.Message + "==" + ex.StackTrace);
        }

    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewgallery.aspx?msg=Album process has been cancelled successfully.");
    }
   
    protected void fill_Data()
    {
        rfv_File.Visible = false;

        try
        {
            strQuery = "select * from photocategory where id=" + Request.QueryString["id"].ToString();
            DataTable dt = new DataTable();
            dt = (new DAL()).GetDataTable(strQuery, CommandType.Text, null);
            
            if (dt != null && dt.Rows.Count > 0)
            {
                tbx_Title.Text = dt.Rows[0]["title"].ToString();
                rbl_Visible.SelectedValue = dt.Rows[0]["Visible"].ToString().Replace("True", "1").Replace("False", "0");
               
                img.Visible = true;
                img.Src = ConfigurationManager.AppSettings["siteurl"].ToString() + "/webfiles/photogallery/album/medium/" + dt.Rows[0]["Image"].ToString();
                ViewState["img"] = dt.Rows[0]["Image"].ToString();
                
                if (dt.Rows[0]["Image"].ToString() == "")
                {
                    img.Visible = false;
                }
            }
            else
                Response.Redirect("viewgallery.aspx");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}