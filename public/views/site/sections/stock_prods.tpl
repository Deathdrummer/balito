<section class="section stock_prods"{% if data_scroll_id %} id="{{data_scroll_id}}"{% endif %}{% if data_scroll_block %} data-scroll-block="{{data_scroll_block}}"{% endif %}>
	<div class="container">
        <div class="section__top">
            <h2 class="section__title">{{title}}</h2>
            <a href="{{base_url(link_to_catalog.seo_url)}}" title="{{link_title|default(link_page.link_title)}}" class="button button_bordered"><span>{{button_text}}</span><svg><use xlink:href="#card-arrow"></use></svg></a>
        </div>
        
            
        {% if prods %}
            <div class="row gutters-5 gutters-md-7 gutters-lg-10 gutters-xl-15" id="stockProds" itemscope itemtype="http://schema.org/ItemList">
                {% for id, item in prods|randfromlist(4) %}
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                        {% include 'views/'~controller~'/render/catalog/product.tpl' with item.prod %}
                    </div>
                {% endfor %}
            </div>
        {% endif %}
    </div>
</section>



<script type="text/javascript"><!--
    var unitHeightTOut;
    function setUnitHeight() {
        $('#stockProds').find('.card__caption').css('height', 'auto');
        if ($(window).width() >= breakpointSM) $('#stockProds').ddrUnitHeight('.card__caption');
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