using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Configuration;

/// <summary>
/// Summary description for EmployeeUtility
/// </summary>
public class AccountsUtility
{
    public static Account FindAccountById(int id)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["CompanyOrderSystemConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("Select * From Accounts where Id=@Id",cnStr);
        da.SelectCommand.Parameters.AddWithValue("@Id", id);

        DataTable dt = new DataTable();
        da.Fill(dt);


        DataRow row = dt.Rows[0];
        Account m = new Account()
        {
            Id = Convert.ToInt32(row["Id"]),
            DepartmentID=row["DepartmentID"].ToString(), //這邊存的換成了部門名稱
            Password = row["Password"].ToString(),
            ImageFileName = row["ImageFileName"] is DBNull ? "" : row["ImageFileName"].ToString()
        };


        return m;
    }
    public static Account FindAccount(int id, string password)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["CompanyOrderSystemConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("Select * From Accounts where id=@id And Password=@Password", cnStr);
        da.SelectCommand.Parameters.AddWithValue("@id", id);
        da.SelectCommand.Parameters.AddWithValue("@Password", password);

        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            return null;
        }
        DataRow row = dt.Rows[0];
        Account m = new Account()
        { 
            Id = Convert.ToInt32(row["Id"]),
            //UserName = row["UserName"].ToString(),
            Password = row["Password"].ToString(),
            Roles=row["Roles"].ToString(),
            DepartmentID=row["DepartmentID"].ToString(),
            ImageFileName = row["ImageFileName"] is DBNull ? "" : row["ImageFileName"].ToString()
        };


        return m;
    }
}