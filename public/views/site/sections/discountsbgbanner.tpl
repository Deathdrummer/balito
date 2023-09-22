<section class="section section_padding discountsbgbanner"{% if data_scroll_id %} id="{{data_scroll_id}}"{% endif %}{% if data_scroll_block %} data-scroll-block="{{data_scroll_block}}"{% endif %}>
    <div class="container">
        <div class="discountsbgbanner__block" style="background-image: url('{{base_url('public/filemanager/'~bg)}}');">
            <img class="discountsbgbanner__image discountsbgbanner__image_left" src="{{base_url('public/filemanager/'~img_left)}}" alt="">
            <img class="discountsbgbanner__image discountsbgbanner__image_right" src="{{base_url('public/filemanager/'~img_right)}}" alt="">
            
            <div class="discountsbgbanner__caption">
                <div class="discountsbgbanner__top">
                    <div><p class="discountsbgbanner__top_percent">{{percent}}%</p></div>
                    <div>
                        <p class="discountsbgbanner__top_large">{{large_text}}</p>
                        <p class="discountsbgbanner__top_small">{{small_text}}</p>
                    </div>
                </div>
                <div class="discountsbgbanner__button">
                    <button class="button button_white"
                        callbackform
                        cbtype="2"
                        cbtitle="{{callbackform[2]['title']}}"
                        cbsuccess="{{callbackform[2]['send_success']}}"
                        cbbutton="{{callbackform[2]['button']}}"
                        cbyandexreachgoal="{{callbackform[2]['reachgoal']}}"
                        >{{button_text}}</button>
                </div>
            </div>
        </div>
    </div>
</section>