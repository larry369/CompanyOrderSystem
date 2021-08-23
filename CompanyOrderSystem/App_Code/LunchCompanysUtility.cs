using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for LunchCompanysUtility
/// </summary>
public class LunchCompanysUtility
{
    public static List<LunchCompanys> FindAllLunchCompanys()
    {
        string cnStr = ConfigurationManager.ConnectionStrings["CompanyOrderSystemConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("Select * From LunchCompanys", cnStr);

        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            return null;
        }
        var query = from row in dt.AsEnumerable()
                    select new LunchCompanys()
                    {
                        LunchCompanyID = Convert.ToInt32(row["LunchCompanyID"]),
                        LunchCompanyName = row["LunchCompanyName"].ToString(),
                        TaxID = row["TaxID"].ToString(),
                        PhoneNumber = row["PhoneNumber"].ToString()
                    };

        return query.ToList();
    }
    public static void UpdateLunchCompany(LunchCompanys lunchcomp)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["CompanyOrderSystemConnectionString1"].ConnectionString;
        SqlConnection cn = new SqlConnection(cnStr);
        SqlCommand cmd = new SqlCommand(
            "Update LunchCompanys  set LunchCompanyName=@LunchCompanyName , TaxID=@TaxID, PhoneNumber=@PhoneNumber where LunchCompanyID=@LunchCompanyID ", cn);

        cmd.Parameters.AddWithValue("@LunchCompanyID", lunchcomp.LunchCompanyID);
        cmd.Parameters.AddWithValue("@LunchCompanyName", lunchcomp.LunchCompanyName);
        cmd.Parameters.AddWithValue("@TaxID", lunchcomp.TaxID);
        cmd.Parameters.AddWithValue("@PhoneNumber", lunchcomp.PhoneNumber);


        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static void DeleteLunchCompanyById(int id)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["CompanyOrderSystemConnectionString1"].ConnectionString;
        SqlConnection cn = new SqlConnection(cnStr);
        SqlCommand cmd = new SqlCommand("Delete From LunchCompanys where LunchCompanyID = @LunchCompanyID", cn);

        cmd.Parameters.AddWithValue("@LunchCompanyID", id);

        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static void InsertLunchCompany(LunchCompanys lunchComp)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["CompanyOrderSystemConnectionString1"].ConnectionString;
        SqlConnection cn = new SqlConnection(cnStr);
        SqlCommand cmd = new SqlCommand(
            "insert into LunchCompanys (LunchCompanyName, TaxID, PhoneNumber) values (@LunchCompanyName, @TaxID, @PhoneNumber)", cn);

        cmd.Parameters.AddWithValue("@LunchCompanyName", lunchComp.LunchCompanyName);
        cmd.Parameters.AddWithValue("@TaxID", lunchComp.TaxID);
        cmd.Parameters.AddWithValue("@PhoneNumber", lunchComp.PhoneNumber);


        cn.Open();
        cmd.ExecuteNonQuery();
        cn.Close();
    }
    public static LunchCompanys FindAllLunchCompanysById(string id)
    {
        string cnStr = ConfigurationManager.ConnectionStrings["CompanyOrderSystemConnectionString1"].ConnectionString;
        SqlDataAdapter da = new SqlDataAdapter("Select * From LunchCompanys where LunchCompanyID=@LunchCompanyID", cnStr);
        da.SelectCommand.Parameters.AddWithValue("@LunchCompanyID", id);

        DataTable dt = new DataTable();
        da.Fill(dt);
        if (dt.Rows.Count == 0)
        {
            return null;
        }
        var query = from row in dt.AsEnumerable()
                    select new LunchCompanys()
                    {
                        LunchCompanyID = Convert.ToInt32(row["LunchCompanyID"]),
                        LunchCompanyName = row["LunchCompanyName"].ToString(),
                        TaxID = row["TaxID"].ToString(),
                        PhoneNumber = row["PhoneNumber"].ToString()
                    };

        return query.SingleOrDefault();
    }

}