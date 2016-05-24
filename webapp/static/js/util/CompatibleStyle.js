var CompStyle = {
    lineStyle : function(){
        var isIE=navigator.userAgent.indexOf("Media Center")>=0?true:false;
        // var isIE = navigator.userAgent.indexOf("Microsoft Internet Explorer")!=-1?true:false;

        var isFirefox=navigator.userAgent.indexOf("Firefox")>=0?true:false;

        var isChrome=navigator.userAgent.indexOf("Chrome")>=0?true:false;


        if(isIE||isFirefox){
            $("input[type=text]").focus(function(event) {
                /* Act on the event */
                CompStyle.borderLine(this,true);
            });

            $("input[type=text]").blur(function(event) {
                /* Act on the event */
                CompStyle.borderLine(this,false);
            });
        }else if(isChrome){
            $("input[type=text]").focus(function(event) {
                /* Act on the event */
                CompStyle.outLine(this,true);
            });
            $("input[type=text]").blur(function(event) {
                /* Act on the event */
                CompStyle.outLine(this,false);
            });
        }
    },
    /*启用或者关闭border*/
    borderLine:function(el,isShow){
        if(isShow){
            $(el).css({
                'border':'1px solid #4791FF'
            })
        }else(
            $(el).css({
                'border':'1px solid #ddd'
            })
        )
    },
    /*启用或者关闭outline*/
    outLine:function(el,isShow){
        if(isShow){
            $(el).css({
                'outline':'1px solid #4791FF'
            })
        }else(
            $(el).css({
                'outline':'none'
            })
        )
    }

}
