var Evaluate = {
    length: 0,
    getMessage : function(articleId,divId){
        //alert(articleId);
        var url = RESOUCE_SYSTEM_URL_JS+"/message/list";
        var param = {articleId:articleId};

        $.get(url,param,function(data){

            var $ul = $("<ul></ul>");

            $('.s_g_title').html("评论 (共"+data.total+"条评论):");

            $(data.list).each(function(index, el) {
                Evaluate.length += 1;
                var $li = Evaluate.render(el);
                $ul.append($li);
            });

            $("#"+divId).children('ul').remove();
            $("#"+divId).append($ul);
        });
    },

    render : function(item){
        var $li = $("<li></li>");

        var $span1 = $("<span class='list_text'></span>");
        $span1.text(item.content);
        $li.append($span1);

        var $span2 = $("<span class='list_date'></span>");
        $span2.text(item.date);

        $li.append($span2);

        return $li;

    }
}
