<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta name="renderer" content="webkit" />
<meta name="viewport" content="width=device-width, initial-scale=1.0,maximum-scale=1, user-scalable=no">
<title>法律声明</title>
<%@ include file="/resource.jsp" %>
<%
    String param = (String)request.getAttribute("param");
%>
<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/css/bootstrap.css">
<link rel="stylesheet" href="${RESOUCE_STATIC_URL}/css/style.css">
</head>
<body>

<div class="container law-container">
    <div class="row">
        <div class="col-xs-12 col-sm-2 col-md-2 text-right">
            <img src="" alt="" />
            <ul>
                <li><a href="${RESOUCE_SYSTEM_URL}/">首页</a></li>
                <li><a data-name="gywm">关于我们</a></li>
                <li><a data-name="lxwm">联系我们</a></li>
                <li><a data-name="flsm">法律声明</a></li>
            </ul>
        </div>
        <div class="col-xs-12 col-sm-10 col-md-10 law-content-parent">
            <div data-content="gywm" class="law-content" style="display:none;">
                <span>关于我们</span>
                <div class="law-content-text" >
                    <span>
                                             关 于 我 们
                    ------律师个人资料永久免费展示，不做律师竞价排名收费。
                    ------帮当事人找适合的律师，为普及法律知识、促进和谐社会而努力。
                    ------律师湾总部位于上海，为全国律师、当事人提供优质服务。
                                            律师湾客服联系方式：（以下联系方式均不解答法律咨询，咨询请先注册普通会员，然后发布到这里)
                    微信客服号：lvshiwan。（绑定QQ：2320857761）--免费推荐律师

                    QQ客服：2320857761(网站问题反馈、及收费法律咨询)
                                     律师使用帮助在这里 咨询用户使用帮助在这里
                    邮箱2320857761@qq.com、lvshiwan@lvshiwan.com
                    QQ群289658686（仅供已注册各省律师会员案例研讨、业务开拓交流）
                    </span>
                </div>
            </div>

            <div data-content="lxwm" class="law-content" style="display:none;">
                <span>联系我们</span>
                <div class="law-content-text">
                    <span>
律师湾客服联系方式：（以下联系方式均不解答法律咨询，咨询请先注册普通会员，然后发布到这里)

微信客服号：lvshiwan。（绑定QQ：2320857761）--免费推荐律师

QQ客服：2320857761(网站问题反馈、及收费法律咨询)
                 律师使用帮助在这里 咨询用户使用帮助在这里
邮箱2320857761@qq.com、lvshiwan@lvshiwan.com
QQ群289658686（仅供已注册各省律师会员案例研讨、业务开拓交流）




copyright@right:2011-2013 律师湾（lvshiwan.com）版权所有 沪ICP备11048970号-1


----律师湾是律师之间、律师和当事人之间沟通、交流的免费平台。
----律师湾为普及法律知识、促进和谐社会而努力。
                    </span>
                </div>
            </div>

            <div data-content="flsm" class="law-content" style="display:none;">
                <span>法律声明</span>
                <div class="law-content-text">
                    <span>
                        律师湾网（以下简称"本网站"）依据《律师湾网服务协议》（以下简称"本协议"）的规定提供服务，本协议具有合同效力。注册会员时，请您认真阅读本协议，审阅并接受或不接受本协议（未成年人应在法定监护人陪同下审阅）。
    若您已经注册为本网站会员，即表示您已充分阅读、理解并同意自己与本网站订立本协议，且您自愿受本协议的条款约束。本网站有权随时变更本协议并在本网站上予以公告。经修订的条款一经在本网站的公布后，立即自动生效。如您不同意相关变更，必须停止使用本网站。本协议内容包括协议正文及所有律师湾网已经发布的各类规则。所有规则为本协议不可分割的一部分，与本协议正文具有同等法律效力。一旦您继续使用本网站，则表示您已接受并自愿遵守经修订后的条款。
