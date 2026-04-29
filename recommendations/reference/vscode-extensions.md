# Reference: VS Code Extensions

> Knowledge table of VS Code extensions. **NEVER auto-install.** The author's primary IDE is PyCharm/IntelliJ (`.idea/` is in every project, `.vscode/` rarely is). VS Code is secondary; CC has its own equivalent of many extensions. This file exists so an agent knows these are options if the user works in VS Code.

## Master TOC

- [Agent rule](#agent-rule)
- [CC-friendly defaults](#cc-friendly-defaults)
- [Other notable extensions on the system](#other-notable-extensions-on-the-system)

## Agent rule

**Never auto-install VS Code extensions.** When a task would benefit from one:

1. Mention the extension as a recommendation
2. Provide the install command (`code --install-extension <id>`)
3. Let the user decide whether to install

VS Code extension preferences are highly personal — what saves time for one person clutters another's UI.

## CC-friendly defaults

If the user works in VS Code, these are worth recommending:

| Extension | Purpose | Install |
|---|---|---|
| `eamodio.gitlens` | Git history inline + blame | `code --install-extension eamodio.gitlens` |
| `donjayamanne.githistory` | Git log viewer | `code --install-extension donjayamanne.githistory` |
| `github.vscode-pull-request-github` | GitHub PRs in editor | `code --install-extension github.vscode-pull-request-github` |
| `github.remotehub` | GitHub Remote (open repos without clone) | `code --install-extension github.remotehub` |
| `esbenp.prettier-vscode` | Prettier integration | `code --install-extension esbenp.prettier-vscode` |
| `christian-kohler.path-intellisense` | Autocomplete file paths | `code --install-extension christian-kohler.path-intellisense` |
| `formulahendry.code-runner` | Quick run snippets | `code --install-extension formulahendry.code-runner` |
| `chrmarti.regex` | Regex playground | `code --install-extension chrmarti.regex` |
| `cschlosser.doxdocgen` | Doxygen comment generator | `code --install-extension cschlosser.doxdocgen` |

## Other notable extensions on the system

The author has 40+ extensions installed. Most are highly personal (Live2D, custom themes, Chinese book reader, MATLAB-specific, etc.). The CC-friendly subset above is what's worth recommending broadly.

For a complete list of what the author has installed, run on the user's machine:

```bash
ls ~/.vscode/extensions
```

(But again: don't auto-install — ask first.)
