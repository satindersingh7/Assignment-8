using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class faq_buzz_value : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strquery = "select * from faq where visible=1 order by sortorder asc";
        DataTable dt = new DAL().GetDataTable(strquery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            rep_Faq.Visible = true;
            noitem.Visible = false;
            rep_Faq.DataSource = dt;
            rep_Faq.DataBind();
        }
        else
        {
            noitem.Visible = true;
        }
    }
}