<section class="section slider"{% if data_scroll_id %} id="{{data_scroll_id}}"{% endif %}{% if data_scroll_block %} data-scroll-block="{{data_scroll_block}}"{% endif %}>
    {% if posters %}
        <ul id="mainPosters" class="slider__block">
            {% for poster in posters %}
                <li>
                    <div class="poster" style="background-image: url('{{base_url('public/filemanager/'~poster.bg)}}');">
                        <div class="poster__caption">
                            {% if poster.is_main %}
                                <h1 class="poster__descroption"{% if font_size %} style="font-size: {{font_size}}px; line-height: {{font_size}}px;"{% endif %}>{{poster.description}}</h1>
                            {% else %}
                                <p class="poster__descroption"{% if font_size %} style="font-size: {{font_size}}px; line-height: {{font_size}}px;"{% endif %}>{{poster.description}}</p>
                            {% endif %}
                            <div class="poster__prices">
                                {% if poster.prod.price %}
                                    <p class="poster__price poster__price_new">{{poster.prod.price|number_format(0, '', ' ')}} <span>{{currency}}</span></p> 
                                {% endif %}
                                {% if poster.prod.price_old %}
                                    <p class="poster__price poster__price_old">{{poster.prod.price_old|number_format(0, '', ' ')}} <span>{{currency}}</span></p>
                                {% endif %}
                            </div>
                            <div class="poster__link">
                                <a class="button button_white poster__button" href="{{base_url(poster.prod.seo_url)}}" title="{{poster.link_title|default(poster.prod.title)}}">подробнее</a>
                            </div>
                        </div>
                        
                        <div class="poster__product">
                            <img src="{{base_url('public/filemanager/'~poster.poster)}}" alt="{{poster.alt}}" title="{{poster.prod.title}}">
                        </div>
                    </div>
                </li>
            {% endfor %}
        </ul>
    {% endif %}
    
    <div class="slider__arrows hidden-xs-down">
        <i class="slider__arrow slider__arrow_left fa fa-angle-left" title="Назад"></i>
        <i class="slider__arrow slider__arrow_right fa fa-angle-right" title="Вперед"></i>
    </div>
</section>



<script type="text/javascript"><!--
    $(document).ready(function() {
        $('#mainPosters').ddrCarousel({
            arrowLeft: '.slider__arrow_left', // Нужно делать невидимыми. Создать класс visible при котором стрелка должна отображаться
            arrowRight: '.slider__arrow_right', // Нужно делать невидимыми. Создать класс visible при котором стрелка должна отображаться
            autoplay: {{autoplay}},
            speed: {{speed}},
            loop: true,
            pauseOnHover: {{pause_on_hover}},
            fade: false,
            dotsSelector: false, // контеинер дял точек навигации. Активный с классом active
            response: false, // [1, 'sm:2', 'md:2', 'lg:3', 'xl:4'], первый элемент, сколько изначально показывать слайдов. Далее, брейкпоинт:кол-во слайдов
            accessBrPoints: false, // {768: 992} брейкпоинты от и до - когда карусель будет активироваться
            beforeChange: false,
            unitHeight: false // выровнить высоту блоков карусели (в значение можнно передать брейкпоинт с которого будет активироваться функция)
        });
    });
//--></script>