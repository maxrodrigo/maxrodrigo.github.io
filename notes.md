---
title: Notes
---

This is an attempt to compile and publish all my notes. The idea is to post old notes from my notebooks, emails and personal wiki keeping the original date. I'm also going to revise the ones I consider relevant.

<ul class="notes">
    {%- for post in site.posts -%}
    <li class="note">
        <time datetime="{{ post.date | date_to_xmlschema  }}" itemprop="datePublished">
            {%- if post.last_modified_at -%}
                {{ post.last_modified_at | date_to_string }}
            {%- else -%}
                {{ post.date | date_to_string  }}
            {%- endif -%}
        </time>
        <a href="{{ post.url }}">{{ post.title | escape }}</a> 
    </li>
    {%- endfor -%}
</ul>
