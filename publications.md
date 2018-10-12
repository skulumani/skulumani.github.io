---
layout: page
title: Publications
mathjax: true
---
$$
\newcommand{\SO}{\mathsf{SO(3)}}
\newcommand{\bracket}[1]{\left[ #1 \right]}
\newcommand{\parenth}[1]{\left( #1 \right)}
\newcommand{\tr}[1]{\mathrm{tr}\negthickspace\bracket{#1}}
$$

<!-- 
<ul class="posts">
{% for post in site.posts %}

{% if post.category contains 'research' %}
	{% if post.file %}
		<a href="https://docs.google.com/viewer?url={{ post.file }}"> <img src="{{site.baseurl}}assets/pdf32.png" align="right"> </a>
  {% endif %}
  <a href="{{ post.url }}">{{ post.title }}</a>
	<hr/>
{% endif %}
{% endfor %}
</ul> 
-->

{% for year in (2013..2018) reversed %}
### {{ year }}

{% bibliography --query @*[year={{ year }}] %}

{% endfor %}

<p>
More:
{% if site.academia_username %}
<a href="https://independent.academia.edu/{{ site.academia_username }}"><i class="ai ai-academia fa-lg"></i></a> 
{% endif %}

{% if site.mendeley_username %}
<a href="https://www.mendeley.com/profiles/{{ site.mendeley_username }}"><i class="ai ai-mendeley fa-lg"></i></a>
{% endif %}

{% if site.orcid_username %}
<a href="http://orcid.org/{{ site.orcid_username }}"><i class="ai ai-orcid fa-lg"></i></a>
{% endif %}

{% if site.research_gate_username %}
<a href="https://www.researchgate.net/profile/{{ site.research_gate_username }}"><i class="ai ai-researchgate fa-lg"></i></a>
{% endif %}

{% if site.arxiv_username %}
<a href="https://arxiv.org/a/{{ site.arxiv_username }}.html"><i class="ai ai-arxiv fa-lg"></i></a>
{% endif %}

{% if site.google_scholar_username %}
<a href="https://scholar.google.com/citations?hl=en&user={{ site.google_scholar_username }}" data-proofer-ignore><i class="ai ai-google-scholar fa-lg"></i></a>
{% endif %}

</p>
