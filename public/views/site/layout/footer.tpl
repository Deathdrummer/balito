<footer class="footer" itemscope itemtype="http://schema.org/WPFooter">
    <div class="container">
        <div class="footer__block noselect row justify-content-evenly justify-content-md-evenly">
            <div class="col-12 col-sm-auto">
                <ul class="footer__nav">
                    {% for page in navigation.pages %}
                        {% if page.active %}
							<li class="active"><span>{{page.title}}</span></li>
						{% else %}
							<li><a href="{{page.href}}">{{page.title}}</a></li>
						{% endif %}
                    {% endfor %}
                </ul>
            </div>
            
            <div class="col-12 col-sm-auto">
                <ul class="footer__nav">
                    {% for category in navigation.categories %}
                        {% if category.active %}
							<li class="active"><span>{{category.title}}</span></li>
						{% else %}
							<li><a href="{{category.href}}">{{category.title}}</a></li>
						{% endif %}
                    {% endfor %}
                </ul>
            </div>
            
            <div class="col-12 col-sm-auto">
                <ul class="footer__nav">
                    <li><a email>{{email.contact}}</a></li>
                    <li><a phone>{{phone.city1}}</a> <span>(горячая линия)</span></li>
                    {% if pdf_catalog %}
                        <li><a href="{{base_url('public/filemanager/'~pdf_catalog)}}" download title="Кликните чтобы скачать">Скачать PDF-каталог</a></li>
                    {% endif %}
                </ul>
                
                {% if soc %}
                    <ul class="footer__soc">
                        {% for item in soc|sortby('sort') %}
                            <li>
                                <a href="{{item.link}}" target="_blank" title="{{item.title}}"{% if item.icon %} style="background-image: url('{{base_url('public/filemanager/'~item.icon)}}')"{% endif %}>
                                    {% if item.iconawesome %}
                                        <i class="fa fa-{{item.iconawesome}}"></i>
                                    {% elseif item.sprite %}
                                        <svg><use xlink:href="{{item.sprite}}"></use></svg>
                                    {% endif %}
                                </a>
                            </li>
                        {% endfor %}
                    </ul>
                {% endif %}
            </div>
        </div>
    </div>
    
    <meta itemprop="copyrightYear" content="{{date('Y')}}">
    <meta itemprop="copyrightHolder" content="{{email.from_name}}">
</footer>