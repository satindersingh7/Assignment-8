using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

/// <summary>
/// Check Your Form Before Sumit
/// </summary>
public class ImageVarification
{
    static int _curImageCode = 1;
	public ImageVarification()
	{

	}
    /// <summary>
    /// Generares Image
    /// </summary>
   

 
    /// <summary>
    /// Check Image and User Input
    /// </summary>    
    /// <param name="userInput"></param>
    /// <returns>If user input correct code than Returns true else return false</returns>
    public static bool checkImageCode(string userInput,string num)
    {
        string[] imageCodeArray = {"-", "clock", "chair", "horse", "fish", "elephant", "balloon", "ball", "rose", "camera", "apple","banana","motorbike","bird","boat","bulb","car","cat","bicycle","dog","flower","guitar","hat","icecream","mobile","pencil","phone","plane","train","television","umbrella" };
        if (imageCodeArray[int.Parse(num)] == userInput.ToLower())
        {
            return true;
        }        
        return false;
    }

    public static void setImage(Image img,HiddenField hf)
    {  
            Random rn = new Random();
            int n = rn.Next(1, 30);
            if (n <= 0 || n > 30) n = 1;
            hf.Value = n.ToString();
            img.ImageUrl = ConfigurationManager.AppSettings["siteurl"].ToString() + "images/capache/st" + n.ToString() + "r.jpg";
    }

    public static void setImage1(Image img, HiddenField hf)
    {
        string text = Guid.NewGuid().ToString().Substring(0, 5);
        HttpContext.Current.Application["Captcha"] = text;
        hf.Value = text;
        img.ImageUrl = ConfigurationManager.AppSettings["siteurl"].ToString() + "/includes/Captcha.aspx";

        //string text = (new Random().Next(0, 9)).ToString() + (new Random().Next(2, 8)).ToString() + (new Random().Next(3, 7)).ToString() + (new Random().Next(4, 6)).ToString();
        //HttpContext.Current.Response.Cookies["Captcha"]["value"] = text;
        //hf.Value = text;
        //img.ImageUrl = ConfigurationManager.AppSettings["siteurl"].ToString() + "includes/Captcha.aspx";

      
    }

    public static bool checkImageCode1(string userInput, string num)
    {
        string[] imageCodeArray = { "-", "clock", "chair", "horse", "fish", "elephant", "balloon", "ball", "rose", "camera", "apple", "banana", "motorbike", "bird", "boat", "bulb", "car", "cat", "bicycle", "dog", "flower", "guitar", "hat", "icecream", "mobile", "pencil", "phone", "plane", "train", "television", "umbrella" };
        if (imageCodeArray[int.Parse(num)] == userInput.ToLower())
        {
            return true;
        }
        return false;
    }
}
