<section class="section section_padding discountsimplebanner{% if padding %} {{padding}}{% endif %}"{% if data_scroll_id %} id="{{data_scroll_id}}"{% endif %}{% if data_scroll_block %} data-scroll-block="{{data_scroll_block}}"{% endif %}>
	<div class="container"> 
        <div class="discountsimplebanner__block">
            <div class="discountsimplebanner__caption">
                <h3 class="discountsimplebanner__percent">-{{percent}}%</h3>
                <h4 class="discountsimplebanner__text">{{text}}</h4>
            </div>
            <div class="discountsimplebanner__image" style="background-image: url('{{base_url('public/filemanager/'~image)}}');"></div>
        </div>
    </div>
</section>