---
name: setup
description: プロジェクトのセットアップウィザード。新規プロジェクト開始時、またはコンテキスト・要件を更新したいときに使う。3段階のQ&AでAIが迷わないための context.md と requirements.md を生成する。
disable-model-invocation: true
---

# web-studio セットアップ

`${CLAUDE_SKILL_DIR}/references/setup-guide.md` を読み込み、指示に従う。

⚠ **ヒアリング省略禁止:**
- ユーザーが大量の情報を事前に提供した場合でも、ヒアリング対話は省略しない
- 提供された情報は interview.md に記録し、不足分・深掘りを対話で確認する
- 全ステージの対話を経て Stage 6b の承認を得るまで、最終出力ファイルを生成しないこと

出力:
- `{project}/docs/interview.md`（ヒアリング記録）
- `{project}/docs/context.md`（なぜ作るか・背景・判断基準）
- `{project}/docs/requirements.md`（何を作るか・仕様）
- `{project}/docs/DESIGN.md`（クリエイティブブリーフ + デザイン方向性ドラフト）
