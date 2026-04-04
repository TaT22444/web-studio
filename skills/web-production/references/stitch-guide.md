# 🎨 Stitch ビジュアル探索ガイド（Claude内部参照用）

> Phase 2-A の実行ガイド。
> Google Stitch（MCP: `user-stitch`）を使い、デザインドラフト前に視覚的な方向性を探索する。
> 成果物は `{project}/docs/references/` へのスクリーンショット保存と `DESIGN.md` v1.5 への追記。

---

## このフェーズの目的

**言葉で合意した方向性を、実際のビジュアルで確認する。**

Phase 1（セットアップ）で DESIGN.md v1 に「世界観」「カラー方向性」「Do's/Don'ts」「設計方向の決定事項」が言語化されている。
しかし、同じ言葉から異なるビジュアルを想像する可能性がある。
Stitch で実際の画面を生成し、ユーザーと AI が **同じ絵を見ながら** 方向性を確定する。

### やること
- **トップページ** のモバイル版・デスクトップ版を生成
- ユーザーと対話しながら方向を調整
- 確定した方向性をスクリーンショットと言語で記録

### やらないこと
- 全ページの完全なデザインを作ること
- Stitch の HTML コードをプロダクションに使うこと
- ピクセルパーフェクトな仕上げ（それは Phase 2-B の仕事）

---

## ワークフロー

### Step 1: ドキュメント読み込み

以下を全て読み込む:
- `{project}/docs/context.md`
- `{project}/docs/requirements.md`
- `{project}/docs/DESIGN.md`（v1）

### Step 2: Stitch プロジェクトの準備

ユーザーに確認する:
```
Stitch で視覚的な方向性を探索します。

1. 既存の Stitch プロジェクトがあれば URL を教えてください
   （例: https://stitch.withgoogle.com/projects/XXXXX）
2. なければ、プロジェクト名を指定してください（新規作成します）
```

**既存プロジェクト:** URL からプロジェクト ID を抽出し、`get_project` で確認する。
**新規作成:** `create_project` で作成する。

### Step 3: プロンプトの構築

DESIGN.md v1 の各セクションから情報を抽出し、Stitch プロンプトに変換する。

#### DESIGN.md → プロンプトのマッピング

| DESIGN.md v1 セクション | プロンプトでの表現 |
|---|---|
| Section 1: クリエイティブブリーフ | ページ全体の目的・コンセプトの説明 |
| Section 2: 雰囲気・世界観 | Vibe を示す形容詞（例: "minimalist, calm luxury, gallery-like"） |
| Section 3: カラー方向性 | 具体的な HEX カラーコード。色の役割も併記 |
| Section 5: タイポグラフィ方向性 | フォントの印象を記述（例: "thin elegant serif for headlines"） |
| Section 6: レイアウト・見せ方 | 余白の量、写真の扱い、レイアウトの特徴 |
| Section 7: Do's and Don'ts | RULES として「やること」「やらないこと」を箇条書き |
| Section 8: 設計方向の決定事項 | セクション構成・表現方針を具体的に記述 |

#### プロンプト構成テンプレート

```
Design a [MOBILE/DESKTOP] landing page for [業種] "[ブランド名]" in [場所].

VIBE: [雰囲気を表す形容詞 3〜5語]

COLORS:
- Page background: [HEX]
- Surface/alternate: [HEX]
- Text primary: [HEX]
- Text secondary: [HEX]
- [その他の色役割: HEX]

TYPOGRAPHY: [フォントの印象を自然言語で記述]

SECTIONS (top to bottom):
1. [セクション名]: [内容とレイアウトの簡潔な記述]
2. [セクション名]: [内容とレイアウトの簡潔な記述]
...

RULES:
- [Do's/Don'ts から抽出した制約]
- [角丸・シャドウ・CTA の扱い等]

Overall: [全体の印象を1文で]
```

#### プロンプト作成の原則（Stitch Prompt Guide より）

