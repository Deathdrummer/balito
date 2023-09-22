<form class="section mb-20px" id="{{id}}" autocomplete="off">
	<div class="section_title">
		<h2>Общие настройки</h2>
		<div class="buttons notop">
			<button class="large" id="{{id}}Save" title="Сохранить настройки"><i class="fa fa-save"></i> <span>Сохранить</span></button>
		</div>
	</div>
	
	
	<ul class="tabstitles">
		<li id="tabContent">Контент</li>
		<li id="tabSoc">Соц. сети</li>
		<li id="tabOpenGraph">Open Graph</li>
		<li id="tabCallback">Формы обратной связи</li>
		<li id="tabSettings">Системные настройки</li>
	</ul>
	
	
	<div class="tabscontent">
		<div tabid="tabContent">
			<table class="fieldset">
				
				{% include form~'file.tpl' with {'label': 'Изображения и иконки', 'data': [
					{'name': 'setting_logo', 'label': 'Логотип', 'ext': 'images', 'alt': 1},
					{'name': 'setting_favicon', 'label': 'Фавикон', 'ext': 'images'}
				]} %}
				
				
				
				{% include form~'field.tpl' with {'label': 'телефоны', 'name': 'setting_phone', 'rules': 'empty', 'data': [
					{'name': 'mobile1', 'label': 'Мобильный телефон 1', 'phonemask': 1},
					{'name': 'mobile12', 'label': 'Мобильный телефон 2', 'phonemask': 1},
					{'name': 'free1', 'label': 'Бесплатный телефон 1', 'mask': '8 (800) ^^^-^^-^^'},
					{'name': 'free2', 'label': 'Бесплатный телефон 2', 'mask': '8 (800) ^^^-^^-^^'},
					{'name': 'city1', 'label': 'Городской телефон 1', 'mask': '8 (^^^) ^^^-^^-^^'},
					{'name': 'city2', 'label': 'Городской телефон 2', 'mask': '8 (^^^) ^^^-^^-^^'}
				]} %}
				
				
				{% include form~'field.tpl' with {'label': 'E-mail адреса', 'name': 'setting_email', 'rules': 'empty', 'data': [
					{'name': 'from', 'label': 'От кого приходят письма', 'rules': 'email', 'placeholder': 'example@site.ru'},
					{'name': 'to', 'label': 'Куда приходят письма', 'rules': 'email', 'placeholder': 'example@site.ru'},
					{'name': 'subject', 'label': 'Заголовок письма', 'rules': 'string', 'placeholder': 'Новая заявка'},
					{'name': 'from_name', 'label': 'Отправитель', 'rules': 'string', 'placeholder': 'site.ru'},
					{'name': 'contact', 'label': 'Отобразить на сайте', 'rules': 'email', 'placeholder': 'example@site.ru'},
				]} %}
				
				
				{% include form~'field.tpl' with {'label': 'настройки SMPT', 'name': 'setting_smtp', 'rules': 'empty', 'data': [
					{'name': 'host', 'label': 'Хост', 'rules': 'string', 'placeholder': 'Имя сервера'},
					{'name': 'user', 'label': 'Пользователь', 'rules': 'string', 'placeholder': ''},
					{'name': 'pass', 'label': 'Пароль', 'rules': 'string', 'type': 'password', 'placeholder': 'Пароль от почты'},
					{'name': 'port', 'label': 'Порт', 'rules': 'string', 'placeholder': ''},
					{'name': 'crypto', 'label': 'Шифрование', 'rules': 'string', 'placeholder': 'STARTTLS'},
				]} %}
				
				
				
				{% include form~'textarea.tpl' with {'label': 'Мета-теги', 'rows': 10, 'name': 'setting_metatags'} %}
				{% include form~'textarea.tpl' with {'label': 'JS функции (работают только на хостинге)', 'rows': 20, 'name': 'setting_scripts'} %}
				{% include form~'textarea.tpl' with {'label': 'Скрипты в <head>', 'rows': 10, 'name': 'setting_scripts_head'} %}
				
				
				{% include form~'field.tpl' with {'label': 'Количество товаров на странице', 'name': 'setting_count_products', 'type': 'number', 'cls': 'w-60px'} %}
				
				{% include form~'select.tpl' with {'label': 'Тип карточки товара', 'name': 'setting_card_variant', 'data': [
					{'value': 'vertical', 'title': 'Вертикальные изображения'},
					{'value': 'horizontal', 'title': 'Горионтальные изображения'}
				], 'cls': 'w-40rem'} %}
				
				{% include form~'select.tpl' with {'label': 'Отображение 3D модели в вертикальном типе карточки', 'name': 'setting_show_3d_variant', 'data': [
					{'value': 'in_main', 'title': 'Иконка в главной картинке'},
					{'value': 'standalone', 'title': 'Отдельный элемент'}
				], 'cls': 'w-40rem'} %}
				
				{% include form~'field.tpl' with {'label': 'Знак валюты', 'name': 'setting_currency', 'cls': 'w-60px'} %}
				
				{% include form~'file.tpl' with {'label': 'PDF каталог', 'name': 'setting_pdf_catalog', 'ext': 'docs'} %}
				
				
				{% include form~'field.tpl' with {'label': 'Плавающая иконка', 'name': 'setting_stockicon', 'data': [
					{'name': 'url', 'label': 'URL страницы', 'rules': 'string', 'placeholder': 'URL страницы', 'cls': 'w-60rem'},
					{'name': 'link_title', 'label': 'Title ссылки', 'rules': 'string', 'placeholder': 'Title ссылки', 'cls': 'w-60rem'}
				]} %}
				
				{% include form~'field.tpl' with {'label': 'ID иконки прокрутки вверх', 'name': 'setting_scrolltop', 'cls': 'w-20rem'} %}
				
				
				{% include form~'textarea.tpl' with {'label': 'Надпись под ценой в карточке товара', 'markdown': 1, 'rows': 4, 'name': 'setting_pricecaption'} %}
				
				
				
						
				{#{% include form~'field.tpl' with {'label': 'тест', 'name': 'setting_site|foo'} %}
				{% include form~'field.tpl' with {'label': 'Просто переменная', 'name': 'setting_site|variable'} %}
				
				{% include form~'field.tpl' with {'label': 'тест 2', 'name': 'setting_site|title'} %}
				{% include form~'field.tpl' with {'label': 'Просто переменная 2', 'name': 'setting_site|variable'} %}			
				
				{% include form~'field.tpl' with {'label': 'Заголовок сайта', 'type': 'tel', 'phonemask': 1, 'code': '+7', 'name': 'setting_site_tool'} %}
				
				{% include form~'textarea.tpl' with {'label': 'Meta description', 'editor': 1, 'name': 'setting_description'} %}
				
				{% include form~'select.tpl' with {'label': 'Тип Карточки товара', 'name': 'setting_card_variant', 'data': [
					{'value': 'vertical', 'title': 'Вертикальные изображения'},
					{'value': 'horizontal', 'title': 'Горионтальные изображения'}
				], 'cls': 'w-40rem'} %}
				
				{% include form~'checkbox.tpl' with {'label': 'checkbox', 'v': 2, 'data': [
					{'name': 'setting_first', 'label': 'Инстаграм', 'value': 'insta', 'inline': 0},
					{'name': 'setting_second', 'label': 'Инстаграм2', 'value': 'insta2', 'inline': 0},
					{'name': 'setting_third', 'label': 'Инстаграм3', 'value': 'insta3', 'inline': 0}
				]} %}
				
				{% include form~'radio.tpl' with {'label': 'Заголовок radio', 'name': 'setting_site|radio', 'data': [
					{'label': 'Инстаграм 4', 'value': 'insta4', 'inline': 1},
					{'label': 'Инстаграм 5', 'value': 'insta5', 'inline': 1},
					{'label': 'Инстаграм 6', 'value': 'insta6', 'inline': 0},
					{'label': 'Инстаграм 7', 'value': 'insta7', 'inline': 0}
				]} %}#}
				
				
				
				{#{% include form~'file.tpl' with {'label': 'Это лейбл для файла', 'data': [
					{'name': 'foo', 'label': 'Инстаграм', 'ext': 'images'},
					{'name': 'bar', 'label': 'Инстаграм2', 'ext': 'images'},
					{'name': 'rool', 'label': 'Инстаграм3', 'ext': 'jpg|jpeg|png|gif'}
				]} %}#}
			</table>
		</div>
		
		<div tabid="tabSoc">
			<table class="fieldset">
				<tbody>
					<tr>
						<td class="default">Социальные сети</td>
						<td>
							<table>
								<thead>
									<tr>
										<td class="w-66px">Иконка</td>
										<td class="w-30rem">Иконка fontawesome</td>
										<td class="w-30rem">Иконка sprite</td>
										<td class="w-40rem">Название</td>
										<td>Ссылка</td>
										<td class="w-60px">Сортировка</td>
										<td class="w-60px">Опции</td>
									</tr>
								</thead>
								<tbody id="socList">
									{% if setting_soc %}
										{% for index, item in setting_soc %}
											{% include 'views/admin/render/common/soc_item.tpl' with {index: index, item: item} %}
										{% endfor %}
									{% else %}
										<tr class="empty">
											<td colspan="7"><p class="empty center">Нет данных</p></td>
										</tr>
									{% endif %}
								</tbody>
								<tfoot>
									<tr>
										<td colspan="7">
											<div class="buttons right notop">
												<button class="small alt" id="addSocItem">Добавить</button>
											</div>
										</td>
									</tr>
								</tfoot>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		
		
		<div tabid="tabOpenGraph">
			<table class="fieldset">
				{% include form~'file.tpl' with {'label': 'Картинка', 'name': 'setting_og|image', 'ext': 'images'} %}
				
				{% include form~'field.tpl' with {'label': 'Заголовок', 'name': 'setting_og|title', 'cls': 'w-60rem'} %}
				{% include form~'field.tpl' with {'label': 'URL', 'name': 'setting_og|url', 'cls': 'w-60rem'} %}
				{% include form~'field.tpl' with {'label': 'Название сайта', 'name': 'setting_og|site_name', 'cls': 'w-60rem'} %}
				
				{% include form~'textarea.tpl' with {'label': 'Описание', 'rows': 4, 'name': 'setting_og|description', 'cls': 'w-60rem'} %}
			</table>
		</div>
		
		
		<div tabid="tabCallback">
			<ul class="tabstitles sub mt-30px mb-20px">
				<li id="subTabHeaderCallback">Заказать звонок в шапке сайте</li>
				<li id="subTabPromoCallback">Получить промокод</li>
				<li id="subTabIndividualCallback">Индивидульный подход</li>
				<li id="subTabCardCallback">Заказать в карточке товара</li>
				<li id="subTabOtherEquipment">Желаете в другой комплектации</li>
				<li id="subTabCommonCallback">Кнопка обратной связи</li>
			</ul>
			
			
			
			
			<div class="tabscontent">
				{% for k, tabid in ['subTabHeaderCallback', 'subTabPromoCallback', 'subTabIndividualCallback', 'subTabCardCallback', 'subTabOtherEquipment', 'subTabCommonCallback'] %}
					<div tabid="{{tabid}}">
						<table class="fieldset">
							{% include form~'field.tpl' with {'label': 'Заголовок в форме на сайте', 'name': 'setting_callbackform|'~(k+1)~'|title', 'cls': 'w-100rem'} %}
							{% include form~'field.tpl' with {'label': 'Заголовок в письме', 'name': 'setting_callbackform|'~(k+1)~'|title_mail', 'cls': 'w-100rem'} %}
							{% include form~'field.tpl' with {'label': 'Сообщение при успешной отправке', 'name': 'setting_callbackform|'~(k+1)~'|send_success', 'cls': 'w-100rem'} %}
							{% include form~'field.tpl' with {'label': 'Текст кнопки', 'name': 'setting_callbackform|'~(k+1)~'|button', 'cls': 'w-100rem'} %}
							
							{% include form~'textarea.tpl' with {'label': 'Описание в форме', 'name': 'setting_callbackform|'~(k+1)~'|desc', 'cls': 'w-100rem'} %}
							
							{% if k == 1 %}
								{% include form~'field.tpl' with {'label': 'Заголовок в письме для клиента', 'name': 'setting_title_promo', 'cls': 'w-100rem'} %}
								{% include form~'field.tpl' with {'label': 'Тема письма для клиента', 'name': 'setting_subject_promo', 'cls': 'w-100rem'} %}
								{% include form~'field.tpl' with {'label': 'Промокод маска: * - буква с нижним регистром, # - буква с верхним регистром, ? - цифра', 'name': 'setting_promocode', 'cls': 'w-30rem'} %}
								{% include form~'textarea.tpl' with {'label': 'текст по промокоду в письме', 'name': 'setting_promo_desc', 'cls': 'w-100rem'} %}
							{% endif %}
							
							{% include form~'field.tpl' with {'label': 'Цель Яндекс метрики', 'name': 'setting_callbackform|'~(k+1)~'|reachgoal', 'cls': 'w-100rem'} %}
							
							
							{% include form~'checkbox.tpl' with {'label': 'Отобразить поля в форме', 'name': 'setting_callbackform|'~(k+1)~'|fields', 'v': 2, 'data': [
								{'name': 'name', 'label': 'Имя', 'value': 1, 'small': 1, 'inline': 1},
								{'name': 'phone', 'label': 'Телефон', 'value': 1, 'small': 1, 'inline': 1},
								{'name': 'email', 'label': 'E-mail', 'value': 1, 'small': 1, 'inline': 1},
								{'name': 'city', 'label': 'Город', 'value': 1, 'small': 1, 'inline': 1}
							]} %}
							
							{% include form~'checkbox.tpl' with {'label': 'Обязательное поле', 'name': 'setting_callbackform|'~(k+1)~'|required', 'v': 2, 'data': [
								{'name': 'name', 'label': 'Имя', 'value': 1, 'small': 1, 'inline': 1},
								{'name': 'phone', 'label': 'Телефон', 'value': 1, 'small': 1, 'inline': 1},
								{'name': 'email', 'label': 'E-mail', 'value': 1, 'small': 1, 'inline': 1},
								{'name': 'city', 'label': 'Город', 'value': 1, 'small': 1, 'inline': 1}
							]} %}
							
						</table>
					</div>
				{% endfor %}
			</div>
		</div>
		
		
		<div tabid="tabSettings">
			<table class="fieldset">
				{% include form~'checkbox.tpl' with {'label': 'Задавать переменные в категориях', 'v': 2, 'data': [
					{'name': 'setting_setvarstocats', 'value': 'insta', 'inline': 0}
				]} %}
				
				{% include form~'checkbox.tpl' with {'label': 'Задавать переменную для страницы карточки товара в каталогах', 'v': 2, 'data': [
					{'name': 'setting_setvarstocatalogs', 'value': 'insta', 'inline': 0}
				]} %}
				
				{% include form~'checkbox.tpl' with {'label': 'Строгий режим фильтров товаров в каталоге', 'name': 'setting_strict_filters', 'v': 2, 'data': [
					{'name': 'tags', 'label': 'Теги', 'value': 1},
					{'name': 'icons', 'label': 'Значки', 'value': 1}
				]} %}
			</table>
		</div>
	</div>
	
			
	
