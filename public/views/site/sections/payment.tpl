<section class="section section_padding payment"{% if data_scroll_id %} id="{{data_scroll_id}}"{% endif %}{% if data_scroll_block %} data-scroll-block="{{data_scroll_block}}"{% endif %}>
	<div class="container">
		
		<h1 class="section__title payment__title">Оплата</h1>
		<div class="paymentblock">
			{% if payment %}
				<div class="row gutters-6 gutters-sm-8 gutters-md-10 justify-content-center">
					{% for item in payment %}
						<div class="col-12 col-md-4 col-lg-4">
							<div class="paymentblock__item" style="background-image: url('{{base_url('public/filemanager/__mini__/'~item.image)}}');">
								<div class="paymentblock__sublabel"></div>
								<div class="paymentblock__label" style="background-image: url('{{base_url('public/filemanager/__mini__/'~item.image)}}');">
									<span>{{item.title}}</span>
								</div>
							</div>
							<p class="paymentblock__desc">{{item.description|raw}}</p>
						</div>
					{% endfor %}
				</div>
			{% endif %}
		</div>
		
		
		<h1 class="section__title payment__title">Доставка</h1>
		<div class="deliveryblock">
			{% if delivery %}
				<div class="row">
					{% for section, items in delivery %}
						<div class="col-12 col-md-4 mb-50px mb-md-0px">
							<h2 class="deliveryblock__sectiontitle">{% if section == 1 %}Самовывоз{% elseif section == 2 %}Транспортная компания{% elseif section == 3 %}Собственная доставка{% endif %}</h2>
							
							{% if items %}
								{% for item in items %}
									<div class="deliveryblock__item">
										<strong class="deliveryblock__subtitle">{{item.city}}</strong>
										<p class="deliveryblock__text">{{item.address|raw}}</p>
									</div>
								{% endfor %}
							{% endif %}
						</div>
					{% endfor %}
				</div>
			{% endif %}
		</div>
		
	</div>
</section>