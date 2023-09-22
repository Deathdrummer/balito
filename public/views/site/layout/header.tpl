<header class="header">
	<div class="container">
		<div class="row header__block align-items-center justify-content-between">
			<div class="col-auto">
				{% if logo %}
					{% if seo_url == 'index' %}
						<img class="header__logo" src="{{base_url('public/filemanager/'~logo.file)}}" alt="{{logo.alt}}">
					{% else %}
						<a href="{{base_url()}}" title="Вернулься на главную"><img class="header__logo" src="{{base_url('public/filemanager/'~logo.file)}}" alt="{{logo.alt}}"></a>
					{% endif %}
				{% endif %}
			</div>
			<div class="col-auto ml-auto hidden-md-down">
				<ul class="header__nav noselect" itemscope itemtype="http://schema.org/SiteNavigationElement">
					{% for page in navigation.pages %}
						{% if page.active %}
							<li class="active"><span itemprop="name">{{page.title}}</span></li>
						{% else %}
							<li><a href="{{page.href}}" title="{{page.link_title|default(page.title)}}" itemprop="url">{{page.title}}</a></li>
						{% endif %}
					{% endfor %}
				</ul>
			</div>
			<div class="col-auto ml-auto ml-lg-0 hidden-xs-down">
				<div class="header__contacts">
					<p><i class="fa fa-phone"></i><a phone>{{phone.free1}}</a></p>
					<button
						class="button button_small button_white hidden-md-down"
						callbackform
						cbtype="1"
						cbtitle="{{callbackform[1]['title']}}"
						cbsuccess="{{callbackform[1]['send_success']}}"
						cbbutton="{{callbackform[1]['button']}}"
						cbyandexreachgoal="{{callbackform[1]['reachgoal']}}"
						>Заказать звонок</button>
				</div>
			</div>
			<div class="col-auto hidden-lg-up">
				<div id="mobileNavButton" class="navmobile">
					<div></div>
					<div></div>
					<div></div>
				</div>
			</div>
		</div>
	</div>
	
	{# переменная navigation в себе содержит все #}
</header>
