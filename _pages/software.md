---
layout: academic
compact_header: true
page_kind: software
permalink: /software/
title: "Software Release"
intro: "Tools for non-volatile memory and compute-in-memory research."
redirect_from:
  - /md/
  - /markdown.html
---

<section class="software-feature">
  <p class="eyebrow">Open-source research software <span>/</span> MIT License</p>
  <h2>CoMN</h2>
  <p class="software-lead">An algorithm–hardware co-design platform for non-volatile memory based neural network accelerators.</p>
  <p>Developed by Peng Huang's research group at Peking University, CoMN supports design evaluation and optimization from device nonidealities to accelerator architecture.</p>
  <div class="home-actions"><a class="academic-button" href="https://github.com/booniebears/CoMN">Source code <span aria-hidden="true">↗</span></a><a href="https://github.com/booniebears/CoMN#get-started">Installation &amp; usage ↗</a><a href="https://doi.org/10.1109/TCAD.2024.3358220">Read the paper ↗</a></div>
</section>

<div class="software-modules">
  <article><span class="research-index">01</span><h3>Algorithm adapter</h3><p>Improve neural network inference accuracy while accounting for NVM device nonidealities.</p></article>
  <article><span class="research-index">02</span><h3>Mapper</h3><p>Map CNN models to CIM chips through pipeline, weight transformation, partition and placement optimization.</p></article>
  <article><span class="research-index">03</span><h3>Hardware optimizer</h3><p>Explore microarchitecture and circuit design choices during early design.</p></article>
</div>

<div class="software-details">
  <section><h2>Getting started</h2><p>Follow the repository README for build commands, configuration files and example runs. It covers the adapter, mapper and hardware optimizer.</p><p><a href="https://github.com/booniebears/CoMN#get-started">Open the setup guide ↗</a></p>
  <details class="resource-note"><summary>Web interface</summary><p>The repository links to a <a href="http://101.42.97.22:8081/index.html">web interface</a> requiring registration. The developers recommend local installation; download the source code and follow the setup guide.</p></details></section>
  <section><h2>Contact</h2><address><a href="mailto:lixiahan@pku.edu.cn">Lixia Han · lixiahan@pku.edu.cn</a><a href="mailto:phwang@pku.edu.cn">Peng Huang · phwang@pku.edu.cn</a><a href="mailto:chensy@stu.pku.edu.cn">Siyuan Chen · chensy@stu.pku.edu.cn</a></address></section>
</div>

## Reference

<p>Please cite the CoMN paper when using or adapting the platform.</p>
<div class="software-reference" markdown="1">
{% for paper in site.data.publications.publications %}{% if paper.title contains 'CoMN:' %}{{ paper.citation }}{% endif %}{% endfor %}
</div>
