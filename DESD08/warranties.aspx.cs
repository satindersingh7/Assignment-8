using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class our_story : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        PageContent.PageName = "Warranties";
        PageContent.MetaControl = ltr_Meta;
    }
}