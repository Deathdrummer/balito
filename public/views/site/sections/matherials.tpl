<section class="section section_padding matherials"{% if data_scroll_id %} id="{{data_scroll_id}}"{% endif %}{% if data_scroll_block %} data-scroll-block="{{data_scroll_block}}"{% endif %}>
	<div class="container">
		<div class="row flex-md-nowrap">
			<div class="col-12 col-md-auto">
				<div class="contacts__nav noselect">
					
					<div class="contactsnavmobile hidden-md-up" touch="contacts__nav_opened">
						<span>Разделы</span>
						<i class="fa"></i>
					</div>
					
					
					<div class="contactsnav">
						<div class="contactsnav__item">
							<div class="contactsnav__title contactsnav__title_static">
								<span>{{navtitle}}</span>
							</div>
							
							{% if matherials_categories %}
								<ul class="contactsnav__list contactstabstitles contactstabstitles_opened" materialsnav>
									{% for category in matherials_categories %}
										<li class="contactstabstitles__item" openmatherialscategory="{{sha1(category.title)}}">{{category.title}}</li>
									{% endfor %}
								</ul>
							{% endif %}
						</div>
					</div>
				</div>
			</div>
			
			
			
			<div class="col-12 col-md contactscontentcol">
				<div class="contacts__content" id="matherialsBlock">
					<div class="contactscontent" id="contactsTabsContent">
						{% for category, catData in matherials_categories %}
							<div matherialscategorytab="{{sha1(matherials_categories[category]['title'])}}">
								{% if matherials_collection[category] %}
									<div class="matherials__items">
										<div class="row">
											{% for item in matherials_collection[category] %}
												<div class="col-12 col-sm-6 col-md-6 col-lg-4">
													{% include 'views/'~controller~'/render/catalog/material.tpl' with item %}
												</div>
											{% endfor %}
										</div>
									</div>
								{% else %} 
									<p class="empty">Нет материалов</p>
								{% endif %} 
							</div>	
						{% endfor %}
					</div>
				</div>
			</div>
		</div>
	</div> 
</section>