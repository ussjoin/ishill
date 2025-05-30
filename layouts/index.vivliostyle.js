// @ts-check
/** @type {import('@vivliostyle/cli').VivliostyleConfigSchema} */

{{ $pages := where .Site.RegularPages "Type" "in" .Site.Params.mainSections }}

const vivliostyleConfig = [
    {{ range $pages }}
    {
        title: '{{- .Title -}}', // populated into 'publication.json', default to 'title' of the first entry or 'name' in 'package.json'.
        // author: '', // default to 'author' in 'package.json' or undefined
        language: 'en',
        readingProgression: 'ltr', // reading progression direction, 'ltr' or 'rtl'.
        size: '5.5in,8.5in',
        image: 'ghcr.io/vivliostyle/cli:latest',
        entry: [ // **required field**
            '.{{ .Path }}/index.html'
        ],
        output: [ // path to generate draft file(s). default to '{title}.pdf'
        '.{{ .Path }}/{{- .Title | urlize -}}.view.pdf',
        ],
        // cover: './cover.png', // cover image. default to undefined.
    },
    {{ end }}
];

module.exports = vivliostyleConfig;
