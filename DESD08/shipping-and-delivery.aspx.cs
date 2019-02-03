using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class shipping_and_delivery : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        PageContent.PageName = "Shipping and Delivery";
        PageContent.MetaControl = ltr_Meta;
    }
}