<section class="section section_padding catalog"{% if data_scroll_id %} id="{{data_scroll_id}}"{% endif %}{% if data_scroll_block %} data-scroll-block="{{data_scroll_block}}"{% endif %}>
	<div class="container">
		
		<div class="section__header">
			{% if seo_title or title %}<h1 class="section__title">{{seo_title|default(title)}}</h1>{% endif %}
			{% if seo_text %}<p class="section__desc">{{seo_text}}</p>{% endif %}
		</div>
		
		<div class="row">
			<div class="col-12 col-md-auto">
				<div class="catalog__leftblock leftblock noselect">
					<div class="leftblock__top" toggleleftblock>
						<h4 class="leftblock__title">Фильтр</h4>
						<div class="leftblock__arrow leftblock__arrow_down"></div>
					</div>
					
					<div class="leftblock__content" toggleleftcontent>
						<div class="leftitem">
							<div class="leftitem__top" toggleleftitem="cats">
								<p class="leftitem__title">{{categories_title}}</p>
								<div class="leftitem__arrow leftitem__arrow_down"></div>
							</div>
							
							<div class="leftitem__content" leftitemcontent>
								<input type="hidden" id="catalogId" value="{{catalog_id}}">
								{% if navigation.categories %}
									<ul class="categories" id="categories">
										{% for catId, category in navigation.categories|sortby('sort') %}
											{% if category.active %}
												<li class="categories__item categories__item_active" currentcategory="{{catId}}"><span>{{category.title}}</span></li>
											{% else %}
												<li class="categories__item"><a href="{{category.href}}" title="{{category.link_title|default(category.title)}}">{{category.title}}</a></li>
											{% endif %}
										{% endfor %}
									</ul>
								{% endif %}
							</div>
						</div>
						
						{% if ops %}
							<div class="leftitem">
								<div class="leftitem__top" toggleleftitem="ops">
									<p class="leftitem__title">{{options_title}}</p>
									<div class="leftitem__arrow leftitem__arrow_down"></div>
								</div>
								
								<div class="leftitem__content" leftitemcontent>
									<div class="opsblock" id="colors">
										{% for opt in ops %}
											<div class="opsblock__item" style="background-color: {{opt.color}};" option="{{opt.color}}" title="{{opt.title}}"></div>
										{% endfor %}
									</div>
								</div>
							</div>
						{% endif %}
						
						{% if products_tags %}
							<div class="leftitem">
								<div class="leftitem__top" toggleleftitem="tags">
									<p class="leftitem__title">{{tags_title}}</p>
									<div class="leftitem__arrow leftitem__arrow_down"></div>
								</div>
								
								<input type="hidden" id="strictTags" value="{{strict_filters.tags}}">
								<div class="leftitem__content" leftitemcontent>
									<div class="hashtagsblock" id="hashtags">
										{% for tag in products_tags %}
											<p class="hashtagsblock__item" hashtag="{{tag}}">{{tag}}</p>  {# hashtagsblock__item_active #}
										{% endfor %}
									</div>
								</div>
							</div>
						{% endif %}
						
						{% if products_icons %}
							<div class="leftitem">
								<div class="leftitem__top" toggleleftitem="icons">
									<p class="leftitem__title">{{icons_title}}</p>
									<div class="leftitem__arrow leftitem__arrow_down"></div>
								</div>
								
								<input type="hidden" id="strictIcons" value="{{strict_filters.icons}}">
								<div class="leftitem__content" leftitemcontent>
									<div class="iconsblock" id="icons">
										{% for icon in products_icons %}
											<div class="iconsblock__item" icon="{{icon.id}}" style="background-image: url('{{base_url('public/filemanager/__thumbs__/'~icon.icon)}}');" title="{{icon.title}}"></div>  {# hashtagsblock__item_active #}
										{% endfor %}
									</div>
								</div>
							</div>
						{% endif %}
					</div>
				</div>
			</div>
			
			
			
			<div class="col-12 col-md" productscontainer>
				{% if main_catalog.count %}
					<div class="catalog__wait"><i class="fa fa-spinner fa-pulse fa-fw"></i></div>
					<div id="productsList" itemscope itemtype="http://schema.org/ItemList">
						<div class="row gutters-5 gutters-md-7 gutters-lg-10 gutters-xl-15">
							{% for item in main_catalog.items %}
								<div class="col-12 col-sm-6 col-md-6 col-lg-4">
									{% include 'views/'~controller~'/render/catalog/product.tpl' with item %}
								</div>
							{% endfor %}
						</div>
					</div>
					
					{% if main_catalog.count > count_per_page %}
						<div class="catalog__pagination noselect">
							<ul class="pagination" id="catalogPagination">
								<li class="pagination__arrow pagination__arrow_left" paginationrule="prev" title="Назад" disabled><svg><use xlink:href="#left-arrow"></use></svg></li>
								{% for page in 0..ceil((main_catalog.count / count_per_page) - 1) %}
									<li class="pagination__item{% if page == 0 %} pagination__item_active{% endif %}" pagination="{{page}}">{{page + 1}}</li>
								{% endfor %}
								<li class="pagination__arrow pagination__arrow_right" paginationrule="next" title="Вперед"><svg><use xlink:href="#right-arrow"></use></svg></li>
							</ul>
						</div>
					{% endif %}
					
				{% else %}
                    <p class="empty">Нет товаров</p>
				{% endif %}
			</div>
		</div>
	</div>
</section>


<script type="text/javascript"><!--
    var unitHeightTOut;
    function setUnitHeight() {
        $('#productsList').find('.card__caption').css('height', 'auto');
        if ($(window).width() >= breakpointSM) $('#productsList').ddrUnitHeight('.card__caption');
    }
    
    $(document).ready(function() {
        setUnitHeight();
        $(window).resize(function() {
            clearTimeout(unitHeightTOut);
            unitHeightTOut = setTimeout(function() {
                setUnitHeight();
            }, 50);
        });
        
    });
//--></script> 