<div class="section" id="{{id}}">
	<div class="section_title">
		<h2>Модификации</h2>
	</div>
	
	
	<table>
		<thead>
			<tr>
				<td>Название</td>
				<td class="w-20">Имя базы данных</td>
				<td class="w-20">Пользователь базы даннх</td>
				<td class="w-20">Пароль базы данных</td>
				<td class="nowidth">Активная</td>
				<td class="w-13rem">Опции</td>
			</tr>
		</thead>
		<tbody id="modificationsList">
			{% if modifications %}
				{% for id, mod in modifications %}
					<tr>
						<td>{{mod.title}}</td>
						<td>{{mod.db_name}}</td>
						<td>{{mod.db_user}}</td>
						<td>{{mod.db_pass|default('-')}}</td>
						<td class="center">
							<div class="radio d-inline-block">
								<div class="radio__item radio__item_inline mr-0">
									<div>
										<input id="check{{id}}"
										type="radio"
										setactivemod="{{mod.db_name}}"
										{% if active == mod.db_name %}checked{% endif %}>
										<label for="check{{id}}"></label>
									</div>
								</div>
							</div>
						</td>
						<td class="center">
							<div class="buttons nowrap inline notop">
								<button modsedit="{{id}}"{% if mod.disabled %} main{% endif %}><i class="fa fa-edit" title="Редактировать модификатор"></i></button>
								{% if not mod.disabled %}<button modsremove="{{id}}" class="remove" title="Удалить модификатор"><i class="fa fa-trash"></i></button>{% endif %}
							</div>
						</td>
					</tr>
				{% endfor %}
			{% else %}
				<tr class="empty">
					<td colspan="6"><p class="empty center">Нет данных</p></td>
				</tr>
			{% endif %}
		</tbody>
		<tfoot>
			<tr>
				<td colspan="6">
					<div class="buttons nowrap right notop">
						<button id="modificationsNew" title="Новый модификатор">Новая модификация</button>
					</div>
				</td>
			</tr>
		</tfoot>
	</table>
	
	
</div>

<script type="text/javascript"><!--
$(document).ready(function() {
	
	clientFileManager();
	
	
	$('#modificationsNew').on(tapEvent, function() {
		var rowId = parseInt($('#modificationsList').children('tr:last').find('[modsedit]').attr('modsedit')) + 1 || 1,
			isMain = $(this).attr('main') != undefined ? 1 : 0;;
		
		ddrPopUp({
			title: 'Новая модификация|4',
			width: 800,
			buttons: [{id: 'modificationsAdd', title: 'Добавить'}],
			closeByButton: true,
			close: 'Отмена'
		}, function(newModificationWin) {
			newModificationWin.setData('admin/modifications/get_form', {is_main: isMain});
			
			$('#modificationsAdd').on(tapEvent, function() {
				$('#modForm').formSubmit({
					url: 'admin/modifications/save',
					fields: {id: rowId},
					dataType: 'html',
					before: function() {
						newModificationWin.wait();
					},
					success: function(row) {
						if (row != 0) {
							if ($('#modificationsList').children('tr.empty').length == 1) $('#modificationsList').children('tr.empty').remove();
							$('#modificationsList').append(row);
							notify('Модификация успешно добавлена!');
							newModificationWin.close();
						} else {
							notify('ошибка добавления модификации!', 'error');
						}
					},
					complete: function() {
						newModificationWin.wait(false);
					}
				});
			});
		});
	});
	
	
	
	
	$('body').off(tapEvent, '[modsedit]').on(tapEvent, '[modsedit]', function() {
		var rowId = $(this).attr('modsedit'),
			isMain = $(this).attr('main') != undefined ? 1 : 0;
		
		ddrPopUp({
			title: 'Изменить модификацию|4',
			width: 800,
			buttons: [{id: 'modificationsUpdate', title: 'Обновить'}],
			closeByButton: true,
			close: 'Отмена'
		}, function(updateModificationWin) {
			updateModificationWin.setData('admin/modifications/get_form', {id: rowId, edit: 1, is_main: isMain});
			
			$('#modificationsUpdate').on(tapEvent, function() {
				$('#modForm').formSubmit({
					url: 'admin/modifications/update',
					fields: {id: rowId},
					dataType: 'html',
					before: function() {
						updateModificationWin.wait();
					},
					success: function(row) {
						if (row != 0) {
							$('#modificationsList').children('tr').eq(rowId).replaceWith(row);
							notify('Модификация успешно обновлена!');
							updateModificationWin.close();
						} else {
							notify('ошибка обновления модификации!', 'error');
						}
					},
					complete: function() {
						updateModificationWin.wait(false);
					}
				});
			});
		});
	});
	
	
	
	
	
	
	
	
	$('body').off(tapEvent, '[modsremove]').on(tapEvent, '[modsremove]', function() {
		var rowId = $(this).attr('modsremove');
		
		ddrPopUp({
			title: 'Удалить модификацию|4',
			width: 400,
			html: '<p class="red">Вы действительно хотите удалить модификацию?</p>',
			buttons: [{id: 'modificationsRemove', title: 'Удалить'}],
			close: 'Отмена',
			contentToCenter: true
		}, function(removeModificationWin) {
			$('#modificationsRemove').on(tapEvent, function() {
				removeModificationWin.wait();
				$.post('/admin/modifications/remove', {id: rowId}, function(result) {
					if (result) {
						notify('Модификация успешно удалена!');
						removeModificationWin.close();
						if ($('#modificationsList').children('tr').length == 1) {
							$('#modificationsList').children('tr').eq(rowId).replaceWith('<tr class="empty"><td colspan="6"><p class="empty center">Нет данных</p></td></tr>');
						} else {
							$('#modificationsList').children('tr').eq(rowId).remove();
						}
					} else {
						notify('Ошибка удаления модификации!', 'error');
						removeModificationWin.wait(false);
					}
				});
			});
		});
	});
	
	
	
	$('#modificationsList').off(tapEvent, '[setactivemod]').on(tapEvent, '[setactivemod]', function() {
		var modName = $(this).attr('setactivemod');
		
		$.post('/admin/modifications/set_modification', {controller: 'admin', mod: modName}, function(result) {
			if (result) {
				notify('Модификация успешно изменена!');
				$('#adminSetModifications').children('option:selected').prop('selected', false);
				$('#adminSetModifications').children('option[value="'+modName+'"]').prop('selected', true);
			}
			else notify('Ошибка изменения модификации!', 'error');
		}, 'json');
		if ($(this).is(':checked')) {
			$('#modificationsList').find('[setactivemod]:checked').removeAttrib('checked');
			$(this).setAttrib('checked');
		}
	});
	
	
	
	
	
	
	
});
//--></script>