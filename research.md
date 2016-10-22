---
layout: page
title: Publications
---

## Research Posts

<ul class="posts">
{% for post in site.posts %}

{% if post.category contains 'research' %}
	{% if post.file %}
		<a href="{{ post.file }}"> <img src="{{site.baseurl}}assets/pdf32.png" align="right"> </a>
  {% endif %}
  <a href="{{ post.url }}">{{ post.title }}</a>
	<hr/>
{% endif %}
{% endfor %}
</ul>

## List of Publications

* S. Kulumani and T. Lee, “Constrained geometric attitude control on \\( \mathsf{SO(3)} \\),” International Journal of Control, Automation, and Systems, submitted.

* S. Kulumani and T. Lee, [“Low-Thrust Trajectory Design Using Reachability Sets near Asteroid 4769 Castalia,”]({% post_url 2016-08-20-2016AAS %}) in Proceedings of the AIAA/AAS Astrodynamics Specialists Conference, Long Beach, California, September 2016.

* S. Kulumani, I. Hussein, C. Roscoe, M. Wilkins, and P. Schumacher, [“Estimation of Information- Theoretic Quantities for Particle Clouds,”]({% post_url 2016-10-15-2016AAS-B %}) in Proceedings of the AIAA/AAS Astrodynamics Specialists Conference, Long Beach, California, September 2016.

* S. Kulumani and T. Lee, “Systematic design of optimal low-thrust transfers for the three-body problem,” Acta Astronautica, submitted.

* S. Kulumani, C. Poole, and T. Lee, [“Geometric adaptive control of attitude dynamics on \\( \mathsf{SO(3)} \\) with state inequality constraints,”]({% post_url 2015-10-09-2016ACC%}) in 2016 American Control Conference (ACC), July 2016, pp. 4936–4941.

* S. Kulumani and T. Lee, [“Systematic design of optimal low-thrust transfers for the three-body problem,”]({% post_url 2015-08-10-2015AAS%}) in Proceedings of the AAS/AIAA Astrodynamics Specialist Conference, Vail, Colorado, no. 757, August 2015. [Online]. Available: [http://arxiv.org/abs/1510.02695](http://arxiv.org/abs/1510.02695)

* S. Kulumani, “Space based TDOA Geo-Location,” in Proceedings of the Space Control Conference, MIT/Lincoln Laboratories, May 2013.





	
	
