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
| `{project}/docs/context.md` がない | `/web-studio:setup` を案内する |
| `{project}/docs/requirements.md` がある | Phase 2 へ |
| `{project}/design-draft.html` がある | Phase 3 へ |

## 全フェーズ共通
`{project}/docs/context.md` が存在する場合、**各フェーズ開始前に必ず読み込む**。
エージェント間の認識齟齬を防ぐ唯一の基準となる。

## Phase 2（デザイナー）
以下を必ず読み込んでから開始する:
- `{project}/docs/context.md`
- `{project}/docs/requirements.md`
- `${CLAUDE_SKILL_DIR}/references/figma-rules.md`

出力: `{project}/design-draft.html`

## Phase 3（エンジニア）
以下を必ず読み込んでから開始する:
- `{project}/docs/context.md`
- `{project}/docs/requirements.md`
- `${CLAUDE_SKILL_DIR}/references/production-rules.md`

出力: `{project}/src/`

## ⚠ 重要ルール
- 成果物は必ずファイルに書き込む。チャット出力のみで終わらせない。
- 各フェーズ完了後、必ずユーザーの承認を得てから次フェーズへ進む。
- `context.md` の「AIの判断基準」はAIが変更しない。
