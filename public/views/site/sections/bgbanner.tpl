<section class="section section_padding bgbanner"{% if data_scroll_id %} id="{{data_scroll_id}}"{% endif %}{% if data_scroll_block %} data-scroll-block="{{data_scroll_block}}"{% endif %}>
    <div class="container">
        <div class="bgbanner__block" style="background-image: url('{{base_url('public/filemanager/'~bg)}}');">
            <h3 class="bgbanner__title">{{title}}</h3>
            <div class="bgbanner__textblock">
                {{text|nlreplace('<p class="bgbanner__text"></p>')|raw}}
            </div>
            <button class="button button_white bgbanner__button"
                callbackform
                cbtype="3"
                cbtitle="{{callbackform[3]['title']}}"
                cbsuccess="{{callbackform[3]['send_success']}}"
                cbbutton="{{callbackform[3]['button']}}"
                cbyandexreachgoal="{{callbackform[3]['reachgoal']}}"
                >{{button}}</button>
        </div>
    </div>
</section>