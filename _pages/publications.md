---
layout: academic
title: "Publications"
permalink: /publications/
description: "Research publications, invited talks, books and patents of Peng Huang."
compact_header: true
page_kind: publications
---

<div id="papers"></div>

{% include publications-list.html %}

## Invited talks
{% for item in site.data.publications.talks %}
{{ forloop.index }}. {{ item.citation }}
{% endfor %}

<h2 id="books-and-book-chapters">Books</h2>
{% for item in site.data.publications.books %}
{{ forloop.index }}. {{ item.citation }}
{% endfor %}

## Patents

### Chinese patents
{% assign chinese_patents = site.data.publications.patents | where: 'jurisdiction', 'CN' %}
{% for item in chinese_patents %}
{{ forloop.index }}. {{ item.citation }}
{% endfor %}

### US patents
{% assign us_patents = site.data.publications.patents | where: 'jurisdiction', 'US' %}
{% for item in us_patents %}
{{ forloop.index }}. {{ item.citation }}
{% endfor %}

### Published US applications

{% for item in site.data.publications.patent_applications %}
{{ forloop.index }}. {{ item.citation }}
{% endfor %}
