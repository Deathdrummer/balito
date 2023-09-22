<section class="section section_padding categoriestabs"{% if data_scroll_id %} id="{{data_scroll_id}}"{% endif %}{% if data_scroll_block %} data-scroll-block="{{data_scroll_block}}"{% endif %}>
	<div class="container">
        {% if cats_tabs_title %}
            <div class="section__top">
                <h2 class="section__title">{{cats_tabs_title}}</h2>
            </div>
        {% endif %}
            
        
        {% if cats_tabs %}
            <div class="row categoriestabs__block gutters-2 gutters-sm-3 gutters-md-5 justify-content-center">
                {% for cat in cats_tabs %}
                    <div class="col-12 col-sm-6 col-md-4 col-lg-{{cat.cols}} mt-4px mt-sm-6px mt-md-10px">
                        <a href="{{base_url(cat.cat.seo_url)}}" title="{{cat.link_title|default(cat.title)}}" class="categoriestabs__item" style="background-image: url('{{base_url('public/filemanager/__mini__/'~cat.image)}}');">
                            <div class="categoriestabs__sublabel"></div>
                            <div class="categoriestabs__label" style="background-image: url('{{base_url('public/filemanager/__mini__/'~cat.image)}}');">
                                <span>{{cat.title}}</span>
                            </div>
                            {#<div class="categoriestabs__moblabel hidden-md-up"><span>{{cat.title}}</span></div>#}
                        </a>
                    </div>
                {% endfor %}
            </div>
        {% endif %}
    </div>
</section>