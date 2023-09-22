<div class="mobilenavwrap hidden-lg-up"></div>
<div class="mobilenav hidden-lg-up" id="mobileNavBlock">
	<div class="mobilenav__close" id="mobileNavButtonClose"></div>
	
	<div class="mobilenav__contacts">
		<p><i class="fa fa-phone"></i><a phone>{{phone.free1}}</a></p>
		<button 
			callbackform
			cbtype="1"
			cbtitle="{{callbackform[1]['title']}}"
			cbsuccess="{{callbackform[1]['send_success']}}"
			cbbutton="{{callbackform[1]['button']}}"
			cbyandexreachgoal="{{callbackform[1]['reachgoal']}}"
			>Заказать звонок</button>
	</div>
	
	<ul class="mobilenav__nav">
		{% for page in navigation.pages %}
			{% if page.active %}
				<li class="active"><span>{{page.title}}</span></li>
			{% else %}
				<li><a href="{{page.href}}">{{page.title}}</a></li>
			{% endif %}
		{% endfor %}
	</ul>
	
	{# переменная navigation в себе содержит все #}
	
	{% if modifications %}
		<div class="modifications">
			{% for m in modifications %}
				{% if m.active == false %}
					<div class="modifications__item" modification="{{m.modification}}">
						<span>{{m.label}}</span>
					</div>
				{% endif %}
			{% endfor %}
		</div>
	{% endif %}
</div>