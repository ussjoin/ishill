#!env bash
set -euxo pipefail

function cleanup()
{
    # Terminates http.server
    kill $(cat PID)
    rm PID
}

trap cleanup EXIT

python3 -m http.server & # starts on port 8000
# $! == PID of last background process
echo $! > PID

{{ $pages := where .Site.RegularPages "Type" "in" .Site.Params.mainSections }}

{{ range $pages }}
    weasyprint  http://localhost:8000{{ .Path }}/  .{{ .Path }}/{{- .Title | urlize -}}.view.pdf
    {{ if ne "imprints" .Type }}
        pdfimpose saddle -f letter -o  '.{{ .Path }}/{{- .Title | urlize -}}.zine.pdf' '.{{ .Path }}/{{- .Title | urlize -}}.view.pdf'
    {{ end }}
{{ end }}