1. **簡潔に、1画面に集中**: 1回のプロンプトで1画面を生成する
2. **形容詞で雰囲気を設定**: 色・フォント・写真のトーンに影響する
3. **具体的に**: 「何を」「どう」変えるか明示する
4. **UI用語を使う**: "navigation bar", "hero section", "card layout" 等
5. **長すぎない**: 5000文字を超えると要素が落ちやすい。核心を絞る

### Step 4: 画面の生成

#### 生成順序

1. **モバイル版を先に生成する**（Instagram 等からの流入が多い場合は特に）
2. **デスクトップ版を次に生成する**

#### MCP 呼び出し

```
CallMcpTool:
  server: "user-stitch"
  toolName: "generate_screen_from_text"
  arguments:
    projectId: "{プロジェクトID}"
    deviceType: "MOBILE"  （または "DESKTOP"）
    modelId: "GEMINI_3_1_PRO"
    prompt: "{構築したプロンプト}"
```

⚠ **生成には数分かかる場合がある。リトライしない。**
⚠ **接続エラーでも生成が成功している場合がある。`list_screens` で確認する。**

#### 生成結果の確認

レスポンスの `outputComponents` を確認する:
- `design.screens[].screenshot.downloadUrl` — スクリーンショットの URL
- `design.screens[].id` — 画面ID（編集時に使用）
- `design.screens[].title` — 生成されたタイトル
- `text` — Stitch からのテキスト説明
- `suggestion` — Stitch が提案する次のアクション

### Step 5: ユーザーとの対話・調整

生成結果をユーザーに提示する:
```
Stitch でトップページの [モバイル/デスクトップ] 版を生成しました。
Stitch プロジェクトで確認できます: [URL]

以下の点について、フィードバックをお聞かせください:
- 全体の雰囲気・トーンは合っていますか？
- 色の印象はどうですか？
- 余白の量は多い/少ない/ちょうどよい？
- Hero の構成は好みですか？
- 変えたい部分はありますか？
```

#### 修正が必要な場合

`edit_screens` で対象画面を修正する。**1回の修正は1〜2変更に絞る**（Prompt Guide の推奨）。

```
CallMcpTool:
  server: "user-stitch"
  toolName: "edit_screens"
  arguments:
    projectId: "{プロジェクトID}"
    selectedScreenIds: ["{対象画面のID}"]
    prompt: "{具体的な修正指示}"
```

修正プロンプトの例:
- `"Increase whitespace between sections significantly"`
- `"Make the hero section taller with darker overlay"`
- `"Change the navigation to a more minimal style with wider letter-spacing"`

**NG な修正プロンプト:**
- レイアウト変更 + 色変更 + フォント変更を1回で要求する（壊れやすい）
- 5000文字超の詳細指示（要素が抜け落ちる）

### Step 6: スクリーンショットの保存

方向性が確定したら、スクリーンショットを `docs/references/` に保存する。

生成結果の `screenshot.downloadUrl` からダウンロードする:

```bash
curl -L -o {project}/docs/references/stitch-top-mobile.png "{screenshotUrl}=s0"
curl -L -o {project}/docs/references/stitch-top-desktop.png "{screenshotUrl}=s0"
```

**URL の末尾に `=s0` を付けるとオリジナルサイズで取得できる。**

`docs/references/` フォルダが存在しない場合は作成する。

### Step 7: DESIGN.md の更新（v1 → v1.5）

DESIGN.md v1 の末尾に以下のセクションを追記する。

