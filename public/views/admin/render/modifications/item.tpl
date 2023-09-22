<tr>
	<td>{{title}}</td>
	<td>{{db_name}}</td>
	<td>{{db_user}}</td>
	<td>{{db_pass}}</td>
	<td class="center">
		<div class="checkbox d-inline-block">
			<div class="radio__item radio__item_inline mr-0">
				<div>
					<input id="check{{id}}"
					setactivemod="{{db_name}}"
					{% if active %}checked{% endif %}
					type="radio">
					<label for="check{{id}}"></label>
				</div>
			</div>
		</div>
	</td>
	<td class="center">
		<div class="buttons nowrap inline notop">
			<button modsedit="{{id}}"><i class="fa fa-edit" title="Редактировать модификатор"></i></button>
			{% if not is_main %}
				<button modsremove="{{id}}" class="remove" title="Удалить модификатор"><i class="fa fa-trash"></i></button>
			{% endif %}
		</div>
	</td>
</tr>	