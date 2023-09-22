<!DOCTYPE html>
<html lang="ru">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	
	<style>
		* {
			margin: 0;
			padding: 0;
			font-size: 100%;
			font-family: sans-serif;
			font-weight: normal;
		}
		
		.wrap {
			margin: 10px;
			border: 1px solid #eee;
			background-color: #f4f5f9;
			padding: 10px;
		}
		
		h1 {
			font-size: 2rem;
			color: #666;
			margin-bottom: 1rem;
			font-weight: normal;
		}
		
		h2 {
			font-size: 1.4rem;
			color: #888;
			margin-bottom: 0.6rem;
			font-weight: normal;
		}
		
		p {
			color: #666;
			font-size: 1rem;	
			margin-bottom: 10px;
		}
			p strong {
				font-weight: bold;
			}
		
		
		
		ul {
			padding: 0;
		}
			ul li {
				list-style: none;
			}
				ul li strong {
					font-weight: bold;
				}
		
		
		.message {
			margin: 10px 0;
			white-space: pre-line;
			font-size: 14px;
			color: #5a9;
			border: 1px dotted #aaa
		}
		
		.product {
			text-align: center;
			display: inline-block;
		}
		
		.product__image {
			
		}
			.product__image img {
				width: 400px;
				height: auto;
				border: none;
				outline: none !important;
			}
		
		
		.product__name {
			font-size: 16px;
			margin-top: 20px;
			font-size: 20px;
			text-decoration: none;
		}
		
		
	</style>
</head>
<body>
	<div class="wrap">
		<h1>{{title}}</h1>
		
		{% if fields.name %}<p>Имя: {{fields.name}}</p>{% endif %}
		{% if fields.phone %}<p>Номер телефона: {{fields.phone}}</p>{% endif %}
		{% if fields.email %}<p>E-mail: {{fields.email}}</p>{% endif %}
		{% if fields.city %}<p>Город: {{fields.city}}</p>{% endif %}
		
		<br>
		
		{% if fields.code %}<p>Промокод: {{fields.code}}</p>{% endif %}
		
		<br>
		<br>
		
		{% if fields.product %}
			<p>Продукт:</p>
			<a href="{{fields.product.href}}">
				<div class="product">
					<div class="product__image">
						<img src="{{fields.product.image}}" alt="{{fields.product.title}}" title="{{fields.product.title}}">
					</div>
					<div class="product__name">{{fields.product.title}}</div>
				</div>
			</a>
		{% endif %}
	</div>
</body>
</html>