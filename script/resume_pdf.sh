#!/usr/bin/env bash

# ATENTION: This file is execute by pre-commit git hook.
# Site must be built by the time this script is executed

pdf_filename='Luis_Maximiliano_Rodrigo_Zubieta_Resume.pdf'
pdf_path='./assets/pdf'

# Built version of resume.md
resume_html='./_site/resume.html'

# Generate new pdf filename with current timestamp
timestamp=$(date +%s)
new_pdf_filename=${pdf_filename/.pdf/.${timestamp}.pdf}
new_pdf="${pdf_path}/$new_pdf_filename"

# rdate replace rdate placeholder inside the pdf file
rdate=$(stat -f "%Sm" -t "%B %d, %Y" ./resume.md)

echo 'Generating resume PDFe..'
wkhtmltopdf --disable-smart-shrinking \
            --dpi 300 \
            --print-media-type \
            -B 20mm -L 20mm -R 20mm -T 20mm \
            --footer-spacing 10 \
            --footer-font-size 8 \
            --footer-right 'Revised [rdate]' \
            --footer-left 'Page [page] of [toPage]' \
            --replace "rdate" "${rdate}" \
            ${resume_html} ${new_pdf}

echo "Generated PDF '${new_pdf}'"
cd ${pdf_path}
ln -sf $new_pdf_filename $pdf_filename