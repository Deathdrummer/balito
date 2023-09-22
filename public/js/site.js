jQuery(document).ready(function($) {
	
	// фиксация хэдера при скролле
	$('header').scrollFix({
		cls: 'header_fixed',
		pos: 300
	});
	
	
	
	// Левый блок
	$('[toggleleftblock]').on(tapEvent, function() {
		if (!$(this).hasClass('opened')) {
			$(this).addClass('opened');
			$(this).find('.leftblock__arrow').removeClass('leftblock__arrow_down').addClass('leftblock__arrow_up');
		} else {
			$(this).removeClass('opened');
			$(this).find('.leftblock__arrow').removeClass('leftblock__arrow_up').addClass('leftblock__arrow_down');
		}
	});
	
	
	
	// Левый блок категорий и каталога
	$('[toggleleftitem]').on(tapEvent, function() {
		let type = $(this).attr('toggleleftitem');
		
		if (!$(this).hasClass('opened')) {
			lscache.set(type, 1);
			$(this).addClass('opened');
			$(this).find('.leftitem__arrow').removeClass('leftitem__arrow_down').addClass('leftitem__arrow_up');
		} else {
			lscache.set(type, 0);
			$(this).removeClass('opened');
			$(this).find('.leftitem__arrow').removeClass('leftitem__arrow_up').addClass('leftitem__arrow_down');
		}
	});
	
	let filterCats = lscache.get('cats'),
		filterOps = lscache.get('ops'),
		filterTags = lscache.get('tags'),
		filterIcons = lscache.get('icons');
	
	if (filterCats == 1 || filterCats === null) {
		$('[toggleleftitem="cats"]').addClass('opened');
		$('[toggleleftitem="cats"]').find('.leftitem__arrow').addClass('leftitem__arrow_up');
	} 
	
	if (filterOps == 1 || filterOps === null) {
		$('[toggleleftitem="ops"]').addClass('opened');
		$('[toggleleftitem="ops"]').find('.leftitem__arrow').addClass('leftitem__arrow_up');
	}
	
	if (filterTags == 1 || filterTags === null) {
		$('[toggleleftitem="tags"]').addClass('opened');
		$('[toggleleftitem="tags"]').find('.leftitem__arrow').addClass('leftitem__arrow_up');
	}
	
	if (filterIcons == 1 || filterIcons === null) {
		$('[toggleleftitem="icons"]').addClass('opened');
		$('[toggleleftitem="icons"]').find('.leftitem__arrow').addClass('leftitem__arrow_up');
	}
	
	
	
	
	
	
	
	
	// можно указать параметр strictTags и strictIcons для запроса
	let categoryId = parseInt($('#categories').find('[currentcategory]').attr('currentcategory')) || null,
		catalogId = parseInt($('#catalogId').val()) || null,
		colors = [],
		hashtags = [],
		strictTags = $('#strictTags').val() ? true : false,
		icons = [],
		strictIcons = $('#strictIcons').val() ? true : false;
		
	
	//--------------------------------------------  цвета
	$('[option]').on(tapEvent, function() {
		$('.catalog__wait').addClass('visible');
		
		if (!$(this).hasClass('opsblock__item_active')) {
			$(this).addClass('opsblock__item_active');
		} else {
			$(this).removeClass('opsblock__item_active');
		}
		
		colors = [];
		$('#colors').find('[option].opsblock__item_active').each(function() {
			colors.push($(this).attr('option'));
		});
		
		
		getAjaxHtml('admin/catalog/get_products', {
			catalog: catalogId,
			category: categoryId,
			colors: colors,
			hashtags: hashtags,
			icons: icons,
			strict_tags: strictTags,
			strict_icons: strictIcons
		}, function(html, stat) {
			if (!stat) html = '<p class="empty">Нет данных</p>';
			$('#catalogItems, #productsList').html(html);
			buildPagination();
			$('section.catalog').find('#productsList').ddrUnitHeight('.card__caption');
		}, function() {
			$('.catalog__wait').removeClass('visible');
		}, function(err) {
			console.log(err);
		});
	});
	
	
	
	//-------------------------------------------- теги
	
	function loadTagsProducts() {
		// можно указать параметр strict_tags и strict_icons для запроса
		getAjaxHtml('admin/catalog/get_products', {
			catalog: catalogId,
			category: categoryId,
			colors: colors,
			hashtags: hashtags,
			icons: icons,
			strict_tags: strictTags,
			strict_icons: strictIcons
		}, function(html, stat) {
			if (!stat) html = '<p class="empty">Нет данных</p>';
			
			if ($('#catalogItems, #productsList').length == 0) {
				$('[productscontainer]').html('<div id="productsList" itemscope itemtype="http://schema.org/ItemList">'+html+'</div>');
			} else {
				$('#catalogItems, #productsList').html(html);
			}
			
			buildPagination();
			$('section.catalog').find('#productsList').ddrUnitHeight('.card__caption');
		}, function() {
			$('.catalog__wait').removeClass('visible');
		});
	}
	
	
	
	let urlTags = getArgs('tags');
	if (urlTags) {
		let urlTagsAr = urlTags.split(',');
		$.each(urlTagsAr, function(k, tag) {
			hashtags.push(tag);
			let t = decodeURI(tag).replace('_', ' ')
			$('[hashtag="'+t+'"]').addClass('hashtagsblock__item_active');
		});
		loadTagsProducts();
	}
	
	$('[hashtag]').on(tapEvent, function() {
		$('.catalog__wait').addClass('visible');
		if (!$(this).hasClass('hashtagsblock__item_active')) {
			$(this).addClass('hashtagsblock__item_active');
		} else {
			$(this).removeClass('hashtagsblock__item_active');
		}
		
		hashtags = [];
		$('#hashtags').find('[hashtag].hashtagsblock__item_active').each(function() {
			let tag = $(this).attr('hashtag');
			hashtags.push(tag.replace(' ', '_'));
		});
		
		if (hashtags.length) history.replaceState(null, null, location.pathname+'?tags='+hashtags.join(','))
		else history.replaceState(null, null, location.pathname);
		loadTagsProducts();
	});
	
	
	
	
	
	//-------------------------------------------- значки
	$('[icon]').on(tapEvent, function() {
		$('.catalog__wait').addClass('visible');
		
		if (!$(this).hasClass('iconsblock__item_active')) {
			$(this).addClass('iconsblock__item_active');
		} else {
			$(this).removeClass('iconsblock__item_active');
		}
		
		icons = [];
		$('#icons').find('[icon].iconsblock__item_active').each(function() {
			icons.push($(this).attr('icon'));
		});
		
		// можно указать параметр strict_tags и strict_icons для запроса
		getAjaxHtml('admin/catalog/get_products', {
			catalog: catalogId,
			category: categoryId,
			colors: colors,
			hashtags: hashtags,
			icons: icons,
			strict_tags: strictTags,
			strict_icons: strictIcons
		}, function(html, stat) {
			if (!stat) html = '<p class="empty">Нет данных</p>';
			$('#catalogItems, #productsList').html(html);
			buildPagination();
			$('section.catalog').find('#productsList').ddrUnitHeight('.card__caption');
		}, function() {
			$('.catalog__wait').removeClass('visible');
		});
	});
	
	
	
	
	
	
	// Построить пагинацию
	function buildPagination() {
		let productsCount = $('#catalogItems, #productsList').find('#productsCount').val(),
			countPerPage = $('#productsPerPage').val();
		
		if (+productsCount > +countPerPage) {
			let iters = (productsCount / countPerPage) 
			 paginationHtml = '<li class="pagination__arrow pagination__arrow_left" paginationrule="prev" title="Назад" disabled><svg><use xlink:href="#left-arrow"></use></svg></li>';
			for (page = 0; page < iters; page++) {
				paginationHtml += '<li class="pagination__item'+(page == 0 ? ' pagination__item_active' : '')+'" pagination="'+page+'">'+(page+1)+'</li>';
			}
			paginationHtml += '<li class="pagination__arrow pagination__arrow_right" paginationrule="next" title="Вперед"><svg><use xlink:href="#right-arrow"></use></svg></li>';
			$('#catalogPagination').html(paginationHtml);
		} else {
			$('#catalogPagination').html('');
		}
	}
	
	
	
	
	//------------------------------------------------------------------- Клик на цифру страницы
	$('#catalogPagination').on(tapEvent, '[pagination]:not(.pagination__item_active)', function() {
		$('.catalog__wait').addClass('visible');
		
		let thisItem = this,
			activeItem = $('[pagination].pagination__item_active'),
			page = $(thisItem).attr('pagination');

		$('[pagination].pagination__item_active').removeClass('pagination__item_active');
		$(thisItem).addClass('pagination__item_active');
		
		if (page == 0) {
			$('[paginationrule="prev"]').setAttrib('disabled');
		} else {
			$('[paginationrule="prev"][disabled]').removeAttrib('disabled');
		}
		
		if (!$(thisItem).next().attr('pagination')) {
			$('[paginationrule="next"]').setAttrib('disabled');
		} else {
			$('[paginationrule="next"][disabled]').removeAttrib('disabled');
		}
		
		// можно указать параметр strict_tags и strict_icons для запроса
		getAjaxHtml('admin/catalog/get_products', {
			catalog: catalogId,
			category: categoryId,
			colors: colors,
			hashtags: hashtags,
			icons: icons,
			page: page,
			strict_tags: strictTags,
			strict_icons: strictIcons
		}, function(html, stat) {
			if (!stat) html = '<p class="empty">Нет данных</p>';
			$('#catalogItems, #productsList').html(html);
			$('html, body').animate({scrollTop: 100}, 300, 'swing');
			$('section.catalog').find('#productsList').ddrUnitHeight('.card__caption');
		}, function() {
			$('.catalog__wait').removeClass('visible');
		});
	});
	
	
	
	
	//------------------------------------------------------------------- Клик на сттрелку
	$('#catalogPagination').on(tapEvent, '[paginationrule]', function() {
		$('.catalog__wait').addClass('visible');
		
		let dir = $(this).attr('paginationrule'),
			activeItem = $('#catalogPagination').find('.pagination__item.pagination__item_active').attr('pagination'),
			nextItem = $('#catalogPagination').find('[pagination="'+(parseInt(activeItem)+(dir == 'prev' ? -1 : +1))+'"]'),
			page = $(nextItem).attr('pagination');
		
		$('#catalogPagination').find('.pagination__item.pagination__item_active').removeClass('pagination__item_active');
		$(nextItem).addClass('pagination__item_active');
		
		
		if (dir == 'prev' && $(nextItem).attr('pagination') == 0) {
			$('[paginationrule="prev"]').setAttrib('disabled');
		} else {
			$('[paginationrule="prev"][disabled]').removeAttrib('disabled');
		}
		
		if (dir == 'next' && !$(nextItem).next().attr('pagination')) {
			$('[paginationrule="next"]').setAttrib('disabled');
		} else {
			$('[paginationrule="next"][disabled]').removeAttrib('disabled');
		}
		
		getAjaxHtml('admin/catalog/get_products', {
			catalog: catalogId,
			category: categoryId,
			colors: colors,
			hashtags: hashtags,
			icons: icons,
			page: page,
			strict_tags: strictTags,
			strict_icons: strictIcons
		}, function(html, stat) {
			if (!stat) html = '<p class="empty">Нет данных</p>';
			$('#catalogItems, #productsList').html(html);
			$('html, body').animate({scrollTop: 100}, 300, 'swing');
			$('section.catalog').find('#productsList').ddrUnitHeight('.card__caption');
		}, function() {
			$('.catalog__wait').removeClass('visible');
		}); 
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//------------------------------------------------ Карточка товара
	let imgPath = $('#imgPath').val(),
		thumbsPath = imgPath+'__thumbs__/',
		miniPath = imgPath+'__mini__/',
		prodThreed = $('#productThreed').val() || false;
	
	$('#cardGallery').ddrCarousel({
		arrowLeft: '.cardgallery__arrow_left', // Нужно делать невидимыми. Создать класс visible при котором стрелка должна отображаться
		arrowRight: '.cardgallery__arrow_right', // Нужно делать невидимыми. Создать класс visible при котором стрелка должна отображаться
		autoplay: false,
		speed: 3000,
		loop: false,
		pauseOnHover: true,
		fade: false,
		dotsSelector: false, // контеинер дял точек навигации. Активный с классом active
		response: [2, 'sm:3', 'sm:3', 'md:3', 'lg:4', 'xl:4'], // [1, 'sm:2', 'md:2', 'lg:3', 'xl:4'], первый элемент, сколько изначально показывать слайдов. Далее, брейкпоинт:кол-во слайдов
		accessBrPoints: false, // {768: 992} брейкпоинты от и до - когда карусель будет активироваться
		onInit: function() {
			$('.cardgallery').ready(function() {
				$('.cardgallery').addClass('cardgallery_visible');
			});
		},
		unitHeight: false // выровнить высоту блоков карусели (в значение можнно передать брейкпоинт с которого будет активироваться функция)
	});
	
	// Клик по картинке
	$('#cardGallery').on(tapEvent, '[cardgalleryitem]:not(.cardimage_item_active)', function() {
		let imgPath = $(this).attr('cardgalleryitem'),
			alt = $(this).attr('alt'),
			popupImg = $(this).attr('cardgallerypopup');
		
		$('#cardGallery').find('[cardgalleryitem].cardimage_item_active, [cardvideoid].cardimage_item_active').removeClass('cardimage_item_active');
		
		// Если до этого было активно видео
		if ($('[mainimage]').find('iframe').length) {
			if (prodThreed) $('[mainimage]').find('[showthreed]').removeClass('hidden');
			$('[mainimage]').find('iframe').remove();
			$('[mainimage]').find('img').removeClass('hidden');
		}
		
		$('[mainimage]').find('img').attr('src', imgPath).attr('cardimagepopup', popupImg).attr('alt', alt);
		$(this).addClass('cardimage_item_active');	
	});
	
	// Клик по видео
	$('#cardGallery').on(tapEvent, '[cardvideoid]:not(.cardimage_item_active)', function() {
		let videoId = $(this).attr('cardvideoid'),
			frameHtml = '<iframe width="100%" height="100%" src="https://www.youtube.com/embed/'+videoId+'?autoplay=1" allow="autoplay" frameborder="0" allow="accelerometer; encrypted-media; gyroscope; picture-in-picture"></iframe>';
		$('#cardGallery').find('[cardgalleryitem].cardimage_item_active, [cardvideoid].cardimage_item_active').removeClass('cardimage_item_active');
		$('[mainimage]').find('img').addClass('hidden');
		$('[mainimage]').append(frameHtml);
		if (prodThreed) $('[mainimage]').find('[showthreed]').addClass('hidden');
		$(this).addClass('cardimage_item_active');
	});
	
	
	
	
	$('.carditem__images').on(tapEvent, '[showthreed]', function() {
		let path = $(this).attr('showthreed');
		
		ddrPopUp({
			title: false,
			width: 1700,
			html: '<model-viewer class="modelviewer modelviewer_popup" id="popupModelViewer" exposure="0.4" src="/public/filemanager/'+path+'" ar ar-scale="fixed" auto-rotate camera-controls></model-viewer>',
			disabledButtons: false,
			closeByButton: false,
			close: false,
			contentToCenter: false,
			topClose: true,
			winClass: 'ddrpopup__win_modelview',
		}, function(modelViewerWin) {
			modelViewerWin.wait();
			$('#popupModelViewer').on('load', function() {
				setTimeout(function() {
					modelViewerWin.wait(false);
				}, 100);
			});
		});
	});
	
	
	
	
	$('#videoGallery').on(tapEvent, '[cardvideoid]', function() {
		$('#videoGallery').find('[cardvideoid]').html('').addClass('cardimage_main_video');
		
		let thisItem = this,
			poster = $(thisItem).attr('src'),
			videoId = $(thisItem).attr('cardvideoid'),
			frameHtml = '<iframe width="100%" height="100%" id="video'+videoId+'" src="https://www.youtube.com/embed/'+videoId+'?autoplay=1" allow="autoplay" allowfullscreen frameborder="0" allow="accelerometer; encrypted-media; gyroscope; picture-in-picture"></iframe>';
		
		$(thisItem).removeClass('cardimage_main_video').html(frameHtml);
	});
	
	
	
	
	
	
	
	
	//----------------------------------------------------------- Модальное окно фото в картоке товара
	let wRSTOut;
	$(window).resize(function() {
		clearTimeout(wRSTOut);
		wRSTOut = setTimeout(function() {
			if ($(window).width() >= breakpointSM) {
				activatePopup(true);
			} else {
				activatePopup(false);
			}
		}, 100);
	});
	
	if ($(window).width() < breakpointSM) activatePopup(false);
	
	function activatePopup(stat) {
		if (stat) {
			$('#cardItemBlock').find('[cardimagepopup][disabled]').removeAttrib('disabled');
		} else if (stat === false) {
			$('#cardItemBlock').find('[cardimagepopup]:not([disabled])').setAttrib('disabled');
		}
	}
	
	$('#cardItemBlock').on(tapEvent, '[cardimagepopup]:not([disabled])', function() {
		let showthreed = $('#cardItemBlock').find('[showthreed]');
		if ($(showthreed).length == 0 || ($(showthreed).length && $('[showthreed]').is(':hover') == false)) {
			let image = $(this).attr('cardimagepopup');
			ddrPopUp({
				html: '<img src="'+image+'" alt="">',
				winClass: 'ddrpopup__win_cardimage'
			}, function(ddrwin) {});
		}
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	$('[openaddresinfo]').on(tapEvent, function() {
		let map = $(this).attr('openaddresinfo').split('|');
		
		ddrPopUp({
			title: false,
			width: 1000,
			html: '',
			buttons: false,
			disabledButtons: false,
			closeByButton: false,
			close: false,
			contentToCenter: false,
			topClose: true,
			winClass: 'ddrpopup__win_modelview',
		}, function(openaddresinfoWin) {
			openaddresinfoWin.wait();
			
			getSectionData({section: 'contacts', template: 'render/contacts/more_info.tpl', data: {map: map}}, function(html, stat) {
				openaddresinfoWin.setData(html, false, function() {
					openaddresinfoWin.wait(false);
				});
			});
		});
	});
	
	
	
	
	
	
	
	
	
	
	$('[sizes]').on(tapEvent, function() {
		let data = $(this).attr('sizes'),
			prodId = $(this).attr('prodid'),
			sizes = false;
		if (data) {
			sizes = JSON.parse(data);
		}
		
		ddrPopUp({
			title: 'Габаритные размеры|2',
			width: 1300,
			buttons: false,
			disabledButtons: false,
			closeByButton: false,
			close: false,
			contentToCenter: false,
			winClass: 'ddrpopup__win_callback',
			closePos: 'left',
			buttonsAlign: 'between',
			topClose: true,
			addClass: false,
		}, function(sizesWin) {
			sizesWin.setData('admin/products/get_sizes', {data: sizes, product_id: prodId}, function() {
				
				$('[callbackformpopup]').on(tapEvent, function() {
					let type = $(this).hasAttr('cbtype') ? $(this).attr('cbtype').trim() : false,
						title = $(this).hasAttr('cbtitle') ? $(this).attr('cbtitle').trim() : false,
						sendSuccess = $(this).hasAttr('cbsuccess') ? $(this).attr('cbsuccess').trim() : false,
						prodId = $(this).hasAttr('cbprod') ? $(this).attr('cbprod').trim() : false,
						buttonText = $(this).hasAttr('cbbutton') ? $(this).attr('cbbutton').trim() : false,
						yandexReachGoal = $(this).hasAttr('cbyandexreachgoal') ? $(this).attr('cbyandexreachgoal').trim() : false;
					
					
					sizesWin.setData('admin/common/get_callback_form', {type: type, product_id: prodId}, function(html, stat) {
						if (!stat) {
							sizesWin.setData(html, false);
							sizesWin.removeButtons();
						} else {
							sizesWin.setTitle(title);
							sizesWin.setWidth(450);
							sizesWin.setButtons([{id: 'sendCallback', title: buttonText}], 'Отмена');
							$('#callbackForm').find('input:not([type="hidden"]):not([type="checkbox"]):not([type="checkbox"])').each(function() {
								let placeholder = $(this).attr('placeholder'),
									conditions = [];	
								if ($(this).attr('type') == 'tel') conditions.push('+7 (___) ___-__-__');
								$(this).ddrAnimInput({
									left: 0,
									index: '80%',
									top: 60,
									color: '#333',
									placeholder: placeholder,
									conditions: conditions,
									display: 'block'
								});
							});
						}
							
						$('#sendCallback').on(tapEvent, function() {
							sizesWin.wait();
							
							let capcha = $('#capcha').val(),
								capchaOrigin = $('#capcha_origin').val();
							
							if (capcha != capchaOrigin) {
								$('#capcha').errorLabel('Ошибка! Введен неверный код!');
								sizesWin.wait(false);
							} else {
								$('#callbackForm').formSubmit({
									url: 'admin/common/send_email',
									fields: {type: type},
									formError: function(error) {
										sizesWin.wait(false);
									},
									success: function() {
										sizesWin.setData('<h4>'+(sendSuccess || 'Заявка успешно отправлена!')+'</h4>', false);
										sizesWin.removeButtons();
										if (yandexReachGoal) yaCounter77386018.reachGoal(yandexReachGoal);
										setTimeout(function() {
											sizesWin.close();
										}, 5000);
									},
									complete: function() {
										sizesWin.wait(false);
									}
								});
							}	
						});
					});
					
				});
			});
			
		});
	});
	
	
	
	$('[cardoption]').on(tapEvent, function() {
		let thisOpt = this,
			prodId = $(thisOpt).attr('cardoption');
		
		$.post('/admin/products/get_card_product', {id: prodId}, function(prod) {
			
			if ($('[mainimage]').find('iframe').length) {
				$('[mainimage]').find('iframe').remove();
				$('[mainimage]').find('img').removeClass('hidden');
			}
			
			//$('[mainimage]:not(:empty)').html('');
			if (prod.main_image) {
				$('[mainimage]').removeClass('cardimage_empty');
				//$('[mainimage]').css('background-image', 'url('+imgPath+prod.main_image.file+')');
				$('[mainimage]').find('img').attr('src', imgPath+prod.main_image.file).attr('cardimagepopup', imgPath+prod.main_image.file).attr('alt', prod.main_image.alt);
				$('[mainimage]').attr('title', prod.main_image.alt);
			} else {
				$('[mainimage]').addClass('cardimage_empty');
				$('[mainimage]').css('background-image', '');
				$('[mainimage]').attr('title', false);
			}
			
			
			if (prod.threed && prod.variant == 'horizontal') $('[mainimage]').append('<div showthreed="'+prod.threed.file+'" title="'+prod.threed.alt+'"></div>');
			else $('[mainimage]').find('[showthreed]').remove();
			
			if (prod.variant == 'horizontal') {
				if (prod.gallery || prod.videos) {
					let galleryHtml = '';
					
					if (prod.main_image) {
						galleryHtml += '<li>';
						galleryHtml += 	'<div class="cardimage cardimage_item cardimage_item_active" style="background-image: url(\''+thumbsPath+prod.main_image.file+'\');" cardgalleryitem="'+imgPath+prod.main_image.file+'" title="'+prod.main_image.alt+'"></div>';
						galleryHtml += '</li>';
					}
					
					if (prod.videos) {
						$.each(prod.videos, function(k, video) {
							galleryHtml += '<li>';
							galleryHtml += '<div class="cardimage cardimage_item cardimage_item_video" style="background-image: url(\'https://i.ytimg.com/vi/'+video.id+'/mqdefault.jpg\');" cardvideoid="'+video.id+'"></div>';
							galleryHtml += '</li>';
						});
					}
					
					if (prod.gallery) {
						$.each(prod.gallery, function(k, item) {
							galleryHtml += '<li>';
							galleryHtml += 	'<div class="cardimage cardimage_item" style="background-image: url(\''+thumbsPath+item.file+'\');" cardgalleryitem="'+miniPath+item.file+'" cardgallerypopup="'+imgPath+item.file+'" title="'+item.alt+'"></div>';
							galleryHtml += '</li>';
						});
					}
					
					
					$('#cardGallery').ddrCarousel('destroy');
					$('#cardGallery').html(galleryHtml);
					
					$('#cardGallery').ddrCarousel({
						arrowLeft: '.cardgallery__arrow_left', // Нужно делать невидимыми. Создать класс visible при котором стрелка должна отображаться
						arrowRight: '.cardgallery__arrow_right', // Нужно делать невидимыми. Создать класс visible при котором стрелка должна отображаться
						autoplay: false,
						speed: 3000,
						loop: false,
						pauseOnHover: true,
						fade: false,
						dotsSelector: false, // контеинер дял точек навигации. Активный с классом active
						response: [2, 'sm:3', 'sm:3', 'md:3', 'lg:4', 'xl:4'], // [1, 'sm:2', 'md:2', 'lg:3', 'xl:4'], первый элемент, сколько изначально показывать слайдов. Далее, брейкпоинт:кол-во слайдов
						accessBrPoints: false, // {768: 992} брейкпоинты от и до - когда карусель будет активироваться
						onInit: function() {
							$('#cardGallery').show();
						},
						unitHeight: false // выровнить высоту блоков карусели (в значение можнно передать брейкпоинт с которого будет активироваться функция)
					});
				} else {
					$('#cardGallery').ddrCarousel('destroy');
					$('#cardGallery').html('');
				}
				
			} else if (prod.variant == 'vertical') {
				let galleryHtml = '';
				
				if (prod.main_image) {
					galleryHtml += 	'<div class="cardimage cardimage_main" style="background-image: url(\''+(imgPath+prod.main_image.file)+'\');" cardimagepopup="'+(imgPath+prod.main_image.file)+'" title="'+prod.main_image.alt+'"></div>';
				}
				
				if (prod.threed) {
					galleryHtml += '<model-viewer class="cardimage cardimage_main cardimage_main_obj modelviewer" src="'+(imgPath+prod.threed.file)+'" title="'+(prod.threed.alt)+'" auto-rotate camera-controls></model-viewer>';
				}
				
				if (prod.videos) {
					$.each(prod.videos, function(k, video) {
						galleryHtml += '<div class="cardimage cardimage_main cardimage_main_video" style="background-image: url(\'https://i.ytimg.com/vi/'+video.id+'/mqdefault.jpg\');" cardvideoid="'+video.id+'"></div>';
					});
				}
				
				if (prod.gallery) {
					$.each(prod.gallery, function(k, item) {
						galleryHtml += 	'<div class="cardimage cardimage_main" style="background-image: url(\''+(miniPath+item.file)+'\');" cardimagepopup="'+imgPath+item.file+'" title="'+item.alt+'"></div>';
					});
				}
				
				$('.carditem__images').html(galleryHtml);
			}
				
			
			$('[name]').text(prod.name);
			document.title = prod.title;

			
			if (prod.prod_categories) {
				let catsHtml = '';
				$.each(prod.prod_categories, function(id, title) {
					catsHtml += '<small class="carditem__category" category="'+id+'">'+title+'</small>';
				});
				$('[categories]').html(catsHtml);
			} else $('[categories]').html('');
			
			if (prod.price) {
				let priceHtml = '';
				priceHtml += '<div class="carditem__priceblock carditem_space">';
				priceHtml +=	'<h2 class="carditem__price">'+$.number(prod.price, 0, '.', ' ')+' <small>'+prod.currency+'</small></h2>';
				if (prod.price_old) {
					priceHtml +=	'<h4 class="carditem__priceold">'+$.number(prod.price_old, 0, '.', ' ')+' <small>'+prod.currency+'</small></h4>';
				}
				if (prod.pricecaption) priceHtml +=	'<small class="carditem__pricecaption">'+prod.pricecaption+'</small>';
				priceHtml += '</div>';
				$('#priceBlock').html(priceHtml);
			} else {
				$('#priceBlock').html('');
			}
			
			
			
			if (prod.hashtags) {
				let tagsHtml = '';
				$.each(prod.hashtags, function(k, tag) {
					tagsHtml += '<p class="hashtagsblock__item">'+tag+'</p>\n';
				});
				$('#hashtagsBlock').html('<h3 class="carditem__captiontitle carditem_space">Теги:</h3><div class="carditem__hashtagsblock hashtagsblock" hashtags>'+tagsHtml+'</div>');
			} else {
				$('#hashtagsBlock').html('');
			}
			
			
			if (prod.icons) {
				let iconsHtml = '';
				$.each(prod.icons, function(k, icon) {
					iconsHtml += '<div class="iconsblock__item iconsblock__item_card" style="background-image: url(\''+icon.icon+'\')" title="'+icon.title+'"></div>\n';
				});
				$('#iconsBlock').html('<div class="carditem__iconsblock carditem_space iconsblock" icons>'+iconsHtml+'</div>');
			} else {
				$('#iconsBlock').html('');
			}
			
			
			
			
			
			
			if (prod.attributes || prod.description) {
				let htmlTool = '';
				htmlTool += '<h3 class="carditem__captiontitle carditem_space">Описание:</h3>';
			
				if (prod.attributes) {
					htmlTool += '<div class="carditem__attributeslock attributesblock" attributes>';
					$.each(prod.attributes, function(k, attr) {
						htmlTool += '<li class="attributesblock__item">';
						htmlTool += 	'<span>'+attr.name+'</span>'+"\n";
						htmlTool += 	'<strong>'+attr.value+'</strong>';
						htmlTool += '</li>';
					});
					htmlTool += '</div>';
				}
				
				if (prod.description) {
					htmlTool += '<div class="carditem__desc'+(prod.attributes ? ' carditem__desc_bordered' : '')+'" description>'+prod.description+'</div>'
				}
				$('#attrsDescBlock').html(htmlTool);
			} else {
				$('#attrsDescBlock').html('');
			}
			
				
			
			
			if (prod.files) {
				$('[sizes]').setAttrib('sizes', JSON.stringify(prod.files));
			}
			
			
			$('[setorder]').attr('setorder', prod.id);
			
			
			history.replaceState({}, prod.name, prod.seo_url);
			$('#cardOptions').find('.opsblock__item.opsblock__item_active').removeClass('opsblock__item_active');
			$(thisOpt).addClass('opsblock__item_active');
		}, 'json').fail(function(e) {
			notify('Системная ошибка!', 'error');
			showError(e);
		});
		
	});
	
	
	
	
	
	// Плавающий блок в карточке товара
	if ($('#cardItemCaption').length && $(window).width() > breakpointMD) $('#cardItemCaption').ddrFloatingBlock(20);
	
	
	$('.contactsnav__item:first').find('[contactsnavtitle]').addClass('contactsnav__title_opened');
	$('#contactsTabsContent').find('[contactstab]:first').addClass('visible');
	
	if ($(window).width() > breakpointMD) {
		$('.contactsnav').on(tapEvent, '[contactsnavtitle]:not(.contactsnav__title_opened)', function() {
			$('[contactsnavtitle].contactsnav__title_opened').removeClass('contactsnav__title_opened');
			$(this).addClass('contactsnav__title_opened');
		});
		
	} else {
		$('[opencontacts]').on(tapEvent, function() {
			let thisItem = this;
			setTimeout(function() {
				$(thisItem).closest('.contacts__nav').removeClass('contacts__nav_opened');
				$(thisItem).closest('.contactsnavmobile').removeAttrib('aria-expanded');
			}, 50);
		});
	}
	
	
	
	
	$('.contactsnav__list:first').find('[opencontacts]:first').addClass('active');
	
	$('[opencontacts]').on(tapEvent, function() {
		let thisItem = this,
			tabId = $(thisItem).attr('opencontacts');
		
		$('[opencontacts].active').removeClass('active');
		$(thisItem).addClass('active');
		
		$('#contactsTabsContent').find('[contactstab]').removeClass('visible');
		$('#contactsTabsContent').find('[contactstab="'+tabId+'"]').addClass('visible');
	});
	
	
	
	
	$('[materialsnav]').find('[openmatherialscategory]:first').addClass('active');
	$('[matherialscategorytab]:first').addClass('visible');
	
	$('[openmatherialscategory]').on(tapEvent, function() {
		let thisItem = this,
			tabId = $(thisItem).attr('openmatherialscategory');
		
		$('[openmatherialscategory].active').removeClass('active');
		$(thisItem).addClass('active');
		
		$('#contactsTabsContent').find('[matherialscategorytab]').removeClass('visible');
		$('#contactsTabsContent').find('[matherialscategorytab="'+tabId+'"]').addClass('visible');
	});
	
	
	
	
	
	$('#matherialsBlock').on(tapEvent, '[openmaterial]', function() {
		let d = $(this).attr('openmaterial').split('|'),
			title = d[0],
			imageUrl = d[1],
			desc = $(this).closest('.material').find('[materialdesc]').attr('materialdesc'),
			html = '';
		
		
		html += '<div class="material material_popup">';
		html += '<img class="material__image" src="'+imageUrl+'" />';
		html += '<div class="material__caption">';
		html += 	'<div class="material__desc material__desc_raw" materialdesc>'+desc+'</div>';
		html += '</div>';
		html += '</div>';
		
		ddrPopUp({
			title: title,
			html: html,
			width: 1200,
			buttonsAlign: 'right',
			buttonsDir: 'ltr',
			close: 'Закрыть',
		}, function(materialWin) {
			
		});
	});
	
	
	
	
	
	
	
	
	
	//----------------------------------------------------------- Форма связи
	
	$('[callbackform]').on(tapEvent, function() {
		let type = $(this).hasAttr('cbtype') ? $(this).attr('cbtype').trim() : false,
			title = $(this).hasAttr('cbtitle') ? $(this).attr('cbtitle').trim() : false,
			sendSuccess = $(this).hasAttr('cbsuccess') ? $(this).attr('cbsuccess').trim() : false,
			prodId = $(this).hasAttr('cbprod') ? $(this).attr('cbprod').trim() : false,
			buttonText = $(this).hasAttr('cbbutton') ? $(this).attr('cbbutton').trim() : false,
			yandexReachGoal = $(this).hasAttr('cbyandexreachgoal') ? $(this).attr('cbyandexreachgoal').trim() : false;
		
		ddrPopUp({
			title: title+'|5',
			width: 450,
			buttons: [{id: 'sendCallback', title: buttonText}],
			buttonsAlign: 'between',
			winClass: 'ddrpopup__win_callback',
			disabledButtons: true,
			closePos: 'left',
			close: 'Отмена'
		}, function(callbackWin) {
			callbackWin.setData('admin/common/get_callback_form', {type: type, product_id: prodId}, function(html, stat) {
				if (!stat) {
					callbackWin.setData(html, false);
					callbackWin.removeButtons();
				} else {
					callbackWin.enabledButtons();
					$('#callbackForm').find('input:not([type="hidden"]):not([type="checkbox"]):not([type="checkbox"])').each(function() {
						let placeholder = $(this).attr('placeholder'),
							conditions = [];	
						if ($(this).attr('type') == 'tel') conditions.push('+7 (___) ___-__-__');
						$(this).ddrAnimInput({
							left: 0,
							index: '80%',
							top: 60,
							color: '#333',
							placeholder: placeholder,
							conditions: conditions,
							display: 'block'
						});
					});
				}
					
			});
			
			$('#sendCallback').on(tapEvent, function() {
				callbackWin.wait();
				
				let capcha = $('#capcha').val(),
					capchaOrigin = $('#capcha_origin').val();
				
				if (capcha != capchaOrigin) {
					$('#capcha').errorLabel('Ошибка! Введен неверный код!');
					callbackWin.wait(false);
				} else {
					$('#callbackForm').formSubmit({
						url: 'admin/common/send_email',
						fields: {type: type},
						formError: function(error) {
							callbackWin.wait(false);
						},
						success: function() {
							callbackWin.setData('<h4>'+(sendSuccess || 'Заявка успешно отправлена!')+'</h4>', false);
							callbackWin.removeButtons();
							if (yandexReachGoal) yaCounter77386018.reachGoal(yandexReachGoal);
							setTimeout(function() {
								callbackWin.close();
							}, 5000);
						},
						complete: function() {
							callbackWin.wait(false);
						}
					});
				}	
			});
			
		});
	});
	
	
	
});















































