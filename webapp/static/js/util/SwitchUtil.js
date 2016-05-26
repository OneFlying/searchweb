var SwitchUtil = {

    switchView : function(el,className){

        var $obj = $(".law-title-chanage");
        $obj.removeClass("law-title-chanage");

        var obj_name = $obj.data("name");

        $(el).addClass('law-title-chanage');
        var name = $(el).data("name");

        $("."+className).find(".law-content").each(function(index, item) {
            var content = $(item).data("content");

            if(obj_name == content){
                $(item).hide();
            }
            if(name == content){
                $(item).show();
            }
        });

    }
}
