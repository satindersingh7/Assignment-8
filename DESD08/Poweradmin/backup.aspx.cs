using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Text;
using System.Data.SqlClient;

public partial class backup : System.Web.UI.Page
{
    string strQuery = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Backup"] == null) Response.Redirect("default.aspx");
    }
    protected void btn_Backup_Click(object sender, EventArgs e)
    {
        string backupfile = DAL.GetRootPath() + "//App_Data//backup//" + DAL.CurrCountryTime().ToString("ddMMyyyyhhmmss") + ".sql";
        //new DAL().TakeBackup(backupfile);

        strQuery = "update admin set backupdt='" + DAL.CurrCountryTime().ToString("yyyy-MM-dd") + "' where id=1";
        new DAL().ExecuteNonQuery(strQuery, CommandType.Text, null);

        ViewState["FileName"] = backupfile;

        //ViewState["FileName"] = CreateSQLBackup();


        string[] files = Directory.GetFiles(DAL.GetRootPath() + "//App_Data");

        foreach (string file in files)
        {
            FileInfo fi = new FileInfo(file);
            if (fi.LastAccessTime < DateTime.Now.AddMonths(-1))
                fi.Delete();
        }
        fs1.Visible = false;
        fs2.Visible = true;
    }
    protected void lb_Download_Click(object sender, EventArgs e)
    {
        string FilePath = ViewState["FileName"].ToString();

        if (File.Exists(FilePath))
        {
            FileInfo file = new FileInfo(FilePath);

            Response.Clear();

            Response.AddHeader("Content-Disposition", "attachment; filename=" + DAL.CurrCountryTime().ToString("dd-MMM-yyyy") + "-Backup.sql");

            Response.AddHeader("Content-Length", file.Length.ToString());

            Response.ContentType = "application/octet-stream";

            Response.WriteFile(file.FullName);

            Response.End();
        }
    }

    //string CreateSQLBackup()
    //{
    //    string query = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' order by TABLE_NAME asc";
    //    DataTable dt = new DAL().GetDataTable(query, CommandType.Text, null);
    //    StringBuilder strTableScript = new StringBuilder();

    //    DateTime dtCurTime = DateTime.Now;

    //    string curdatetime = dtCurTime.ToString("ddMMyyyyhhmmss");
    //    string bacckuppath = Server.MapPath("App_Data");


    //    string backupFile = bacckuppath + "\\backup-" + curdatetime + ".sql";


    //    StreamWriter sw = new StreamWriter(backupFile);

    //    DAL dac = new DAL();

    //    string tablesnamesforsp = "";

    //    foreach (DataRow dr in dt.Rows)
    //    {
    //        string tblName = Convert.ToString(dr[0]);
    //        string columnsForDataTransfer = "";
    //        string strCreateTable = "if exists (select * from sysobjects where name='" + tblName + "' and xtype='U')" + System.Environment.NewLine + "DROP TABLE " + tblName + System.Environment.NewLine + "GO" + System.Environment.NewLine + "CREATE TABLE " + tblName + "(" + System.Environment.NewLine;

    //        SqlParameter[] sppara = new SqlParameter[1];
    //        sppara[0] = new SqlParameter("@TABLENAME", tblName);

    //        tablesnamesforsp += tblName + ",";

    //        columnsForDataTransfer = "INSERT [" + tblName + "] (";


    //        DataSet dsTableProp = dac.GetDataSet("PS_GETCOLUMNSBYTABLENAME", CommandType.StoredProcedure, sppara);
    //        if (dsTableProp != null)
    //        {
    //            if (dsTableProp.Tables.Count > 0)
    //            {
    //                DataTable dtTable = dsTableProp.Tables[0];
    //                foreach (DataRow dr2 in dtTable.Rows)
    //                {
    //                    string ColumnName, TypeName, max_length, PRECISION, scale;
    //                    ColumnName = Convert.ToString(dr2["ColumnName"]);
    //                    TypeName = Convert.ToString(dr2["TypeName"]);
    //                    max_length = Convert.ToString(dr2["max_length"]);
    //                    PRECISION = Convert.ToString(dr2["PRECISION"]);
    //                    scale = Convert.ToString(dr2["scale"]);

    //                    columnsForDataTransfer += "[" + ColumnName + "],";

    //                    if (ColumnName.ToLower() == "id")
    //                    {
    //                        strCreateTable += "\t[" + ColumnName + "] " + TypeName + " IDENTITY(1,1) NOT NULL Primary key ," + System.Environment.NewLine;
    //                    }
    //                    else
    //                    {
    //                        string dttype = "";
    //                        if (TypeName.ToLower() == "varchar" && max_length == "-1")
    //                            dttype = " " + TypeName + "(MAX)";
    //                        else if (TypeName.ToLower() == "varchar" || TypeName.ToLower() == "text")
    //                            dttype = " " + TypeName + "(" + max_length + ")";
    //                        else if (TypeName.ToLower() == "numeric")
    //                        {
    //                            dttype = " " + TypeName + "(" + PRECISION + "," + scale + ")";
    //                        }
    //                        else
    //                            dttype = " " + TypeName;

    //                        strCreateTable += "\t[" + ColumnName + "] " + dttype + "," + System.Environment.NewLine;
    //                    }
    //                }
    //            }
    //        }
    //        strCreateTable = strCreateTable.Remove(strCreateTable.LastIndexOf(",")) + System.Environment.NewLine + ")";

    //        strTableScript.AppendLine(strCreateTable);

    //        strCreateTable = "";

    //        columnsForDataTransfer = columnsForDataTransfer.Remove(columnsForDataTransfer.LastIndexOf(",")) + ")";

    //        columnsForDataTransfer += " values(";

    //        SqlParameter[] sppara2 = new SqlParameter[1];
    //        sppara2[0] = new SqlParameter("@TABLENAME", tblName);
    //        DataTable dtRecords = dac.GetDataTable("PS_GETTABLEDATA", CommandType.StoredProcedure, sppara2);

    //        StringBuilder strTblRecords = new StringBuilder();
    //        StringBuilder strRowRecords = new StringBuilder();
    //        if (dtRecords.Rows.Count > 0)
    //        {
    //            foreach (DataRow drrecords in dtRecords.Rows)
    //            {
    //                string strRecords = "";
    //                foreach (DataColumn dcrecords in dtRecords.Columns)
    //                {
    //                    if (dcrecords.ColumnName.ToLower() == "id")
    //                        strRecords += " " + Convert.ToString(drrecords[dcrecords.ColumnName]).Replace("'", "''") + ",";
    //                    else
    //                        strRecords += " N'" + Convert.ToString(drrecords[dcrecords.ColumnName]).Replace("'", "''") + "',";
    //                }
    //                strRecords = strRecords.Remove(strRecords.LastIndexOf(","));

    //                strRowRecords.Append(columnsForDataTransfer + strRecords + ")" + System.Environment.NewLine);
    //            }


    //            strTblRecords.Append("SET IDENTITY_INSERT [" + tblName + "] ON" + System.Environment.NewLine + strRowRecords.ToString() + System.Environment.NewLine + "SET IDENTITY_INSERT [" + tblName + "] OFF" + System.Environment.NewLine);
    //        }
    //        strTableScript.AppendLine(strTblRecords.ToString());
    //    }

    //    string strSpBackup = "";
    //    string[] tblsp = tablesnamesforsp.Split(',');
    //    for (int i = 0; i < tblsp.Length; i++)
    //    {
    //        if (tblsp[i] != "")
    //        {
    //            SqlParameter[] sppara3 = new SqlParameter[1];
    //            sppara3[0] = new SqlParameter("@BackTABLE", tblsp[i]);
    //            DataTable dtSps = dac.GetDataTable("PS_GETBACKUP", CommandType.StoredProcedure, sppara3);

    //            foreach (DataRow dr in dtSps.Rows)
    //            {
    //                string spName = Convert.ToString(dr["spName"]);

    //                string spBODY = Convert.ToString(dr["spBODY"]);

    //                strSpBackup += "if exists (select * from sysobjects where name='" + spName + "' and xtype='P')" + System.Environment.NewLine + "DROP PROC " + spName + System.Environment.NewLine + "GO" + System.Environment.NewLine;
    //                strSpBackup += spBODY + System.Environment.NewLine + "GO" + System.Environment.NewLine;
    //            }
    //        }
    //    }
    //    sw.Write(strSpBackup + System.Environment.NewLine + strTableScript);
    //    sw.Close();

    //    return backupFile;
    //}
}