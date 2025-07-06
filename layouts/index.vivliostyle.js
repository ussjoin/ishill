// @ts-check
/** @type {import('@vivliostyle/cli').VivliostyleConfigSchema} */

{{ $pages := where .Site.RegularPages "Type" "in" .Site.Params.mainSections }}
{{ $pages := $pages | intersect (where .Site.RegularPages "Type" "ne" "imprints") }}

const vivliostyleConfig = [
    {{ range $pages }}
    {
        title: '{{- .Title -}}', // populated into 'publication.json', default to 'title' of the first entry or 'name' in 'package.json'.
        language: 'en',
        readingProgression: 'ltr', // reading progression direction, 'ltr' or 'rtl'.
        size: '5.5in,8.5in',
        image: 'ghcr.io/vivliostyle/cli:latest',
        renderMode: 'docker',
        entry: [ // **required field**
            '.{{ .Path }}/index.html'
        ],
        output: [ // path to generate draft file(s). default to '{title}.pdf'
        '.{{ .Path }}/{{- .Title | urlize -}}.view.pdf',
        ],
        static: {
            '{{ relURL "css" }}': './css',
            '{{ relURL "fonts" }}': './fonts',
        },
    },
    {{ end }}
];

module.exports = vivliostyleConfig;
