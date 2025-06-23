#!env bash
set -euxo pipefail

{{ $pages := where .Site.RegularPages "Type" "in" .Site.Params.mainSections }}

vivliostyle build
{{ range $pages }}
    {{- if ne "imprints" .Type -}}
        pdfimpose saddle -f letter -o  '.{{ .Path }}/{{- .Title | urlize -}}.zine.pdf' '.{{ .Path }}/{{- .Title | urlize -}}.view.pdf'
    {{ end }}
{{ end }}

