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
| `{project}/docs/requirements.md` がある & `design-draft.html` も `design-draft/` もない | Phase 2 へ |
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

## Phase 2（デザイン — デザイナー）
以下を必ず読み込んでから開始する:
- `{project}/docs/context.md`
- `{project}/docs/requirements.md`
- `{project}/docs/DESIGN.md`（v1: クリエイティブブリーフ + デザイン方向性。セクション1のクリエイティブブリーフが設計の最重要入力）
- `${CLAUDE_SKILL_DIR}/references/figma-rules.md`

ワークフロー:
1. 全ドキュメント読み込み + 参考サイト/画像の視覚分析
2. トップページのデザインを作成
3. ユーザーの承認を得る
4. 承認後、残りページを展開

出力:
- 1ページのみ: `{project}/design-draft.html`
- 複数ページ: `{project}/design-draft/index.html`, `{project}/design-draft/{page}.html` ...
- `{project}/docs/DESIGN.md`（v1 → v2 に更新: 確定値を記録。以降のフィードバックで v2.x として追記更新可）

## Phase 3（実装 — エンジニア）
以下を必ず読み込んでから開始する:
- `{project}/docs/context.md`
- `{project}/docs/requirements.md`
- `{project}/docs/DESIGN.md`（v2+: デザインシステムの SSoT）
- `{project}/design-draft.html` または `{project}/design-draft/` 以下のファイル群
- `${CLAUDE_SKILL_DIR}/references/production-rules.md`

出力: `{project}/src/`

## ⚠ 重要ルール
- 成果物は必ずファイルに書き込む。チャット出力のみで終わらせない。
- 各フェーズ完了後、必ずユーザーの承認を得てから次フェーズへ進む。
- 各フェーズ内でのフィードバック・修正ラウンドは想定内。ユーザーが「完了」「次へ進んで」等を明示するまではそのフェーズに留まる。
- `context.md` の「AIの判断基準」はAIが変更しない。
- `DESIGN.md` はフェーズ間のデザイン情報の橋渡し役。Phase 2 で v1 → v2 に更新し、Phase 3 で SSoT として参照する。Phase 2 内のフィードバックで v2.x として追記更新してよい。Phase 3 突入前の最新版が SSoT となる。
