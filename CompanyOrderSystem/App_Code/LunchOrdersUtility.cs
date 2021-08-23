using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for LunchOrdersUtility
/// </summary>
public class LunchOrdersUtility
{
    public static List<LunchOrders> FindLunchOrderById(int id)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["CompanyOrderSystemConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("Select * From LunchOrders where EmployeeID=@EmployeeID And OrderDate=@OrderDate", cnStr);
        string TodayLunchOrder = DateTime.Now.ToShortDateString(); //判斷抓到的Id欄位 的 Pun欄位日期時間是不是今天的，有的話就會抓到資料
        da.SelectCommand.Parameters.AddWithValue("@EmployeeID", id);
        da.SelectCommand.Parameters.AddWithValue("@OrderDate", TodayLunchOrder);


        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            return null;
        }

        var query = from row in dt.AsEnumerable()
                    select new LunchOrders()
                    {
                        LunchOrderID = Convert.ToInt32(row["LunchOrderID"]),
                        EmployeeID = Convert.ToInt32(row["EmployeeID"]),
                        OrderDate = row["OrderDate"].ToString(),
                        OrderName = row["OrderName"].ToString(),
                        OrderInfo = row["OrderInfo"].ToString(),
                        OrderCount = Convert.ToInt32(row["OrderCount"]),
                        OrderPrice = Convert.ToInt32(row["OrderPrice"])
                    };



        return query.ToList();
    }
    public static void DeleteLunchOrderByOrderId(int orderid)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["CompanyOrderSystemConnectionString1"].ConnectionString;
        SqlConnection cn = new SqlConnection(cnStr);
        SqlCommand cmd = new SqlCommand("Delete From LunchOrders where LunchOrderID = @LunchOrderID ", cn);

        cmd.Parameters.AddWithValue("@LunchOrderID", orderid);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static void InsertLunchOrder(LunchOrders lunchorder)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["CompanyOrderSystemConnectionString1"].ConnectionString;
        SqlConnection cn = new SqlConnection(cnStr);
        SqlCommand cmd = new SqlCommand(
            "insert into LunchOrders ( EmployeeID, OrderDate, OrderName, OrderInfo, OrderCount, OrderPrice) values ( @EmployeeID, @OrderDate, @OrderName, @OrderInfo, @OrderCount, @OrderPrice )", cn);

        cmd.Parameters.AddWithValue("@EmployeeID", lunchorder.EmployeeID);
        cmd.Parameters.AddWithValue("@OrderDate", lunchorder.OrderDate);
        cmd.Parameters.AddWithValue("@OrderName", lunchorder.OrderName);
        cmd.Parameters.AddWithValue("@OrderInfo", lunchorder.OrderInfo);
        cmd.Parameters.AddWithValue("@OrderCount", lunchorder.OrderCount);
        cmd.Parameters.AddWithValue("@OrderPrice", lunchorder.OrderPrice);


        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
}