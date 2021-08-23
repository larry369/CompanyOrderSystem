//補0
function padLeft(str, lenght) {
    if (str.length >= lenght)
        return str;
    else
        return padLeft("0" + str, lenght);

}
//function calculate(){

//    var columntotal = parseInt($(`#priceText${i}`).val()) * parseInt($(`#countText${i}`).val());
//    $(`#allpriceText${i}`).val(columntotal);

//    //上方總價
//    var total = 0;
//    for (var j = 1; j <= i; j++) {

//        total += parseInt($(`#allpriceText${j}`).val());
//        //alert("每行相加");
//    }
//    //稅
//    var tex = parseInt($("#TextBoxTex").val()) / 100;
//    $("#TextBoxTex1").val(total * tex);
//    //alert("稅");
//    //console.log(typeof tex);
//    //運費
//    var fre = parseInt($("#TextBoxfre").val());
//    $("#TextBox1total").val(total * (1 + tex) + fre);

//}