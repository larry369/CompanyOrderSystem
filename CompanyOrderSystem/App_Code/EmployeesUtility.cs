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
public class EmployeesUtility
{
    public static Employee FindEmployeeById(int id)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["CompanyOrderSystemConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("Select * From Employees where EmployeeID=@EmployeeID", cnStr);
        da.SelectCommand.Parameters.AddWithValue("@EmployeeID", id);

        DataTable dt = new DataTable();
        da.Fill(dt);


        DataRow row = dt.Rows[0];
        Employee e = new Employee()
        {
            EmployeeID = Convert.ToInt32(row["EmployeeID"]),
            Name = row["Name"].ToString(),
            DepartmentID = row["DepartmentID"].ToString(),
            DepartmentName = row["DepartmentName"].ToString(),
            //ImageFileName = row["ImageFileName"] is DBNull ? "" : row["ImageFileName"].ToString()
            //FirstDate = row["FirstDate"] is DBNull ? "" : Convert.ToDateTime(row["FirstDate"]),
            //LastDate = Convert.ToDateTime(row["LastDate"]),
        };


        return e;
    }
}