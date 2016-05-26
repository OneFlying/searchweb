var Evaluate = {
    getMessage : function(articleId,divId){
        //alert(articleId);
        var url = RESOUCE_SYSTEM_URL_JS+"/message/list";
        var param = {articleId:articleId};

        $.get(url,param,function(data){

            var $ul = $("<ul></ul>");

            var $div = $("<div></div>");
            var $hr = $("<hr/>");
            $div.text("评论(共"+data.total+"条评论):");


            $(data.list).each(function(index, el) {
                var $li = Evaluate.render(el);
                $ul.append($li);
            });

            $("#"+divId).children('div').remove();
            $("#"+divId).append($div);
            $("#"+divId).children('hr').remove();
            $("#"+divId).append($hr);
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
