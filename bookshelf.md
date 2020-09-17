---
title: Bookshelf
description: Books, talks and other resources I consider noteworthy.
---

Some of the books, videos and other resources I consider noteworthy.

Is also a good place to thank all my friends and mentors who helped me in this adventure of learning.

{%- for shelf in site.data.bookshelf %}

## {{ shelf[0] | capitalize }}

{%- for book in shelf[1] %}
  - #### {{ book.title }}
    {% if book.author %}By {{ book.author }}  {% endif %}
    {% if book.date %}{{ book.date }}  {% endif %}
    {% if book.url %}[{{ book.url }}](){% endif %}
{%- endfor -%}

{%- endfor -%}
