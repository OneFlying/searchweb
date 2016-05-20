
var HtmlUtil = {
    toHtmlStr : function(res){
        var objE = document.createElement("div");

    　　 objE.innerHTML = res;

    　　 var obj = objE.childNodes;

        return obj;
    },
    trim: function(str,is_global){

        var result;
        result = str.replace(/(^\s+)|(\s+$)/g,"");
        if(is_global.toLowerCase()=="g")
        {
            result = result.replace(/\s/g,"");
         }
        return result;
    }
}
