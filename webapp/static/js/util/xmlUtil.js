//字符串转化为xml
function toXmlDom(source){
var xmlDoc = null;
if (window.ActiveXObject) {
var ARR_ACTIVEX =
["MSXML4.DOMDocument","MSXML3.DOMDocument","MSXML2.DOMDocument","MSXML.DOMDocument","Microsoft.XmlDom"];
var XmlDomflag = false;
for (var i = 0;i < ARR_ACTIVEX.length && !XmlDomflag ;i++) {
try {
var objXML = new ActiveXObject(ARR_ACTIVEX[i]);
xmlDoc = objXML;
XmlDomflag = true;
} catch (e) {
}
}
if (xmlDoc) {
xmlDoc.async = false;
xmlDoc.loadXML(source);
}
}else{
var parser=new DOMParser();
var xmlDoc=parser.parseFromString(source,"text/xml");
}
return xmlDoc;
} 
