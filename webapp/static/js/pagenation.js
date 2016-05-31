
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
     firstPage : function($el,opts,param){

        var me = this;
        $el.unbind("click");
        $el.bind("click",function(){

            opts.page = param.page = me.options.page-1;

            me.initPage(opts,param);
        });
    },
    nextPage : function($el,opts,param,total_page){

        //alert("ok");
        var me = this;
        //if(opts.page > total_page)
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
        var p = navigator.platform;
        system.win = p.indexOf("Win") == 0;
        system.mac = p.indexOf("Mac") == 0;
        system.x11 = (p == "X11") || (p.indexOf("Linux") == 0);
       
        var opts = $.extend(this.options,options);
        var me = this;

        opts.page = opts.page || 1;//默认值
        opts.rows = opts.rows || 10;//默认值

        var param = $.extend(exetramParam,opts.page,opts.rows);
        $.get(opts.url,param,function(data){

            if(data.rows != undefined){
                $(".nums").text("共为您搜索到 "+data.rows+" 条相关数据");
            }else{
                $(".nums").text("共为您搜索到 0 条相关数据");
            }

            //获取总页数
            var total_page = Math.ceil(data.rows/opts.rows);//也总页数
            //获取渲染后的对象
            var $ul="";
             if(system.win||system.mac||system.x11){//如果是电脑
               // alert('是电脑');
                $ul = me.renderPageNation(total_page,opts,param);
            }else{ //如果是手机
                //alert('是手机');
                $ul = me.renderPageAdapterScreen(total_page,opts,param);
             }
            /*if(parseInt(options.screen_width) <= 700){
                $ul = me.renderPageAdapterScreen(total_page,opts,param);
            }else{
                $ul = me.renderPageNation(total_page,opts,param);
            }*/

            //加载导航条
            $("#"+opts.pageId).children().remove();
            if(data.rows != undefined){
                $("#"+opts.pageId).append($ul);
            }
            //console.log(data);

            var contenthtml = Page.initContent(data.list,data.promotion,param.keywords);

            $("#"+opts.contentId).children().remove();
            //$("#"+opts.contentId).append(contenthtml);
            $('#'+opts.contentId).append(contenthtml[0]);
            $('#'+opts.contentId).append(contenthtml[1]);

        });

    },
   /* renderPictrue: function(total_page,opts,param)
        var $ul = $("<ul></ul>");
        var $pre_page_li = $("<li></li>");
        var $pre_page_a = $("<a><</a>");
        //如果是第一页则前一页箭头不显示
        if(opts.page == 1){
            $pre_page_li.attr("style","display:none");
        }
         this.prePage($pre_page_a,opts,param);
        $pre_page_li.append($pre_page_a);
        $ul.append($pre_page_li);
    },*/
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
        if(opts.page == 1){
            $show_page_li.attr("style","display:none");
        }
        $show_page_li.append($show_page_span);
        $ul.append($show_page_li);
        /*if(opts.page > 11){
            
        }*/
        //后一页
        var $next_page_li = $("<li></li>");
        var $next_page_a;
        if(opts.page == 1){
            $next_page_a = $("<a>下一页</a>");
            //$next_page_li..attr("style","display:none");
        }else{
            $next_page_a = $("<a>></a>");
        }
        if(opts.page == total_page){
            $next_page_li.attr("style","display:none");
        }
        this.nextPage($next_page_a,opts,param);
        $next_page_li.append($next_page_a);


        $ul.append($next_page_li);

        if(total_page != 0){
            return $ul;
        }

    },
    /*
    渲染导航条
    */
    renderPageNation : function(total_page,opts,param){
       // alert(opts.page);
        var $ul = $("<ul id ='ul_title'></ul>");

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
        this.nextPage($next_page_a,opts,param,total_page);
        $next_page_li.append($next_page_a);
        //alert(opts.page);
        //模仿百度的分页机制
        //大于10页时
        if(total_page > 10){
            //点击7以后
            if(opts.page > 6){
                /*for(var i=0; i < 10; i++){*/
                    if( total_page < 11){
                        for(var i=0; i < 10; i++){
                            var $li = $("<li></li>");
                            var $a = $("<a>"+(i+1)+"</a>");
                            $li.append($a);
                            $ul.append($li);
                            if(i == (opts.page-1)){
                                $a.addClass('active');            
                                if(opts.page == 1){
                                    $pre_page_li.css({display:"none"});
                                }
                                if(opts.page == total_page){
                                    $next_page_li.css({display:"none"});
                                }
                                    this.options.page = opts.page;
                            }                  
                            //绑定点击事件
                            this.clickPage($a,opts,param); 
                        }
                    }else{
                        //判断所选页和总数的差值，当差值大于4时，正常执行，当小于4时，则页数的生成不变，参考百度  gaoqijun
                        var chaju = total_page - opts.page;
                        //alert(chaju);
                        if(chaju > 4){
                            for(var i=0; i < 10; i++){
                                var $li = $("<li></li>");
                                var $a = $("<a>"+(opts.page-5+i)+"</a>");
                                 $li.append($a);
                                $ul.append($li);
                                if((opts.page-5+i) == opts.page){
                                    $a.addClass('active');            
                                    if(opts.page == 1){
                                        $pre_page_li.css({display:"none"});
                                    }
                                    if(opts.page == total_page){
                                        $next_page_li.css({display:"none"});
                                    }
                                        this.options.page = opts.page;
                                }                  
                                //绑定点击事件
                                this.clickPage($a,opts,param); 
                            }
                        }else{
                            for(var i = total_page -9; i <= total_page ;i++){
                                var $li = $("<li></li>");
                                var $a = $("<a>"+i+"</a>");
                                $li.append($a);
                                $ul.append($li);
                                if(i == opts.page){
                                    $a.addClass('active');            
                                    if(opts.page == 1){
                                        $pre_page_li.css({display:"none"});
                                    }
                                    if(opts.page == total_page){
                                        $next_page_li.css({display:"none"});
                                    }
                                        this.options.page = opts.page;
                                }                  
                                //绑定点击事件
                                this.clickPage($a,opts,param); 
                            }
                        }
                       
                    }
                    
              //  }
              //不点击7以后的页数时
            }else{
                for(var i=0; i < 10; i++){
                    var $li = $("<li></li>");
                    var $a = $("<a>"+(i+1)+"</a>");
                    $li.append($a);
                    $ul.append($li);
                    if(i == (opts.page-1)){
                        $a.addClass('active');            
                        if(opts.page == 1){
                            $pre_page_li.css({display:"none"});
                        }
                        if(opts.page == total_page){
                            $next_page_li.css({display:"none"});
                        }
                        this.options.page = opts.page;
                    }                  
                //绑定点击事件
                this.clickPage($a,opts,param); 
                }
            }
              //小于10页
        }else{
            for(var i=0; i < total_page; i++){
                var $li = $("<li id = '"+(i+1)+"'></li>");
                var $a = $("<a>"+(i+1)+"</a>"); 
                $li.append($a);
                $ul.append($li);
                if(i == (opts.page-1)){
                    $a.addClass('active');
                   
                    if(opts.page == 1){
                        $pre_page_li.css({display:"none"});
                    }
                    if(opts.page == total_page){
                        $next_page_li.css({display:"none"});
                    }
                        this.options.page = opts.page;
                    }                  
            //绑定点击事件
            this.clickPage($a,opts,param);  

            }
        } 
        /*for(var i=0; i < total_page; i++){
            if(i < 10){
                var $li = $("<li id = '"+(i+1)+"'></li>");
                var $a = $("<a>"+(i+1)+"</a>");
            }
            $li.append($a);
            $ul.append($li);
            if(i == (opts.page-1)){
                $a.addClass('active');
               
                if(opts.page == 1){
                    $pre_page_li.attr("style","display:none");
                }
                if(opts.page == total_page){
                    $next_page_li.attr();
                }
                    this.options.page = opts.page;
                }                  
            //绑定点击事件
            this.clickPage($a,opts,param);  

        }*/

        $ul.append($next_page_li);

        return $ul;
    }
}
