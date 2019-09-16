---
title: Notes
---

This is an attempt to compile and publish all my notes. The idea is to post old notes from my notebooks, emails and personal wiki keeping the original date. I'm also going to revise the ones I consider relevant.

<ul class="notes">
    {%- for post in site.posts -%}
    <li>
        <a href="{{ post.url }}">{{ post.title }}</a> 
    </li>
    {%- endfor -%}
</ul>
