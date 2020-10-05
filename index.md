---
redirect_from:
  - about
  - notes
---
{%- assign birthdate = 491141100 -%}

Hi there, my name is Max. I'm a {{ 'now' | date: "%s" | minus: birthdate | divided_by: 31557600 | floor }}[^birthdate] years old Software Engineer based in ~~[Buenos Aires]( https://www.google.com.ar/maps/place/Buenos+Aires/ )~~  ~~[Madrid]( https://www.google.com.ar/maps/place/Madrid/ )~~  ~~[Minneapolis]( https://www.google.com.ar/maps/place/Minneapolis/ )~~ [Barcelona]( https://www.google.com.ar/maps/place/Barcelona/ ).
I am currently working as a Senior Backend Engineer specialized in Python and Cloud Architecture.

Curriculum Vitae: [[PDF](/assets/pdf/Luis_Maximiliano_Rodrigo_Zubieta_Resume.pdf)][[HTML](resume.html)]

You can reach me at:
- [{{ site.email }}]( mailto:{{ site.email }} ) [[Public key]( gpg.html )][^xkcd]
- [@maxrodrigo]( https://github.com/maxrodrigo/ ) on GitHub
- [LinkedIn]( https://www.linkedin.com/in/maxrodrigo/ )
- @maxrodrigo on [Freenode]( http://www.freenode.net )
- ~~██████ on [SA](https://github.com/bibanon/bibanon/wiki/Something-Awful)~~

[^birthdate]: DOB: {{ birthdate }} - 33yo gift <http://www.ilovepumbaa.com/>
[^xkcd]: Relevant xkcd: <https://xkcd.com/1553/> / <https://xkcd.com/364/>

## Things

- [0xffsec's Handbook](https://0xffsec.com/handbook)
- [μz](https://github.com/maxrodrigo/uz) -  A zsh micro plugin manager
- [NordVPN Tmux Plugin](https://github.com/maxrodrigo/tmux-nordvpn)
- [λ AWS Lambdas@Edge A/B Testing ](https://github.com/maxrodrigo/ab-testing-lambdas)
- [Bookshelf](bookshelf.md)

## Notes

Security-related notes are being moved to [0xffsec's Handbook](https://0xffsec.com/handbook).

{%- for post in site.posts %}
- {{ post.date | date: "%Y-%m-%d" }} [{{ post.title | escape }}]({{ post.url }})
{%- endfor -%}
