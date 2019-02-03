using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class dashboard : System.Web.UI.Page
{
    string strQuery = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        ltrinquiry.Text = new DAL().ExecuteScalar("select count(id) from productenquiry where unread=1", CommandType.Text, null);
        ltrfaq.Text = new DAL().ExecuteScalar("select count(id) from faq", CommandType.Text, null);
        ltrProduct.Text = new DAL().ExecuteScalar("select count(id) from product", CommandType.Text, null);
      
    }
  
}