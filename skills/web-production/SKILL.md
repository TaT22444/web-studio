---
name: web-production
description: Web制作ワークフロースキル。クライアントサイトやユーザー自身起点のサイトの制作依頼があったとき、または要件定義・デザイン・実装のいずれかのフェーズを開始するときに使用する。Webサイト・LP・コーポレートサイトの制作依頼、リニューアル、デザインや実装の話が出たら必ずこのスキルを使うこと。
---

# 🌐 Web制作スキル

## 起動時確認
1. プロジェクト名を確認（英小文字・ハイフン形式）
2. 作業ディレクトリ: カレントディレクトリ
3. フェーズ判定:

| 状態 | 対応 |
|------|------|
| `{project}/docs/context.md` がない | Phase 1（セットアップ）を自動開始 |
| `{project}/docs/requirements.md` がある & `design-draft.html` も `design-draft/` もない | Phase 2-A を提案（Stitch ビジュアル探索）→ スキップ可 → Phase 2-B へ |
| `{project}/design-draft.html` または `{project}/design-draft/` がある | Phase 3 へ |

## Phase 1（セットアップ — ディレクター）
`context.md` が存在しない場合、セットアップを自動開始する。
`${CLAUDE_SKILL_DIR}/../setup/references/setup-guide.md` を読み込み、指示に従う。

⚠ **ヒアリング省略禁止:**
ユーザーが最初の発言で多くの情報を提供しても、ヒアリング対話をスキップしてはならない。
提供済みの情報は interview.md に記録した上で、不足分・深掘りを対話で聞く。
**Stage 6b（設計方向の対話）の承認を得るまで、context.md / requirements.md / DESIGN.md を生成してはならない。**

出力:
- `{project}/docs/interview.md`（ヒアリング記録）
- `{project}/docs/context.md`（事業背景・判断基準）
- `{project}/docs/requirements.md`（仕様・構成）
- `{project}/docs/DESIGN.md`（クリエイティブブリーフ + デザイン方向性ドラフト — v1）

## 全フェーズ共通
`{project}/docs/context.md` が存在する場合、**各フェーズ開始前に必ず読み込む**。
エージェント間の認識齟齬を防ぐ唯一の基準となる。

## Phase 2-A（ビジュアル探索 — Stitch）【任意・推奨】

Phase 1 完了後、デザインドラフトに入る前に **Google Stitch で視覚的な方向性を探索する** オプショナルステップ。
ユーザーに「Stitch でビジュアルの方向性を確認しますか？」と提案する。スキップも可。

以下を読み込んでから開始する:
- `{project}/docs/context.md`
- `{project}/docs/requirements.md`
- `{project}/docs/DESIGN.md`（v1）
- `${CLAUDE_SKILL_DIR}/references/stitch-guide.md`

ワークフロー:
1. 全ドキュメント読み込み
2. ユーザーに Stitch プロジェクト URL を確認（既存 or 新規作成）
3. DESIGN.md v1 からプロンプトを構築し、トップページをモバイル・デスクトップで生成
4. ユーザーと方向性を対話で調整（edit_screens で微調整可）
5. 承認後、スクリーンショットを `{project}/docs/references/` に保存
6. DESIGN.md に「ビジュアル探索の結果」セクションを追記（v1 → v1.5）

出力:
- `{project}/docs/references/stitch-top-mobile.png`（スクリーンショット）
- `{project}/docs/references/stitch-top-desktop.png`（スクリーンショット）
- `{project}/docs/DESIGN.md`（v1 → v1.5: ビジュアル探索結果を追記）

⚠ **Stitch の出力はビジュアルブリーフであり、プロダクションコードではない。**
Phase 2-B はゼロからデザインを作成し、Stitch 出力は視覚的参照としてのみ使う。

---

## Phase 2-B（デザインドラフト — デザイナー）
以下を必ず読み込んでから開始する:
- `{project}/docs/context.md`
- `{project}/docs/requirements.md`
- `{project}/docs/DESIGN.md`（v1.5 があれば v1.5、なければ v1。セクション1のクリエイティブブリーフが設計の最重要入力）
- `${CLAUDE_SKILL_DIR}/references/figma-rules.md`
- `{project}/docs/references/stitch-*.png`（Phase 2-A 実施済みの場合）

ワークフロー:
1. 全ドキュメント読み込み + 参考サイト/画像の視覚分析（Stitch 参照画像を含む）
2. トップページのデザインを作成
3. ユーザーの承認を得る
4. 承認後、残りページを展開

出力:
- 1ページのみ: `{project}/design-draft.html`
- 複数ページ: `{project}/design-draft/index.html`, `{project}/design-draft/{page}.html` ...
- `{project}/docs/DESIGN.md`（v1.5 → v2 に更新: 確定値を記録。以降のフィードバックで v2.x として追記更新可）

## Phase 3（実装 — エンジニア）
以下を必ず読み込んでから開始する:
- `{project}/docs/context.md`
- `{project}/docs/requirements.md`
- `{project}/docs/DESIGN.md`（v2+: デザインシステムの SSoT。v2.x の追記更新がある場合は最新版を使う）
- `{project}/design-draft.html` または `{project}/design-draft/` 以下のファイル群
- `${CLAUDE_SKILL_DIR}/references/production-rules.md`

出力: `{project}/src/`

## ⚠ 重要ルール
- 成果物は必ずファイルに書き込む。チャット出力のみで終わらせない。
- 各フェーズ完了後、必ずユーザーの承認を得てから次フェーズへ進む。
- 各フェーズ内でのフィードバック・修正ラウンドは想定内。ユーザーが「完了」「次へ進んで」等を明示するまではそのフェーズに留まる。
- `context.md` の「AIの判断基準」はAIが変更しない。
- `DESIGN.md` はフェーズ間のデザイン情報の橋渡し役。Phase 2-A で v1 → v1.5（ビジュアル探索結果追記）、Phase 2-B で v1.5 → v2（確定値記録）に更新し、Phase 3 で SSoT として参照する。Phase 2-B 内のフィードバックで v2.x として追記更新してよい。Phase 3 突入前の最新版が SSoT となる。
