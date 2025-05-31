#!env bash

{{ $pages := where .Site.RegularPages "Type" "in" .Site.Params.mainSections }}

vivliostyle build
{{ range $pages }}
    INNAME='.{{ .Path }}/{{- .Title | urlize -}}.view.pdf'
    OUTNAME='.{{ .Path }}/{{- .Title | urlize -}}.zine.pdf'
    psbook $INNAME | psnup -2 -p letter > $OUTNAME
{{ end }}

