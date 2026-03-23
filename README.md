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
| Phase 1: ヒアリング＋要件定義 | ディレクター | `docs/interview.md` `docs/context.md` `docs/requirements.md` `docs/DESIGN.md`(v1) |
| Phase 2: ワイヤーフレーム | デザイナー | `wireframe.html` |
| Phase 3: ビジュアルデザイン | デザイナー | `design-draft.html` + `docs/DESIGN.md`(v2) |
| Phase 4: 実装 | エンジニア | `src/` |

各フェーズはユーザーの承認を得てから次へ進みます。

### docs/ の構成

| ファイル | 役割 |
|---|---|
| `interview.md` | ヒアリングの質問と回答の生ログ |
| `context.md` | 事業背景・AIの判断基準 |
| `requirements.md` | 仕様・構成・導線設計 |
| `DESIGN.md` | デザインシステム（v1: 方向性ドラフト → v2: 確定値） |

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
