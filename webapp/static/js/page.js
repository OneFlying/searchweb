
var Page = {
    initpage:function(){
        alert("ok");
        var opts = {
            page:1,
            rows:10,
            url:"${RESOUCE_SYSTEM_URL}/article/page",
            pageId:'_pageNation'
        };
        var pageNation = PageNation(opts);
    },
    initContent:function(data){
        var $ul = $("<ul></ul>");
        $ul.addClass('article');
        $(data).each(function(index, item) {

            var li ;
            if(index < 2){
                li = Page.renderProtion(item);
            }else{
                li = Page.renderPage(item);
            }
            //var li = Page.renderPage(item);
            $ul.append(li);
        });
        return $ul;
    },
    clickTitle : function(id){
        window.open("info?id="+id);

    },
    renderProtion:function(obj){
        var $li = $("<li></li>");
        var $a_title = $("<a>"+obj.title+"</a>");
        $a_title.attr("data-id",obj.id);
        $a_title.unbind("click");
        $a_title.bind("click",function(){
            Page.clickTitle($a_title.data("id"));
        });
        $li.addClass('promotion');
        $li.append($a_title);


        var $div_row = $("<div></div>");
        $div_row.addClass('row');

        if(obj.imgids){
            var $div_img = $("<div></div>");
            $div_img.addClass('col-xs-3 col-md-2 col-sm-2');

            var $div_img_contain = $("<div></div>");
            $div_img_contain.addClass('img-adjust');
            var $img = $("<img/>");
            $img.attr("src",obj.imgids);

            $div_img_contain.append($img);
            $div_img.append($div_img_contain);

            var $div_content = $("<div></div>");
            $div_content.addClass('col-xs-9 col-md-10 col-sm-10 content-adjust');

            var $span = $("<span></span>");
            $span.addClass('dec_word');
            $span.text(Page.pageContent(obj.content));
            $div_content.append($span);

            var $a_website = $("<a></a>");
            $a_website.addClass('website');
            $a_website.text(obj.website);
            $a_website.attr("href",obj.website);

            $div_content.append($a_website);

            $div_row.append($div_img);
            $div_row.append($div_content);
        }else{

            var $div_content = $("<div></div>");
            $div_content.addClass('col-xs-12 col-md-12 col-sm-12');

            var $span = $("<span></span>");
            $span.addClass('dec_word');
            $span.text(Page.pageContent(obj.content));
            $div_content.append($span);

            var $a_website = $("<a></a>");
            $a_website.addClass('website');
            $a_website.text(obj.website);
            $a_website.attr("href",obj.website);
            //console.log($a_website);
            $div_content.append($a_website);

            $div_row.append($div_content);
        }

        $li.append($div_row);

        return $li;
    },
    renderPage:function(obj){


        var $li = $("<li></li>");
        var $a_title = $("<a>"+obj.title+"</a>");
        $a_title.attr("data-id",obj.id);
        $a_title.unbind("click");
        $a_title.bind("click",function(){
            Page.clickTitle($a_title.data("id"));
        });

        $li.append($a_title);


        var $div_row = $("<div></div>");
        $div_row.addClass('row');

        if(obj.imgids){
            var $div_img = $("<div></div>");
            $div_img.addClass('col-xs-3 col-md-2 col-sm-2');

            var $div_img_contain = $("<div></div>");
            $div_img_contain.addClass('img-adjust');
            var $img = $("<img/>");
            $img.attr("src",obj.imgids);

            $div_img_contain.append($img);
            $div_img.append($div_img_contain);

            var $div_content = $("<div></div>");
            $div_content.addClass('col-xs-9 col-md-10 col-sm-10 content-adjust');

            var $span = $("<span></span>");
            $span.addClass('dec_word');
            $span.text(Page.pageContent(obj.content));
            $div_content.append($span);

            var $a_website = $("<a></a>");
            $a_website.addClass('website');
            $a_website.text(obj.website);
            $a_website.attr("href",obj.website);

            $div_content.append($a_website);

            $div_row.append($div_img);
            $div_row.append($div_content);
        }else{

            var $div_content = $("<div></div>");
            $div_content.addClass('col-xs-12 col-md-12 col-sm-12');

            var $span = $("<span></span>");
            $span.addClass('dec_word');
            $span.text(Page.pageContent(obj.content));
            $div_content.append($span);

            var $a_website = $("<a></a>");
            $a_website.addClass('website');
            $a_website.text(obj.website);
            $a_website.attr("href",obj.website);
            //console.log($a_website);
            $div_content.append($a_website);

            $div_row.append($div_content);
        }

        $li.append($div_row);

        return $li;
    },
    pageContent : function(str){

        var obj = HtmlUtil.toHtmlStr(str);
        var res="";
        //console.log($(obj));
        $(obj).each(function(index, item) {
            res += HtmlUtil.trim($(item).text(),"g");

        });

        return res.substring(0,200)+"...";
    }
}
