---
name: init
description: web-studio プラグインのスキル・エージェントをプロジェクトの .claude/ にコピーして展開する。プロジェクトごとにカスタマイズしたいときに使う。
disable-model-invocation: true
---

# web-studio init

プロジェクトの `.claude/` にプラグインのファイルを展開します。
展開後はそのプロジェクト内のファイルを直接編集してカスタマイズできます。

以下の Bash コマンドを実行してください：

```bash
SKILL_DIR="${CLAUDE_SKILL_DIR}"
PLUGIN_ROOT="$(dirname "$(dirname "$SKILL_DIR")")"
PROJECT_CLAUDE=".claude"

# ディレクトリ作成
mkdir -p "$PROJECT_CLAUDE/skills/web-production/references"
mkdir -p "$PROJECT_CLAUDE/agents"

# スキルをコピー
cp "$PLUGIN_ROOT/skills/web-production/SKILL.md" "$PROJECT_CLAUDE/skills/web-production/SKILL.md"
cp "$PLUGIN_ROOT/skills/web-production/references/requirements.md" "$PROJECT_CLAUDE/skills/web-production/references/requirements.md"
cp "$PLUGIN_ROOT/skills/web-production/references/figma-rules.md" "$PROJECT_CLAUDE/skills/web-production/references/figma-rules.md"
cp "$PLUGIN_ROOT/skills/web-production/references/production-rules.md" "$PROJECT_CLAUDE/skills/web-production/references/production-rules.md"

# エージェントをコピー
cp "$PLUGIN_ROOT/agents/director.md" "$PROJECT_CLAUDE/agents/director.md"
cp "$PLUGIN_ROOT/agents/designer.md" "$PROJECT_CLAUDE/agents/designer.md"
cp "$PLUGIN_ROOT/agents/engineer.md" "$PROJECT_CLAUDE/agents/engineer.md"

echo "✅ .claude/ に展開完了。自由にカスタマイズしてください。"
```

実行後、`.claude/` 以下のファイルを編集することでこのプロジェクト専用の設定にカスタマイズできます。
プラグイン本体には影響しません。
