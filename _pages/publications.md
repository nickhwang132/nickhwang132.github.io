---
layout: academic
title: "Publications"
permalink: /publications/
description: "Research publications, invited talks, books and patents of Peng Huang."
intro: "Publications, invited talks, books and patents."
---

<nav class="section-nav" aria-label="Publication sections"><a href="#papers">Papers</a><a href="#conference-program">Conference program</a><a href="#invited-talks">Invited talks</a><a href="#books-and-book-chapters">Books &amp; chapters</a><a href="#patents">Patents</a><a href="{{ site.author.googlescholar }}">Google Scholar ↗</a></nav>

<div id="papers"></div>
Some entries are grouped by online publication year; citations retain the final issue details.

{% include publications-list.html %}

## Conference program

Conference records are listed separately from published papers.

{% for item in site.data.publications.conference_programs %}
{{ forloop.index }}. {{ item.citation }}
{% endfor %}

## Invited talks
{% for item in site.data.publications.talks %}
{{ forloop.index }}. {{ item.citation }}
{% endfor %}

## Books and book chapters
{% for item in site.data.publications.books %}
{{ forloop.index }}. {{ item.citation }}
{% endfor %}

## Patents

Granted patents list the grant publication number, application number and grant date. Chinese and US counterparts are separate entries. Published applications are listed separately below.

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

These are application publications and are not counted as granted patents.

{% for item in site.data.publications.patent_applications %}
{{ forloop.index }}. {{ item.citation }}
{% endfor %}
