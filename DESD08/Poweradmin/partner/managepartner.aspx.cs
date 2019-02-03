using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Drawing;
using System.Text;
using System.Security.Cryptography;
using System.IO;

public partial class Poweradmin_Partner_managePartner : System.Web.UI.Page
{
    string strQuery, msg;
    string WorkingDirectory = DAL.GetRootPath() + "webfiles\\";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (DAL.IsNumeric(Request.QueryString["id"]) == true)
        {
            ltr_title.Text = "Edit";
            RequiredFieldValidator1.Visible = false;
            if (!this.IsPostBack)
            {
                fill_Data();
            }
        }

    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        string filename = "", filenameresource = "";
        #region Resize Image

        if (fulp.HasFile)
        {
            if (fulp.PostedFile.ContentLength > (1048576 * int.Parse(ConfigurationManager.AppSettings["ImageSize"].ToString())))
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Image size have exceeded the maximum size limit. Please upload image below " + ConfigurationManager.AppSettings["ImageSize"].ToString() + " MB size.');", true);

                return;
            }

            Bitmap uploadedImage = new Bitmap(fulp.FileContent);

            if (uploadedImage.Width >= Convert.ToInt16(ConfigurationManager.AppSettings["PartnerImgWidth"].ToString()) && uploadedImage.Height >= Convert.ToInt16(ConfigurationManager.AppSettings["PartnerImgHeight"].ToString()))
            {

                filename = DateTime.Now.ToString("ddmmyyyyhhmmss") + fulp.FileName.ToString();
                filename = filename.Trim().Replace("(", "").Replace(")", "").Replace("[", "").Replace("]", "").Replace("#", "").Replace("$", "").Replace("%", "").Replace("@", "").Replace("&", "").Replace("'", "").Replace(" ", "");
                imageresize imgrez = new imageresize();
                int maxWidth = int.Parse(ConfigurationManager.AppSettings["PartnerImgWidth"].ToString());
                int maxHeight = int.Parse(ConfigurationManager.AppSettings["PartnerImgHeight"].ToString());

                imgrez.GetScaledPicture(uploadedImage, maxWidth, maxHeight, "Partner", "", filename);
                uploadedImage.Save(WorkingDirectory + "Partner\\" + filename);
            }
            else
            {
                ltrmessageimage.Visible = true;
                ltrmessageimage.Text = "Brand Partner image width and height should be greater than " + ConfigurationManager.AppSettings["PartnerImgWidth"].ToString() + "px and " + ConfigurationManager.AppSettings["PartnerImgHeight"].ToString() + "px";
                return;
            }

           

            if (ViewState["img"] != null)
            {
                if (ViewState["img"].ToString() != "")
                {
                    try
                    {
                        if (System.IO.File.Exists(DAL.GetRootPath() + "\\webfiles\\Partner\\" + ViewState["img"].ToString()))
                            System.IO.File.Delete((DAL.GetRootPath() + "\\webfiles\\Partner\\" + ViewState["img"].ToString()));

                    }
                    catch (Exception ex)
                    { }
                }
            }
        }
        if (ViewState["img"] != null && filename == "") filename = ViewState["img"].ToString();
        #endregion
        

        
        if (!DAL.IsNumeric(Request.QueryString["id"]))
        {
            int sortorder = 1;
            #region ManageSortOrder

            string maxnum = (new DAL()).ExecuteScalar("Select max(sortorder) from Partner", CommandType.Text, null); // this query will fetch the maximum display order number from db
            if (maxnum != null && maxnum != "")
                sortorder = int.Parse(maxnum.ToString()) + 1;
            #endregion
            strQuery = "insert into Partner(Visible,URL,image,sortorder,AddedDate,AddedIp) ";
            strQuery += "values('" + rbl_Visible.SelectedValue.ToString() + "','" + txtURL.Text.Replace("'", "''") + "','" + filename.ToString() + "',";
            strQuery += "" + sortorder + ",'" + DAL.GetDateWithFormat() + "','" + DAL.getIP() + "')";
            (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
            msg = "Partner details has been added successully.";
            Response.Redirect("viewPartner.aspx?msg=" + msg);


        }
        else
        {

            strQuery = "update Partner set Visible='" + rbl_Visible.SelectedValue.ToString() + "',URL='" + txtURL.Text.Replace("'", "''") + "',";
            strQuery += "image='" + filename.ToString() + "',";
           strQuery += "ModifyDate='" + DAL.GetDateWithFormat() + "',ModifyIp='" + DAL.getIP() + "' where id=" + Request.QueryString["id"].ToString();
            (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
            msg = "Partner details has been modified successfully.";
            Response.Redirect("viewPartner.aspx?msg=" + msg);


        }


    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewPartner.aspx");
    }

    protected void fill_Data()
    {
        string strQuery = "select * from Partner where id=" + Request.QueryString["id"].ToString();
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            rbl_Visible.SelectedValue = dt.Rows[0]["Visible"].ToString().Replace("True", "1").Replace("False", "0");
            txtURL.Text = dt.Rows[0]["URL"].ToString();
          
            if (dt.Rows[0]["Image"].ToString() != "")
            {
               img.Visible = true;
               img.Src = "../../webfiles/Partner/" + dt.Rows[0]["Image"].ToString();
            }
            ViewState["img"] = dt.Rows[0]["Image"].ToString();
           
    
        }
    }

}