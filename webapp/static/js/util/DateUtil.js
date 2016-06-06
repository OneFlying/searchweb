var DateUtil = {

    getLocalStyleDate : function(date){
        var date1 = date.split(" ");
        var date2 = date1[0].split("-");

        var res = date2[0]+"年"+date2[1]+"月"+date2[2]+"日";

        return res;
    }
}
