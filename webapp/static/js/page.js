
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
    initContent:function(data,promotion,keywords){

        //var $ul = $("<ul></ul>");
        //$ul.addClass('article');
        var obj = [];
        var div1 = $('<div class="content_top"></div>');
        var div2 = $('<div class="c-container"></div>');
        $(data).each(function(index, item) {
            var li ;
            if((index < 2) &&(promotion)){
                li = Page.renderProtion(item,keywords);
                li.appendTo(div1);
            }else{
                li = Page.renderPage(item,keywords);
                li.appendTo(div2);
            }
            //$ul.append(li);
        });
        if (div1.html().length != 0) {
        	obj.push(div1);
        }
        obj.push(div2);
        //return $ul;
        return obj;
    },
    clickTitle : function(id){
        window.open("info?id="+id);
    },
    //渲染推广
    renderProtion:function(obj,keywords){
        var div = $('<div class="content_top_item"></div>'),
            a = $('<a href="#"></a>');

        var title = $('<div class="content_title" data-id="'+obj.id+'">'+obj.title+'</div>');
        title.bind('click',function (event) {
            event.preventDefault();
            Page.clickTitle(title.data("id"));
        });
        title.appendTo(a);

        var content = $('<div class="content_content" data-id="'+obj.id+'"></div>'),
            right = $('<div class="c_col_r"></div>'),
            p = $('<p></p>'),
            link = $('<div class="content_link"></div>'),
            link_a = $('<a href="'+obj.website+'" target="_blank">'+obj.website+'</a>');

        content.bind('click',function (event) {
            event.preventDefault();
            Page.clickTitle(content.data("id"));
        });

        link_a.appendTo(link);

        var cont = Page.pageContent(obj.content);
        var regStr=new RegExp("("+keywords+")","g");
        var str = cont.replace(regStr,"<font style='color:red;'>"+keywords+"</font>");

        p.html(str);
        p.appendTo(right);

        if(obj.imgids) {
            var left = $('<div class="c_col_l"></div>'),
                left_a = $('<a href="#"></a>'),
                left_img = $('<img alt="ad" src="'+obj.imgids+'" />');
            left_img.appendTo(left_a);
            left_a.appendTo(left);
            left.appendTo(content);
        }
        right.appendTo(content);
        content.appendTo(a);
        link.appendTo(a);
        a.appendTo(div);
        return div;

        /*var $li = $("<li></li>");
         var $a_title = $("<a>"+obj.title+"</a>");
         $a_title.attr("data-id",obj.id);
         $a_title.unbind("click");
         $a_title.bind("click",function(){
         Page.clickTitle($a_title.data("id"));
         });
         $li.addClass('promotion');
         $li.append($a_title);*/

        // var $div_row = $("<div></div>");
        // $div_row.addClass('row');

        /*if(obj.imgids){

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

            var content_ = Page.pageContent(obj.content);
            var reg=new RegExp("("+keywords+")","g");
            var newstr = content_.replace(reg,"<font style='color:red;'>"+keywords+"</font>");
            $span.html(newstr);
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
            var content_ = Page.pageContent(obj.content);
            var reg=new RegExp("("+keywords+")","g");
            var newstr = content_.replace(reg,"<font style='color:red;'>"+keywords+"</font>");
            $span.html(newstr);
            $div_content.append($span);

            var $a_website = $("<a></a>");
            $a_website.addClass('website');
            $a_website.text(obj.website);
            $a_website.attr("href",obj.website);
            //console.log($a_website);
            $div_content.append($a_website);

            $div_row.append($div_content);
        }

        $li.append($div_row);*/

        //return $li;
    },
    //渲染搜索结果
    renderPage:function(obj,keywords){
        var content_ = Page.pageContent(obj.title,true);
        var reg=new RegExp("("+keywords+")","g");
        var title = content_.replace(reg,"<font style='color:#CC0000'>"+keywords+"</font>");
        var row = $('<div class="c-row"></div>'),
            h = $('<h3></h3>'),
            h_a = $('<a href="#" data-id="'+obj.id+'" target="_blank">'+title+'</a>');

        h_a.appendTo(h);
        h.appendTo(row);
        h_a.bind('click',function (event) {
            event.preventDefault();
            h_a.addClass('active');
            Page.clickTitle(h_a.data("id"));
        });

        var right = $('<div class="c_col_r"></div>'),
            p = $('<p></p>'),
            link = $('<div class="c_col_link"></div>'),
            link_a = $('<a target="_blank" href="'+obj.website+'">'+obj.website+'</a>');
        link_a.appendTo(link);

        content_ = Page.pageContent(obj.content);
        var newstr = content_.replace(reg,"<font style='color:#CC0000;'>"+keywords+"</font>");
        p.html(newstr);
        p.appendTo(right);

        if (obj.imgids) {
            var left = $('<div class="c_col_l"></div>'),
                left_a = $('<a href="'+obj.website+'" target="_blank"></a>'),
                left_img = $('<img alt="ad" src="'+obj.imgids+'" />');
            left_img.appendTo(left_a);
            left_a.appendTo(left);
            left.appendTo(row);
        }

        right.appendTo(row);
        link.appendTo(row);
        return row;

        /*var $li = $("<li></li>");
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

            var content_ = Page.pageContent(obj.content);
            var reg=new RegExp("("+keywords+")","g");
            var newstr = content_.replace(reg,"<font style='color:red;'>"+keywords+"</font>");
            $span.html(newstr);
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

            var content_ = Page.pageContent(obj.content);
            var reg=new RegExp("("+keywords+")","g");
            var newstr = content_.replace(reg,"<font style='color:red;'>"+keywords+"</font>");
            $span.html(newstr);

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

        return $li;*/
    },
    pageContent : function(str,isBool){

        var obj = HtmlUtil.toHtmlStr(str);
        var res="";
        //console.log($(obj));
        $(obj).each(function(index, item) {
            res += HtmlUtil.trim($(item).text(),"g");

        });
        if (isBool)
            return res;
        return res.substring(0,150)+"...";
    },
    getRelSearchData : function(keywords,isMobile){

        var url = RESOUCE_SYSTEM_URL_JS+"/relsearch/list";
        var param = {keywords:keywords};
        $.get(url,param,function(data){

            if(data.success){

                var tableHtml = Page.renderRelSearch(data.list,isMobile);
                $("#rs").children().remove();
                if(data.list != null) {
                    $('#rs').append('<div class="tt">相关搜索</div>');
                }
                $("#rs").append(tableHtml);
            }else{

            }

        });
    },
    renderRelSearch : function(list,isMobile){//相关搜索
        var $tbody = $("<tbody></tbody>");

        // var res = Math.ceil(list.length/3);
        // var flag = true;
        var row = isMobile ? 4 : 3;
        var col = isMobile ? 2 : 3;

        var t=0;
        for(var i=0;i<row;i++){
            var $tr = $("<tr></tr>");

            /*
            展现数据有问题
            */
            for(var k=0;k<col;k++,t++){


                if(list[t] != undefined){
                    var $td = $("<td></td>");
                    var $a = $("<a></a>");
                    var key = list[t].keywords;
                    if(isMobile) {
                        var width = $('#rs').width();
                        $td.css({width:width/2-1});
                        if (k == 1) {
                            $a.css({borderLeft: '1px solid #dadada'});
                        }
                    }

                    $a.attr("href",RESOUCE_SYSTEM_URL_JS+"/article/list?keywords="+key);
                    $a.text(key);
                    $td.append($a);
                    $tr.append($td);
                }

            }
            $tbody.append($tr);
        }

        return $tbody;
    },
    getAdertInfo : function(keywords,divId){
        var url = RESOUCE_SYSTEM_URL_JS+"/advert/list";
        var param = {keywords:keywords};
        $.get(url,param,function(data){
            $("#"+divId).children().remove();
            if(data.list != null && data.list.length != 0) {
                //console.log(data.list);
                $('#'+divId).append('<span style="font-size:14px;font-weight:bold;margin-bottom:10px;display:block;">广告推荐</span>');
            }
            Page.renderAdvert(data.list,divId);
        });
    },
    renderAdvert : function(list,divId){
        var html = '<table>';
        var t = 0;
        var length = Math.ceil(list.length/4);
        for (var i = 0; i < length; i ++) {
            html += '<tr>';
            for(var k = 0; k < 4; k ++,t ++) {
                if(list[t] != undefined) {
                    html += '<td>'
                        + '<img alt="ad" src="' + list[t].logourl + '" />'
                        + '<a href="' + list[t].adurl + '" title="' + list[t].title + '">' + list[t].desc + '</a>'
                        + '</td>';
                }
            }
            html += '</tr>';
        }
        html += '</table>';
        $('#'+divId).html($('#'+divId).html() + html);
        // var t=0;
        // for(var i=0;i<4;i++){
        //     var table = $('<table></table>');
        //     var $rowDiv = $("<div></div>");
        //     $rowDiv.addClass('row');
        //     for(var k=0;k<3;k++,t++){
        //
        //         if(list[t] != undefined){
        //
        //             var $topDiv = $("<div></div>");
        //             $topDiv.addClass('col-sm-4 col-md-4');
        //
        //             var $div = $("<div></div>");
        //             $div.addClass('ad-item');
        //
        //             var $img = $("<img/>");
        //             $img.attr("src",list[t].logourl);
        //
        //             var $a = $("<a></a>");
        //             $a.attr("href",list[t].adurl);
        //             $a.text(list[t].title);
        //
        //             var $span = $("<span></span>");
        //             $span.text(list[t].desc);
        //
        //             $div.append($img);
        //             $div.append($a);
        //             $div.append($span);
        //
        //             $topDiv.append($div);
        //
        //             $rowDiv.append($topDiv);
        //         }
        //     }
        //     $("#"+divId).append($rowDiv);
        // }
    }

}
