using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class thank_you : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        PageContent.PageName = "Contact us Thank you";
       // PageContent1.PageName = "Product enquiry Thank you";
        PageContent.MetaControl = ltr_Meta;
    }
}