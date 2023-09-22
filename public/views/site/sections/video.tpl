<section class="section section_padding video"{% if data_scroll_id %} id="{{data_scroll_id}}"{% endif %}{% if data_scroll_block %} data-scroll-block="{{data_scroll_block}}"{% endif %}>
	<div class="container">
		{% if video_title %}
			<div class="section__top">
				<h2 class="section__title">{{video_title}}</h2>
			</div>	
		{% endif %}
		<div class="video__container">
			<div class="video__block">
				<iframe width="100%" height="100%" src="https://www.youtube.com/embed/{{video_url|youtubevideoid}}?controls=0&disablekb=1&showinfo=0&rel=0&vq=hd1080" frameborder="0" allowfullscreen></iframe>
			</div>
		</div>
	</div>
</section>