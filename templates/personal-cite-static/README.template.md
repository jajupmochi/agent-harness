# <SITE_NAME>

> <DESCRIPTION>

> **Language:** English | [中文](README.zh.md)

## Master TOC

- [Live site](#live-site)
- [Local development](#local-development)
- [Structure](#structure)
- [License](#license)

## Live site

`<DEPLOY_URL>`

## Local development

```bash
python3 -m http.server 8000
# Open http://localhost:8000/index.html
```

## Structure

- `index.html` — main page
- `locales/{en,zh}.json` — i18n translations
- `data/*.json` — site data (citations, projects, ...)
- `css/`, `js/`, `images/`, `res/` — assets

## License

MIT (see [LICENSE](LICENSE)).
