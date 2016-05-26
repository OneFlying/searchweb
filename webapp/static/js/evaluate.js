var Evaluate = {
    getMessage : function(articleId,divId){
        //alert(articleId);
        var url = RESOUCE_SYSTEM_URL_JS+"/message/list";
        var param = {articleId:articleId};

        $.get(url,param,function(data){
            var $ul = $("<ul></ul>");
            $(data.list).each(function(index, el) {
                var $li = Evaluate.render(el);
                $ul.append($li);
            });
            $("#"+divId).children('ul').remove();
            $("#"+divId).append($ul);
        });
    },

    render : function(item){
        var $li = $("<li></li>");

        var $span1 = $("<span></span>");
        $span1.text(item.content);
        $li.append($span1);

        var $span2 = $("<span></span>");
        $span2.attr("class","time");
        $span2.text(item.date);

        $li.append($span2);

        return $li;

    }
}