```markdown

---

## 9. ビジュアル探索の結果（Phase 2-A）

### Stitch プロジェクト
- URL: https://stitch.withgoogle.com/projects/{projectId}

### 選定した方向性
（どの画面を選んだか、何が決め手だったか。ユーザーのフィードバック要約）

### 視覚的な特徴（Phase 2-B への引き継ぎ）
- **Hero の構成:** （例: 暗い店内写真全面、白文字オーバーレイ、店名のみ）
- **色の実際の印象:** （例: #F8F7F4 は画面上で十分温かみがあった）
- **タイポグラフィの質感:** （例: 細い明朝体が世界観に合っていた。Inter のラベルも馴染む）
- **余白の量:** （例: Stitch 出力の余白量がちょうどよい / もう少し増やしたい）
- **セクション間のリズム:** （例: 背景色の切替でリズムが出ていた）
- **全体の印象:** （例: ギャラリーのような静けさが出ていた）
- **改善点（Phase 2-B で対応）:** （例: Concept のフォントサイズをもう少し大きく）

### 参考スクリーンショット

| ファイルパス | 内容 |
|---|---|
| docs/references/stitch-top-mobile.png | トップページ モバイル版 |
| docs/references/stitch-top-desktop.png | トップページ デスクトップ版 |
```

ステータスを `方向性ドラフト（v1.5 — ビジュアル探索済み）` に更新する。

---

## Stitch のフォントマッピング

DESIGN.md v1 のタイポグラフィ方向性から、Stitch で利用可能なフォントにマッピングする。

| 方向性キーワード | Stitch フォント候補 |
|---|---|
| 高級・上品・セリフ | `NOTO_SERIF`, `EB_GARAMOND`, `LIBRE_CASLON_TEXT`, `NEWSREADER`, `LITERATA` |
| モダン・クリーン・サンセリフ | `INTER`, `DM_SANS`, `GEIST`, `HANKEN_GROTESK`, `IBM_PLEX_SANS` |
| 温かみ・親しみやすさ | `NUNITO_SANS`, `WORK_SANS`, `RUBIK`, `PLUS_JAKARTA_SANS` |
| シャープ・テック | `SPACE_GROTESK`, `SORA`, `MANROPE` |
| クラシック・伝統的 | `SOURCE_SERIF_FOUR`, `DOMINE`, `EB_GARAMOND` |
| 日本語サイト（和のテイスト） | `NOTO_SERIF`（Mincho 系の代替）, `EB_GARAMOND`（Cormorant 系の代替） |

⚠ Stitch は Cormorant Garamond / Shippori Mincho 等の Google Fonts を直接指定できない。
プロンプトのテキストで「thin elegant serif like Cormorant Garamond」と記述し、
Stitch のフォントプリセットからは最も近いものを選ぶ。
最終的なフォント選択は Phase 2-B で正確に行う。

---

## Stitch のテーマオプション

プロンプトだけでなく、`generate_screen_from_text` のテーマ関連引数でも方向性を制御できる。
ただし、現時点ではプロンプトに情報を含める方が安定しており、テーマ引数は補助的に使う。

### colorMode
- `LIGHT` — ライトモード（多くのサイト）
- `DARK` — ダークモード

### colorVariant
- `MONOCHROME` — モノクロ（ミニマル・洗練系に最適）
- `NEUTRAL` — ニュートラル（温かみのあるナチュラル系に）
- `TONAL_SPOT` — トーナルスポット（標準的なMaterial配色）

### roundness
- `ROUND_FOUR` — 角丸 4px（ミニマル）
- `ROUND_EIGHT` — 角丸 8px（標準）
- `ROUND_TWELVE` — 角丸 12px（やわらかい）
- `ROUND_FULL` — 完全な丸

### spacingScale
- `0` — 最小
- `1` — コンパクト
- `2` — 標準
- `3` — ゆったり（余白重視のデザインに）

---

## 完了条件

以下が全て満たされたら Phase 2-A は完了:

- [ ] モバイル版・デスクトップ版のトップページが生成済み
- [ ] ユーザーが方向性を承認済み
- [ ] スクリーンショットが `docs/references/` に保存済み
- [ ] DESIGN.md が v1.5 に更新済み

完了後、チャットに以下を表示する:
```
✅ ビジュアル探索完了

Stitch で視覚的な方向性を確認しました。
- docs/references/stitch-top-mobile.png
- docs/references/stitch-top-desktop.png
- docs/DESIGN.md（v1.5 に更新）

「デザインドラフトに進んで」と伝えてください。
Phase 2-B でこの方向性をベースにデザインを作成します。
```
