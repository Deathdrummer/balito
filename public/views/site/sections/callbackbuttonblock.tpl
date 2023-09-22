<section class="section section_padding commoncallback"{% if data_scroll_id %} id="{{data_scroll_id}}"{% endif %}{% if data_scroll_block %} data-scroll-block="{{data_scroll_block}}"{% endif %}>
	<div class="container">
		<div class="commoncallback__block" style="background-image: url('{{base_url('public/filemanager/'~bg)}}');{% if block_height %} height: {{block_height}}px;{% endif %}">
			<div class="commoncallback__button">
		        <button class="button button_black"
		            callbackform
		            cbtype="6"
		            cbtitle="{{callbackform[6]['title']}}"
		            cbsuccess="{{callbackform[6]['send_success']}}"
		            cbbutton="{{callbackform[6]['button']}}"
		            cbyandexreachgoal="{{callbackform[6]['reachgoal']}}"
		            >{{button_text}}</button>
		    </div>
		</div>
	</div>
</section>