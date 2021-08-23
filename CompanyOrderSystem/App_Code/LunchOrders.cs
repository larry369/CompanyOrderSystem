using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for LunchOrders
/// </summary>
public class LunchOrders
{
    public int LunchOrderID { get; set; }
    public int EmployeeID { get; set; }
    public string OrderDate { get; set; }
    public string OrderName { get; set; }
    public string OrderInfo { get; set; }
    public int OrderCount { get; set; }
    public int OrderPrice { get; set; }
}
public class LunchTotalOrders
{
    public string OrderInfo { get; set; }
    public int OrderCount { get; set; }
    public int OrderPrice { get; set; }
}