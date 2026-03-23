# web-studio

Web制作のヒアリング・要件定義・ワイヤーフレーム・ビジュアルデザイン・実装を4フェーズで進めるClaude Codeプラグインです。

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
| Phase 1: ヒアリング＋要件定義 | ディレクター | `{project}/docs/context.md` `{project}/docs/requirements.md` |
| Phase 2: ワイヤーフレーム | デザイナー | `{project}/wireframe.html` |
| Phase 3: ビジュアルデザイン | デザイナー | `{project}/design-draft.html` |
| Phase 4: 実装 | エンジニア | `{project}/src/` |

各フェーズはユーザーの承認を得てから次へ進みます。

## アップデート

```bash
claude plugin update web-studio
```

### 更新が反映されない場合

環境によっては `update` が失敗したり、マーケットプレイスのキャッシュが古いままになることがあります。その場合は、マーケットプレイスを再登録してから再インストールしてください。

```bash
claude plugin marketplace remove web-studio
claude plugin marketplace add TaT22444/web-studio
claude plugin install web-studio
```
