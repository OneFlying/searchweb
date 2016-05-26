var Keywrods={

    getContent : function(){
        var url = RESOUCE_SYSTEM_URL_JS+"/websiteconfig/getinfo";

        $.get(url,function(data){
            var obj = data.wc;

            $("meta[name='keywords']").attr("content",obj.keywords);
        });
    }

}
