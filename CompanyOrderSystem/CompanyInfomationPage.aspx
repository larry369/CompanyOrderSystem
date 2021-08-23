<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="Style" runat="Server">
    <link href="Content/sweetalert/sweetalert2.min.css" rel="stylesheet" />
    <link href="Content/css/jquery.dataTables.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="myContent" runat="Server">
    <div class="col-lg-9">
        <h1 class="mt-4">廠商資訊</h1>
        <hr />
        <div class="row">
            <div class="col-lg-3">
                <h5>新增廠商</h5>
                <hr />
                廠商名稱：<input type="text" id="CompanyName_txt" class="form-control form-control-user " />
                統一編號：<input type="text" id="TaxID_txt" class="form-control form-control-user" />
                電話：<input type="text" id="phone_txt" class="form-control form-control-user" />
                <hr />
                <input id="btn_LunchCompany" type="button" value="新增" class="btn btn-success" />
                <asp:HyperLink ID="HyperLink1" runat="server" CssClass="btn btn-danger" NavigateUrl="~/Orderpage.aspx">返回</asp:HyperLink>
            </div>
            <div class="col-lg-9">
                <h5>廠商列表</h5>
                <hr />
                <table id="companylist" class="display">
                    <thead>
                        <tr>
                            <th>編號</th>
                            <th>名稱</th>
                            <th>統一編號</th>
                            <th>電話</th>
                            <th>功能</th>
                        </tr>
                    </thead>
                    <tbody id="companyaddhere">
                    </tbody>
                </table>
            </div>
        </div>

        <!--Modal-->
        <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">菜單資訊&nbsp;</h6>
                            廠商名稱：<input type="text" id="ShowCompanyName_txt" style="border: 0px; background-color: rgba(255,255,255,0.2)" /><br />
                            <input type="hidden" id="hidden_ShowCompanyId" />
                            品名<input type="text" id="menuProduct_txt" style="width: 180px;" />
                            種類<input type="text" id="menuType_txt" style="width: 180px;" />
                            價格<input type="text" id="menuPrice_txt" style="width: 180px;" />
                            <a href="#" id="newMenu_btn" class="btn btn-success btn-icon-split">
                                <span class="icon text-white-50">
                                    <i class="fa fa-plus"></i>
                                </span>
                                <span class="text">新增</span>
                            </a>

                        </div>


                        <div class="card-body">
                            <div class="table-responsive">

                                <table class="table-bordered" id="dataTable2" style="width: 100%;" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>品名</th>
                                            <th>種類</th>
                                            <th>價格</th>
                                            <th>功能</th>
                                        </tr>
                                    </thead>
                                    <tbody id="myTableBody2">
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--/Modal-->




    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Script" runat="Server">
    <script src="Scripts/sweetalert/sweetalert2.min.js"></script>
    <script src="Scripts/js/jquery.dataTables.min.js"></script>
    <script src="Scripts/bootstrap4.0.0/js/bootstrap.min.js"></script>
    <script>
        $(function () {
            var data = { get: 0 };
            var i = 0;

            $.ajax({
                type: 'POST',
                async: false,
                url: '/WebService.asmx/GetLunchCompanysQuery',
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(data),
                success: function (data) {
                    $(data.d).each(function (index, item) {
                        i++;
                        $("#companyaddhere").append(
                            `<tr id="tr${i}">
                                    <td><input type="text" id="lcid${i}" value="${item.LunchCompanyID}"  style="border:1px solid transparent;width:50px" readonly="true"/></td>
                                    <td><input type="text" id="lcname${i}" value="${item.LunchCompanyName}"  style="border:1px solid transparent;width:100px" readonly="true"/></td>
                                    <td><input type="text" id="lctax${i}" value="${item.TaxID}"  style="border:1px solid transparent;width:100px" readonly="true"/></td>
                                    <td><input type="text" id="lcphone${i}" value="${item.PhoneNumber}"  style="border:1px solid transparent;width:120px" readonly="true"/></td>
                                    <td>
                                        <input type="hidden" id="hidden_LunchCompanyid${i}"  value="${item.LunchCompanyID}"/>
                                        <input type="hidden" id ="hidden_LunchCompanyName${i}" value="${item.LunchCompanyName}"/>
                                        <input type="hidden" id="hidden_rowid${i}"  value="${i}"/>
                                        <a href="#" id="newproduct_btn${i}" class="btn btn-primary btn-icon-split" title="${i}" style="font-size:small;" data-toggle="modal" data-target=".bd-example-modal-lg"  >
                                        <span class="icon text-white-50">
                                        <i class="fas fa-clipboard-list"></i>
                                        </span>
                                        <span class="text">菜單</span>
                                        </a>
                                        <a href="#" id="update_btn${i}" class="btn btn-info btn-icon-split" title="${i}" style="font-size:small;" onclick="return false">
                                        <span class="icon text-white-50">
                                            <i class="fa fa-wrench"></i>
                                        </span>
                                        <span class="text">修改</span>
                                        </a>
                                        <a href="#" id="delete_btn${i}" class="btn btn-danger btn-icon-split" title="${i}" style="font-size:small;" >
                                        <span class="icon text-white-50">
                                            <i class="fas fa-trash"></i>
                                        </span>
                                        <span class="text">刪除</span>
                                        </a>
                                        <a href="#" id="updatecomplete_btn${i}" class="btn btn-success btn-icon-split" title="${i}" style="font-size:small;display:none;" >
                                        <span class="icon text-white-50">
                                            <i class="fa fa-check"></i>
                                        </span>
                                        <span class="text">完成</span>
                                        </a>
                                        <a href="#" id="updatecancel_btn${i}" class="btn btn-warning btn-icon-split" title="${i}" style="font-size:small;display:none;" >
                                        <span class="icon text-white-50">
                                            <i class="fa fa-times"></i>
                                        </span>
                                        <span class="text">取消</span>
                                        </a>
                                    </td>
                                </tr>`);
                        $(`#update_btn${i}`).click(function () {
                            var u = $(this).attr("title");
                            $("#tr" + u + " input").css("border", "1px solid black");
                            $("#tr" + u + " input").removeAttr("readonly");
                            $("#lcid" + u).css("border", "1px solid transparent");
                            $("#lcid" + u).attr("readonly", "true");
                            $("#newproduct_btn" + u).css("display", "none");
                            $("#update_btn" + u).css("display", "none");
                            $("#delete_btn" + u).css("display", "none");
                            $("#updatecomplete_btn" + u).css("display", "");
                            $("#updatecancel_btn" + u).css("display", "");
                        });
                        $(`#updatecomplete_btn${i}`).click(function () {
                            var uc = $(this).attr("title");
                            $("#tr" + uc + " input").css("border", "1px solid transparent");
                            $("#tr" + uc + " input").attr("readonly", "true");
                            $("#newproduct_btn" + uc).css("display", "");
                            $("#update_btn" + uc).css("display", "");
                            $("#delete_btn" + uc).css("display", "");
                            $("#updatecomplete_btn" + uc).css("display", "none");
                            $("#updatecancel_btn" + uc).css("display", "none");
                            var dataupdatelc = { lcid: parseInt($("#hidden_LunchCompanyid" + uc).val()), lcname: $("#lcname" + uc).val(), taxid: $("#lctax" + uc).val(), phonenumber: $("#lcphone" + uc).val() };
                            $("#hidden_LunchCompanyName" + uc).val($("#lcname" + uc).val());
                            $.ajax({
                                type: 'POST',
                                url: '/WebService.asmx/UpdateLunchCompany',
                                contentType: "application/json;charset=utf-8",
                                data: JSON.stringify(dataupdatelc),
                                success: function (data) {
                                    //alert("新增成功")

                                },
                                error: function (x) {
                                    alert("company add error");
                                }
                            });

                        });
                        $(`#updatecancel_btn${i}`).click(function () {
                            var uc = $(this).attr("title");
                            $("#tr" + uc + " input").css("border", "1px solid transparent");
                            $("#tr" + uc + " input").attr("readonly", "true");
                            $("#newproduct_btn" + uc).css("display", "");
                            $("#update_btn" + uc).css("display", "");
                            $("#delete_btn" + uc).css("display", "");
                            $("#updatecomplete_btn" + uc).css("display", "none");
                            $("#updatecancel_btn" + uc).css("display", "none");

                        });
                        $(`#delete_btn${i}`).click(function () {
                            var dc = $(this).attr("title");
                            swal({
                                title: '確定要刪除嗎?',
                                text: "刪除會將系統中廠商菜單一併刪除!",
                                type: 'warning',
                                showCancelButton: true,
                            }).then(
                                function () {

                                    var data = { id: $("#hidden_LunchCompanyid" + dc).val() };
                                    $.ajax({
                                        type: 'POST',
                                        async: false,
                                        url: '/WebService.asmx/DeleteLunchCompany',
                                        contentType: "application/json;charset=utf-8",
                                        data: JSON.stringify(data),
                                        success: function (data) {

                                        },
                                        error: function (x) {
                                            alert("delete error");
                                        }
                                    });
                                    var data3 = { id: $("#hidden_LunchCompanyid" + dc).val() };

                                    $.ajax({
                                        type: 'POST',
                                        async: false,
                                        url: '/WebService.asmx/DeleteLunchMenusById',
                                        contentType: "application/json;charset=utf-8",
                                        data: JSON.stringify(data3),
                                        success: function (data) {

                                        },
                                        error: function (x) {
                                            alert("delete error");
                                        }
                                    });

                                    $("#tr" + dc).remove();

                                    swal('完成!', '廠商已經刪除', 'success')
                                },
                                function (dismiss) {
                                    if (dismiss === 'cancel') {
                                        swal('取消', '廠商未被刪除', 'error')
                                    }
                                });
                        });
                        $(`#newproduct_btn${i}`).click(function () {
                            //alert($(this).attr("title"));
                            var x = $(this).attr("title");
                            //alert($("#hidden_LunchCompanyName"+x).attr("value"));

                            //alert($(`#hidden_LunchCompanyid${x}`).attr("value"));
                            //alert($(`#hidden_LunchCompanyName${x}`).attr("value"));
                            var CompanyName = $(`#hidden_LunchCompanyName${x}`).attr("value");
                            var CompanyId = $(`#hidden_LunchCompanyid${x}`).attr("value");

                            $("#ShowCompanyName_txt").val(CompanyName);
                            $("#hidden_ShowCompanyId").val(CompanyId);

                            $("#myTableBody2").empty();

                            //showmenu
                            var data1 = { id: $("#hidden_ShowCompanyId").val() };
                            var m = 0;
                            $.ajax({
                                type: 'POST',
                                async: false,
                                url: '/WebService.asmx/GetMenusQueryById',
                                contentType: "application/json;charset=utf-8",
                                data: JSON.stringify(data1),
                                success: function (data) {
                                    //alert("Hello");
                                    $(data.d).each(function (index, item) {
                                        m++;

                                        $("#myTableBody2").append(
                                            `<tr id="menutr${m}">
                                        <td>${item.LunchName}</td>
                                        <td>${item.LunchType}</td>
                                        <td>${item.Price}</td>
                                        <td>
                                            <input type="hidden" id="hidden_menuLunchCompanyid${m}"  value="${item.LunchCompanyID}"/>
                                            <input type="hidden" id ="hidden_menuLunchCompanyName${m}" value="${item.LunchName}"/>
                                                <a href="#" id="menusDelete_btn${m}" class="btn btn-danger btn-icon-split" title="${m}">
                                                <span class="icon text-white-50">
                                                    <i class="fas fa-trash"></i>
                                                </span>
                                                <span class="text">刪除</span>
                                                </a>
                                        </td>
                                    </tr>`);
                                        $(`#menusDelete_btn${m}`).click(function () {
                                            var d = $(this).attr("title");
                                            if (confirm("確定要刪除嗎?") == true) {
                                                var data5 = { id: $("#hidden_menuLunchCompanyid" + d).val(), name: $("#hidden_menuLunchCompanyName" + d).val() };
                                                $.ajax({
                                                    type: 'POST',
                                                    async: false,
                                                    url: '/WebService.asmx/DeleteLunchMenuByIdandName',
                                                    contentType: "application/json;charset=utf-8",
                                                    data: JSON.stringify(data5),
                                                    success: function (data) {

                                                    },
                                                    error: function (x) {
                                                        alert("delete error");
                                                    }
                                                });

                                                $("#menutr" + d).remove();
                                            }

                                        });
                                    })
                                },
                                error: function (x) {
                                    alert("show error");
                                }
                            });
                            //showmenuend

                        });


                    })
                    $('#companylist').DataTable();

                },
                error: function (x) {

                }
            });
            //新增廠商
            $("#btn_LunchCompany").click(function () {
                var data = { name: $("#CompanyName_txt").val(), taxID: $("#TaxID_txt").val(), phone: $("#phone_txt").val() }
                $.ajax({
                    type: 'POST',
                    async: false,
                    url: '/WebService.asmx/LunchCompanyAdd',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(data),
                    success: function (data) {

                        location.href = "CompanyInfomationPage.aspx";
                    },
                    error: function (x) {
                        alert("company add error");
                    }
                });
            });
            //新增廠商end
            //新增菜單
            $("#newMenu_btn").click(function () {
                var data = { id: $("#hidden_ShowCompanyId").val(), name: $("#menuProduct_txt").val(), type: $("#menuType_txt").val(), price: $("#menuPrice_txt").val() }
                $.ajax({
                    type: 'POST',
                    async: false,
                    url: '/WebService.asmx/MenuAdd',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(data),
                    success: function (data) {
                    },
                    error: function (x) {
                        alert("menu add error");
                    }
                });

                $("#myTableBody2").empty();
                var data1 = { id: $("#hidden_ShowCompanyId").val() };
                var m = 0;
                $.ajax({
                    type: 'POST',
                    async: false,
                    url: '/WebService.asmx/GetMenusQueryById',
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(data1),
                    success: function (data) {
                        $(data.d).each(function (index, item) {
                            m++;

                            $("#myTableBody2").append(
                                `<tr id="menutr${m}">
                                        <td>${item.LunchName}</td>
                                        <td>${item.LunchType}</td>
                                        <td>${item.Price}</td>
                                        <td>
                                            <input type="hidden" id="hidden_menuLunchCompanyid${m}"  value="${item.LunchCompanyID}"/>
                                            <input type="hidden" id ="hidden_menuLunchCompanyName${m}" value="${item.LunchName}"/>
                                            <a href="#" id="menusDelete_btn${m}" class="btn btn-danger btn-icon-split" title="${m}">
                                            <span class="icon text-white-50">
                                                <i class="fas fa-trash"></i>
                                            </span>
                                            <span class="text">刪除</span>
                                            </a>
                                        </td>
                                    </tr>`);
                            $(`#menusDelete_btn${m}`).click(function () {
                                var d = $(this).attr("title");
                                swal({
                                    title: '確認?',
                                    text: "品項即將被刪除!",
                                    type: 'warning',
                                    showCancelButton: true,
                                }).then(
                                    function () {

                                        var data5 = { id: $("#hidden_menuLunchCompanyid" + d).val(), name: $("#hidden_menuLunchCompanyName" + d).val() };
                                        $.ajax({
                                            type: 'POST',
                                            async: false,
                                            url: '/WebService.asmx/DeleteLunchMenuByIdandName',
                                            contentType: "application/json;charset=utf-8",
                                            data: JSON.stringify(data5),
                                            success: function (data) {

                                            },
                                            error: function (x) {
                                                alert("delete error");
                                            }
                                        });

                                        $("#menutr" + d).remove();

                                        swal('完成!', '品項已經刪除', 'success')
                                    },
                                    function (dismiss) {
                                        if (dismiss === 'cancel') {
                                            swal('取消', '品項未被刪除', 'error')
                                        }
                                    });
                            });
                        })
                    },
                    error: function (x) {
                        alert("show error");
                    }
                });


            });
            //新增菜單end

        });
    </script>

</asp:Content>

