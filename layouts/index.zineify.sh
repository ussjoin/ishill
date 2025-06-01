#!env bash
set -euxo pipefail

{{ $pages := where .Site.RegularPages "Type" "in" .Site.Params.mainSections }}

vivliostyle build
{{ range $pages }}
    psbook '.{{ .Path }}/{{- .Title | urlize -}}.view.pdf' > '.{{ .Path }}/{{- .Title | urlize -}}.tmp.pdf'
    psnup -2 -p letter '.{{ .Path }}/{{- .Title | urlize -}}.tmp.pdf' > '.{{ .Path }}/{{- .Title | urlize -}}.zine.pdf'
    rm '.{{ .Path }}/{{- .Title | urlize -}}.tmp.pdf'
{{ end }}

