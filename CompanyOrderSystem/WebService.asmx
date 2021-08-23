<%@ WebService Language="C#" Class="WebService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Collections.Generic;// List<>

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService  : System.Web.Services.WebService {

    //今日供應訂餐菜單資訊
    [WebMethod]
    public List<Menus> GetMenusQueryById(int id)
    {
        return MenusUtility.FindAllMenusById(id);
    }

    //all午餐廠商資訊
    [WebMethod]
    public List<LunchCompanys> GetLunchCompanysQuery(int get)
    {
        return LunchCompanysUtility.FindAllLunchCompanys();
    }

    //更新廠商資訊
    [WebMethod]
    public void UpdateLunchCompany(int lcid, string lcname, string taxid, string phonenumber)
    {
        LunchCompanys lunchcomp = new LunchCompanys()
        {
            LunchCompanyID = lcid,
            LunchCompanyName = lcname,
            TaxID = taxid,
            PhoneNumber = phonenumber
        };
        LunchCompanysUtility.UpdateLunchCompany(lunchcomp);
    }
    //刪除廠商資料
    [WebMethod]
    public void DeleteLunchCompany(int id)
    {
        LunchCompanysUtility.DeleteLunchCompanyById(id);
    }
    //刪除廠商資料的同時，刪除廠商的菜單
    [WebMethod]
    public void DeleteLunchMenusById(int id)
    {
        MenusUtility.DeleteLunchMenusById(id);
    }

    [WebMethod]
    public void DeleteLunchMenuByIdandName(int id, string name)
    {
        MenusUtility.DeleteLunchMenuByName(id, name);
    }
    //新增午餐廠商資料
    [WebMethod]
    public void LunchCompanyAdd(string name, string taxID, string phone)
    {
        LunchCompanys lunchComp = new LunchCompanys()
        {
            LunchCompanyName = name,
            TaxID = taxID,
            PhoneNumber = phone
        };

        LunchCompanysUtility.InsertLunchCompany(lunchComp);
    }
    [WebMethod]
    public void MenuAdd(int id, string name, string type, string price)
    {
        Menus lunchmenu = new Menus()
        {
            LunchCompanyID = id,
            LunchName = name,
            LunchType = type,
            Price = price
        };

        MenusUtility.InsertMenu(lunchmenu);
    }
    [WebMethod(EnableSession =true)]
    public void Getmenubarnamebyid(string name)
    {
        LunchCompanys lc = LunchCompanysUtility.FindAllLunchCompanysById(name);
        Session["ShowMenuname"] = lc.LunchCompanyName;
    }
    [WebMethod(EnableSession =true)]
    public void SavetoSession(string get)
    {
        Session["ShowMenu"] = get;

    }
    [WebMethod]
    public List<LunchOrders> GetLunchOrderQueryById(int id)
    {
        return LunchOrdersUtility.FindLunchOrderById(id);
    }
    [WebMethod]
    public void DeleteLunchOrderByOrderId(int orderid)
    {
        LunchOrdersUtility.DeleteLunchOrderByOrderId(orderid);
    }
    //新增訂單
    [WebMethod]
    public void OrderAdd(int id, string date, string name, string order, int count, int price)
    {
        LunchOrders lunchorder = new LunchOrders()
        {
            EmployeeID = id,
            OrderDate = date,
            OrderName = name,
            OrderInfo = order,
            OrderCount = count,
            OrderPrice = price
        };

        LunchOrdersUtility.InsertLunchOrder(lunchorder);
    }
}