<section class="section section_padding productsList"{% if data_scroll_id %} id="{{data_scroll_id}}"{% endif %}{% if data_scroll_block %} data-scroll-block="{{data_scroll_block}}"{% endif %}>
	
    <div class="container">
        <div class="section__header">
            {% if seo_title or title %}<h1 class="section__title">{{seo_title|default(title)}}</h1>{% endif %}
            {% if seo_text %}<p class="section__desc">{{seo_text}}</p>{% endif %}
        </div>
    </div>
        
    
    
    <div class="container">
        {% if showroom.count %}
            <div class="row gutters-5 gutters-md-7 gutters-lg-10 gutters-xl-15" id="productsList" itemscope itemtype="http://schema.org/ItemList">
                {% for item in showroom.items %}
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                        {% include 'views/'~controller~'/render/catalog/product.tpl' with item %}
                    </div>
                {% endfor %}
            </div>
        {% else %}
            <p class="empty">Витрина пуста</p>
        {% endif %}
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