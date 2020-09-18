#!/usr/bin/env bash

filename='Luis_Maximiliano_Rodrigo_Zubieta_Resume.pdf'
resume_html='./_site/resume.html'
pdf_path='./assets/pdf'

# Generate new pdf filename
timestamp=$(date +%s)
new_filename=${filename/.pdf/.${timestamp}.pdf}

# rdate replace rdate placeholder inside the pdf file
rdate=$(stat -f "%Sm" -t "%B %d, %Y" ./resume.md)

xvfb-run wkhtmltopdf --disable-smart-shrinking \
                     --dpi 300 \
                     --print-media-type \
                     -B 20mm -L 20mm -R 20mm -T 20mm \
                     --footer-spacing 10 \
                     --footer-font-size 8 \
                     --footer-right 'Revised [rdate]' \
                     --footer-left 'Page [page] of [toPage]' \
                     --replace "rdate" "${rdate}" \
                     ${resume_html} ${new_filename}

echo "Built PDF: '${new_filename}'"
