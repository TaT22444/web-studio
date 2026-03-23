---
name: web-production
description: Web制作ワークフロースキル。クライアントサイトやユーザー自身起点のサイトの制作依頼があったとき、または要件定義・デザイン・実装のいずれかのフェーズを開始するときに使用する。Webサイト・LP・コーポレートサイトの制作依頼、リニューアル、デザインや実装の話が出たら必ずこのスキルを使うこと。
---

# 🌐 Web制作スキル

## 起動時確認
1. プロジェクト名を確認（英小文字・ハイフン形式）
2. 作業ディレクトリ: カレントディレクトリ
3. フェーズ判定:

| 状況 | 開始フェーズ |
|------|------------|
| 何もない / 依頼だけある | Phase 1 |
| `{project}/docs/requirements.md` がある | Phase 2 |
| `{project}/design-draft.html` がある | Phase 3 |

## Phase 1（ディレクター）
`${CLAUDE_SKILL_DIR}/references/requirements.md` を読み込み、指示に従う。
出力: `{project}/docs/requirements.md`

## Phase 2（デザイナー）
`${CLAUDE_SKILL_DIR}/references/figma-rules.md` を読み込み、指示に従う。
出力: `{project}/design-draft.html`

## Phase 3（エンジニア）
`${CLAUDE_SKILL_DIR}/references/production-rules.md` を読み込み、指示に従う。
出力: `{project}/src/`

## ⚠ 重要ルール
- 成果物は必ずファイルに書き込む。チャット出力のみで終わらせない。
- 各フェーズ完了後、必ずユーザーの承認を得てから次フェーズへ進む。
- 「ブランドの本質」はAIが変更しない。