</form>




<script type="text/javascript"><!--
$(document).ready(function() {
	
	
	$('#addSocItem').on(tapEvent, function() {
		let index = $('#socList').find('tr:not(.empty):last').attr('index') || 0;
		getAjaxHtml('admin/common/get_soc_item', {index: parseInt(index) + 1}, function(html) {
			let emptyRow = $('#socList').find('tr.empty');
			if (emptyRow.length) {
				$(emptyRow).remove();
			}
			$('#socList').append(html);
		}, function() {
			
		});
	});
	
	
	
	$('#socList').on(tapEvent, '[removesoc]', function() {
		$(this).closest('tr').remove();
	});
	
	
	
	
	
	
	
	//--------------------------------------------- Файлменеджер
	clientFileManager({
		onChooseFile: function(item) {
			$(item).addClass('file__block_changed');
			enableScroll();
		}
	});
	
	$('#settingsSave').scrollFix({pos: 500});
	
	// --------------------------------------------------------------------------------------- Сохранение основных настроек
	$('#settingsSave').on(tapEvent, function() {
		$('#settings').formSubmit({
			url: 'admin/save_settings',
			fields: {outer: 'setting_'},
			ignoreNames: 'files',
			success: function(response) {
				if (response) {
					notify('Настройки сохранены!');
					$('table.fieldset').find('.file__block_changed').removeClass('file__block_changed');
					$('table.fieldset').find('.changed').removeClass('changed');
				} 
				else notify('Ошибка сохранения данных', 'error');
			},
			error: function(e) {
				notify('Системная ошибка!', 'error');
				showError(e);
			},
			formError: function(fields) {
				if (fields) {
					$.each(fields, function(k, item) {
						$(item.field).errorLabel(item.error);
					});
				}
			}
		});
	});
	
	
	
});
//--></script>