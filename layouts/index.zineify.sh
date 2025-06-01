#!env bash
set -euxo pipefail

{{ $pages := where .Site.RegularPages "Type" "in" .Site.Params.mainSections }}

vivliostyle build
{{ range $pages }}
    psbook '.{{ .Path }}/{{- .Title | urlize -}}.view.pdf' | psnup -2 -p letter > '.{{ .Path }}/{{- .Title | urlize -}}.zine.pdf'
{{ end }}

