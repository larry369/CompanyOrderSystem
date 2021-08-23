<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        HiddenId.Value = HttpContext.Current.User.Identity.Name;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="Style" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="myContent" runat="Server">
    <div class="col-lg-9">

        <h1 class="mt-4">首頁</h1>
        <asp:HiddenField ID="HiddenId" runat="server" />
        <div class="table-responsive">
            <table class="table table-bordered" id="dataTablehpinfo" style="width: 100%;">
                <thead>
                    <tr>
                        <th>訂單資訊</th>
                        <th>數量</th>
                        <th>價格</th>
                    </tr>
                </thead>
                <tbody id="dataTablehpinfoshow">
                </tbody>
            </table>
        </div>
        <hr />
        <span>總價：<input type="text" id="TotalPrice" style="border:none;text-align:right;color:dodgerblue;"/>&nbsp;元</span>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Script" runat="Server">
    <script>
        $(function () {
            var dataid = { id: $("#myContent_HiddenId").val() };
            var o = 0;
            var Lasttotal = 0;
            $.ajax({
                type: 'POST',
                async: false,
                url: '/WebService.asmx/GetLunchOrderQueryById',
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(dataid),
                success: function (data) {
                    $(data.d).each(function (index, item) {
                        o++;
                        $("#dataTablehpinfoshow").append(
                            `<tr id="ordertr${o}">
                                        <td>${item.OrderInfo}</td>
                                        <td>${item.OrderCount}</td>
                                        <td id="orderprice${o}" title="${item.OrderPrice}">${item.OrderPrice}</td>
                                    </tr>`);
                        Lasttotal += parseInt($("#orderprice" + o).attr("title"));
                    })
                    $("#TotalPrice").val(Lasttotal);
                },
                error: function (x) {

                }
            });

        });
    </script>
</asp:Content>

