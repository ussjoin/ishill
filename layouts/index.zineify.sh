#!env bash
set -euxo pipefail

function cleanup()
{
    # Terminates http.server
    kill $(cat .PID)
    rm .PID
}

trap cleanup EXIT

python3 -m http.server & # starts on port 8000
# $! == PID of last background process
echo $! > .PID


{{ $pages := where .Site.RegularPages "Type" "in" .Site.Params.mainSections }}

{{ $a4style := resources.Get "css/a4.css" | fingerprint }}
{{ $letterstyle := resources.Get "css/letter.css" | fingerprint }}

{{ range $pages }}
    {{ if ne "imprints" .Type }}
        {{ if .Site.Params.output_letter }}
        weasyprint  -s 'http://localhost:8000{{ $letterstyle.RelPermalink }}' --optimize-images --dpi 150 http://localhost:8000{{ .Path }}/  .{{ .Path }}/{{- .Title | urlize -}}.view-letter.pdf
        pdfimpose saddle -f letter --imargin 1mm -o  '.{{ .Path }}/{{- .Title | urlize -}}.zine-letter.pdf' '.{{ .Path }}/{{- .Title | urlize -}}.view-letter.pdf'
        {{ end }}

        {{ if .Site.Params.output_a4 }}
        weasyprint  -s 'http://localhost:8000{{ $a4style.RelPermalink }}' --optimize-images --dpi 150 http://localhost:8000{{ .Path }}/  .{{ .Path }}/{{- .Title | urlize -}}.view-a4.pdf
        pdfimpose saddle -f a4 --imargin 1mm -o  '.{{ .Path }}/{{- .Title | urlize -}}.zine-a4.pdf' '.{{ .Path }}/{{- .Title | urlize -}}.view-a4.pdf'
        {{ end }}
    {{ end }}
{{ end }}

{{ if .Site.Params.enableArchive }}
    ls | grep -v zineify.sh | zip -r {{ .Site.Title | urlize }}-archive.zip -@
{{ end }}
