using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Poweradmin_ckeditor_ckeditor : System.Web.UI.UserControl
{
    string _text = "";
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public string Text
    {
        get { return editor1.InnerText; }
        set { editor1.InnerText = value; }
    }
}