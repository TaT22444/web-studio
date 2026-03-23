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
| `{project}/docs/requirements.md` がある & `wireframe.html` も `wireframe/` もない | Phase 2 へ |
| `{project}/wireframe.html` または `wireframe/` がある & `design-draft.html` も `design-draft/` もない | Phase 3 へ |
| `{project}/design-draft.html` または `design-draft/` がある | Phase 4 へ |

## Phase 1（セットアップ — ディレクター）
`context.md` が存在しない場合、セットアップを自動開始する。
`${CLAUDE_SKILL_DIR}/../setup/references/setup-guide.md` を読み込み、指示に従う。

出力:
- `{project}/docs/interview.md`（ヒアリング記録）
- `{project}/docs/context.md`（事業背景・判断基準）
- `{project}/docs/requirements.md`（仕様・構成）
- `{project}/docs/DESIGN.md`（デザイン方向性ドラフト — v1）

## 全フェーズ共通
`{project}/docs/context.md` が存在する場合、**各フェーズ開始前に必ず読み込む**。
エージェント間の認識齟齬を防ぐ唯一の基準となる。

## Phase 2（ワイヤーフレーム — デザイナー）
以下を必ず読み込んでから開始する:
- `{project}/docs/context.md`
- `{project}/docs/requirements.md`
- `{project}/docs/DESIGN.md`（v1: レイアウト好み・余白感・画像比率を構造に反映）
- `${CLAUDE_SKILL_DIR}/references/wireframe-rules.md`

出力:
- 1ページのみ: `{project}/wireframe.html`
- 複数ページ: `{project}/wireframe/index.html`, `{project}/wireframe/{page}.html` ...

## Phase 3（ビジュアルデザイン — デザイナー）
以下を必ず読み込んでから開始する:
- `{project}/docs/context.md`
- `{project}/docs/requirements.md`
- `{project}/docs/DESIGN.md`（v1: カラー・世界観・参考サイトをビジュアルに反映）
- `{project}/wireframe.html` または `{project}/wireframe/` 以下のファイル群
- `${CLAUDE_SKILL_DIR}/references/figma-rules.md`

出力:
- 1ページのみ: `{project}/design-draft.html`
- 複数ページ: `{project}/design-draft/index.html`, `{project}/design-draft/{page}.html` ...（ワイヤーフレームと同じページ数・同じファイル名）
- `{project}/docs/DESIGN.md`（v1 → v2 に更新: 確定値を記録）

## Phase 4（実装 — エンジニア）
以下を必ず読み込んでから開始する:
- `{project}/docs/context.md`
- `{project}/docs/requirements.md`
- `{project}/docs/DESIGN.md`（v2: デザインシステムの SSoT）
- `{project}/design-draft.html`
- `${CLAUDE_SKILL_DIR}/references/production-rules.md`

出力: `{project}/src/`

## ⚠ 重要ルール
- 成果物は必ずファイルに書き込む。チャット出力のみで終わらせない。
- 各フェーズ完了後、必ずユーザーの承認を得てから次フェーズへ進む。
- `context.md` の「AIの判断基準」はAIが変更しない。
- `DESIGN.md` はフェーズ間のデザイン情報の橋渡し役。Phase 3 で v1 → v2 に更新し、Phase 4 で SSoT として参照する。
