using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class includes_content : System.Web.UI.UserControl
{
    string _pageName;
    object _metaControl;
    protected void Page_Load(object sender, EventArgs e)
    {
        FetchPageDetails();
    }
    public string PageName
    {
        set
        {
            _pageName = value;
        }
    }

    public object MetaControl
    {
        set
        {
            _metaControl = value;
        }
    }

    void FetchPageDetails()
    {

        DataTable dtPageDetails = (new DAL()).getFullPageDetails(_pageName);
        if (dtPageDetails != null)
        {
            if (dtPageDetails.Rows.Count > 0)
            {
                string content = dtPageDetails.Rows[0]["PageDesc"].ToString();
                string title = dtPageDetails.Rows[0]["PageIETitle"].ToString();
                string meta = dtPageDetails.Rows[0]["Meta"].ToString();

                lblContent.Text = content;
               
                    this.Page.Title = title;

                if (_metaControl != null)
                {
                    Literal ll = (Literal)_metaControl;
                    ll.Text = meta;
                }
            }
            //else
            //    this.Page.Title = "Welcome to ";
        }
    }
}
