---
layout: page
title: Research
---

<ul class="posts">
{% for post in site.posts %}

{% if post.categories contains 'research' %}
	{% if post.file %}
		<a href="{{ post.file }}"> <img src="{{site.baseurl}}assets/pdf32.png" align="right"> </a>
  {% endif %}
  <a href="{{ post.url }}">{{ post.title }}</a></br>
	<hr/>
{% endif %}
{% endfor %}
</ul>

	
	
