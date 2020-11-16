---
redirect_from:
  - about
  - notes
---
{%- assign birthdate = 491141100 -%}

Hi there, my name is Max. I'm a {{ 'now' | date: "%s" | minus: birthdate | divided_by: 31557600 | floor }}[^birthdate] years old Software Engineer based in ~~[Buenos Aires]( https://www.google.com.ar/maps/place/Buenos+Aires/ )~~  ~~[Madrid]( https://www.google.com.ar/maps/place/Madrid/ )~~  ~~[Minneapolis]( https://www.google.com.ar/maps/place/Minneapolis/ )~~ [Barcelona]( https://www.google.com.ar/maps/place/Barcelona/ ).
I am currently working as a Senior Engineer specialized in Python and Cloud Architecture. I'm also writing an open source [book](https://0xffsec.com/handbook) on penetration testing.

Curriculum Vitae: [[PDF](/assets/pdf/Luis_Maximiliano_Rodrigo_Zubieta_Resume.pdf)][[HTML](resume.html)]

You can reach me at:
- [{{ site.email }}]( mailto:{{ site.email }} ) [[Public key]( gpg.html )][^xkcd]
- [@maxrodrigo]( https://github.com/maxrodrigo/ ) on GitHub
- [LinkedIn]( https://www.linkedin.com/in/maxrodrigo/ )

[^birthdate]: DOB: {{ birthdate }} - 33yo gift <http://www.ilovepumbaa.com/>
[^xkcd]: Relevant xkcd: <https://xkcd.com/1553/> / <https://xkcd.com/364/>

## Thinks I do.

:pager: cyber

- [Pentesting Handbook](https://0xffsec.com/handbook)
- [Web Dōjō - WebApps Pentesting Lab](https://github.com/0xffsec/webdojo)

:shipit: devops

- [Cookiecutter Chalice Framework](https://github.com/maxrodrigo/cookiecutter-chalice)
- [λ AWS Lambdas@Edge A/B Testing](https://github.com/maxrodrigo/ab-testing-lambdas)

:rice: rice

- [NordVPN Tmux Plugin](https://github.com/maxrodrigo/tmux-nordvpn)
- [μz](https://github.com/maxrodrigo/uz) - ZSH Micro Plugin Manager.
- [homesick](https://github.com/maxrodrigo/homesick) - My daily dotfiles.
- [gitster](https://github.com/maxrodrigo/gitster) -  A Gister ZSH theme with no dependencies.

:alien: others

- [wasabi](https://github.com/maxrodrigo/wasabi) - A simple yet useful keypad.
- [Bookshelf](bookshelf.md) - My bookshelf.

## Notes

Security-related were moved to [0xffsec's Handbook](https://0xffsec.com/handbook).

{%- for post in site.posts %}
- {{ post.date | date: "%Y-%m-%d" }} [{{ post.title | escape }}]({{ post.url }})
{%- endfor -%}
