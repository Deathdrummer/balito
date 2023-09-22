<section class="section section_padding carditem"{% if data_scroll_id %} id="{{data_scroll_id}}"{% endif %}{% if data_scroll_block %} data-scroll-block="{{data_scroll_block}}"{% endif %}>
	<div class="container">
		<div class="carditem__block row gutters-10" id="cardItemBlock" itemscope itemtype="http://schema.org/Product">
			<div class="col-12 col-md-6">
				<div class="carditem__images"{% if card_variant == 'vertical' %} id="videoGallery"{% endif %}>
					<input type="hidden" id="imgPath" value="{{base_url('public/filemanager/')}}">
					<input type="hidden" id="productThreed" value="{{product.threed.file}}">
					
					{% if product.main_image.file %}
						<div class="cardimage cardimage_main" mainimage>
							<img class="cardimage cardimage_main" itemprop="image" src="{{base_url('public/filemanager/__mini__/'~product.main_image.file)|no_file('public/images/no_product_500.png')}}" cardimagepopup="{{base_url('public/filemanager/'~product.main_image.file)}}" alt="{{product.main_image.alt|default(product.name)}}">
							{% if product.threed.file and (card_variant == 'horizontal' or (card_variant == 'vertical' and show_3d_variant == 'in_main')) %}<div showthreed="{{product.threed.file}}" alt="{{roduct.name}}"></div>{% endif %}
						</div>
					{% elseif not product.threed.file %}
						<div class="cardimage cardimage_main cardimage_empty" mainimage>
							<img src="{{base_url('public/images/no_product_500.png')}}" alt="{{product.name}}">
						</div>
					{% endif %}
					
					{% if card_variant == 'vertical' and show_3d_variant == 'standalone' %}
						{% if product.threed.file %}
							<model-viewer class="cardimage cardimage_main cardimage_main_obj modelviewer" src="{{base_url('public/filemanager/'~product.threed.file)|no_file('public/images/no_product_500.png')}}" auto-rotate camera-controls></model-viewer>
						{% elseif not product.main_image.file %}
							<div class="cardimage cardimage_main cardimage_empty"></div>
						{% endif %}
					{% endif %}
					{# #}
					
					{% if product.gallery or product.videos %}
						{% if card_variant == 'vertical' %}
							{% if product.videos %}
								{% for video in product.videos %}
									<div class="cardimage cardimage_main cardimage_main_video" style="background-image: url('https://i.ytimg.com/vi/{{video.id}}/sddefault.jpg');" cardvideoid="{{video.id}}"></div>
								{% endfor %}
							{% endif %}
							
							{% if product.gallery %}
								{% for item in product.gallery %}
									<img class="cardimage cardimage_main{% if not item.file %} cardimage_empty{% endif %}" src="{{base_url('public/filemanager/__mini__/'~item.file)|no_file('public/images/no_product_500.png')}}" cardimagepopup="{{base_url('public/filemanager/'~item.file)}}" alt="{{item.alt|default(product.name)}}">
								{% endfor %}
							{% endif %}
						{% elseif card_variant == 'horizontal' %}
							<div class="cardimage_gallery cardgallery">
								<div class="cardgallery__arrow cardgallery__arrow_left"><i class="fa fa-angle-left"></i></div>
								<ul class="cardgallery__items" id="cardGallery">
									{% if product.main_image.file %}
										<li>
											<img itemprop="image" class="cardimage cardimage_item cardimage_item_active" src="{{base_url('public/filemanager/__thumbs__/'~product.main_image.file)|no_file('public/images/no_product_500.png')}}" cardgalleryitem="{{base_url('public/filemanager/__mini__/'~product.main_image.file)}}" cardgallerypopup="{{base_url('public/filemanager/'~product.main_image.file)}}" alt="{{product.main_image.alt|default(product.name)}}">
										</li>	
									{% endif %}
									
									{% if product.videos %}
										{% for video in product.videos %}
											<li>
												<div class="cardimage cardimage_item cardimage_item_video" style="background-image: url('https://i.ytimg.com/vi/{{video.id}}/mqdefault.jpg');" cardvideoid="{{video.id}}"></div>
											</li>
										{% endfor %}
									{% endif %}
									
									{% if product.gallery %}
										{% for item in product.gallery %}
											<li>
												<img class="cardimage cardimage_item{% if not item.file %} cardimage_empty{% endif %}" src="{{base_url('public/filemanager/__thumbs__/'~item.file)|no_file('public/images/no_product_500.png')}}" cardgalleryitem="{{base_url('public/filemanager/__mini__/'~item.file)}}" cardgallerypopup="{{base_url('public/filemanager/'~item.file)}}" alt="{{item.alt|default(product.name)}}">
											</li>
										{% endfor %}
									{% endif %}
								</ul>
								<div class="cardgallery__arrow cardgallery__arrow_right"><i class="fa fa-angle-right"></i></div>
							</div>
						{% endif %}
					{% else %}
						<div class="cardimage_gallery cardgallery">
							<div class="cardgallery__arrow cardgallery__arrow_left"><i class="fa fa-angle-left"></i></div>
							<ul class="cardgallery__items" id="cardGallery"></ul>
							<div class="cardgallery__arrow cardgallery__arrow_right"><i class="fa fa-angle-right"></i></div>
						</div>
					{% endif %}
				</div>
			</div>
			
			
			<div class="col-12 col-md-6">
				<div class="carditem__caption"{% if card_variant == 'vertical' %} id="cardItemCaption"{% endif %}>
					<h1 class="carditem__title" itemprop="name">{{product.name}}</h1>
					
					<div class="carditem__categories" categories>
						{% if product.prod_categories %}
							{% for catId, catTitle in product.prod_categories %}
								<small class="carditem__category" category="{{catId}}">{{catTitle}}</small>
							{% endfor %}
						{% endif %} 
					</div>
					
					
					<div id="priceBlock" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
						{% if product.price %}
							<div class="carditem__priceblock carditem_space">
								<h2 class="carditem__price">{{product.price|number_format(0, '', ' ')}} <small>{{currency}}</small></h2>
								{% if product.price_old %}
									<h4 class="carditem__priceold">{{product.price_old|number_format(0, '', ' ')}} <small>{{currency}}</small></h4>
								{% endif %}
								{% if product.price_label and product.pricecaption %}<small class="carditem__pricecaption">{{product.pricecaption|parsedown|raw}}</small>{% endif %}
							</div>
							
						{% endif %}
						<meta itemprop="price" content="{{product.price|default(0)}}">
						<meta itemprop="priceCurrency" content="RUB">
						<meta itemprop="availability" content="http://schema.org/InStock" />
					</div>
					
					<div class="carditem__rating">
						<span class="d-block pb-4px mr-5px">Рейтинг:</span>
						<div class="d-flex align-items-center">
							{% include 'views/site/patterns/rating.tpl' with {count: 5, type: 'small', rating: product.rating} %}
							<small class="pb-2px ml-5px">{{product.rating|round(1)}}/5</small>
						</div>
						<p id="goToReviews" class="carditem__ratinglink" title="Перейти к отзывам">Отзывы</p>
					</div>
					
					
					
					{% if product.options %}
						<h3 class="carditem__captiontitle carditem_space">{{options_title}}</h3>
						<div class="carditem__opsblock opsblock opsblock_carditem noselect" id="cardOptions">
							{% for opt in product.options %}
								<div class="opsblock__item{% if opt.active %} opsblock__item_active{% endif %}" style="background-color:{{opt.color}};" title="{{opt.title}}" cardoption="{{opt.product_id}}"></div>
							{% endfor %}
						</div>   
					{% endif %}
					
					
					
					<div id="hashtagsBlock">
						{% if product.hashtags %}
							<h3 class="carditem__captiontitle carditem_space">{{tags_title}}</h3>
							<div class="carditem__hashtagsblock hashtagsblock" hashtags>
								{% for k, tag in product.hashtags %}
									<p class="hashtagsblock__item">{{tag}}</p>
								{% endfor %}
							</div>
						{% endif %}
					</div>
					
					
					<div id="iconsBlock">
						{% if product.icons %}
							<div class="carditem__iconsblock carditem_space iconsblock" icons>
								{% for k, icon in product.icons %}
									<div class="iconsblock__item iconsblock__item_card" style="background-image: url('{{icon.icon}}')" title="{{icon.title}}"></div>
								{% endfor %}
							</div>
						{% endif %}
					</div>
					
					
					{% if product.attributes or product.description %}
						<div id="attrsDescBlock">
							<h3 class="carditem__captiontitle carditem_space">Описание:</h3>
							{% if product.attributes %}
								<div class="carditem__attributeslock attributesblock" attributes>
									{% for k, attr in product.attributes %}
										<li class="attributesblock__item">
											<span>{{attr.name}}</span>
											<strong>{{attr.value}}</strong>
										</li>
									{% endfor %}
								</div>
							{% endif %}
							
							{% if product.description %}
								<div itemprop="description" class="carditem__desc{% if product.attributes %} carditem__desc_bordered{% endif %}" description>{{product.description|raw}}</div>
							{% endif %}
						</div>
					{% endif %}
					
					
					
					
					<div class="carditem__buttons carditem_space row gutters-10">
						{% if product.files %}
							<div class="col-12 col-sm-6 col-lg-4">
								<button class="button button_white button_bordered" prodid="{{product.product_id}}" sizes="{{product.files|json_encode}}">Размеры</button>
							</div>
						{% endif %}
						
						<div class="col-12 col-sm-6 col-lg-4 mt-10px mt-sm-0px">
							<button class="button button_white button_bordered button_smalltext"
								callbackform
								cbtype="5"
								cbtitle="{{callbackform[5]['title']}}"
								cbsuccess="{{callbackform[5]['send_success']}}"
								cbprod="{{product.product_id}}"
								cbbutton="{{callbackform[5]['button']}}"
								cbyandexreachgoal="{{callbackform[5]['reachgoal']}}"
								>Желаете в другой комплектации?</button>
						</div>
						
						<div class="col-12 col-sm-12 col-lg-4 mt-10px mt-lg-0px">
							<button class="button button_black"
							callbackform
							cbtype="4"
							cbtitle="{{callbackform[4]['title']}}"
							cbsuccess="{{callbackform[4]['send_success']}}"
							cbprod="{{product.product_id}}"
							cbbutton="{{callbackform[4]['button']}}"
							cbyandexreachgoal="{{callbackform[4]['reachgoal']}}"
							>{{catalog_vars.order_button}}</button>
						</div>
					</div>
					
				</div>
			</div>
		</div>
		
		
		
		{% if product.simular_products_category.count %}
			<div class="carditem__products">
				<div class="section__top">
					<h2 class="section__title">Вам может понравиться</h2>
					<a class="section__button button button_bordered button_transparent" href="{{base_url(catalog_link.seo_url)}}">
						<span>Все диваны</span>
						<svg><use xlink:href="#card-arrow"></use></svg>
					</a>
				</div>
				
				<div productslist>
					{% include 'views/site/render/catalog/list.tpl' with {'products': product.simular_products_category, 'rows': 4} %}
				</div>
				
				<div class="text-center">
					<a class="button button_bordered button_transparent hidden-sm-up" href="{{base_url(catalog_link.seo_url)}}">
						<span>Все диваны</span>
						<svg><use xlink:href="#card-arrow"></use></svg>
					</a>
				</div>
			</div>
		{% endif %}
			
		{% if product.simular_products_options.count %}
			<div class="carditem__products">
				<div class="section__top">
					<h2 class="section__title">Вам может понравиться</h2>
					<a class="section__button button button_bordered button_transparent" href="{{base_url(catalog_link.seo_url)}}">
						<span>Все диваны</span>
						<svg><use xlink:href="#card-arrow"></use></svg>
					</a>
				</div>
				
				<div productslist>
					{% include 'views/site/render/catalog/list.tpl' with {'products': product.simular_products_options, 'rows': 4} %}
				</div>
				
				<div class="text-center">
					<a class="button button_bordered button_transparent hidden-sm-up" href="{{base_url(catalog_link.seo_url)}}">
						<span>Все диваны</span>
						<svg><use xlink:href="#card-arrow"></use></svg>
					</a>	
				</div>
			</div>
		{% endif %}
		
		
		{% if product.simular_products_tags.count %}
			<div class="carditem__products">
				<div class="section__top">
					<h2 class="section__title">Вам может понравиться</h2>
					<a class="section__button button button_bordered button_transparent" href="{{base_url(catalog_link.seo_url)}}">
						<span>Все диваны</span>
						<svg><use xlink:href="#card-arrow"></use></svg>
					</a>
				</div>
				
				<div productslist>
					{% include 'views/site/render/catalog/list.tpl' with {'products': product.simular_products_tags, 'rows': 4} %}
				</div>
				
				<div class="text-center">
					<a class="button button_bordered button_transparent hidden-sm-up" href="{{base_url(catalog_link.seo_url)}}">
						<span>Все диваны</span>
						<svg><use xlink:href="#card-arrow"></use></svg>
					</a>
				</div>
			</div>
		{% endif %}
		
		
		
		<div class="carditem__reviews" reviewsblock>
			<div class="section__top align-items-center">
				<h2 class="section__title">Отзывы покупателей</h2>
				<button class="section__button section__button_ever button button_bordered button_transparent" id="newReviewBtn">
					<span class="hidden-xs-down mr-5px">Добавить отзыв</span>
					<i class="fa fa-plus hidden-sm-up ml-0px" title="Добавить отзыв"></i>
					{# <svg><use xlink:href="#card-arrow"></use></svg> #}
				</button>
			</div>
			<div id="reviewsBlock"></div>
		</div>
	</div>
</section>


<script type="text/javascript"><!--
	var unitHeightTOut;
	function setUnitHeight() {
		$('[productslist]').find('.card__caption').css('height', 'auto');
		if ($(window).width() >= breakpointSM) $('[productslist]').ddrUnitHeight('.card__caption');
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
	
	
	
	$('#goToReviews').on(tapEvent, function() {
		let reviewsPos = $('[reviewsblock]').offset().top;
		$('html, body').animate({scrollTop: (reviewsPos - 40)}, 800, 'easeOutExpo');
	});
	
	
	
	
	// получить отзывы
	let prodId = {{product.product_id}},
		prodName = '{{product.name}}';
		
	
	
	
	
	getAjaxHtml('reviews/all', {product_id: prodId, product_name: prodName}, function(html) {
		$('#reviewsBlock').html(html);
	}, function() {
		if ($('#reviewsBlock').find('#cardReviews').length) {
			
			$('[reviewimagepopup]').off(tapEvent).on(tapEvent, function() {
				let image = $(this).attr('reviewimagepopup');
				ddrPopUp({
					html: '<img src="'+image+'" alt="">',
					winClass: 'ddrpopup__win_cardimage'
				}, function(ddrwin) {});
			});
			
			
			/*let mDPosX;
			$('[reviewimagepopup]').on('mousedown', function(e) {
				mDPosX = e.clientX;
			});
			
			$('[reviewimagepopup]').on('mouseup', function(e) {
				if (mDPosX == e.clientX) {
					
				}
			});*/
		}
	});
	
	
	let reviewSuccessTOut;
	$('#newReviewBtn').off(tapEvent).on(tapEvent, function() {
		clearTimeout(reviewSuccessTOut);
		ddrPopUp({
			title: 'Добавить отзыв|4',
			width: 800,
			buttons: [{id: 'reviewAddBtn', title: 'Добавить'}],
			close: 'Отмена',
			winClass: 'ddrpopup__win_callback'
		}, function(newReviewWin) {
			newReviewWin.setData('reviews/form', function() {
				
				let filesData = [];
				ddrDragFiles({
					dropZone: '#reviewDropFiles',
					emptyDropHtml: '<svg><use xlink:href="#photo"></use></svg><span>Загрузить фото</span><svg class="arrow"><use xlink:href="#arrow_photo"></use></svg><small>Перетяните или загрузите фото с компъютера</small>',
					fileTempHtml: '<i class="ddrdragfiles__loading fa fa-spinner fa-spin"></i>',
					dropItemHtml: '<svg><use xlink:href="#photo"></use></svg><span>{{load_photo_lang}}</span>',
					itemsGridCls: 'dcol-3 dcol-sm-3 dcol-md-4 dcol-lg-5 dcol-xl-6',
					//alreadyFiles: id name src checked
					//alreadyFilesParams: параметры для запроса существующих файлов
					//deleteAlready:
					//disabled:
					accessTypes: ['image/jpeg', 'image/png', 'image/gif', 'image/webp'],
					maxFileSize: 5,
					//nameLimit: лимит назавания картинки
					lang: 'ru',
					//onInit:
					//onDragHover:
					//onDragLeave:
					//onDrop: o.dropZone, countImages, lastIter, files
					//onLoadItem: файл позиция порядковый номер файла
					//onIsset: если есть хоть один уже загруженный файл
					filesData: function(uploadedfiles) {
						filesData = uploadedfiles;
					}
				});
				
				
				
				$('#reviewRating').getRating({
					size: 30,
					labelSize: 20,
					onClick: function(mark) {
						if ($('#reviewRatingError').length) $('#reviewRatingError').remove();
						$('#reviewRatingField').val(mark);
					}
				});
				
				
				
				$('#reviewAddBtn').off(tapEvent).on(tapEvent, function() {
					$('#reviewForm').formSubmit({
						url: 'reviews/add',
						fields: {product_id: prodId},
						files: {field: 'images', files: filesData},
						formError: function(errors) {
							$.each(errors, function(k, errData) {
								if ($(errData.field).attr('id') == 'reviewRatingField') {
									$('#reviewRating').after('<span id="reviewRatingError" class="fz-14px" style="color: #ff1e1e;">Необходимо поставить оценку!</span>');
								}
							});
						},
						before: function() {
							newReviewWin.wait();
						},
						error: function() {
							newReviewWin.wait(false);
						},
						success: function(stat) {
							
							if (stat == '-1') {
								notify('Ошибка! Капча введена неверно!', 'error');
								$('#reviewCapcha').errorLabel('Неверно!');
								newReviewWin.wait(false);
							
							} else if (stat == '-2') {
								notify('Ошибка! Отзыв не добавлен!', 'error');
								newReviewWin.wait(false);
							
							} else if (stat == '1') {
								newReviewWin.setTitle('');
								newReviewWin.setData('reviews/success');
								newReviewWin.setWidth(500);
								newReviewWin.setButtons([], 'Закрыть');
								reviewSuccessTOut = setTimeout(function() {
									newReviewWin.close();
								}, 10000);
							}
						}
					});
				});
				
			});
		});
	});
		
	
	
	
	
	
	
	
//--></script> 