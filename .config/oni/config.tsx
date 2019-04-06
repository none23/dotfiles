
import * as React from "react"
import * as Oni from "oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")

    // Input
    //
    // Add input bindings here:
    //
    // oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"))

    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")

}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}

export const configuration = {
  "autoUpdate.enabled": false,
  "browser.defaultUrl": "https://duckduckgo.com",
  "configuration.showReferenceBuffer": true,
  "debug.fixedSize": null,
  "debug.neovimPath": null,
  "debug.persistOnNeovimExit": false,
  "debug.detailedSessionLogging": false,
  "debug.showTypingPrediction": false,
  "debug.showNotificationOnError": false,
  "debug.fakeLag.languageServer": null,
  "debug.fakeLag.neovimInput": null,
  "wildmenu.mode": true,
  "commandline.mode": true,
  "commandline.icons": false,
  "experimental.preview.enabled": false,
  "experimental.welcome.enabled": false,
  "experimental.particles.enabled": false,
  "experimental.sessions.enabled": false,
  "experimental.sessions.directory": null,
  "experimental.vcs.sidebar": false,
  "experimental.vcs.blame.enabled": true,
  "experimental.vcs.blame.mode": "auto",
  "experimental.vcs.blame.timeout": 800,
  "experimental.colorHighlight.enabled": true,
  "experimental.colorHighlight.filetypes": [
    ".css",
    ".js",
    ".jsx",
    ".tsx",
    ".ts",
    ".re",
    ".sass",
    ".scss",
    ".less",
    ".pcss",
    ".sss",
    ".stylus",
    ".xml",
    ".svg"
  ],
  "experimental.indentLines.enabled": true,
  "experimental.indentLines.color": "#333333",
  "experimental.indentLines.skipFirst": true,
  "experimental.indentLines.filetypes": [
    ".css",
    ".js",
    ".jsx",
    ".tsx",
    ".ts",
    ".re",
    ".sass",
    ".scss",
    ".less",
    ".pcss",
    ".sss",
    ".stylus",
    ".xml",
    ".svg"
  ],
  "experimental.markdownPreview.enabled": false,
  "experimental.markdownPreview.autoScroll": true,
  "experimental.markdownPreview.syntaxHighlights": true,
  "experimental.markdownPreview.syntaxTheme": "atom-one-dark",
  "experimental.neovim.transport": "stdio",
  "editor.maxLinesForLanguageServices": 2500,
  "editor.textMateHighlighting.enabled": false,
  "autoClosingPairs.enabled": false,
  "autoClosingPairs.default": [
    {
      "open": "{",
      "close": "}"
    },
    {
      "open": "[",
      "close": "]"
    },
    {
      "open": "(",
      "close": ")"
    }
  ],
  "oni.audio.bellUrl": null,
  "oni.useDefaultConfig": true,
  "oni.enhancedSyntaxHighlighting": true,
  "oni.loadInitVim": true,
  "oni.hideMenu": false,
  "oni.exclude": [
    "node_modules",
    ".git"
  ],
  "oni.bookmarks": [],
  "editor.renderer": "canvas",
  "editor.backgroundOpacity": 1,
  "editor.backgroundImageUrl": null,
  "editor.backgroundImageSize": "cover",
  "editor.clipboard.enabled": true,
  "editor.clipboard.synchronizeYank": true,
  "editor.clipboard.synchronizeDelete": false,
  "editor.definition.enabled": true,
  "editor.quickInfo.enabled": true,
  "editor.quickInfo.delay": 50,
  "editor.completions.mode": "oni",
  "editor.errors.slideOnFocus": true,
  "editor.formatting.formatOnSwitchToNormalMode": false,
  "editor.fontLigatures": true,
  "editor.fontSize": "11px",
  "editor.fontWeight": "normal",
  //"editor.fontFamily": "InconsolataPowerlive",
  "editor.linePadding": 1.2,
  "editor.quickOpen.filterStrategy": "vscode",
  "editor.quickOpen.defaultOpenMode": 0,
  "editor.quickOpen.alternativeOpenMode": 4,
  "editor.quickOpen.showHidden": true,
  "quickOpen.defaultOpenMode": 0,
  "editor.split.mode": "native",
  "editor.typingPrediction": true,
  "editor.scrollBar.visible": true,
  "editor.scrollBar.cursorTick.visible": true,
  "editor.fullScreenOnStart": true,
  "editor.maximizeScreenOnStart": false,
  "editor.cursorLine": false,
  "editor.cursorLineOpacity": 0.1,
  "editor.cursorColumn": false,
  "editor.cursorColumnOpacity": 0.1,
  "editor.tokenColors": [],
  "editor.imageLayerExtensions": [
    ".gif",
    ".jpg",
    ".jpeg",
    ".bmp",
    ".png"
  ],
  "explorer.persistDeletedFiles": true,
  "explorer.maxUndoFileSizeInBytes": 500000,
  "environment.additionalPaths": [
    "/usr/bin",
    "/usr/local/bin"
  ],
  "environment.additionalVariables": {},
  "keyDisplayer.showInInsertMode": false,
  "language.html.languageServer.command": "/opt/oni/resources/app/node_modules/vscode-html-languageserver-bin/htmlServerMain.js",
  "language.html.languageServer.arguments": [
    "--stdio"
  ],
  "language.go.languageServer.command": "go-langserver",
  "language.go.textMateGrammar": "/opt/oni/resources/app/extensions/go/syntaxes/go.json",
  "language.vue.textMateGrammar": "/opt/oni/resources/app/extensions/vue/syntaxes/vue.json",
  "language.python.languageServer.command": "pyls",
  "language.cpp.languageServer.command": "clangd",
  "language.c.languageServer.command": "clangd",
  "language.css.languageServer.command": "/opt/oni/resources/app/node_modules/vscode-css-languageserver-bin/cssServerMain.js",
  "language.css.languageServer.arguments": [
    "--stdio"
  ],
  "language.css.textMateGrammar": "/opt/oni/resources/app/extensions/css/syntaxes/css.tmLanguage.json",
  "language.css.tokenRegex": "[$_a-zA-Z0-9-]",
  "language.elixir.textMateGrammar": {
    ".ex": "/opt/oni/resources/app/extensions/elixir/syntaxes/elixir.tmLanguage.json",
    ".exs": "/opt/oni/resources/app/extensions/elixir/syntaxes/elixir.tmLanguage.json",
    ".eex": "/opt/oni/resources/app/extensions/elixir/syntaxes/eex.tmLanguage.json",
    ".html.eex": "/opt/oni/resources/app/extensions/elixir/syntaxes/html(eex).tmLanguage.json"
  },
  "language.less.languageServer.command": "/opt/oni/resources/app/node_modules/vscode-css-languageserver-bin/cssServerMain.js",
  "language.less.languageServer.arguments": [
    "--stdio"
  ],
  "language.less.textMateGrammar": "/opt/oni/resources/app/extensions/less/syntaxes/less.tmLanguage.json",
  "language.less.tokenRegex": "[$_a-zA-Z0-9-]",
  "language.scss.languageServer.command": "/opt/oni/resources/app/node_modules/vscode-css-languageserver-bin/cssServerMain.js",
  "language.scss.languageServer.arguments": [
    "--stdio"
  ],
  "language.scss.textMateGrammar": "/opt/oni/resources/app/extensions/scss/syntaxes/scss.json",
  "language.scss.tokenRegex": "[$_a-zA-Z0-9-]",
  "language.reason.languageServer.command": "/opt/oni/resources/app/node_modules/ocaml-language-server/bin/server/index.js",
  "language.reason.languageServer.arguments": [
    "--stdio"
  ],
  "language.reason.languageServer.rootFiles": [
    ".merlin",
    "bsconfig.json"
  ],
  "language.reason.languageServer.configuration": {
    "reason": {
      "codelens": {
        "enabled": true,
        "unicode": true
      },
      "bsb": {
        "enabled": true
      },
      "debounce": {
        "linter": 500
      },
      "diagnostics": {
        "tools": [
          "bsb",
          "merlin"
        ]
      },
      "path": {
        "bsb": "bsb",
        "ocamlfind": "ocamlfind",
        "ocamlmerlin": "ocamlmerlin",
        "opam": "opam",
        "rebuild": "rebuild",
        "refmt": "refmt",
        "refmterr": "refmterr",
        "rtop": "rtop"
      }
    }
  },
  "language.reason.textMateGrammar": "/opt/oni/resources/app/extensions/reason/syntaxes/reason.json",
  "language.ocaml.languageServer.command": "/opt/oni/resources/app/node_modules/ocaml-language-server/bin/server/index.js",
  "language.ocaml.languageServer.arguments": [
    "--stdio"
  ],
  "language.ocaml.languageServer.configuration": {
    "reason": {
      "codelens": {
        "enabled": true,
        "unicode": true
      },
      "bsb": {
        "enabled": true
      },
      "debounce": {
        "linter": 500
      },
      "diagnostics": {
        "tools": [
          "bsb",
          "merlin"
        ]
      },
      "path": {
        "bsb": "bsb",
        "ocamlfind": "ocamlfind",
        "ocamlmerlin": "ocamlmerlin",
        "opam": "opam",
        "rebuild": "rebuild",
        "refmt": "refmt",
        "refmterr": "refmterr",
        "rtop": "rtop"
      }
    }
  },
  "language.javascript.languageServer.command": "flow",
  "language.haskell.languageServer.arguments": [
    "--lsp",
  ],
  "language.typescript.completionTriggerCharacters": [
    ".",
    "/",
    "\\"
  ],
  "language.typescript.textMateGrammar": {
    ".ts": "/opt/oni/resources/app/extensions/typescript/syntaxes/TypeScript.tmLanguage.json",
    ".tsx": "/opt/oni/resources/app/extensions/typescript/syntaxes/TypeScriptReact.tmLanguage.json"
  },
  "language.lua.textMateGrammar": "/opt/oni/resources/app/extensions/lua/syntaxes/lua.tmLanguage.json",
  "language.sh.textMateGrammar": "/opt/oni/resources/app/extensions/shell/syntaxes/shell.tmLanguage.json",
  "language.zsh.textMateGrammar": "/opt/oni/resources/app/extensions/shell/syntaxes/shell.tmLanguage.json",
  "language.cs.textMateGrammar": "/opt/oni/resources/app/extensions/csharp/syntaxes/csharp.tmLanguage.json",
  "language.javascript.completionTriggerCharacters": [
    ".",
    "/",
    "\\"
  ],
  "language.javascript.textMateGrammar": {
    ".js": "/opt/oni/resources/app/extensions/javascript/syntaxes/JavaScript.tmLanguage.json",
    ".jsx": "/opt/oni/resources/app/extensions/javascript/syntaxes/JavaScriptReact.tmLanguage.json"
  },
  "learning.enabled": true,
  "achievements.enabled": true,
  "menu.caseSensitive": "smart",
  "menu.rowHeight": 30,
  "menu.maxItemsToShow": 8,
  "notifications.enabled": true,
  "recorder.copyScreenshotToClipboard": false,
  "recorder.outputPath": "/tmp",

  "sidebar.enabled": true,
  "sidebar.default.open": true,
  "sidebar.width": "15em",
  "sidebar.marks.enabled": false,
  "sidebar.plugins.enabled": false,
  "snippets.enabled": true,
  "snippets.userSnippetFolder": null,

  "statusbar.enabled": false,
  "statusbar.fontSize": "0.9em",
  "statusbar.priority": {
    "oni.status.workingDirectory": 0,
    "oni.status.linenumber": 2,
    "oni.status.gitHubRepo": 0,
    "oni.status.mode": 1,
    "oni.status.filetype": 1,
    "oni.status.git": 3
  },

  "oni.plugins.prettier": {
    "settings": {
      "semi": true,
      "tabWidth": 2,
      "useTabs": false,
      "singleQuote": true,
      "trailingComma": "all",
      "bracketSpacing": true,
      "jsxBracketSameLine": false,
      "arrowParens": "avoid",
      "printWidth": 80
    },
    "formatOnSave": true,
    "enabled": true,
  },

  "tabs.mode": "tabs",
  "tabs.height": "1.3em",
  "tabs.highlight": true,
  "tabs.maxWidth": "30em",
  "tabs.showFileIcon": true,
  "tabs.showIndex": false,
  "tabs.wrap": false,
  "tabs.dirtyMarker.userColor": "#de1e1e",

  "terminal.shellCommand": null,

  "ui.animations.enabled": false,
  "ui.colorscheme": "nwsome",
  // "ui.fontSmoothing": "auto",
  // "ui.iconTheme": "theme-icons-seti",
  "ui.fontFamily": "'xos4 Terminus', 'Inconsolata for Powerline', 'monospace', monospace, BlinkMacSystemFont, 'Lucida Grande', 'Segoe UI', Ubuntu, Cantarell, sans-serif",
  "ui.fontSize": "12px",

  "workspace.defaultWorkspace": null,
  "workspace.autoDetectWorkspace": "noworkspace",
  "workspace.autoDetectRootFiles": [
    ".git",
    "node_modules",
    ".svn",
    "package.json",
    ".hg",
    ".bzr",
    "build.xml"
  ],
  "_internal.hasCheckedInitVim": true
}
