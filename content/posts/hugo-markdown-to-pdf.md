---
title: How I build my CV from Markdown to PDF and Hugo
date: 2022-01-22T09:31:00
draft: true
---

I recently migrated my website from [Jekyll](https://jekyllrb.com/) to [Hugo](https://gohugo.io/).
Not because of any particular feature
but because the [handbook](https://0xffsec.com/handbook/) is made with it,
and I preferred the ease of maintenance.

If you want a Jekyll vs Hugo comparison forestry.io made [a good one](https://forestry.io/blog/hugo-and-jekyll-compared/) some years ago.

With the site migration out the way,
I had to redesign the deployment of the CV pdf.
Which started being a [manual process](https://github.com/maxrodrigo/maxrodrigo.github.io/blob/1e51c81675a6c62fd18d54852d6d1a080eb38e6d/script/gen_resume_pdf),
a [pre-commit](https://github.com/maxrodrigo/maxrodrigo.github.io/blob/afe799e0426ff405fb0517f9efc5a7f956efb402/script/pre-commit) hook,
and finally,
a GitHub [action](https://github.com/maxrodrigo/maxrodrigo.github.io/blob/jekyll/.github/workflows/render-cv.yml).
In addition to adapting the pipeline to the new document,
I wanted to declutter, remove dependencies,
and if possible, add flexibility.

## Considerations

- **Won't do a MD to PDF convertion**

    I wanted to use pandoc to directly convert MD to PDF
    but that would restrict me for having a custom format except the interpreted by pandoc.
    Also I would have to strip the front matter from the file and add the title since the current,
    and most of the themes, have the title assign to the theme layout.

- **Delegate the configuration to the front matter.**

    I want to the output filename to be dynamic not hardcoded.
    Delegating the name resposability to the front matter will make it easier to change,
    easier to maintain, and if changed the alias for the old name with also be configured in the same place.

- **Use Git history**

    I won't store previous artifacts in the repository.
    If I need to go back in history I'll use the markdown version.

- **Remove dependencies**

    [WeasyPrint](https://weasyprint.org/) and [wkhtmltopdf](https://wkhtmltopdf.org/) work great
    but I will remove the middle step of the HTML convertion.

- **Convertion would run ether when the files or the css r updated.**
