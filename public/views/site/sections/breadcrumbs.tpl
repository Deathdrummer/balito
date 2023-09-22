<section class="section breadcrumbs"{% if data_scroll_id %} id="{{data_scroll_id}}"{% endif %}{% if data_scroll_block %} data-scroll-block="{{data_scroll_block}}"{% endif %}>
	<div class="container">
		<ul class="breadcrumbs__block" itemscope itemtype="http://schema.org/BreadcrumbList">
			<li class="breadcrumbs__item" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
				<a href="{{base_url()}}" itemprop="item" title="Перейти на главную страницу">
					<span itemprop="name">{{main_page|lower}}</span>
				</a>
				<meta itemprop="position" content="1" />
			</li>
			
			
			{% if page_title %}
				<li class="breadcrumbs__item" itemprop="itemListElement" itemscope="" itemtype="http://schema.org/ListItem">
					<a itemprop="item">
						<span itemprop="name" title="Текущая страница">{{page_title|lower}}</span>
					</a>
					<meta itemprop="position" content="2">
				</li>
			{% elseif navigation.categories|hasinarr('active', 1) %}
				<a class="breadcrumbs__item" href="{{base_url('catalog')}}">каталог</a>
				<span class="breadcrumbs__item"  title="Текущая страница">{{navigation.categories[navigation.categories|hasinarr('active', 1)]['title']|lower}}</span>
			{% endif %}
		</ul>
	</div>
</section>