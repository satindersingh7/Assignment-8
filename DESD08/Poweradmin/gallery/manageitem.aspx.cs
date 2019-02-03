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

public partial class Poweradmin_Gallery_managePhoto : System.Web.UI.Page
{
    string strQuery, msg, filename = "", filenamemobile = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack) { ImageContent.Visible = true; fill_Category(); }
        if (DAL.IsNumeric(Request.QueryString["id"]) == true)
        {
            rfv_File.Enabled = false;
            ltr_title.Text = "Edit";
            if (!this.IsPostBack)
            {
                
                fill_Data();

            }
        }

    }
    
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        int sortorder = 1;
        try
        {
            #region Resize Image For Website

            if (DAL.IsNumeric(Request.QueryString["id"]))
                filename = ViewState["img"].ToString();

            if (FUplarge.HasFile)
            {
                if (FUplarge.PostedFile.ContentLength > (1048576 * int.Parse(ConfigurationManager.AppSettings["ImageSize"].ToString())))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Image size have exceeded the maximum size limit. Please upload large image below " + ConfigurationManager.AppSettings["Gallerylimittext"].ToString() + " MB size.');", true);
                    return;
                }
                Bitmap uploadedImage = new Bitmap(FUplarge.FileContent);

                if (uploadedImage.Width >= Convert.ToInt16(ConfigurationManager.AppSettings["PhotosmallWidth"].ToString()) && uploadedImage.Height >= Convert.ToInt16(ConfigurationManager.AppSettings["PhotosmallHeight"].ToString()))
                {

                    filename = DateTime.Now.ToString("ddmmyyyyhhmmss") + FUplarge.FileName.ToString();
                    filename = filename.Trim().Replace("(", "").Replace(")", "").Replace("[", "").Replace("]", "").Replace("#", "").Replace("$", "").Replace("%", "").Replace("@", "").Replace("&", "").Replace("'", "").Replace(" ", "");
                    imageresize imgrez = new imageresize();
                    int maxWidth = int.Parse(ConfigurationManager.AppSettings["PhotoLargeWidth"].ToString());
                    int maxHeight = int.Parse(ConfigurationManager.AppSettings["PhotoLargeHeight"].ToString());
                    imgrez.GetScaledPicture(uploadedImage, maxWidth, maxHeight, "photogallery", "large", filename);

                    maxWidth = int.Parse(ConfigurationManager.AppSettings["PhotosmallWidth"].ToString());
                    maxHeight = int.Parse(ConfigurationManager.AppSettings["PhotosmallHeight"].ToString());
                    imgrez.GetScaledPicture(uploadedImage, maxWidth, maxHeight, "photogallery", "medium", filename);
                }
                else
                {
                    ltrmessageimage.Visible = true;
                    ltrmessageimage.Text = "Photo image width and height should greater than " + ConfigurationManager.AppSettings["PhotosmallWidth"].ToString() + " and " + ConfigurationManager.AppSettings["PhotosmallHeight"].ToString() + "";
                    return;
                }

            }
            #endregion




            if (!DAL.IsNumeric(Request.QueryString["id"]))
            {

                #region ManageSortOrder
                
                object maxnum = (new DAL()).ExecuteScalar("Select max(sortorder) from PhotoGallery where catid= "+ddl_Category.SelectedValue, CommandType.Text, null); // this query will fetch the maximum display order number from db
                if (maxnum != null && maxnum.ToString() != "")
                    sortorder = int.Parse(maxnum.ToString()) + 1;

                #endregion

                strQuery = "insert into PhotoGallery(Catid,Visible,Image,Title,AddedDate,AddedIp,sortorder,contenttype) values(" + ddl_Category.SelectedValue.ToString() + "," + rbl_Visible.SelectedValue.ToString() + ",'" + filename.Replace("'", "''") + "','" + tbx_Title.Text.Replace("'", "''") + "','" + DAL.GetDateWithFormat() + "','" + DAL.getIP() + "'," + sortorder + ",1)";
                msg = "Photo information has been added successfully.";
                (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);

            }
            else
            {
                strQuery = "update PhotoGallery set Catid='" + ddl_Category.SelectedValue.ToString() + "',Visible=" + rbl_Visible.SelectedValue.ToString() + ",Image='" + filename.Replace("'", "''") + "',title='" + tbx_Title.Text.Replace("'", "''") + "',ModifyDate='" + DAL.GetDateWithFormat() + "',ModifyIp='" + DAL.getIP() + "' where id=" + Request.QueryString["id"].ToString();
                msg = "Photo information has been modified successfully.";
                (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
                #region check category sort order
                if (ViewState["catid"] != null && ViewState["catid"].ToString() != ddl_Category.SelectedValue.ToString())
                {
                    strQuery = "update PhotoGallery set sortorder=sortorder-1 where Catid=" + ViewState["catid"].ToString() + " and sortorder>" + ViewState["sortorder"].ToString();
                    new DAL().ExecuteNonQuery(strQuery, CommandType.Text, null);

                    string maxnum = (new DAL()).ExecuteScalar("Select max(sortorder) from PhotoGallery where Catid=" + ddl_Category.SelectedValue.ToString() + " and id<>" + Request.QueryString["id"].ToString(), CommandType.Text, null); // this query will fetch the maximum display order number from db
                    if (maxnum != null && maxnum != "")
                        sortorder = int.Parse(maxnum.ToString()) + 1;

                    strQuery = "update PhotoGallery set sortorder=" + sortorder + " where id=" + Request.QueryString["id"].ToString();
                    new DAL().ExecuteNonQuery(strQuery, CommandType.Text, null);
                }
                #endregion
                #region Delete Image
                if (ViewState["img"] != null && ViewState["img"].ToString() != "" && filename != "" && ViewState["img"].ToString() != filename)
                {
                    try
                    {
                        if (File.Exists(DAL.GetRootPath() + "\\webfiles\\photogallery\\large\\" + ViewState["img"].ToString()))
                            File.Delete(DAL.GetRootPath() + "\\webfiles\\photogallery\\large\\" + ViewState["img"].ToString());

                        if (File.Exists(DAL.GetRootPath() + "\\webfiles\\photogallery\\medium\\" + ViewState["img"].ToString()))
                            File.Delete(DAL.GetRootPath() + "\\webfiles\\photogallery\\medium\\" + ViewState["img"].ToString());


                    }
                    catch (Exception ex)
                    {
                        // do nothing
                    }
                }
                #endregion
            }
            msg = "Photo information has been modified successfully.";
            Response.Redirect("viewgallery.aspx?msg=" + msg+"&tab=2");


        }
        catch (Exception ex)
        {
            Response.Write(ex.Message + "==" + ex.StackTrace);
        }

    }

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewgallery.aspx?msg=Photo process has been cancelled successfully.&tab=2");
    }
   
    protected void fill_Data()
    {
        rfv_File.Visible = false;

        try
        {
            strQuery = "select * from PhotoGallery where id=" + Request.QueryString["id"].ToString();
            DataTable dt = new DataTable();
            dt = (new DAL()).GetDataTable(strQuery, CommandType.Text, null);
            
            if (dt != null && dt.Rows.Count > 0)
            {
                ddl_Category.SelectedValue = dt.Rows[0]["catid"].ToString();
                tbx_Title.Text = dt.Rows[0]["Title"].ToString();
                rbl_Visible.SelectedValue = dt.Rows[0]["Visible"].ToString().Replace("True", "1").Replace("False", "0");
                //rbl_Content.SelectedValue = dt.Rows[0]["contenttype"].ToString();
                //rbl_Content.Enabled = false;
                ViewState["img"] = dt.Rows[0]["Image"].ToString();
                ViewState["catid"] = dt.Rows[0]["catid"].ToString();
                ViewState["sortorder"] = dt.Rows[0]["sortorder"].ToString();
                

                if (dt.Rows[0]["contenttype"].ToString().ToLower() == "true" || dt.Rows[0]["contenttype"].ToString().ToLower() == "1")
                {
                    img.Visible = ImageContent.Visible = true;
                    img.Src = ConfigurationManager.AppSettings["siteurl"].ToString() + "/webfiles/photogallery/medium/" + dt.Rows[0]["Image"].ToString();
                    ImageContent.Visible = true;
                    rfv_File.Visible = true;
                   
                }
              
                
            }
            else
                Response.Redirect("viewgallery.aspx?tab=2");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void fill_Category()
    {
        string strQuery = "select * from photocategory order by Title asc";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            ddl_Category.DataSource = dt;
            ddl_Category.DataTextField = "Title";
            ddl_Category.DataValueField = "id";
            ddl_Category.DataBind();
        }
        ddl_Category.Items.Insert(0, new ListItem("Select", ""));
    }
    
}