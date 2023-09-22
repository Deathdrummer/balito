jQuery(document).ready(function($) {
	
	// -------------------------------------------------------------------- меню
	var hideNavTOut;
	$('nav.main_nav').on('mouseenter', function() {
		clearTimeout(hideNavTOut);
	});
	
	$('nav.main_nav, #openNav').on('mouseleave', function() {
		hideNavTOut = setTimeout(function() {
			if ($('#openNav').is(':hover') == false) {
				$('i[touch]').prop('aria-expanded', 'false');
				$('.header__item.opened').removeClass('opened');
			}
		}, 300);
	});
	
	$('nav.main_nav li').on(tapEvent, function() {
		if ($(this).hasClass('active') == false) {
			var thisSection = $(this).data('block');
			$('nav.main_nav').find('li').removeClass('active');
			$(this).addClass('active');
			
			location.hash = '#'+thisSection;
			$(window).one('hashchange', function() {
				renderSection();
			});
			
			$('i[touch]').prop('aria-expanded', 'false');
			$('.header__item.opened').removeClass('opened');
		}
	});
	
	
	
	
	
	
	// -------------------------------------------------------------------- Загрузка блоков
	// - параметры 
	// - callback 
	renderSection = function() {
		
		$('#sectionWait').addClass('visible');
		
		var params = {},
			callback = false,
			hashData = location.hash.substr(1, location.hash.length).split('.'),
			section = hashData[0];
		
		if (arguments.length == 2) {
			params = arguments[0] || {},
			callback = typeof arguments[1] == 'function' ? arguments[1] : false;
		} else if (arguments.length == 1) {
			params = typeof arguments[0] == 'object' ? arguments[0] : {};
			callback = typeof arguments[0] == 'function' ? arguments[0] : false;
		}
		
		$.post('/admin/get_sections_data', {section: section, params: params}, function(html) {
			$('#section').html(html);
			
			//------------------------- Активировать табы, если нет ни одного активного пункта
			if (hashData[1] != undefined) {
				$('#'+section).find('.tabstitles:not(.sub) li').removeClass('active');
				$('#'+section).find('.tabstitles:not(.sub) li#'+hashData[1]).addClass('active');
				
				$('#'+section).find('.tabstitles:not(.sub)').siblings('.tabscontent').find('[tabid]').removeClass('visible');
				$('#'+section).find('.tabstitles:not(.sub)').siblings('.tabscontent').find('[tabid="'+hashData[1]+'"]').addClass('visible');
			} else {
				$('#'+section).find('.tabstitles:not(.sub) li:first').addClass('active');
				$('#'+section).find('.tabstitles:not(.sub)').siblings('.tabscontent').find('[tabid]:first').addClass('visible');
			}
			
			
			
			if (hashData[2] != undefined) {
				if ($('#'+section).find('.tabstitles:not(.sub)').siblings('.tabscontent').find('.tabstitles.sub').length > 0) {
					$('#'+section).find('.tabstitles:not(.sub)').siblings('.tabscontent').find('.tabstitles.sub').each(function() {
						if ($(this).children('li#'+hashData[2]).length > 0) {
							$(this).children('li').removeClass('active');
							$(this).children('li#'+hashData[2]).addClass('active');
							
							$(this).siblings('.tabscontent').find('[tabid]').removeClass('visible');
							$(this).siblings('.tabscontent').find('[tabid="'+hashData[2]+'"]').addClass('visible');
						} else {
							$(this).children('li:first').addClass('active');
							$(this).siblings('.tabscontent').find('[tabid]:first').addClass('visible');
						}
					});
				}
			} else {
				if ($('#'+section).find('.tabstitles:not(.sub)').siblings('.tabscontent').find('.tabstitles.sub').length > 0) {
					$('#'+section).find('.tabstitles:not(.sub)').siblings('.tabscontent').find('.tabstitles.sub').each(function() {
						$(this).children('li').removeClass('active');
						$(this).children('li:first').addClass('active');
						
						$(this).siblings('.tabscontent').find('[tabid]').removeClass('visible');
						$(this).siblings('.tabscontent').find('[tabid]:first').addClass('visible');
					});
				}	
			}
			
			
			setBaseScripts();
						
			// Показать подписи name атрибута полей
			if (getArgs('shownames') == 1) {
				$('body').find('input, textarea, select').each(function(k, item) {
					var thisSelector = this, 
						thisName = $(thisSelector).attr('name') || '';
					$(thisSelector).after('<code showinputname>'+thisName+'</code>');
					$('[showinputname]').css({
						'position': 'absolute',
						'bottom': '-18px',
						'right': '0',
						'font-size': '12px',
						'background-color': '#f6ff93',
						'padding': '1px 4px'
					});
				});
			}
				
			
			
			$('#sectionWait').removeClass('visible');
			$(document).trigger('rendersection');
			if (callback) callback();
		}, 'html').fail(function(e) {
			notify('Системная ошибка!', 'error');
			showError(e);
		});
	};
	
	
	
	// -------------------------------------------------------------------- Автозагрузка section при загрузке страницы и установка tabs 
	if ($('.auth_form').length == 0) {
		if (location.hash == '') {
			location.hash = '#settings';
			$(window).one('hashchange', function() {
				renderSection();
			});
			$('li[data-block="settings"]').addClass('active');
		} else {
			var hashData = location.hash.substr(1, location.hash.length).split('.'),
				section = hashData[0];
			$('li[data-block="'+section+'"]').addClass('active');
			renderSection();
		}
	}
		
	
	
	
	
	
	function activateMarkdown() {
		$('body').find('[markdown]:visible:not(.activated)').each(function(k, item) {
			$(item).addClass('activated');
			let simplemde = new SimpleMDE({
		    	element: item,
		    	autofocus: false,
		    	forceSync: true,
		    	spellChecker: false,
		    	toolbar: [
		    		"bold", "italic", "heading-1", "heading-2", "heading-3", "strikethrough",
		    		"|",
		    		"unordered-list", "ordered-list",
		    		"|",
		    		"link", "image", "table", "horizontal-rule",
		    		"|",
		    		"quote",
		    		"|",
		    		"preview", "side-by-side", "fullscreen"
		    	],
			});
			
			simplemde.codemirror.on("change", function() {
		    	$(item).text(simplemde.value());
			});
		});
	}
	
	$(document).on('rendersection', function() {
		activateMarkdown();
		$(document).on('tabsChange', function() {
			activateMarkdown();
		});
	});
	

	
	
	
	
	
	
	
	
	
	
	
	
	// -------------------------------------------------------------------- Перейти на сайт
	$('#goToSite').on('click', function() {
		var fullPath = location.protocol+'//'+location.host+location.pathname;
		window.open(fullPath.substr(0, fullPath.length - 6));
	});
	
	
	
	// -------------------------------------------------------------------- Выход из админки
	$('#adminLogout').on(tapEvent, function() {
		location = 'admin/logout';
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
});