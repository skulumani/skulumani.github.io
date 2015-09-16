---
layout: page
title: Research
---

<p class="message">
  This page will discuss my research projects
</p>

  <ul class="posts">
    {% for post in site.posts %}
		{% if post.categories contains 'research' %}
			<li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ post.url }}">{{ post.title }}</a></li>
		{% endif %}
    {% endfor %}
  </ul>
