﻿using System;
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

public partial class Poweradmin_Product_manageProduct : System.Web.UI.Page
{
    string strQuery, msg;
    public static string PID = "";
    public string Detail = "active", Image = "", Associate="";
    string WorkingDirectory = DAL.GetRootPath() + "webfiles\\";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            fill_category();
            tabimg.Visible = tabAssociate.Visible = false;
        }
        if (DAL.IsNumeric(Request.QueryString["id"]) == true)
        {
            ltr_title.Text = "Edit";
            if (!this.IsPostBack)
            {
                fill_Data();
                fill_associated();
                tabimg.Visible = tabAssociate.Visible = true;

            }
        }
        if (!this.IsPostBack)
        ViewState["imgcnt"] = "0";
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
            ddlAssCategory.DataSource = dt;
            ddlAssCategory.DataTextField = "Title";
            ddlAssCategory.DataValueField = "id";
            ddlAssCategory.DataBind();
        }
        ddl_Category.Items.Insert(0, new ListItem("Select Category", ""));
        ddlAssCategory.Items.Insert(0, new ListItem("Select Category", ""));
    }
    protected void btn_Submit_Click(object sender, EventArgs e)
    {
        if (txtSellPrice.Text == "")
        {
            txtSellPrice.Text = txtCostPrice.Text;
        }
        if (txtPerweek.Text == "")
        {
            txtPerweek.Text = "0";
        }
        if (txtCostPrice.Text != "" && txtSellPrice.Text != "")
        {
            if (double.Parse(txtCostPrice.Text) < double.Parse(txtSellPrice.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Sell Price Cannot be greater than Cost Price.');", true);
                Detail = "active"; Image = ""; Associate = "";
                return;
            }
        }
        if (txtCostPrice.Text != "" && txtPerweek.Text != "")
        {
            if (double.Parse(txtCostPrice.Text) < double.Parse(txtPerweek.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Per Week Price Cannot be greater than Cost Price.');", true);
                Detail = "active"; Image = ""; Associate = "";
                return;
            }
        }
        if (txtSellPrice.Text != "" && txtPerweek.Text != "")
        {
            if (double.Parse(txtSellPrice.Text) < double.Parse(txtPerweek.Text))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Per Week Price Cannot be greater than Sell Price.');", true);
                Detail = "active"; Image = ""; Associate = "";
                return;
            }
        }
        string filename = ""; int sortorder = 1;
        if (DAL.IsNumeric(Request.QueryString["id"]))
            filename = ViewState["img"].ToString();
        #region Resize Image

        if (fulp.HasFile)
        {
            if (fulp.PostedFile.ContentLength > (1048576 * int.Parse(ConfigurationManager.AppSettings["ImageSize"].ToString())))
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Image size have exceeded the maximum size limit. Please upload image below " + ConfigurationManager.AppSettings["ImageSize"].ToString() + " MB size.');", true);
                Detail = "active"; Image = ""; Associate="";
                return;
            }

            //filename = DateTime.Now.ToString("ddmmyyyyhhmmss") + fulp.FileName.ToString().Replace(" ", "-").Replace("&", "-").Replace("/", "-").Replace("<", "").Replace("<", "").Replace("'", "").Replace("#", "");
            Bitmap uploadedImage = new Bitmap(fulp.FileContent);
            if (uploadedImage.Width >= Convert.ToInt16(ConfigurationManager.AppSettings["ProductImgWidth"].ToString()) && uploadedImage.Height >= Convert.ToInt16(ConfigurationManager.AppSettings["ProductImgHeight"].ToString()))
            {
                FileInfo FILE = new FileInfo(fulp.FileName);
                filename = DAL.FormateText(txtTitle.Text.Replace("\"","")) + "-" + DateTime.Now.ToString("ssms") + FILE.Extension;
                imageresize imgrez = new imageresize();
                int maxWidth = int.Parse(ConfigurationManager.AppSettings["ProductSmallImgWidth"].ToString());
                int maxHeight = int.Parse(ConfigurationManager.AppSettings["ProductSmallImgHeight"].ToString());
                imgrez.GetScaledPicture(uploadedImage, maxWidth, maxHeight, "product", "small", filename);

                maxWidth = int.Parse(ConfigurationManager.AppSettings["ProductImgWidth"].ToString());
                maxHeight = int.Parse(ConfigurationManager.AppSettings["ProductImgHeight"].ToString());
                imgrez.GetScaledPicture(uploadedImage, maxWidth, maxHeight, "product", "medium", filename);

                uploadedImage.Save(WorkingDirectory + "product\\large\\" + filename);
            }
            else
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Deal & Offers image width and height should be greater than " + ConfigurationManager.AppSettings["ProductImgHeight"].ToString() + "px and " + ConfigurationManager.AppSettings["ProductImgWidth"].ToString() + "px');", true);
                Detail = "active"; Image = ""; Associate = "";
                return; 
            }

            if (ViewState["img"] != null)
            {
                if (ViewState["img"].ToString() != "")
                {
                    try
                    {
                        if (System.IO.File.Exists(DAL.GetRootPath() + "\\webfiles\\product\\small\\" + ViewState["img"].ToString()))
                            System.IO.File.Delete((DAL.GetRootPath() + "\\webfiles\\product\\small\\" + ViewState["img"].ToString()));
                        if (System.IO.File.Exists(DAL.GetRootPath() + "\\webfiles\\product\\medium\\" + ViewState["img"].ToString()))
                            System.IO.File.Delete((DAL.GetRootPath() + "\\webfiles\\product\\medium\\" + ViewState["img"].ToString()));
                        if (System.IO.File.Exists(DAL.GetRootPath() + "\\webfiles\\product\\large\\" + ViewState["img"].ToString()))
                            System.IO.File.Delete((DAL.GetRootPath() + "\\webfiles\\product\\large\\" + ViewState["img"].ToString()));
                    }
                    catch (Exception ex)
                    { }

                }
            }

        }

        #endregion
        if (!DAL.IsNumeric(Request.QueryString["id"]))
        {
            string code = (new DAL()).ExecuteScalar("Select count(*) from deal where productcode='" + txtProductCode.Text + "'", CommandType.Text, null); // this query will fetch the maximum display order number from db
            if (code != "0")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Deal & Offers Code already used.');", true);
                Detail = "active"; Image = ""; Associate = "";
                return;
            }
            
            #region ManageSortOrder

            string maxnum = (new DAL()).ExecuteScalar("Select max(sortorder) from Product where catid="+ddl_Category.SelectedValue.ToString()+"", CommandType.Text, null); // this query will fetch the maximum display order number from db
            if (maxnum != null && maxnum != "")
                sortorder = int.Parse(maxnum.ToString()) + 1;
            #endregion
            strQuery = "insert into deal(Visible,featured,Title,productcode,catid,image,costprice,sellprice,description,Perweek,sortorder,AddedDate,AddedIp) ";
            strQuery += "values('" + rbl_Visible.SelectedValue.ToString() + "',";
            strQuery += "'" + rblFeatured.SelectedValue.ToString() + "','" + txtTitle.Text.Replace("'", "''") + "',";
            strQuery += "'" + txtProductCode.Text.Replace("'", "''") + "','" + ddl_Category.SelectedValue.ToString() + "','" + filename + "',";
            strQuery += "" + txtCostPrice.Text.Replace("'", "''") + "," + txtSellPrice.Text.Replace("'", "''") + ",";
            strQuery += "'" + Editor_Description.Text.Replace("'", "''") + "','" + txtPerweek.Text.Replace("'", "''") + "'," + sortorder + ",'" + DAL.GetDateWithFormat() + "','" + DAL.getIP() + "')";
            (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
            msg = "Deal and Offers details has been added successully.";
            Response.Redirect("viewProduct.aspx?msg=" + msg);


        }
        else
        {
            string code = (new DAL()).ExecuteScalar("Select count(*) from deal where id<>" + Request.QueryString["id"].ToString()+" and productcode='" + txtProductCode.Text + "'", CommandType.Text, null); // this query will fetch the maximum display order number from db
            if (code != "0")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Deal & Offers Code already used.');", true);
                Detail = "active"; Image = ""; Associate = "";
                return;
            }
            strQuery = "update deal set Visible='" + rbl_Visible.SelectedValue.ToString() + "',";
            strQuery += "featured='" + rblFeatured.SelectedValue.ToString() + "',image='" + filename + "',Title='" + txtTitle.Text.Replace("'", "''") + "',";
            strQuery += "productcode='" + txtProductCode.Text.Replace("'", "''") + "',catid='" + ddl_Category.SelectedValue.ToString() + "',";
            strQuery += "costprice=" + txtCostPrice.Text.Replace("'", "''") + ",sellprice=" + txtSellPrice.Text.Replace("'", "''") + ",";
            strQuery += "description='" + Editor_Description.Text.Replace("'", "''") + "',Perweek='" + txtPerweek.Text.Replace("'", "''") + "',";
           strQuery += "ModifyDate='" + DAL.GetDateWithFormat() + "',ModifyIp='" + DAL.getIP() + "' where id=" + Request.QueryString["id"].ToString();

           #region check category sort order
           if ((ViewState["catid"] != null && ViewState["catid"].ToString() != ddl_Category.SelectedValue.ToString()))
           {
               string strQuery1 = "update deal set sortorder=sortorder-1 where Catid=" + ViewState["catid"].ToString() + " and sortorder>" + ViewState["sortorder"].ToString();
               new DAL().ExecuteNonQuery(strQuery1, CommandType.Text, null);

               string maxnum = (new DAL()).ExecuteScalar("Select max(sortorder) from deal where Catid=" + ddl_Category.SelectedValue.ToString() + " and id<>" + Request.QueryString["id"].ToString(), CommandType.Text, null); // this query will fetch the maximum display order number from db
               if (maxnum != null && maxnum != "")
                   sortorder = int.Parse(maxnum.ToString()) + 1;

               strQuery1 = "update deal set sortorder=" + sortorder + " where id=" + Request.QueryString["id"].ToString();
               new DAL().ExecuteNonQuery(strQuery1, CommandType.Text, null);
           }

           #endregion

            (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
            msg = "Deal and Offers details has been modified successfully.";
            Response.Redirect("viewProduct.aspx?msg=" + msg);


        }


    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewProduct.aspx");
    }

    protected void fill_Data()
    {
        string strQuery = "select * from deal where id=" + Request.QueryString["id"].ToString();
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            rbl_Visible.SelectedValue = dt.Rows[0]["Visible"].ToString().Replace("True", "1").Replace("False", "0");
            rblFeatured.SelectedValue = dt.Rows[0]["featured"].ToString().Replace("True", "1").Replace("False", "0");
            txtTitle.Text = dt.Rows[0]["title"].ToString();
            txtProductCode.Text = dt.Rows[0]["productcode"].ToString();
            txtCostPrice.Text = dt.Rows[0]["costprice"].ToString();
            txtSellPrice.Text = dt.Rows[0]["sellprice"].ToString();
            ddl_Category.SelectedValue = dt.Rows[0]["catid"].ToString();
            Editor_Description.Text = dt.Rows[0]["description"].ToString();
            txtPerweek.Text = dt.Rows[0]["Perweek"].ToString();
            ViewState["catid"] = dt.Rows[0]["catid"].ToString();
            ViewState["sortorder"] = dt.Rows[0]["sortorder"].ToString();
            if (dt.Rows[0]["Image"].ToString() != "")
            {
                rfv_ProductImage.Visible = false;
                img.Visible = true;
                img.Src = "../../webfiles/product/medium/" + dt.Rows[0]["Image"].ToString();
            }
            ViewState["img"] = dt.Rows[0]["Image"].ToString();
            Fill_Images();

        }
    }
    #region Multiple images
    protected void btn_Submit_Images_Click(object sender, EventArgs e)
    {
        try
        {

            PID = Request.QueryString["id"].ToString();
          
            HttpFileCollection fileCollection = Request.Files;
           
            Dictionary<string, string> Names = callMeForFupImage();
            if (Names != null)
                SaveImages(Names, PID);

            Fill_Images();

            // ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.success('Product images has been added successfully.');", true);
            Response.Redirect("viewproduct.aspx?msg=Deal and Offers has been saved Successfully");
        }
        catch (Exception ex)
        {
            throw ex;
        }

        Detail = ""; Image = "active"; Associate = "";
    }

    protected void Fill_Images()
    {
        try
        {
            strQuery = "select * from deal_images where productid = " + Request.QueryString["id"].ToString() + " order by id ";
            DataTable dt = new DataTable();
            //MySqlParameter[] ProductMimages = new MySqlParameter[1];
            //ProductMimages[0] = new MySqlParameter("in_productid", Request.QueryString["id"].ToString());
            dt = (new DAL()).GetDataTable(strQuery, CommandType.Text, null);
            if (dt != null && dt.Rows.Count > 0)
            {
                RepExistingImages.DataSource = dt;
                RepExistingImages.DataBind();
                RepExistingImages.Visible = true;
                existing.Visible = true;
                ViewState["imgcnt"] = dt.Rows.Count.ToString();
                fulp_Images.Attributes.Add("maxlength", (3-dt.Rows.Count).ToString());
                if (dt.Rows.Count >= 3)
                    fulp_Images.Enabled = false;
                else
                    fulp_Images.Enabled = true;
            }
            else
            {
                existing.Visible = false;
                RepExistingImages.Visible = false;
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    private Dictionary<string, string> callMeForFupImage()
    {
        string filename = "", files = "";
        Dictionary<string, string> dictNames = new Dictionary<string, string>();
        //if (Gallery_Image.HasFile)
        //{
        HttpFileCollection fileCollection = Request.Files;

        for (int i = 0; i < fileCollection.Count; i++)
        {
            //ctl00_ContentPlaceHolder1_fulp_Images//ctl00$ContentPlaceHolder1$fulp_Images
            if (fileCollection.Keys[i] != "ctl00$ContentPlaceHolder1$fulp")
            {
                HttpPostedFile uploadfile = fileCollection[i];

                if (uploadfile.ContentLength > 0)
                {
                    if (uploadfile.ContentLength > (1048576 * int.Parse(ConfigurationManager.AppSettings["ImageSize"].ToString())))
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Image size have exceeded the maximum size limit. Please upload large image below " + ConfigurationManager.AppSettings["ImageSize"].ToString() + " MB size.');", true);
                    }
                    else
                    {
                        Bitmap uploadedImage = new Bitmap(uploadfile.InputStream);
                        if (uploadedImage.Width >= Convert.ToInt16(ConfigurationManager.AppSettings["ProductImgWidth"].ToString()) && uploadedImage.Height >= Convert.ToInt16(ConfigurationManager.AppSettings["ProductImgHeight"].ToString()))
                        {
                            //filename = DateTime.Now.ToString("ddmmyyyyhhmmss") + uploadfile.FileName.ToString().Replace(" ", "-").Replace("&", "-").Replace("/", "-").Replace("<", "").Replace("'", "").Replace("#", "");
                            FileInfo FILE = new FileInfo(uploadfile.FileName);
                            filename = DAL.FormateText(txtTitle.Text) + "-" + (new Random()).Next(0, 100000) + FILE.Extension;
                            if (Path.GetExtension(filename) == "")
                                return null;
                            //dictNames.Add(Path.GetFileName(uploadfile.FileName).Substring(0, uploadfile.FileName.LastIndexOf(".")), filename);
                            dictNames.Add(filename, "");
                            imageresize imgrez = new imageresize();
                            int maxWidth = int.Parse(ConfigurationManager.AppSettings["ProductSmallImgWidth"].ToString());
                            int maxHeight = int.Parse(ConfigurationManager.AppSettings["ProductSmallImgHeight"].ToString());
                            imgrez.GetScaledPicture(uploadedImage, maxWidth, maxHeight, "product", "small", filename);

                            maxWidth = int.Parse(ConfigurationManager.AppSettings["ProductImgWidth"].ToString());
                            maxHeight = int.Parse(ConfigurationManager.AppSettings["ProductImgHeight"].ToString());
                            imgrez.GetScaledPicture(uploadedImage, maxWidth, maxHeight, "product", "medium", filename);

                            uploadedImage.Save(WorkingDirectory + "product\\large\\" + filename);
                        }
                        else
                        {

                            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Deal & Offers image width and height should be greater than " + ConfigurationManager.AppSettings["ProductImgHeight"].ToString() + "px and " + ConfigurationManager.AppSettings["ProductImgWidth"].ToString() + "px');", true);
                            Detail = ""; Image = "active"; Associate = "";
                        }

                    }
                }

            }
        }
        // }
        return dictNames;

    }

    protected void SaveImages(Dictionary<string, string> Names, object PID)
    {

        foreach (KeyValuePair<string, string> item in Names)
        {

            strQuery = "insert into deal_images(ProductId,image) values(" + int.Parse(PID.ToString()) + ",'" + item.Key.Replace("'", "''") + "')";
             (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
        }


    }

    protected void RepExistingImages_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName.ToString() == "DELETEIMG")
        {
            string SELQuery = "SELECT image FROM deal_images WHERE ID = " + e.CommandArgument.ToString();
            //MySqlParameter[] ProductGetImageFromMultiple = new MySqlParameter[1];
            //ProductGetImageFromMultiple[0] = new MySqlParameter("in_imageid", e.CommandArgument.ToString());
            DataTable dt = (new DAL()).GetDataTable(SELQuery, CommandType.Text, null);
            if (dt != null && dt.Rows.Count > 0)
            {
                if (File.Exists(@"" + DAL.GetRootPath() + "\\webfiles\\product\\small\\" + dt.Rows[0]["image"].ToString()))
                    File.Delete(@"" + DAL.GetRootPath() + "\\webfiles\\product\\small\\" + dt.Rows[0]["image"].ToString());
                if (File.Exists(@"" + DAL.GetRootPath() + "\\webfiles\\product\\medium\\" + dt.Rows[0]["image"].ToString()))
                    File.Delete(@"" + DAL.GetRootPath() + "\\webfiles\\product\\medium\\" + dt.Rows[0]["image"].ToString());
                if (File.Exists(@"" + DAL.GetRootPath() + "\\webfiles\\product\\large\\" + dt.Rows[0]["image"].ToString()))
                    File.Delete(@"" + DAL.GetRootPath() + "\\webfiles\\product\\large\\" + dt.Rows[0]["image"].ToString());

            }
            //delete from product_images where id=" + e.CommandArgument.ToString()

            //MySqlParameter[] ProductdeleteImageFromMultiple = new MySqlParameter[1];
            //ProductdeleteImageFromMultiple[0] = new MySqlParameter("in_imageid", e.CommandArgument.ToString());
            (new DAL()).ExecuteNonQuery("delete from deal_images where id=" + e.CommandArgument.ToString(), CommandType.Text, null);

            Fill_Images();
            Detail = ""; Image = "active";
        }
    }

    #endregion
    protected void fill_associated()
    {

        string strQuery1 = "select p.* from Associateddeal ap,Product p where p.id=ap.AssociatePID and ap.pid=" + Request.QueryString["id"].ToString() + " order by p.Title";


        DataTable dt1 = new DAL().GetDataTable(strQuery1, CommandType.Text, null);
        if (dt1 != null && dt1.Rows.Count > 0)
        {
            lbassociate.Items.Clear();
            foreach (DataRow dr in dt1.Rows)
            {
                ListItem l1 = new ListItem(dr["Title"].ToString(), dr["id"].ToString());
                lbassociate.Items.Add(l1);
            }

        }
    }
    protected void fill_listbox(string query)
    {
        ListItem li = new ListItem("Deal and Offers does not exists", "");

        //strQuery = "select * from product ";
        //strQuery+="where category1="+ddlCategory.SelectedValue+" ";
        //strQuery += "and category2=" + ddlSubCategory.SelectedValue + " ";
        //strQuery += "and category3=" + ddlSubCategory1.SelectedValue + "";
        DataTable dt = new DAL().GetDataTable(query, CommandType.Text, null);
        lbproduct.Items.Clear();
        if (dt != null && dt.Rows.Count > 0)
        {

            foreach (DataRow dr in dt.Rows)
            {
                ListItem l1 = new ListItem(dr["Title"].ToString(), dr["id"].ToString());
                lbproduct.Items.Add(l1);
            }
            foreach (ListItem li2 in lbassociate.Items)
                lbproduct.Items.Remove(li2);
        }
        else
        {
            ListItem l1 = new ListItem("No Deals And Offers found", "");
            lbproduct.Items.Add(l1);
        }
        string strQuery1 = "select p.* from Associateddeal ap,deal p where p.id=ap.AssociatePID and ap.pid=" + Request.QueryString["id"].ToString() + " order by p.Title";


        DataTable dt1 = new DAL().GetDataTable(strQuery1, CommandType.Text, null);
        if (dt1 != null && dt1.Rows.Count > 0)
        {
            lbassociate.Items.Clear();
            foreach (DataRow dr in dt1.Rows)
            {
                ListItem l1 = new ListItem(dr["Title"].ToString(), dr["id"].ToString());
                lbassociate.Items.Add(l1);
            }

        }
    }
    protected void btnAddstyle_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < lbproduct.Items.Count; i++)
        {
            ListItem li = lbproduct.Items[i];
            if (li.Selected == true && li.Value != "")
                lbassociate.Items.Add(li);
        }

        for (int i = 0; i < lbassociate.Items.Count; i++)
        {
            ListItem li = lbassociate.Items[i];
            lbproduct.Items.Remove(li);
        }
        Detail = ""; Image = ""; Associate = "active";
    }

    protected void btnRemovestyle_Click(object sender, EventArgs e)
    {
        if (lbproduct.Items.Count == 1 && lbproduct.Items[0].Value == "")
            lbproduct.Items.RemoveAt(0);
        for (int i = 0; i < lbassociate.Items.Count; i++)
        {
            ListItem li = lbassociate.Items[i];
            if (li.Selected == true && li.Value != "")
                lbproduct.Items.Add(li);
        }

        for (int i = 0; i < lbproduct.Items.Count; i++)
        {
            ListItem li = lbproduct.Items[i];
            lbassociate.Items.Remove(li);
        }
        Detail = ""; Image = ""; Associate = "active";

    }
    protected void tbx_Search_TextChanged(object sender, EventArgs e)
    {
        string cat = "";
        if (ddlAssCategory.SelectedValue.ToString() != "") cat = " and catid=" + ddlAssCategory.SelectedValue.ToString() + " ";
        fill_listbox("select * from product where (Title like '%" + tbx_Search.Text.Replace("'", "''") + "%'" + cat + ") and id<>" + Request.QueryString["id"].ToString() + "");
        Detail = ""; Image = ""; Associate = "active";
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (lbassociate.Items.Count > 16)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowPopup", "toastr.error('Select maximum 4 associate deal & offers.');", true);
            Detail = ""; Image = ""; Associate = "active";
            return;
        }
        else
        {
            string strQuery = "select * from Associateddeal where Pid=" + Request.QueryString["id"].ToString();
            DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
            if (dt != null && dt.Rows.Count > 0)
            {

                strQuery = "delete from Associateddeal where pid=" + Request.QueryString["id"].ToString();
                (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);
            }
            foreach (ListItem li in lbassociate.Items)
            {
                strQuery = "insert into Associateddeal(Pid,AssociatePID) values('" + Request.QueryString["id"].ToString() + "','" + li.Value.ToString() + "')";
                (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);

            }
            Response.Redirect("viewproduct.aspx?msg=Deal and Offers succcessfully associated with another Deal and Offers");
        }
    }
    protected void ddlAssCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        string strQuery = "select * from product where id<>" + Request.QueryString["id"].ToString() + " and catid=" + ddlAssCategory.SelectedValue.ToString();
        if (tbx_Search.Text != "") strQuery += " and (Title like '%" + tbx_Search.Text.Replace("'", "''") + "%')";
        fill_listbox(strQuery);
    }
}