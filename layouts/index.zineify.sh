#!env bash

{{ $pages := where .Site.RegularPages "Type" "in" .Site.Params.mainSections }}

vivliostyle build --http
{{ range $pages }}
    INNAME='.{{ .RelPermalink }}{{- .Title | urlize -}}.view.pdf'
    OUTNAME='.{{ .RelPermalink }}{{- .Title | urlize -}}.zine.pdf'
    psbook $INNAME | psnup -2 -p letter > $OUTNAME
{{ end }}

