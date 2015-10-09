---
layout: page
title: Research
---


{% for post in site.posts %}
<ul class="posts">
{% if post.categories contains 'research' %}
	{% if post.file %}
		<a href="{{ post.file }}"> <img src="{{site.baseurl}}assets/pdf32.png" align="right"> </a>
  {% endif %}
  <a href="{{ post.url }}">{{ post.title }}</a></br>
{% endif %}
</ul>
<hr/>
{% endfor %}

	
	
