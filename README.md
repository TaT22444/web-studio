# web-studio

Web制作の要件定義・デザイン・実装を3フェーズで進めるClaude Codeプラグインです。

## インストール

```bash
claude plugin marketplace add TaT22444/web-studio
claude plugin install web-studio
```

## 使い方

Webサイト・LP・コーポレートサイトの制作依頼をすると自動でスキルが起動します。

### フェーズ構成

| フェーズ | 担当 | 成果物 |
|---|---|---|
| Phase 1: 要件定義 | ディレクター | `{project}/docs/requirements.md` |
| Phase 2: デザイン | デザイナー | `{project}/design-draft.html` |
| Phase 3: 実装 | エンジニア | `{project}/src/` |

各フェーズはユーザーの承認を得てから次へ進みます。

## アップデート

```bash
claude plugin update web-studio
```
