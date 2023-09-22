<section class="section section_padding contacts"{% if data_scroll_id %} id="{{data_scroll_id}}"{% endif %}{% if data_scroll_block %} data-scroll-block="{{data_scroll_block}}"{% endif %}>
	<div class="container">
		<div class="row flex-md-nowrap">
			<div class="col-12 col-md-auto">
				<div class="contacts__nav noselect">
					
					<div class="contactsnavmobile hidden-md-up" touch="contacts__nav_opened">
						<span>Выберите город</span>
						<i class="fa"></i>
					</div>
					
					{% if address_list %}
						<div class="contactsnav">
							{% for section, sities in address_list %}
								<div class="contactsnav__item">
									<div class="contactsnav__title" contactsnavtitle>
										<span>{% if section == 1 %}Фирменные салоны{% elseif section == 2 %}Региональные склады{% endif %}</span>
										<i class="fa"></i>
									</div>
									
									{% if sities %}
										<ul class="contactsnav__list contactstabstitles">
											{% for sity, types in sities %}
												<li class="contactstabstitles__item" opencontacts="{{sha1(section~sity)}}">{{sity}}</li>
											{% endfor %}
										</ul>
									{% endif %}
								</div>
							{% endfor %}
						</div>
					{% endif %}
				</div>
			</div>
			
			
			
			<div class="col-12 col-md contactscontentcol">
				<div class="contacts__content">
					{% if banner_address %}
						<div class="contacts__banner" style="background-image: url('{{base_url('public/filemanager/'~banner_bg)}}');">
							<div class="row contactsbanner">
								<div class="col-12 col-sm-6 col-lg-4">
									<div class="contactsbanner__item">
										<span>Адрес</span>
										<p>{{banner_address}}</p>
									</div>
								</div>
								
								{% if banner_fax %}
									<div class="col-12 col-sm-6 col-lg-4">
										<div class="contactsbanner__item">
											<span>Телефон/факс</span>
											<a phone>{{banner_fax}}</a>
										</div>
									</div>
								{% endif %}
								
								{% if banner_email %}
									<div class="col-12 col-sm-6 col-lg-4">
										<div class="contactsbanner__item">
											<span>E-mail</span>
											<a email>{{banner_email}}</a>	
										</div>
									</div>
								{% endif %}
								
								{% if banner_phone %}
									<div class="col-12 col-sm-6 col-lg-4">
										<div class="contactsbanner__item">
											<span>Телефон</span>
											<a phone>{{banner_phone}}</a>
										</div>
									</div>
								{% endif %}
								
								{% if banner_powered %}
									<div class="col-12 col-sm-6 col-lg-4">
										<div class="contactsbanner__item">
											<span>Время работы и прием звонков</span>
											<p>{{banner_powered}}</p>
										</div>
									</div>
								{% endif %}
								
								{% if banner_franchise %}
									<div class="col-12 col-sm-6 col-lg-4">
										<div class="contactsbanner__item">
											<span>Франшиза</span>
											<a email>{{banner_franchise}}</a>
										</div>
									</div>
								{% endif %}
							</div>
						</div>
					{% endif %}
						
					
					
					
					{% if address_list %}
						<div class="contactscontent" id="contactsTabsContent">
							{% for section, sities in address_list %}
								{% if sities %}
									{% for sity, types in sities %}
										<div contactstab="{{sha1(section~sity)}}">
											
											<h1 class="contacts__title">{{sity}}</h1>
											
											{% if map_list[section][sity][0]['map'] %}
												<div class="contacts__map">{{map_list[section][sity][0]['map']|raw}}</div>
											{% endif %}
											
											
											{% for type, items in types %}
												{% if type == 1 and items %}
													<div class="contacts__addressblock addressblock">
														<div class="row">
															{% for addr, address in items %}
																<div class="col-12 col-sm-6 col-md-4">
																	<div class="addressblock__item" itemscope itemtype="http://schema.org/Organization">
																		<div class="addressblock__row">
																			<span>Наименование</span>
																			<a itemprop="name" phone>{{address['title']}}</a>
																		</div>
																		<div class="addressblock__row" itemprop="address" itemscope itemtype="https://schema.org/PostalAddress">
																			<span>Адрес</span>
																			<p itemprop="streetAddress">{{address['address']}}</p>
																		</div>
																		<div class="addressblock__row">
																			<span>Телефон</span>
																			<div class="row gutters-5">
																				<div class="col-auto"><a itemprop="telephone" phone>{{address['phone']}}</a></div>
																				{% if address['phone_second'] %}
																					<div class="col-auto"><a itemprop="telephone" phone>{{address['phone_second']}}</a></div>
																				{% endif %}
																			</div>
																		</div>
																		{% if address['more']['button'] %}
																			<button class="button button_small button_transparent button_bordered mt-5px" openaddresinfo="{{section}}|{{sity}}|{{type}}|{{addr}}"><span>{{address['more']['button']}}</span></button>
																		{% endif %}
																	</div>
																</div>
															{% endfor %}
														</div>
													</div>
													
												{% elseif type == 2 and items %}
													<h2 class="contacts__subtitle">Реквизиты</h2>
													<div class="contacts__addressblock addressblock">
														<div class="row">
															{% for addr, address in items %}
																<div class="col-12 col-sm-6 col-md-4">
																	<div class="addressblock__item" itemscope itemtype="http://schema.org/Organization">
																		{% if address['title'] %}
																			<div class="addressblock__row">
																				<span>Наименование</span>
																				<p itemprop="name">{{address['title']}}</p>
																			</div>
																		{% endif %}
																		
																		{% if address['inn'] %}
																			<div class="addressblock__row">
																				<span>ИНН</span>
																				<p>{{address['inn']}}</p>
																			</div>
																		{% endif %}
																		
																		{% if address['ogrn'] %}
																			<div class="addressblock__row">
																				<span>ОГРН</span>
																				<p>{{address['ogrn']}}</p>
																			</div>
																		{% endif %}
																		
																		{% if address['legal_address'] %}
																			<div class="addressblock__row" itemprop="address" itemscope itemtype="https://schema.org/PostalAddress">
																				<span>Юр. адрес</span>
																				<p itemprop="streetAddress">{{address['legal_address']}}</p>
																			</div>
																		{% endif %}
																		
																		{% if address['phone'] %}
																			<div class="addressblock__row">
																				<span>Телефон</span>
																				<a itemprop="telephone" phone>{{address['phone']}}</a>
																			</div>
																		{% endif %}
																	</div>
																</div>
															{% endfor %}
														</div>
													</div>
												{% endif %}
											
											{% endfor %}
										</div>
									{% endfor %}
								{% endif %} 
							{% endfor %}
						</div>
					{% endif %}
					
					
					{% if contacts_download %}
						<h2 class="contacts__subtitle">Специальная оценка условий труда</h2>
						<p class="contacts__text">Скачать документы специальной оценки условий труда можно по <a class="contacts__link" href="{{base_url('public/filemanager/'~contacts_download)}}" download>ссылке</a>.</p>
					{% endif %}
				</div>
			</div>
		</div>
		
	</div>
</section>