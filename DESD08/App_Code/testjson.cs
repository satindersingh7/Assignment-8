using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Xml;
using Newtonsoft.Json.Linq;
using System.Text;
using System.Web.Script.Services;
using System.Data;
using System.Collections;
using System.Configuration;
using System.IO;

/// <summary>
/// Summary description for testjson
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[ToolboxItem(false)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class testjson : System.Web.Services.WebService {

    public testjson () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld() {
        return "Hello World";
    }
      [WebMethod(Description = "True=On, False=Off")]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void products()
    {
           string Query = "select * from product";
            DataSet ds =new DAL().GetDataSet(Query, CommandType.Text, null);
        
        XmlDataDocument xmldata = new XmlDataDocument(ds);
        XmlElement xmlElement = xmldata.DocumentElement;
        
       
         
           
     
      
        string JSON = XmlToJSON(xmldata);
        JObject json = JObject.Parse(JSON);
        string formatted = json.ToString();
        this.Context.Response.ContentType = "application/json";
        this.Context.Response.Write(formatted);
    }
      [WebMethod]
      public XmlDocument TestVideo(byte[] ByteArrayVideo, string Video, int RestaurantId, int VideoLength)
      {
          // the byte array argument contains the content of the file    
          // the string argument contains the name and extension    
          // of the file passed in the byte array    
          try
          {
              StringBuilder sb = new StringBuilder();
              XmlWriterSettings xmlSettings = new XmlWriterSettings();
              xmlSettings.Indent = true;
              xmlSettings.Encoding = Encoding.UTF8;
              XmlWriter writer = XmlWriter.Create(sb, xmlSettings);
              writer.WriteStartDocument();
              writer.WriteStartElement("StartElement");
              // instance a memory stream and pass the    
              // byte array to its constructor    
              string restname = "";
              restname = new DAL().ExecuteScalar("select name from restaurants where id=" + RestaurantId, CommandType.Text, null);
              if (restname != null && restname != "")
              {
                  //Video
                  MemoryStream ms = new MemoryStream(ByteArrayVideo);

                  // instance a filestream pointing to the    
                  // storage folder, use the original file name    
                  // to name the resulting file    
                  FileStream fs = new FileStream(DAL.GetRootPath() + "webfiles//Video//" + Video, FileMode.Create);


                  // write the memory stream containing the original    
                  // file as a byte array to the filestream    
                  ms.WriteTo(fs);


                  // clean up    
                  ms.Close();
                  fs.Close();
                  fs.Dispose();

                  // return OK if we made it this far    
                  //return DAL.GetRootPath() + "webfiles//User29//Image//" + fileName;
                  writer.WriteStartElement("Uploaded");
                  writer.WriteValue(DAL.GetRootPath() + "webfiles//Video//" + Video);
                  writer.WriteEndElement();
                  string name;
                  int i = 0;

                  string strQuery1 = "select * from testimonailvideo where restaurantid=" + RestaurantId;
                  DataTable dt = new DAL().GetDataTable(strQuery1, CommandType.Text, null);
                  if (dt != null && dt.Rows.Count > 0)
                  {
                      i = dt.Rows.Count + 1;
                      name = "Testimonial " + i.ToString();
                  }
                  else
                  {
                      name = "Testimonial 1";
                  }

                  string strQuery = "insert into TestimonailVideo(RestaurantId,Video,VideoLength,AddedDate,AddedIp,seen,shared,name) values(" + RestaurantId + ",'" + Video + "'," + VideoLength + ",'" + DAL.CurrCountryTime() + "','" + DAL.getIP() + "',0,0,'" + name + "')";
                  (new DAL()).ExecuteNonQuery(strQuery, CommandType.Text, null);

                  #region Send Email
                  string restName = "";
                  string strQuery2 = "select * from Restaurants where id=" + RestaurantId;
                  DataTable dt1 = new DAL().GetDataTable(strQuery2, CommandType.Text, null);
                  if (dt1 != null && dt1.Rows.Count > 0)
                  {
                      restName = dt1.Rows[0]["name"].ToString();
                  }

                  string strMailBody = new DAL().GetMailTemplates("\\mailtemplates\\newvideo.htm");

                  strMailBody = strMailBody.Replace("_LOGOURL_", ConfigurationManager.AppSettings["Logo"].ToString());
                  strMailBody = strMailBody.Replace("_SITEURL_", ConfigurationManager.AppSettings["siteurl"].ToString());
                  strMailBody = strMailBody.Replace("_DATE", DateTime.Now.ToString("dd MMMM yyyy"));
                  strMailBody = strMailBody.Replace("_YourName", restName);
                  strMailBody = strMailBody.Replace("_url", ConfigurationManager.AppSettings["SiteName"].ToString());

                  strMailBody = strMailBody.Replace("_IP_", DAL.getIP());//

                  new DAL().MailToSendSite("websitetesting99@gmail.com", "Burger Nation: New Video", "websitetesting99@gmail.com", strMailBody, null, null, restName);




                  #endregion
                  writer.WriteStartElement("Success");
                  writer.WriteValue("Testimonail Video is Successfully Uploaded");
                  writer.WriteEndElement();
              }
              writer.WriteStartElement("Failure");
              writer.WriteValue("Resturant donot exist");
              writer.WriteEndElement();
              writer.WriteEndElement();
              writer.WriteEndDocument();
              writer.Flush();
              XmlDocument xmlDocument = new XmlDocument();
              xmlDocument.LoadXml(sb.ToString());
              return xmlDocument;
          }
          catch (Exception ex)
          {
              StringBuilder sb = new StringBuilder();
              XmlWriterSettings xmlSettings = new XmlWriterSettings();
              xmlSettings.Indent = true;
              xmlSettings.Encoding = Encoding.UTF8;
              XmlWriter writer = XmlWriter.Create(sb, xmlSettings);
              writer.WriteStartDocument();
              writer.WriteStartElement("StartElement");

              writer.WriteStartElement("ErrorException");
              writer.WriteValue(ex.Message);
              writer.WriteEndElement();

              writer.WriteEndElement();
              writer.WriteEndDocument();
              writer.Flush();
              XmlDocument xmlDocument = new XmlDocument();
              xmlDocument.LoadXml(sb.ToString());
              return xmlDocument;
          }
      }
    #region "Code for Return JSON Data"
    private static string XmlToJSON(XmlDocument xmlDoc)
    {
        StringBuilder sbJSON = new StringBuilder();
        sbJSON.Append("{ ");
        XmlToJSONnode(sbJSON, xmlDoc.DocumentElement, true);
        sbJSON.Append("}");
        return sbJSON.ToString();
    }

    //  StoreChildNode: Store data associated with each nodeName
    //                  so that we know whether the nodeName is an array or not.
    private static void StoreChildNode(SortedList childNodeNames, string nodeName, object nodeValue)
    {
        // Pre-process contraction of XmlElement-s
        if (nodeValue is XmlElement)
        {
            // Convert  <aa></aa> into "aa":null
            //          <aa>xx</aa> into "aa":"xx"
            XmlNode cnode = (XmlNode)nodeValue;
            if (cnode.Attributes.Count == 0)
            {
                XmlNodeList children = cnode.ChildNodes;
                if (children.Count == 0)
                    nodeValue = null;
                else if (children.Count == 1 && (children[0] is XmlText))
                    nodeValue = ((XmlText)(children[0])).InnerText;
            }
        }
        // Add nodeValue to ArrayList associated with each nodeName
        // If nodeName doesn't exist then add it
        object oValuesAL = childNodeNames[nodeName];
        ArrayList ValuesAL;
        if (oValuesAL == null)
        {
            ValuesAL = new ArrayList();
            childNodeNames[nodeName] = ValuesAL;
        }
        else
            ValuesAL = (ArrayList)oValuesAL;
        ValuesAL.Add(nodeValue);
    }
    //  XmlToJSONnode:  Output an XmlElement, possibly as part of a higher array
    private static void XmlToJSONnode(StringBuilder sbJSON, XmlElement node, bool showNodeName)
    {
        if (showNodeName)
            sbJSON.Append("\"" + SafeJSON(node.Name) + "\": ");
        sbJSON.Append("{");
        // Build a sorted list of key-value pairs
        //  where   key is case-sensitive nodeName
        //          value is an ArrayList of string or XmlElement
        //  so that we know whether the nodeName is an array or not.
        SortedList childNodeNames = new SortedList();

        //  Add in all node attributes
        if (node.Attributes != null)
            foreach (XmlAttribute attr in node.Attributes)
                StoreChildNode(childNodeNames, attr.Name, attr.InnerText);

        //  Add in all nodes
        foreach (XmlNode cnode in node.ChildNodes)
        {
            if (cnode is XmlText)
                StoreChildNode(childNodeNames, "value", cnode.InnerText);
            else if (cnode is XmlElement)
                StoreChildNode(childNodeNames, cnode.Name, cnode);
        }

        // Now output all stored info
        foreach (string childname in childNodeNames.Keys)
        {
            ArrayList alChild = (ArrayList)childNodeNames[childname];
            if (alChild.Count == 1)
                OutputNode(childname, alChild[0], sbJSON, true);
            else
            {
                sbJSON.Append(" \"" + SafeJSON(childname) + "\": [ ");
                foreach (object Child in alChild)
                    OutputNode(childname, Child, sbJSON, false);
                sbJSON.Remove(sbJSON.Length - 2, 2);
                sbJSON.Append(" ], ");
            }
        }
        sbJSON.Remove(sbJSON.Length - 2, 2);
        sbJSON.Append(" }");
    }
    private static void OutputNode(string childname, object alChild, StringBuilder sbJSON, bool showNodeName)
    {
        if (alChild == null)
        {
            if (showNodeName)
                sbJSON.Append("\"" + SafeJSON(childname) + "\": ");
            sbJSON.Append("null");
        }
        else if (alChild is string)
        {
            if (showNodeName)
                sbJSON.Append("\"" + SafeJSON(childname) + "\": ");
            string sChild = (string)alChild;
            sChild = sChild.Trim();
            sbJSON.Append("\"" + SafeJSON(sChild) + "\"");
        }
        else
            XmlToJSONnode(sbJSON, (XmlElement)alChild, showNodeName);
        sbJSON.Append(", ");
    }
    // Make a string safe for JSON
    private static string SafeJSON(string sIn)
    {
        StringBuilder sbOut = new StringBuilder(sIn.Length);
        foreach (char ch in sIn)
        {
            if (Char.IsControl(ch) || ch == '\'')
            {
                int ich = (int)ch;
                sbOut.Append(@"\u" + ich.ToString("x4"));
                continue;
            }
            else if (ch == '\"' || ch == '\\' || ch == '/')
            {
                sbOut.Append('\\');
            }
            sbOut.Append(ch);
        }
        return sbOut.ToString();
    }
    #endregion
}