第一条 会员资格
1、只有符合下列条件之一的自然人或法人才能申请成为本网站会员，可以使用本网站的服务；
A、年满十八岁，并具有民事权利能力和民事行为能力的自然人；
B、无民事行为能力人或限制民事行为能力人应经过其监护人的同意；
C、根据中国法律、法规、行政规章成立并合法存在的机关、企事业单位、社团组织和其他组织。
2、会员需要提供真实资料及联系方式。
第二条 会员的权利和义务 　　
1、会员有权根据本协议及本网站发布的相关规则，利用本网站发布需求信息、查询会员信息、参加需求，在本网站社区及相关产品发布信息，参加本网站的有关活动及有权享受本网站提供的其他有关资讯及信息服务；
2、会员须自行负责自己的会员账号和密码，且须对在会员账号密码下发生的所有活动（包括但不限于发布需求信息、网上点击同意各类协议、规则、发布咨询案件等）承担责任。会员有权根据需要更改登录和账户提现密码。因会员的过错导致的任何损失由会员自行承担，该过错包括但不限于：不按照提示操作，未及时进行操作，遗忘或泄漏密码，密码被他人破解，您使用的计算机被他人侵入；　
3、会员应当向本网站提供真实准确的注册信息。保证本网站可以通过上述联系方式与自己进行联系。同时，会员也应当在相关资料实际变更时及时更新有关注册资料；
4、会员不得以任何形式擅自转让或授权他人使用自己在本网站的会员帐号；
5、会员有义务确保在本网站上发布的需求信息真实、准确，无误导性；　
6、会员在本网站网上发布平台，不得发布国家法律、法规、行政规章规定禁止的信息、侵犯他人知识产权或其他合法权益的信息、违背社会公共利益或公共道德的信息；
7、会员在本网站应当遵守诚实信用原则，不得从事与网上服务无关的不当行为，不得在网站平台上发布任何违法信息；
8、会员不应采取不正当手段（包括但不限于虚假点评、互换好评等方式）提高自身或他人信用度，或采用不正当手段恶意评价其他会员，降低其他会员信用度；
9、会员承诺自己在使用本网站实施的所有行为遵守法律、法规、行政规章和本网站的相关规定以及各种社会公共利益或公共道德。如有违反导致任何法律后果的发生，会员将以自己的名义独立承担相应的法律责任；
11、会员不得使用以下方式登录网站或破坏网站所提供的服务：
A、以任何机器人软件、蜘蛛软件、爬虫软件、刷屏软件或其它自动方式访问或登录本网站；B、通过任何方式对本公司内部结构造成或可能造成不合理或不合比例的重大负荷的行为；
C、通过任何方式干扰或试图干扰网站的正常工作或网站上进行的任何活动。
                    </span>
                </div>
            </div>
            <span>&copy;2016 公司名称 沪ICP证1000000323号<i class="icr-logo"></i></span>
            <span><i class="ba-logo"></i>沪公安网备100003232号</span>
        </div>
    </div>
</div>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/lib/bootstrap-3.3.5-dist/js/bootstrap.js"></script>
<script type="text/javascript" src="${RESOUCE_STATIC_URL}/js/util/SwitchUtil.js"></script>
<script type="text/javascript">
    $(document).ready(function(){

        var url = RESOUCE_SYSTEM_URL_JS+"/websiteconfig/getinfo";

        $.get(url,function(data){
            var obj = data.wc;
            $("title").text(obj.title);
            $("img").attr("src","${RESOUCE_STATIC_URL}"+obj.logourl);
        });

        var param = "<%=param%>";

        $("a[data-name="+param+"]").addClass('law-title-chanage');
        $("div[data-content="+param+"]").show();

        $("a").unbind('click');
        $("a").bind('click',function(){
            SwitchUtil.switchView(this,"law-content-parent");
        });
    });
</script>
</body>
</html>
