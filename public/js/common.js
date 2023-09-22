setBaseScripts=function(t){null==t&&(t="body"),0<$(t).find("[editor]:not(.activated)").length&&initEditors(),ddrSelect(t),ddrPhonecodes(),ddrInitTabs(),$(t).find("[phonemask]:not([multicode])").each(function(){var t=$(this).attr("phonemask")||"(^^^) ^^^-^^-^^",e=$(this).attr("code")||"+7",i=$(this).attr("placeholder")||(e+" "+t).replace(/[\^&]/g,"_");$(this).mask(e+" "+t,{autoclear:!1}).attr({placeholder:i,type:"tel"})}),$(t).find("[mask]").each(function(){var t,e=$(this).attr("mask");if(!e)return!0;t=$(this).attr("placeholder")||e.replace(/[\^&]/g,"_"),$(this).mask(e,{autoclear:!1}).attr({placeholder:t})}),$(t).find("[numberformat]").each(function(){var t,e,i=$(this).attr("numberformat");""!=i?(t=null!=(i=i.split("|"))[0]?i[0]:2,e=null!=i[1]?i[1]:".",i=null!=i[2]?i[2]:" ",$(this).number(!0,t,e,i)):$(this).number(!0,2,"."," ")}),$(t).find(".phone ,[phone]").each(function(){$(this).attr("code");$(this).attr("href","tel:"+$(this).text().trim().replace(/-|\(|\)|\s/g,"").replace(/^8/,"+7"))}),$(t).find(".whatsapp, [whatsapp]").each(function(){var t=$(this).data("message"),e=$(this).text().trim().replace(/-|\(|\)|\s/g,"").replace(/^8/,"+7");$(this).attr("code");$(this).attr("href","whatsapp://send?phone="+e+"&abid="+e+"&text="+t)}),$(t).find(".email, [email]").each(function(){$(this).attr("href","mailto:"+$(this).text().trim())}),0<$(t).find("table.fieldset").length&&$(t).find("table.fieldset").changeInputs(function(t,e){"contenteditable"==e.st&&$(t).closest(".textarea").addClass("changed"),$(t).parent().addClass("changed")}),/#ddrpopup/.test(t)&&$(t).changeInputs(function(t,e){"contenteditable"==e.st&&$(t).closest(".textarea").addClass("changed"),$(t).parent().addClass("changed")})},jQuery(document).ready(function(p){setBaseScripts(),p(document).on("focus gesturestart",function(t){t.preventDefault()}),p("body").on("focus","input, textarea, select",function(){p(this).parent("div").addClass("focused")}),p("body").on("focus",".file",function(){p(this).addClass("focused")}),p("body").on("blur","input, textarea, select",function(){p(this).parent("div").removeClass("focused")}),p("body").on("blur",".file",function(){p(this).addClass("focused")}),p("body").on("focus","input.error, textarea.error, select.error, .field.error, .textarea.error, .select.error, .file.error",function(){var t=this;p(t).removeClass("error"),setTimeout(function(){p(t).find("span.error").remove(),p(t).siblings("span.error").remove()},160)}),p("body").on(tapEvent,".file.error",function(){var t=this;p(t).removeClass("error"),setTimeout(function(){p(t).find("span.error").remove()},160)}),p("body").on("submit","form:not([action])",function(t){return t.preventDefault(),!1}),p("body").on("focus",'input[type="text"]:not([noedit]), input[type="password"]:not([noedit]), input[type="email"]:not([noedit]), input[type="tel"]:not([noedit])',function(){p(this).removeAttrib("readonly")}),0==/iPhone|iPad|iPod/i.test(navigator.userAgent)&&p("body").on("blur",'input[type="text"]:not([noedit]), input[type="password"]:not([noedit]), input[type="email"]:not([noedit]), input[type="tel"]:not([noedit])',function(){p(this).setAttrib("readonly")}),p("body").on("change",'input[type="checkbox"]',function(){p(this)[0].hasAttribute("checked")?(p(this).prop("checked",!1),p(this)[0].removeAttribute("checked")):(p(this).prop("checked",!0),p(this)[0].setAttribute("checked",""))}),p(window).scrollTop()>2*p(window).height()?p("[scrolltop]").addClass("visible"):p("[scrolltop]").removeClass("visible"),p(window).on("scroll",function(){p(this).scrollTop()>2*p(window).height()?p("[scrolltop]").addClass("visible"):p("[scrolltop]").removeClass("visible hover")}),p("[scrolltop]").on("click",function(t){t.preventDefault(),p("html, body").animate({scrollTop:0},800,"easeInOutQuint")}),p("[scrolltop]").on("tap click mouseenter",function(){p(this).addClass("hover")}),p("[scrolltop]").on("mouseleave",function(){p(this).removeClass("hover")}),p("body").find("[parallax]").each(function(){var t=p(this).attr("parallax").split("|");p(this).parallax({imageSrc:t[0],speed:parseFloat(t[1])})}),p("body").on(tapEvent,".tabstitles li:not(.active)",function(){if(0<p(this).find("[ignore]:hover").length)return!1;var t=this,e=location.hash.substr(1,location.hash.length).split("."),i=p(t).attr("id"),a=e[0],s=p(t).closest(".tabstitles"),n=p(s).siblings(".tabscontent");p(t).removeClass("error"),null==e[2]&&p("#"+a).find(".tabstitles:not(.sub)").siblings(".tabscontent").find(".tabstitles.sub").each(function(){p(this).children("li").removeClass("active"),p(this).children("li:first").addClass("active"),p(this).siblings(".tabscontent").find("[tabid]").removeClass("visible"),p(this).siblings(".tabscontent").find("[tabid]:first").addClass("visible")}),p(s).children("li").removeClass("active"),p(t).addClass("active"),0==p(s).hasClass("sub")?location.hash=a+"."+i:(e[1]||(e[1]=p(t).closest("#"+a).find(".tabstitles:not(.sub)").children(":first").attr("id")),location.hash=a+"."+e[1]+"."+i),0==p(n).children('[tabid="'+i+'"]').hasClass("visible")&&(p(n).children("[tabid]").removeClass("visible"),p(n).children('[tabid="'+i+'"]').addClass("visible"),p(document).trigger("tabsChange")),initEditors()}),p("body").on(tapEvent,"[showpassword]",function(){0<p(this).parent().find('input[type="password"]').length?(p(this).parent().find('input[type="password"]').prop("type","text"),p(this).removeClass("fa-eye").addClass("fa-eye-slash").prop("title","Скрыть пароль")):0<p(this).parent().find('input[type="text"]').length&&(p(this).parent().find('input[type="text"]').prop("type","password"),p(this).removeClass("fa-eye-slash").addClass("fa-eye").prop("title","Показать пароль"))}),p("#adminSetModifications").on("change",function(){var t=p(this).val();p.post("/admin/modifications/set_site_modification",{controller:"admin",mod:t},function(t){t&&pageReload()},"json")}),p("body").on(tapEvent,"[modification]",function(){var t=p(this).attr("modification");p.post("/admin/modifications/set_site_modification",{controller:"site",mod:t},function(t){t&&pageReload()},"json")}),p("body").on(tapEvent,"[ddrsort]",function(){ddrSort(this)}),p("body").on("focus","[ddrtextarealist]",function(){var e,i,n,a=this,s=p(a).attr("ddrtextarealist"),o=(p(a).attr("load"),p(a).attr("join")||";");function r(){var i=[],t=p(a).parent(".textarea");p(a).siblings(".textarea__addblock").find("input, select").each(function(t,e){"checkbox"==e.type?i.push(p(e).is(":checked")?1:0):i.push(p(e).val())}),""!=p(a).val()?p(a).val(p(a).val()+"\n"+i.join(o)):p(a).val(i.join(o)),t.length&&p(t).addClass("changed"),p(a).siblings(".textarea__addblock").find("input").val(""),p(a).siblings(".textarea__addblock").find("select").children("option").removeAttrib("selected"),p(a).siblings(".textarea__addblock").find("select").children("option:first").prop("selected",!0),p(a).scrollTop(999999999),p(a).siblings(".textarea__addblock").find('[class ^= "dcol"]:first').find("inpus, select").focus()}p("body").find("[ddraladd]").off(tapEvent),p("body").find(".textarea__addblock").find("input, select").off("keyup"),s&&(n=i="",s=s.split("|"),p.each(s,function(e,i){if(!i)return!0;var a,s,i=i.split(";");if(t=i[0]||null,l=i[1]||null,d=i[2]||null,c=i[3]||null,!t)return!0;n+='<div class="dcol'+(c?"-auto "+c:"")+'">',n+='<label class="textareafields__label" for="ddrtextarealistfield'+e+'">'+l+"</label>","select"==t?(a=d.split(","),n+='<select id="ddrtextarealistfield'+e+'" tabid="'+e+'">',p.each(a,function(t,e){if(!e)return!0;var i=e.split(":"),e=i[0],i=null!=i[1]?i[1]:i[0];n+='<option value="'+e+'">'+i+"</option>"}),n+="</select>"):"checkbox"==t?(a=1==d?" checked":"",n+='<div class="checkbox">',n+='<div class="checkbox__item checkbox__item_ver2 checkbox__item_small h-24px">',n+="<div>",n+='<input id="ddrtextarealistfield'+e+'" type="checkbox"'+a+' tabid="'+e+'" />',n+='<label for="ddrtextarealistfield'+e+'"></label>',n+="</div>",n+="</div>",n+="</div>"):"number"==t?(s=null!=d?' value="'+d+'"':"",n+='<input id="ddrtextarealistfield'+e+'" type="number"'+s+' showrows tabid="'+e+'" />'):"text"==t&&(s=null!=d?' value="'+d+'"':"",n+='<input id="ddrtextarealistfield'+e+'" type="text"'+s+' tabid="'+e+'" />'),n+="</div>"})),p(a).setAttrib("touch","textarea_opened"),i+='<div class="textarea__addblock">',i+='<div class="textareafields"><div class="drow dgutter-4">'+n+"</div></div>",i+='<div class="textareabutton"><button ddraladd title="Добавить строку"><i class="fa fa-plus"></i></button></div>',i+="</div>",0==p(a).siblings(".textarea__addblock").length&&p(a).after(i),e=p(a).siblings(".textarea__addblock").height(),p(a).siblings(".textarea__addblock").css("bottom",-e+"px"),p(a).siblings(".textarea__addblock").find("input, select").on("keyup",function(t){13==t.keyCode&&r()}),p(a).siblings(".textarea__addblock").find("[ddraladd]").on(tapEvent,function(){r()})})});