# web-studio

Web制作のヒアリング・要件定義・ワイヤーフレーム・ビジュアルデザイン・実装を4フェーズで進めるプラグインです。

## インストール

### Claude Code

```bash
claude plugin marketplace add TaT22444/web-studio
claude plugin install web-studio
```

### Cursor / その他エディタ

```bash
curl -sL https://raw.githubusercontent.com/TaT22444/web-studio/main/install.sh | bash
```

または手動で:

```bash
git clone https://github.com/TaT22444/web-studio.git /tmp/web-studio
mkdir -p ~/.cursor/skills
cp -R /tmp/web-studio/skills/web-production ~/.cursor/skills/
cp -R /tmp/web-studio/skills/setup ~/.cursor/skills/
rm -rf /tmp/web-studio
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

### Claude Code

```bash
claude plugin update web-studio
```

更新が反映されない場合は、マーケットプレイスを再登録してから再インストールしてください。

```bash
claude plugin marketplace remove web-studio
claude plugin marketplace add TaT22444/web-studio
claude plugin install web-studio
```

### Cursor / その他エディタ

インストールコマンドを再度実行してください（上書きされます）。

```bash
curl -sL https://raw.githubusercontent.com/TaT22444/web-studio/main/install.sh | bash
```
