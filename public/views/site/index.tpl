<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="ltr" lang="ru" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="ltr" lang="ru" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="ltr" lang="ru" prefix="og: http://ogp.me/ns#">
<head itemscope itemtype="http://schema.org/WPHeader">
	<meta charset="UTF-8" />
	<meta name="author" content="Дмитрий Сайтотворец" />
	<meta name="copyright" content="Deathdrumer &copy; Web разработка" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<meta name="format-detection" content="telephone=no"> <!-- отключение автоопределения номеров для Safari (iPhone / IPod / IPad) и Android браузера -->
	<meta http-equiv="x-rim-auto-match" content="none"> <!-- отключение автоопределения номеров для BlackBerry -->
	<meta itemprop="keywords" name="keywords" content="{{meta_keywords|default('')}}">
	<meta itemprop="description" name="description" content="{{meta_description|default('')}}">
	
	<meta property="og:type" content="website">
	<meta property="og:title" content="{{og.title}}">
	<meta property="og:description" content="{{og.description}}">
	<meta property="og:url" content="{{og.url}}">
	<meta property="og:image" content="{{base_url('public/filemanager/'~og.image)}}">
	<meta property="og:site_name" content="{{og.site_name}}">
	
	{% if not hosting %}<meta http-equiv="cache-control" content="no-cache">{% endif %}
	{% if not hosting %}<meta http-equiv="expires" content="1">{% endif %}
	{% if metatags %}{{metatags|raw}}{% endif %}
	<link rel="shortcut icon" href="{% if favicon %}{{base_url('public/filemanager/'~favicon)}}{% else %}{{base_url('public/images/favicon.png')}}{% endif %}" />
	
	<link rel="stylesheet" href="{{base_url('public/css/assets.min.css')}}">
	<link rel="stylesheet" href="{{base_url('public/css/plugins.min.css')}}">
	<link rel="stylesheet" href="{{base_url('public/css/components.min.css')}}">
	{% if is_file('public/css/'~controller~'.min.css') %}<link rel="stylesheet" href="{{base_url('public/css/'~controller~'.min.css')}}">{% endif %}
	
	<script src="{{base_url('public/js/plugins.min.js')}}"></script>
	<script src="{{base_url('public/js/functions.js')}}"></script>
	<script src="{{base_url('public/js/common.js')}}"></script>
	<script src="{{base_url('public/js/components.min.js')}}"></script>

	{% if hosting %}{% include 'views/'~controller~'/layout/hosting.tpl' %}{% endif %} <!-- Если сайт на хостинге - выполнять функции -->
	<title itemprop="headline">{{page_title|default('Страница без заголовка')}}</title>
</head>
<body data-scroll-block="body" id="body">
	{% if svg_sprite %}{{svg_sprite|raw}}{% endif %} {# Вставляем SVG спрайт #}
	{% if header %}{% include 'views/'~controller~'/layout/header.tpl' %}{% endif %}
	{% if nav_mobile %}{% include 'views/'~controller~'/layout/nav_mobile.tpl' %}{% endif %}
	<main>
		{% if sections %}
			{% for section in sections %}
				{% include 'views/'~controller~'/sections/'~section.filename|ext('tpl') with section.data %}
			{% endfor %}
		{% endif %}
	</main>
	{% if footer %}{% include 'views/'~controller~'/layout/footer.tpl' %}{% endif %}
	{% if scrolltop %}<div scrolltop class="hidden-sm-down"><svg><use xlink:href="{{scrolltop}}"></use></svg></div>{% endif %}
	{% if stockicon.url and seo_url != stockicon.url %}<a href="{{stockicon.url}}" class="stockicon" title="{{stockicon.link_title}}"><span class="stockicon__icon">%</span></a>{% endif %}
	
	
	<script type="module" src="{{base_url('public/js/modelViewer.js')}}"></script>
	
	{% if scripts_head %}{{scripts_head|raw}}{% endif %}
	
	{% if is_file('public/js/'~controller~'.js') %}<script src="{{base_url('public/js/'~controller~'.js')}}"></script>{% endif %}
</body>
</html>