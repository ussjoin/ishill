#!env bash
set -euxo pipefail

function cleanup()
{
    # Terminates nginx
    nginx -s quit
}

trap cleanup EXIT

nginx -c nginx.conf

{{ $pages := where .Site.RegularPages "Type" "in" .Site.Params.mainSections }}

{{ range $pages }}
    weasyprint  http://localhost:8000{{ .Path }}/  .{{ .Path }}/{{- .Title | urlize -}}.view.pdf
    {{ if ne "imprints" .Type }}
        pdfimpose saddle -f letter -o  '.{{ .Path }}/{{- .Title | urlize -}}.zine.pdf' '.{{ .Path }}/{{- .Title | urlize -}}.view.pdf'
    {{ end }}
{{ end }}


