using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class brand_partners_buzz_value : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            fill_partner();
        }
    }
    protected void fill_partner()
    {
        string strQuery = "select * from partner where visible=1 order by sortorder ";
        DataTable dt = new DAL().GetDataTable(strQuery, CommandType.Text, null);
        if (dt != null && dt.Rows.Count > 0)
        {
            reppartner.DataSource = dt;
            reppartner.DataBind();
            divNoPartner.Visible = false;
        }
        else
            divNoPartner.Visible = true;
    }
}