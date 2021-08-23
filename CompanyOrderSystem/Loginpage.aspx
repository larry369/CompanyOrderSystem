<%@ Page Language="C#" %>

<!DOCTYPE html>

<script runat="server">
    protected void Page_Load(object sender,EventArgs e)
    {
        Label1.ForeColor = Color.Red;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (TextBox1.Text.Length==5)
        {
            Account m = AccountsUtility.FindAccount(Convert.ToInt32(TextBox1.Text.Substring(1)), TextBox2.Text);
            if (m!=null)
            {
                FormsAuthentication.SetAuthCookie(m.Id.ToString(), false);
                Response.Redirect("~/HomePage.aspx");
            }
            else
            {
                Label1.Text = "登入失敗，帳號或密碼錯誤";
            }
        }
        else
        {
            Label1.Text = "登入失敗，帳號或密碼錯誤";
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />

</head>
<body style="background-color: #5b9bd5">
    <form id="form1" runat="server">
        <div class="container" style="height: 200px;"></div>
        <div class="container">
            <div class="row">
                <div class="col-2"></div>
                <%--<div class="col-4" style="background-color:#97bad9;"></div>--%>
                <img id="loginpage" class="col-4 p-0 m-0" src="Img/LoginImg.png" style="height:400px;"/>
                <div class="col-4 p-4 pt-5" style="background-color:white; height: 400px;">
                    <h4 style="text-align:center;">Testek</h4>
                    <br />
                    <asp:TextBox ID="TextBox1" runat="server" class="form-control form-control-user" Text="A0001" placeholder="員工編號"></asp:TextBox>
                    <br />
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control form-control-user" TextMode="Password" placeholder="密碼"></asp:TextBox>
                    <br />
                    <asp:Button ID="Button1" runat="server" CssClass="form-control btn btn-primary btn-user btn-block" Text="登入" OnClick="Button1_Click"/>
                    <hr />
                    <asp:Label ID="Label1" runat="server"></asp:Label>

                </div>
                <div class="col-2"></div>
            </div>
        </div>

    </form>
    <script src="Scripts/jquery-3.6.0.min.js"></script>
    <script>

</script>
</body>
</html>
