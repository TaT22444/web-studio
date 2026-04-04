# web-studio

Web制作のヒアリング・要件定義・デザイン・実装を一気通貫で進める AI スキルプラグインです。

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

| フェーズ | 担当 | 概要 | 主な成果物 |
|---|---|---|---|
| Phase 1: ヒアリング＋要件定義 | ディレクター | 対話型ヒアリングで事業背景・仕様・デザイン方向性を定義 | `docs/interview.md` `docs/context.md` `docs/requirements.md` `docs/DESIGN.md`(v1) |
| Phase 2-A: ビジュアル探索 | Stitch（任意・推奨） | Google Stitch でトップページの視覚的方向性を探索・合意 | `docs/references/stitch-*.png` `docs/DESIGN.md`(v1.5) |
| Phase 2-B: デザインドラフト | デザイナー | ドキュメント＋ビジュアル参照を元にデザインを作成 | `design-draft.html` or `design-draft/` `docs/DESIGN.md`(v2) |
| Phase 3: 実装 | エンジニア | デザインドラフトを元にプロダクションコードを実装 | `src/` |

各フェーズはユーザーの承認を得てから次へ進みます。Phase 2-A はスキップ可能です。

### docs/ の構成

| ファイル | 役割 |
|---|---|
| `interview.md` | ヒアリングの質問と回答の生ログ |
| `context.md` | 事業背景・AIの判断基準 |
| `requirements.md` | 仕様・構成・導線設計 |
| `DESIGN.md` | デザインシステム（v1: 方向性ドラフト → v1.5: ビジュアル探索結果追記 → v2: 確定値） |

### DESIGN.md のバージョニング

| バージョン | 更新タイミング | 内容 |
|---|---|---|
| v1 | Phase 1 完了時 | クリエイティブブリーフ＋デザイン方向性ドラフト |
| v1.5 | Phase 2-A 完了時（任意） | Stitch ビジュアル探索の結果・方針決定を追記 |
| v2 | Phase 2-B 完了時 | デザインドラフトで確定した値を記録。以降フィードバックで v2.x 更新可 |

## Phase 2-A: Stitch ビジュアル探索について

Phase 1 のドキュメントだけではデザインの「雰囲気」の認識合わせが難しいため、[Google Stitch](https://stitch.withgoogle.com/) を使って視覚的に方向性を確認するステップです。

- Stitch MCP を通じてトップページ（モバイル・デスクトップ）を生成
- ユーザーと対話しながら方向性を調整
- 承認後のスクリーンショットが Phase 2-B のビジュアル参照になる
- Stitch の出力はあくまで **ビジュアルブリーフ** であり、コードは使用しない

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
