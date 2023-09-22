<section class="section section_padding about_factory"{% if data_scroll_id %} id="{{data_scroll_id}}"{% endif %}{% if data_scroll_block %} data-scroll-block="{{data_scroll_block}}"{% endif %}>
	<div class="container">
		<div class="row">
			<div class="col-12 col-md-5 col-lg-4">
				<div class="about_factory__image" style="background-image: url('{{base_url('public/filemanager/'~bg)}}')">
					<div class="about_factory__imgblock">
						<img src="{{base_url('public/filemanager/'~factory_logo)}}" class="about_factory__logo" alt="{{factory_about}}">
						<h3 class="about_factory__title">{{factory_about}}</h3>
						<p class="about_factory__desc">{{factory_desc}}</p>
					</div>
				</div>
			</div>
			<div class="col-12 col-md-7 col-lg-8">
				
				<p class="about_factory__texttop">{{text_top}}</p>
				
				<h4 class="about_factory__listtitle">{{plan_title}}</h4>
				
				{% if plan_list %}
					<ul class="about_factory__list">
						{% for item in plan_list %}
							<li>
								<span class="d-block w-30px">{{item.number}}</span>
								<p>{{item.text}}</p>
							</li>
						{% endfor %}
					</ul>
				{% endif %}
				
				<p class="about_factory__textbottom">{{text_bottom}}</p>
			</div>
		</div>
	</div>
</section>