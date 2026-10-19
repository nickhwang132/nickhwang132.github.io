---
layout: home
permalink: /
title: "Peng Huang — Peking University"
description: "Peng Huang's research in emerging devices, computing-in-memory circuits and architectures, and neuromorphic computing at Peking University."
author_profile: false
redirect_from:
  - /about/
  - /about.html
---
<section class="home-hero" aria-labelledby="home-name">
  <div class="home-hero__copy">
    <p class="eyebrow">Peking University <span aria-hidden="true">/</span> School of Integrated Circuits</p>
    <h1 id="home-name">Peng Huang <span lang="zh-CN">黄鹏</span></h1>
    <p class="home-role">Assistant Professor</p>
    <p class="home-intro">My research explores emerging devices and the circuits and architectures that bring sensing, memory and computation closer together.</p>
    <div class="home-actions">
      <a class="academic-button" href="{{ '/publications/' | relative_url }}">Explore publications <span aria-hidden="true">↗</span></a>
      <a href="{{ site.author.googlescholar }}">Google Scholar <span aria-hidden="true">↗</span></a>
      <a href="#contact">Get in touch <span aria-hidden="true">↓</span></a>
    </div>
    <details class="home-biography">
      <summary>Biography &amp; recognition</summary>
      <p>I am an assistant professor in the School of Integrated Circuits at Peking University. My research interests include emerging computing based on emerging devices, including the design and fabrication of emerging devices, the circuit and architecture design of RRAM-based CIM chips, and neuromorphic computing.</p>
      <p>I have authored over 100 scientific publications in leading international journals and conferences, such as Nature Electronics, Nature Communications, Science Advances, Advanced Materials, IEEE-IEDM, DAC, IEEE-TCAS, and IEEE-EDL. I am a recipient of the Excellent Young Scholars (NSFC 2020), the Second Prize of Natural Science Award (Ministry of Education 2019), and PhD Student Fellowship (IEEE EDS 2014).</p>
    </details>
  </div>
  <figure class="home-portrait">
    <img src="{{ '/images/profile.png' | relative_url }}" srcset="{{ '/images/generated/profile/profile-320.png' | relative_url }} 320w, {{ '/images/profile.png' | relative_url }} 534w" sizes="(max-width: 600px) 140px, 240px" width="534" height="601" alt="Portrait of Peng Huang" fetchpriority="high">
    <figcaption><span>Emerging devices &amp; computing</span><a href="mailto:{{ site.author.email }}">{{ site.author.email }}</a></figcaption>
  </figure>
</section>

<section class="home-section" aria-labelledby="research-title">
  <div class="section-heading"><div><p class="eyebrow">Research</p><h2 id="research-title">From devices to intelligent systems</h2></div></div>
  <div class="research-grid">
    <article><span class="research-index" aria-hidden="true">01</span><h3>Computing-in-memory</h3><p>RRAM-based CIM chips and systems for neural networks.</p></article>
    <article><span class="research-index" aria-hidden="true">02</span><h3>Sensing, computing &amp; storage</h3><p>Emerging devices and architectures for data sensing, computing and storage.</p></article>
    <article><span class="research-index" aria-hidden="true">03</span><h3>Neuromorphic computing</h3><p>Memristor-based approaches to neuromorphic computing.</p></article>
    <article><span class="research-index" aria-hidden="true">04</span><h3>Design automation</h3><p>Automated design tools for emerging computing systems.</p></article>
  </div>
</section>

<section class="home-section" aria-labelledby="recent-papers-title">
  <div class="section-heading"><div><p class="eyebrow">Recent work</p><h2 id="recent-papers-title">Research publications</h2></div><a class="section-link" href="{{ '/publications/' | relative_url }}">All publications <span aria-hidden="true">↗</span></a></div>
  <div class="home-papers">
    {% for item in site.data.home.recent_publications %}
    {% assign paper = site.data.publications.publications | where: 'id', item.id | first %}
    <article class="home-paper"><p class="paper-venue">{{ item.venue }} <span>· {{ paper.year }}</span></p><h3><a href="{{ paper.url }}">{{ paper.title }} <span aria-hidden="true">↗</span></a></h3></article>
    {% endfor %}
  </div>
</section>

<section class="home-section" aria-labelledby="news-title">
  <div class="section-heading"><div><p class="eyebrow">News &amp; group life</p><h2 id="news-title">Around the group</h2></div><a class="section-link" href="{{ '/people/' | relative_url }}">Meet the group <span aria-hidden="true">↗</span></a></div>
  <div class="home-news-grid">
    <div>
      <ol class="news-list">
      {% for item in site.data.updates.items limit: 6 %}
        <li><span class="news-date">{{ item.date }}</span><div>{{ item.text | markdownify }}</div></li>
      {% endfor %}
      </ol>
      <details class="news-archive"><summary>Earlier news</summary><ol class="news-list">
      {% for item in site.data.updates.items offset: 6 %}
        <li><span class="news-date">{{ item.date }}</span><div>{{ item.text | markdownify }}</div></li>
      {% endfor %}
      </ol></details>
    </div>
    <div>{% include carousel.html %}</div>
  </div>
</section>

<section class="home-contact" id="contact" aria-labelledby="contact-title">
  <div><p class="eyebrow">Join us</p><h2 id="contact-title">Let's explore new ways to compute.</h2><p>I welcome motivated undergraduate and graduate students with backgrounds in microelectronics, integrated circuits, computer science, electrical engineering, physics or related areas.</p><p>Open positions: Ph.D., Postdoctoral Researcher and Master's Student.</p><a class="academic-button" href="mailto:{{ site.author.email }}">Contact Peng Huang <span aria-hidden="true">↗</span></a></div>
  <address><span class="eyebrow">Contact</span><a href="mailto:{{ site.author.email }}">{{ site.author.email }}</a><span>+86 10 62765952</span><span>Room 350, Weina Building<br>Peking University<br>Beijing, China</span></address>
</section>
