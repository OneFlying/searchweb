
/**
分页插件
*/
function PageNation(options,exetraParam){

    // this.page = options.page;//当前页
    // this.rows = options.rows;//每页显示多少条
    // this.total_page = 0;
    // this.url = "";

    this.options = options;
    this.exeParam = {page:'1',rows:'10'};

    if(!exetraParam){
        var param = $.extend(this.exeParam,options.page,options.rows);
    }else{
        var param = $.extend(this.exeParam,exetraParam,options.page,options.rows);
    }


    //var me = this;
    if(this.options){

        /*
        获取数据
        */
        this.initPage(options,param);

    }
}

PageNation.prototype = {
    constructor:PageNation,
    prePage : function($el,opts,param){

        var me = this;
        $el.unbind("click");
        $el.bind("click",function(){

            opts.page = param.page = me.options.page-1;

            me.initPage(opts,param);
        });
    },
    nextPage : function($el,opts,param){

        //alert("ok");
        var me = this;
        $el.unbind("click");
        $el.bind("click",function(){

            opts.page = param.page = me.options.page+1;
            me.initPage(opts,param);
        });
    },
    clickPage : function($el,opts,param){

        var me = this;


        $el.unbind("click");
        $el.bind('click',function(){
            opts.page = parseInt($el.text());

            param.page = opts.page;
            me.initPage(opts,param);

        })
    },
    initPage : function(options,exetramParam){

        var opts = $.extend(this.options,options);
        var me = this;

        opts.page = opts.page || 1;//默认值
        opts.rows = opts.rows || 10;//默认值

        var param = $.extend(exetramParam,opts.page,opts.rows);
        $.get(opts.url,param,function(data){

            //获取总页数
            var total_page = Math.ceil(data.rows/opts.rows);//也总页数
            //alert(parseInt(options.screen_width));
            //获取渲染后的对象
            var $ul="";
            if(parseInt(options.screen_width) <= 600){
                $ul = me.renderPageAdapterScreen(total_page,opts,param);
            }else{
                $ul = me.renderPageNation(total_page,opts,param);
            }

            //加载导航条
            $("#"+opts.pageId).children().remove();
            $("#"+opts.pageId).append($ul);

            //var contenthtml = me.callback(data.rows);
        });

    },
    /*
    分辨率改变时渲染导航条
    */
    renderPageAdapterScreen : function(total_page,opts,param){

        var $ul = $("<ul></ul>");

        //前一页
        var $pre_page_li = $("<li></li>");
        var $pre_page_a = $("<a><</a>");
        //如果是第一页则前一页箭头不显示
        if(opts.page == 1){
            $pre_page_li.attr("style","display:none");
        }
        //绑定点击事件
        this.prePage($pre_page_a,opts,param);
        $pre_page_li.append($pre_page_a);
        $ul.append($pre_page_li);

        var $show_page_li = $("<li></li>");
        var $show_page_span = $("<span>第"+opts.page+"页</span>");
        $show_page_li.append($show_page_span);
        $ul.append($show_page_li);

        //后一页
        var $next_page_li = $("<li></li>");
        var $next_page_a = $("<a>></a>");
        if(opts.page == total_page){
            $next_page_li.attr("style","display:none");
        }
        this.nextPage($next_page_a,opts,param);
        $next_page_li.append($next_page_a);


        $ul.append($next_page_li);

        return $ul;
    },
    /*
    渲染导航条
    */
    renderPageNation : function(total_page,opts,param){

        var $ul = $("<ul></ul>");

        //前一页
        var $pre_page_li = $("<li id='pre_page'></li>");
        var $pre_page_a = $("<a><前一页</a>");
        //绑定点击事件
        this.prePage($pre_page_a,opts,param);
        $pre_page_li.append($pre_page_a);
        $ul.append($pre_page_li);

        //后一页
        var $next_page_li = $("<li id='next_page'></li>");
        var $next_page_a = $("<a>后一页></a>");
        this.nextPage($next_page_a,opts,param);
        $next_page_li.append($next_page_a);

        for(var i=0; i < total_page; i++){
            var $li = $("<li></li>");
            var $a = $("<a>"+(i+1)+"</a>");

            if(i == (opts.page-1)){
                $a.addClass('active');
                if(opts.page == 1){
                    $pre_page_li.attr("style","display:none");
                }
                if(opts.page == total_page){
                    $next_page_li.attr("style","display:none");
                }
                this.options.page = opts.page;
            }
            //绑定点击事件
            this.clickPage($a,opts,param);
            $li.append($a);

            $ul.append($li);
        }

        $ul.append($next_page_li);

        return $ul;
    }
}
