# 凡例: [カードタイプ, 消滅カードか否か, ドロー枚数]
# ドロー枚数の扱いが悩ましいカードについては★でコメントを入れてある。

$cards = {

  # ==========================================================
  # Ironcrad
  # ==========================================================

  # ----------------------------------------------------------
  # アタック
  # ----------------------------------------------------------
  "Strike_R"=>              ["Attack", false, 0], # ストライク
  "Strike_R+"=>             ["Attack", false, 0], # 
  "Bash"=>                  ["Attack", false, 0], # 強打
  "Bash+"=>                 ["Attack", false, 0], # 
  "Anger"=>                 ["Attack", false, 0], # 怒り
  "Anger+"=>                ["Attack", false, 0], #
  "BodySlam"=>              ["Attack", false, 0], # ボディスラム
  "BodySlam+"=>             ["Attack", false, 0], #
  "Clash"=>                 ["Attack", false, 0], # クラッシュ
  "Clash+"=>                ["Attack", false, 0], #
  "Cleave"=>                ["Attack", false, 0], # なぎ払い
  "Cleave+"=>               ["Attack", false, 0], #
  "Clothesline"=>           ["Attack", false, 0], # ラリアット
  "Clothesline+"=>          ["Attack", false, 0], #
  "Headbutt"=>              ["Attack", false, 0], # ヘッドバット
  "Headbutt+"=>             ["Attack", false, 0], #
  "HeavyBlade"=>            ["Attack", false, 0], # ヘビーブレード
  "HeavyBlade+"=>           ["Attack", false, 0], #
  "IronWave"=>              ["Attack", false, 0], # アイアンウェーブ
  "IronWave+"=>             ["Attack", false, 0], #
  "PerfectedStrike"=>       ["Attack", false, 0], # パーフェクトストライク
  "PerfectedStrike+"=>      ["Attack", false, 0], #
  "PommelStrike"=>          ["Attack", false, 1], # ポンメルストライク
  "PommelStrike+"=>         ["Attack", false, 2], #
  "SwordBoomerang"=>        ["Attack", false, 0], # ソードブーメラン
  "SwordBoomerang+"=>       ["Attack", false, 0], #
  "Thunderclap"=>           ["Attack", false, 0], # サンダークラップ
  "Thunderclap+"=>          ["Attack", false, 0], #
  "TwinStrike"=>            ["Attack", false, 0], # ツインストライク
  "TwinStrike+"=>           ["Attack", false, 0], #
  "WildStrike"=>            ["Attack", false, 0], # ワイルドストライク
  "WildStrike+"=>           ["Attack", false, 0], #
  "BloodforBlood"=>         ["Attack", false, 0], # 血には血を
  "BloodforBlood+"=>        ["Attack", false, 0], #
  "Carnage"=>               ["Attack", true,  0], # 大虐殺
  "Carnage+"=>              ["Attack", true,  0], #
  "Dropkick"=>              ["Attack", false, 1], # ドロップキック
  "Dropkick+"=>             ["Attack", false, 1], #
  "Hemokinesis"=>           ["Attack", false, 0], # ヘモキネシス
  "Hemokinesis+"=>          ["Attack", false, 0], #
  "Pummel"=>                ["Attack", true,  0], # 猛撃
  "Pummel+"=>               ["Attack", true,  0], #
  "Rampage"=>               ["Attack", false, 0], # ランページ
  "Rampage+"=>              ["Attack", false, 0], #
  "RecklessCharge"=>        ["Attack", false, 0], # 無謀なる突進
  "RecklessCharge+"=>       ["Attack", false, 0], #
  "SearingBlow"=>           ["Attack", false, 0], # 灼熱の一撃
  "SearingBlow+"=>          ["Attack", false, 0], #
  "SeverSoul"=>             ["Attack", false, 0], # 霊魂切断
  "SeverSoul+"=>            ["Attack", false, 0], #
  "Uppercut"=>              ["Attack", false, 0], # アッパーカット
  "Uppercut+"=>             ["Attack", false, 0], #
  "Whirlwind"=>             ["Attack", false, 0], # 旋風刃
  "Whirlwind+"=>            ["Attack", false, 0], #
  "Bludgeon"=>              ["Attack", false, 0], # 脳天割り
  "Bludgeon+"=>             ["Attack", false, 0], #
  "Feed"=>                  ["Attack", false, 0], # 焼身
  "Feed+"=>                 ["Attack", false, 0], #
  "FiendFire"=>             ["Attack", true,  0], # 鬼火
  "FiendFire+"=>            ["Attack", true,  0], #
  "Immolate"=>              ["Attack", true,  0], # 捕食
  "Immolate+"=>             ["Attack", true,  0], #
  "Reaper"=>                ["Attack", true,  0], # 死神
  "Reaper+"=>               ["Attack", true,  0], #

  # ----------------------------------------------------------
  # スキル
  # ----------------------------------------------------------
  "Defend_R"=>              ["Skill",  false, 0], # 防御
  "Defend_R+"=>             ["Skill",  false, 0], #
  "Armaments"=>             ["Skill",  false, 0], # 武装
  "Armaments+"=>            ["Skill",  false, 0], #
  "Flex"=>                  ["Skill",  false, 0], # フレックス
  "Flex+"=>                 ["Skill",  false, 0], #
  "Havoc"=>                 ["Skill",  false, 0], # 荒廃(★割り切り: これはドロー扱いとしないのが自然な気がする)
  "Havoc+"=>                ["Skill",  false, 0], #
  "ShrugItOff"=>            ["Skill",  false, 1], # 受け流し
  "ShrugItOff+"=>           ["Skill",  false, 1], #
  "TrueGrit"=>              ["Skill",  false, 0], # 不屈の闘志
  "TrueGrit+"=>             ["Skill",  false, 0], #
  "Warcry"=>                ["Skill",  true,  1], # 雄叫び
  "Warcry+"=>               ["Skill",  true,  2], #
  "BattleTrance"=>          ["Skill",  false, 3], # バトルトランス
  "BattleTrance+"=>         ["Skill",  false, 4], #
  "Bloodletting"=>          ["Skill",  false, 0], # 瀉血
  "Bloodletting+"=>         ["Skill",  false, 0], #
  "BurningPact"=>           ["Skill",  false, 2], # 焦熱の契約
  "BurningPact+"=>          ["Skill",  false, 3], #
  "Disarm"=>                ["Skill",  true,  0], # 武装解除
  "Disarm+"=>               ["Skill",  true,  0], #
  "DualWield"=>             ["Skill",  false, 0], # 二刀流
  "DualWield+"=>            ["Skill",  false, 0], #
  "Entrench"=>              ["Skill",  false, 0], # 塹壕
  "Entrench+"=>             ["Skill",  false, 0], #
  "FlameBarrier"=>          ["Skill",  false, 0], # 炎の障壁
  "FlameBarrier+"=>         ["Skill",  false, 0], #
  "GhostlyArmor"=>          ["Skill",  true,  0], # ゴーストアーマー
  "GhostlyArmor+"=>         ["Skill",  true,  0], #
  "InfernalBlade"=>         ["Skill",  true,  0], # 非道の刃
  "InfernalBlade+"=>        ["Skill",  true,  0], #
  "Intimidate"=>            ["Skill",  false, 0], # 威嚇
  "Intimidate+"=>           ["Skill",  false, 0], #
  "PowerThrough"=>          ["Skill",  false, 0], # やせ我慢
  "PowerThrough+"=>         ["Skill",  false, 0], #
  "Rage"=>                  ["Skill",  false, 0], # 激怒
  "Rage+"=>                 ["Skill",  false, 0], #
  "SecondWind"=>            ["Skill",  false, 0], # セカンドウィンド
  "SecondWind+"=>           ["Skill",  false, 0], #
  "SeeingRed"=>             ["Skill",  true,  0], # 激昂
  "SeeingRed+"=>            ["Skill",  true,  0], #
  "Sentinel"=>              ["Skill",  false, 0], # 見張り
  "Sentinel+"=>             ["Skill",  false, 0], #
  "Shockwave"=>             ["Skill",  true,  0], # 衝撃波
  "Shockwave+"=>            ["Skill",  true,  0], #
  "SpotWeakness"=>          ["Skill",  false, 0], # 弱点発見
  "SpotWeakness+"=>         ["Skill",  false, 0], #
  "DoubleTap"=>             ["Skill",  false, 0], # ダブルタップ
  "DoubleTap+"=>            ["Skill",  false, 0], #
  "Exhume"=>                ["Skill",  true,  0], # 発掘
  "Exhume+"=>               ["Skill",  true,  0], #
  "Impervious"=>            ["Skill",  true,  0], # 不動
  "Impervious+"=>           ["Skill",  true,  0], #
  "LimitBreak"=>            ["Skill",  true,  0], # リミットブレイク
  "LimitBreak+"=>           ["Skill",  false, 0], #
  "Offering"=>              ["Skill",  true,  3], # 供物
  "Offering+"=>             ["Skill",  true,  5], #

  # ----------------------------------------------------------
  # パワー
  # ----------------------------------------------------------
  "Combust"=>               ["Power",  true,  0], # 燃焼
  "Combust+"=>              ["Power",  true,  0], #
  "DarkEmbrace"=>           ["Power",  true,  0], # 闇の抱擁 (★割り切り)
  "DarkEmbrace+"=>          ["Power",  true,  0], #
  "Evolve"=>                ["Power",  true,  0], # 進化
  "Evolve+"=>               ["Power",  true,  0], #
  "FeelNoPain"=>            ["Power",  true,  0], # 無痛
  "FeelNoPain+"=>           ["Power",  true,  0], #
  "FireBreathing"=>         ["Power",  true,  0], # 炎の吐息
  "FireBreathing+"=>        ["Power",  true,  0], #
  "Inflame"=>               ["Power",  true,  0], # 発火
  "Inflame+"=>              ["Power",  true,  0], #
  "Metallicize"=>           ["Power",  true,  0], # 金属化
  "Metallicize+"=>          ["Power",  true,  0], #
  "Rupture"=>               ["Power",  true,  0], # 破裂
  "Rupture+"=>              ["Power",  true,  0], #
  "Barricade"=>             ["Power",  true,  0], # バリケード
  "Barricade+"=>            ["Power",  true,  0], #
  "Berserk"=>               ["Power",  true,  0], # 狂戦士
  "Berserk+"=>              ["Power",  true,  0], #
  "Brutality"=>             ["Power",  true,  2], # 残虐 (★割り切り: ドロー枚数は1だがカードを使わずに1ドローしているので実質2ドロー分の価値とする)
  "Brutality+"=>            ["Power",  true,  2], #
  "Corruption"=>            ["Power",  true,  0], # 堕落
  "Corruption+"=>           ["Power",  true,  0], #
  "DemonForm"=>             ["Power",  true,  0], # 悪魔化
  "DemonForm+"=>            ["Power",  true,  0], #
  "Juggernaut"=>            ["Power",  true,  0], # ジャガーノート
  "Juggernaut+"=>           ["Power",  true,  0], #

  # ==========================================================
  # Silent
  # ==========================================================

  # ----------------------------------------------------------
  # アタック
  # ----------------------------------------------------------
  "Neutralize"=>            ["Attack", false, 0], # 無力化
  "Neutralize+"=>           ["Attack", false, 0], #
  "Strike_G"=>              ["Attack", false, 0], # ストライク
  "Strike_G+"=>             ["Attack", false, 0], #
  "Bane"=>                  ["Attack", false, 0], # 破滅
  "Bane+"=>                 ["Attack", false, 0], #
  "DaggerSpray"=>           ["Attack", false, 0], # 五月雨ダガー
  "DaggerSpray+"=>          ["Attack", false, 0], #
  "DaggerThrow"=>           ["Attack", false, 0], # ダガースロー
  "DaggerThrow+"=>          ["Attack", false, 0], #
  "FlyingKnee"=>            ["Attack", false, 0], # 飛び膝蹴り
  "FlyingKnee+"=>           ["Attack", false, 0], #
  "PoisonedStab"=>          ["Attack", false, 0], # 毒の一刺し
  "PoisonedStab+"=>         ["Attack", false, 0], #
  "QuickSlash"=>            ["Attack", false, 1], # はやぶさ斬り
  "QuickSlash+"=>           ["Attack", false, 1], #
  "Slice"=>                 ["Attack", false, 0], # スライス
  "Slice+"=>                ["Attack", false, 0], #
  "UnderhandedStrike"=>     ["Attack", false, 0], # スニーキーストライク
  "UnderhandedStrike+"=>    ["Attack", false, 0], #
  "SuckerPunch"=>           ["Attack", false, 0], # 不意打ち
  "SuckerPunch+"=>          ["Attack", false, 0], #
  "AllOutAttack"=>          ["Attack", false, 0], # フルアタック
  "AllOutAttack+"=>         ["Attack", false, 0], #
  "Backstab"=>              ["Attack", true,  0], # 騙し討ち
  "Backstab+"=>             ["Attack", true,  0], #
  "Choke"=>                 ["Attack", false, 0], # 窒息
  "Choke+"=>                ["Attack", false, 0], #
  "Dash"=>                  ["Attack", false, 0], # ダッシュ
  "Dash+"=>                 ["Attack", false, 0], #
  "EndlessAgony"=>          ["Attack", true,  0], # 終わりなき苦痛
  "EndlessAgony+"=>         ["Attack", true,  0], #
  "Eviscerate"=>            ["Attack", false, 0], # 腹裂き
  "Eviscerate+"=>           ["Attack", false, 0], #
  "Finisher"=>              ["Attack", false, 0], # とどめの一撃
  "Finisher+"=>             ["Attack", false, 0], #
  "Flechettes"=>            ["Attack", false, 0], # フレシェット
  "Flechettes+"=>           ["Attack", false, 0], #
  "HeelHook"=>              ["Attack", false, 1], # ヒールフック
  "HeelHook+"=>             ["Attack", false, 1], #
  "MasterfulStab"=>         ["Attack", false, 0], # 一撃必殺
  "MasterfulStab+"=>        ["Attack", false, 0], #
  "Predator"=>              ["Attack", false, 2], # 略奪
  "Predator+"=>             ["Attack", false, 2], #
  "RiddleWithHoles"=>       ["Attack", false, 0], # ハチの巣
  "RiddleWithHoles+"=>      ["Attack", false, 0], #
  "Skewer"=>                ["Attack", false, 0], # 串刺し
  "Skewer+"=>               ["Attack", false, 0], #
  "DieDieDie"=>             ["Attack", true,  0], # ダイダイダイ
  "DieDieDie+"=>            ["Attack", true,  0], #
  "GlassKnife"=>            ["Attack", false, 0], # ガラスのナイフ
  "GlassKnife+"=>           ["Attack", false, 0], #
  "GrandFinale"=>           ["Attack", false, 0], # グランドフィナーレ
  "GrandFinale+"=>          ["Attack", false, 0], #
  "Unload"=>                ["Attack", false, 0], # アンロード
  "Unload+"=>               ["Attack", false, 0], #

  # ----------------------------------------------------------
  # スキル
  # ----------------------------------------------------------
  "Defend_G"=>              ["Skill",  false, 0], # 防御
  "Defend_G+"=>             ["Skill",  false, 0], #
  "Survivor"=>              ["Skill",  false, 0], # サバイバー
  "Survivor+"=>             ["Skill",  false, 0], #
  "Acrobatics"=>            ["Skill",  false, 3], # アクロバット
  "Acrobatics+"=>           ["Skill",  false, 4], #
  "Backflip"=>              ["Skill",  false, 2], # バックフリップ
  "Backflip+"=>             ["Skill",  false, 2], #
  "BladeDance"=>            ["Skill",  false, 0], # 剣の舞
  "BladeDance+"=>           ["Skill",  false, 0], #
  "CloakAndDagger"=>        ["Skill",  false, 0], # 外套と短剣
  "CloakAndDagger+"=>       ["Skill",  false, 0], #
  "DeadlyPoison"=>          ["Skill",  true,  0], # 劇毒
  "DeadlyPoison+"=>         ["Skill",  true,  0], #
  "Deflect"=>               ["Skill",  false, 0], # ディフレクト
  "Deflect+"=>              ["Skill",  false, 0], #
  "DodgeandRoll"=>          ["Skill",  false, 0], # ドッジロール
  "DodgeandRoll+"=>         ["Skill",  false, 0], #
  "Outmaneuver"=>           ["Skill",  false, 0], # 先読み
  "Outmaneuver+"=>          ["Skill",  false, 0], #
  "PiercingWail"=>          ["Skill",  true,  0], # 金切り声
  "PiercingWail+"=>         ["Skill",  true,  0], #
  "Prepared"=>              ["Skill",  false, 1], # 準備
  "Prepared+"=>             ["Skill",  false, 2], #
  "Blur"=>                  ["Skill",  false, 0], # ブラー
  "Blur+"=>                 ["Skill",  false, 0], #
  "BouncingFlask"=>         ["Skill",  false, 0], # バウンドフラスコ
  "BouncingFlask+"=>        ["Skill",  false, 0], #
  "CalculatedGamble"=>      ["Skill",  true,  3], # イカサマ (★割り切り: 体感平均3ドローくらいかな…と)
  "CalculatedGamble+"=>     ["Skill",  false, 3], #
  "Catalyst"=>              ["Skill",  true,  0], # 触媒
  "Catalyst+"=>             ["Skill",  true,  0], #
  "Concentrate"=>           ["Skill",  false, 0], # 集中
  "Concentrate+"=>          ["Skill",  false, 0], #
  "CripplingPoison"=>       ["Skill",  true,  0], # 劇毒
  "CripplingPoison+"=>      ["Skill",  true,  0], #
  "Distraction"=>           ["Skill",  true,  0], # 動揺
  "Distraction+"=>          ["Skill",  true,  0], #
  "EscapePlan"=>            ["Skill",  false, 0], # 脱出計画
  "EscapePlan+"=>           ["Skill",  false, 0], #
  "Expertise"=>             ["Skill",  false, 3], # 職人技 (★割り切り: 体感平均3ドローくらい？)
  "Expertise+"=>            ["Skill",  false, 4], #
  "LegSweep"=>              ["Skill",  false, 0], # 足払い
  "LegSweep+"=>             ["Skill",  false, 0], #
  "Reflex"=>                ["Skill",  false, 2], # 反射
  "Reflex+"=>               ["Skill",  false, 3], #
  "Setup"=>                 ["Skill",  false, 0], # セットアップ
  "Setup+"=>                ["Skill",  false, 0], #
  "Tactician"=>             ["Skill",  false, 0], # 策士
  "Tactician+"=>            ["Skill",  false, 0], #
  "Terror"=>                ["Skill",  true,  0], # 恐怖
  "Terror+"=>               ["Skill",  true,  0], #
  "Adrenaline"=>            ["Skill",  true,  2], # アドレナリン
  "Adrenaline+"=>           ["Skill",  true,  2], #
  "Venomology"=>            ["Skill",  true,  0], # 錬金術
  "Venomology+"=>           ["Skill",  true,  0], #
  "BulletTime"=>            ["Skill",  false, 0], # バレットタイム
  "BulletTime+"=>           ["Skill",  false, 0], #
  "Burst"=>                 ["Skill",  false, 0], # バースト
  "Burst+"=>                ["Skill",  false, 0], #
  "CorpseExplosion"=>       ["Skill",  false, 0], # 死体爆破
  "CorpseExplosion+"=>      ["Skill",  false, 0], #
  "Doppelganger"=>          ["Skill",  true,  0], # ドッペルゲンガー
  "Doppelganger+"=>         ["Skill",  true,  0], #
  "Malaise"=>               ["Skill",  true,  0], # 不快感
  "Malaise+"=>              ["Skill",  true,  0], #
  "NightTerror"=>           ["Skill",  true,  0], # 悪夢
  "NightTerror+"=>          ["Skill",  true,  0], #
  "PhantasmalKiller"=>      ["Skill",  false, 0], # 幻影の暗殺者
  "PhantasmalKiller+"=>     ["Skill",  false, 0], #
  "StormofSteel"=>          ["Skill",  false, 0], # 鋼の嵐
  "StormofSteel+"=>         ["Skill",  false, 0], #

  # ----------------------------------------------------------
  # パワー
  # ----------------------------------------------------------
  "Accuracy"=>              ["Power",  true,  0], # 精度上昇
  "Accuracy+"=>             ["Power",  true,  0], #
  "Caltrops"=>              ["Power",  true,  0], # まきびし
  "Caltrops+"=>             ["Power",  true,  0], #
  "Footwork"=>              ["Power",  true,  0], # フットワーク
  "Footwork+"=>             ["Power",  true,  0], #
  "InfiniteBlades"=>        ["Power",  true,  0], # 無限の刃
  "InfiniteBlades+"=>       ["Power",  true,  0], #
  "NoxiousFumes"=>          ["Power",  true,  0], # 有毒ガス
  "NoxiousFumes+"=>         ["Power",  true,  0], #
  "WellLaidPlans"=>         ["Power",  true,  1], # 用意周到
  "WellLaidPlans+"=>        ["Power",  true,  2], #
  "AThousandCuts"=>         ["Power",  true,  0], # メッタ切り
  "AThousandCuts+"=>        ["Power",  true,  0], #
  "AfterImage"=>            ["Power",  true,  0], # 残像
  "AfterImage+"=>           ["Power",  true,  0], #
  "Envenom"=>               ["Power",  true,  0], # 猛毒の仕込み
  "Envenom+"=>              ["Power",  true,  0], #
  "ToolsoftheTrade"=>       ["Power",  true,  2], # 商売道具 (★割り切り: ドロー枚数は1だがカードを使わずに1ドローしているので実質2ドロー分の価値とする)
  "ToolsoftheTrade+"=>      ["Power",  true,  2], #
  "WraithFormv2"=>          ["Power",  true,  0], # 死霊化
  "WraithFormv2+"=>         ["Power",  true,  0], #

  # ==========================================================
  # Defect
  # ==========================================================

  # ----------------------------------------------------------
  # アタック
  # ----------------------------------------------------------
  "Strike_B"=>              ["Attack", false, 0], # ストライク
  "Strike_B+"=>             ["Attack", false, 0], #
  "BallLightning"=>         ["Attack", false, 0], # ボールライトニング
  "BallLightning+"=>        ["Attack", false, 0], #
  "Barrage"=>               ["Attack", false, 0], # 集中砲火
  "Barrage+"=>              ["Attack", false, 0], #
  "BeamCell"=>              ["Attack", false, 0], # ビームセル
  "BeamCell+"=>             ["Attack", false, 0], #
  "Gash"=>                  ["Attack", false, 0], # 爪
  "Gash+"=>                 ["Attack", false, 0], #
  "ColdSnap"=>              ["Attack", false, 0], # 寒波
  "ColdSnap+"=>             ["Attack", false, 0], #
  "CompileDriver"=>         ["Attack", false, 2], # コンパイルドライバ (★割り切り: 初動はさておきオーブを出した後は平均2ドローくらい)
  "CompileDriver+"=>        ["Attack", false, 2], #
  "GofortheEyes"=>          ["Attack", false, 0], # 目潰し
  "GofortheEyes+"=>         ["Attack", false, 0], #
  "Rebound"=>               ["Attack", false, 0], # リバウンド
  "Rebound+"=>              ["Attack", false, 0], #
  "Streamline"=>            ["Attack", false, 0], # 効率化
  "Streamline+"=>           ["Attack", false, 0], #
  "SweepingBeam"=>          ["Attack", false, 1], # ビーム一掃
  "SweepingBeam+"=>         ["Attack", false, 1], #
  "Blizzard"=>              ["Attack", false, 0], # ブリザード
  "Blizzard+"=>             ["Attack", false, 0], #
  "Lockon"=>                ["Attack", false, 0], # ブルズアイ
  "Lockon+"=>               ["Attack", false, 0], #
  "DoomandGloom"=>          ["Attack", false, 0], # 自暴自棄
  "DoomandGloom+"=>         ["Attack", false, 0], #
  "FTL"=>                   ["Attack", false, 0], # FTL
  "FTL+"=>                  ["Attack", false, 0], #
  "Melter"=>                ["Attack", false, 0], # 溶解炉
  "Melter+"=>               ["Attack", false, 0], #
  "RipandTear"=>            ["Attack", false, 0], # 狂奔
  "RipandTear+"=>           ["Attack", false, 0], #
  "Scrape"=>                ["Attack", false, 0], # スクレイプ
  "Scrape+"=>               ["Attack", false, 0], #
  "Sunder"=>                ["Attack", false, 0], # 切断
  "Sunder+"=>               ["Attack", false, 0], #
  "AllForOne"=>             ["Attack", false, 0], # オールフォーワン
  "AllForOne+"=>            ["Attack", false, 0], #
  "CoreSurge"=>             ["Attack", true,  0], # コアサージ
  "CoreSurge+"=>            ["Attack", true,  0], #
  "Hyperbeam"=>             ["Attack", false, 0], # ハイパービーム
  "Hyperbeam+"=>            ["Attack", false, 0], #
  "MeteorStrike"=>          ["Attack", false, 0], # メテオストライク
  "MeteorStrike+"=>         ["Attack", false, 0], #
  "ThunderStrike"=>         ["Attack", false, 0], # サンダーストライク
  "ThunderStrike+"=>        ["Attack", false, 0], #

  # ----------------------------------------------------------
  # スキル
  # ----------------------------------------------------------
  "Defend_B"=>              ["Skill",  false, 0], # 防御
  "Defend_B+"=>             ["Skill",  false, 0], #
  "Dualcast"=>              ["Skill",  false, 0], # デュアルキャスト
  "Dualcast+"=>             ["Skill",  false, 0], #
  "Zap"=>                   ["Skill",  false, 0], # ザップ
  "Zap+"=>                  ["Skill",  false, 0], #
  "ConserveBattery"=>       ["Skill",  false, 0], # 充電
  "ConserveBattery+"=>      ["Skill",  false, 0], #
  "Coolheaded"=>            ["Skill",  false, 1], # 冷静沈着
  "Coolheaded+"=>           ["Skill",  false, 2], #
  "Hologram"=>              ["Skill",  true,  1], # ホログラム
  "Hologram+"=>             ["Skill",  false, 1], #
  "Leap"=>                  ["Skill",  false, 0], # 跳躍
  "Leap+"=>                 ["Skill",  false, 0], #
  "Redo"=>                  ["Skill",  false, 0], # 再帰
  "Redo+"=>                 ["Skill",  false, 0], #
  "Stack"=>                 ["Skill",  false, 0], # スタック
  "Stack+"=>                ["Skill",  false, 0], #
  "Steam"=>                 ["Skill",  false, 0], # スチームバリア
  "Steam+"=>                ["Skill",  false, 0], #
  "Turbo"=>                 ["Skill",  false, 0], # 加速
  "Turbo+"=>                ["Skill",  false, 0], #
  "Aggregate"=>             ["Skill",  false, 0], # 集計
  "Aggregate+"=>            ["Skill",  false, 0], #
  "AutoShields"=>           ["Skill",  false, 0], # 自動防御盾
  "AutoShields+"=>          ["Skill",  false, 0], #
  "BootSequence"=>          ["Skill",  true,  0], # 起動シーケンス
  "BootSequence+"=>         ["Skill",  true,  0], #
  "Chaos"=>                 ["Skill",  false, 0], # 混沌
  "Chaos+"=>                ["Skill",  false, 0], #
  "Chill"=>                 ["Skill",  true,  0], # 寒気
  "Chill+"=>                ["Skill",  true,  0], #
  "Consume"=>               ["Skill",  false, 0], # 消尽
  "Consume+"=>              ["Skill",  false, 0], #
  "Darkness"=>              ["Skill",  false, 0], # 暗黒
  "Darkness+"=>             ["Skill",  false, 0], #
  "DoubleEnergy"=>          ["Skill",  true,  0], # ダブルエナジー
  "DoubleEnergy+"=>         ["Skill",  true,  0], #
  "Undo"=>                  ["Skill",  false, 2], # 均衡 (★割り切り: 平均2枚保留されて、かつ保留はドローと等価と考えたい…と言いつつウォッチャーの保留は別、一貫性がないが)
  "Undo+"=>                 ["Skill",  false, 2], #
  "ForceField"=>            ["Skill",  false, 0], # フォースフィールド
  "ForceField+"=>           ["Skill",  false, 0], #
  "Fusion"=>                ["Skill",  false, 0], # 融合
  "Fusion+"=>               ["Skill",  false, 0], #
  "GeneticAlgorithm"=>      ["Skill",  true,  0], # 遺伝的アルゴリズム
  "GeneticAlgorithm+"=>     ["Skill",  true,  0], #
  "Glacier"=>               ["Skill",  false, 0], # 氷河
  "Glacier+"=>              ["Skill",  false, 0], #
  "SteamPower"=>            ["Skill",  false, 2], # オーバークロック
  "SteamPower+"=>           ["Skill",  false, 3], #
  "Recycle"=>               ["Skill",  false, 0], # リサイクル
  "Recycle+"=>              ["Skill",  false, 0], #
  "ReinforcedBody"=>        ["Skill",  false, 0], # 強化ボディ
  "ReinforcedBody+"=>       ["Skill",  false, 0], #
  "Reprogram"=>             ["Skill",  false, 0], # 再構成
  "Reprogram+"=>            ["Skill",  false, 0], #
  "Skim"=>                  ["Skill",  false, 3], # スキム
  "Skim+"=>                 ["Skill",  false, 4], #
  "Tempest"=>               ["Skill",  false, 0], # テンペスト
  "Tempest+"=>              ["Skill",  false, 0], #
  "WhiteNoise"=>            ["Skill",  true,  0], # ホワイトノイズ
  "WhiteNoise+"=>           ["Skill",  true,  0], #
  "Amplify"=>               ["Skill",  false, 0], # 増幅
  "Amplify+"=>              ["Skill",  false, 0], #
  "Fission"=>               ["Skill",  true,  2], # 核分裂 (★割り切り: 1か2か迷ってが2とした)
  "Fission+"=>              ["Skill",  true,  2], #
  "Multi-Cast"=>            ["Skill",  false, 0], # マルチキャスト
  "Multi-Cast+"=>           ["Skill",  false, 0], #
  "Rainbow"=>               ["Skill",  false, 0], # レインボー
  "Rainbow+"=>              ["Skill",  false, 0], #
  "Reboot"=>                ["Skill",  true,  0], # 再起動
  "Reboot+"=>               ["Skill",  true,  0], #
  "Seek"=>                  ["Skill",  true,  1], # 検索
  "Seek+"=>                 ["Skill",  true,  2], #

  # ----------------------------------------------------------
  # パワー
  # ----------------------------------------------------------
  "Capacitor"=>             ["Power",  true,  0], # コンデンサ
  "Capacitor+"=>            ["Power",  true,  0], #
  "Defragment"=>            ["Power",  true,  0], # デフラグ
  "Defragment+"=>           ["Power",  true,  0], #
  "Heatsinks"=>             ["Power",  true,  0], # ヒートシンク
  "Heatsinks+"=>            ["Power",  true,  0], #
  "HelloWorld"=>            ["Power",  true,  0], # ハローワールド
  "HelloWorld+"=>           ["Power",  true,  0], #
  "Loop"=>                  ["Power",  true,  0], # ループ
  "Loop+"=>                 ["Power",  true,  0], #
  "SelfRepair"=>            ["Power",  true,  0], # 自己修復
  "SelfRepair+"=>           ["Power",  true,  0], #
  "StaticDischarge"=>       ["Power",  true,  0], # 静電放電
  "StaticDischarge+"=>      ["Power",  true,  0], #
  "Storm"=>                 ["Power",  true,  0], # ストーム
  "Storm+"=>                ["Power",  true,  0], #
  "BiasedCognition"=>       ["Power",  true,  0], # 認知偏向
  "BiasedCognition+"=>      ["Power",  true,  0], #
  "Buffer"=>                ["Power",  true,  0], # バッファー
  "Buffer+"=>               ["Power",  true,  0], #
  "CreativeAI"=>            ["Power",  true,  0], # クリエイティブAI
  "CreativeAI+"=>           ["Power",  true,  0], #
  "EchoForm"=>              ["Power",  true,  0], # 反響化
  "EchoForm+"=>             ["Power",  true,  0], #
  "Electrodynamics"=>       ["Power",  true,  0], # 電気力学
  "Electrodynamics+"=>      ["Power",  true,  0], #
  "MachineLearning"=>       ["Power",  true,  2], # 機械学習 (★割り切り: ドロー枚数は1だがカードを使わずに1ドローしているので実質2ドロー分の価値とする)
  "MachineLearning+"=>      ["Power",  true,  2], #

  # ==========================================================
  # Watcher
  # ==========================================================

  # ----------------------------------------------------------
  # アタック
  # ----------------------------------------------------------
  "Eruption"=>              ["Attack", false, 0], # 噴火
  "Eruption+"=>             ["Attack", false, 0], #
  "Strike_P"=>              ["Attack", false, 0], # ストライク
  "Strike_P+"=>             ["Attack", false, 0], #
  "BowlingBash"=>           ["Attack", false, 0], # ボーリングバッシュ
  "BowlingBash+"=>          ["Attack", false, 0], #
  "Consecrate"=>            ["Attack", false, 0], # 聖別
  "Consecrate+"=>           ["Attack", false, 0], #
  "CrushJoints"=>           ["Attack", false, 0], # 関節破壊
  "CrushJoints+"=>          ["Attack", false, 0], #
  "CutThroughFate"=>        ["Attack", false, 1], # 運命の切り開き
  "CutThroughFate+"=>       ["Attack", false, 1], #
  "EmptyFist"=>             ["Attack", false, 0], # 無の型拳
  "EmptyFist+"=>            ["Attack", false, 0], #
  "FlurryOfBlows"=>         ["Attack", false, 0], # 連打
  "FlurryOfBlows+"=>        ["Attack", false, 0], #
  "FlyingSleeves"=>         ["Attack", false, 0], # 舞い飛ぶ袖
  "FlyingSleeves+"=>        ["Attack", false, 0], #
  "FollowUp"=>              ["Attack", false, 0], # 追撃
  "FollowUp+"=>             ["Attack", false, 0], #
  "JustLucky"=>             ["Attack", false, 0], # ただの幸運
  "JustLucky+"=>            ["Attack", false, 0], #
  "SashWhip"=>              ["Attack", false, 0], # 鞭打つ帯
  "SashWhip+"=>             ["Attack", false, 0], #
  "CarveReality"=>          ["Attack", false, 0], # 刻まれた現実
  "CarveReality+"=>         ["Attack", false, 0], #
  "Conclude"=>              ["Attack", false, 0], # 終結
  "Conclude+"=>             ["Attack", false, 0], #
  "FearNoEvil"=>            ["Attack", false, 0], # 悪しきを恐れず
  "FearNoEvil+"=>           ["Attack", false, 0], #
  "ReachHeaven"=>           ["Attack", false, 0], # 昇天
  "ReachHeaven+"=>          ["Attack", false, 0], #
  "SandsOfTime"=>           ["Attack", false, 0], # 刻一刻
  "SandsOfTime+"=>          ["Attack", false, 0], #
  "SignatureMove"=>         ["Attack", false, 0], # フィニッシュブロー
  "SignatureMove+"=>        ["Attack", false, 0], #
  "TalkToTheHand"=>         ["Attack", true,  0], # 拒絶の拳
  "TalkToTheHand+"=>        ["Attack", true,  0], #
  "Tantrum"=>               ["Attack", false, 0], # かんしゃく
  "Tantrum+"=>              ["Attack", false, 0], #
  "Wallop"=>                ["Attack", false, 0], # ぶん殴り
  "Wallop+"=>               ["Attack", false, 0], #
  "Weave"=>                 ["Attack", false, 0], # 編み上げ
  "Weave+"=>                ["Attack", false, 0], #
  "WheelKick"=>             ["Attack", false, 2], # 回し蹴り
  "WheelKick+"=>            ["Attack", false, 2], #
  "WindmillStrike"=>        ["Attack", false, 0], # ウィンドストライク
  "WindmillStrike+"=>       ["Attack", false, 0], #
  "Brilliance"=>            ["Attack", false, 0], # 光輝
  "Brilliance+"=>           ["Attack", false, 0], #
  "LessonLearned"=>         ["Attack", true,  0], # 得られた教訓
  "LessonLearned+"=>        ["Attack", true,  0], #
  "Ragnarok"=>              ["Attack", false, 0], # ラグナロク
  "Ragnarok+"=>             ["Attack", false, 0], #

  # ----------------------------------------------------------
  # スキル
  # ----------------------------------------------------------
  "Defend_P"=>              ["Skill",  false, 0], # 防御
  "Defend_P+"=>             ["Skill",  false, 0], #
  "Vigilance"=>             ["Skill",  false, 0], # 警戒
  "Vigilance+"=>            ["Skill",  false, 0], #
  "Crescendo"=>             ["Skill",  true,  0], # 昂掲
  "Crescendo+"=>            ["Skill",  true,  0], #
  "EmptyBody"=>             ["Skill",  false, 0], # 無の型体
  "EmptyBody+"=>            ["Skill",  false, 0], #
  "Evaluate"=>              ["Skill",  false, 1], # 評価 (★割り切り: 実質ドローなので。ただし追加で1枚カードを使って2枚ドローする計算なので差し引き1ドローとする)
  "Evaluate+"=>             ["Skill",  false, 1], #
  "Halt"=>                  ["Skill",  false, 0], # 停止
  "Halt+"=>                 ["Skill",  false, 0], #
  "PathToVictory"=>         ["Skill",  false, 0], # 経絡秘孔
  "PathToVictory+"=>        ["Skill",  false, 0], #
  "Prostrate"=>             ["Skill",  false, 0], # 頂礼
  "Prostrate+"=>            ["Skill",  false, 0], #
  "Protect"=>               ["Skill",  false, 0], # 護身
  "Protect+"=>              ["Skill",  false, 0], #
  "ThirdEye"=>              ["Skill",  false, 0], # 第三の目
  "ThirdEye+"=>             ["Skill",  false, 0], #
  "ClearTheMind"=>          ["Skill",  true,  0], # 安らぎ
  "ClearTheMind+"=>         ["Skill",  true,  0], #
  "Collect"=>               ["Skill",  false, 0], # 収穫
  "Collect+"=>              ["Skill",  false, 0], #
  "DeceiveReality"=>        ["Skill",  false, 0], # 欺かれた現実
  "DeceiveReality+"=>       ["Skill",  false, 0], #
  "EmptyMind"=>             ["Skill",  false, 0], # 無の型心
  "EmptyMind+"=>            ["Skill",  false, 0], #
  "ForeignInfluence"=>      ["Skill",  false, 0], # 外的影響
  "ForeignInfluence+"=>     ["Skill",  false, 0], #
  "Indignation"=>           ["Skill",  false, 0], # 憤慨
  "Indignation+"=>          ["Skill",  false, 0], #
  "InnerPeace"=>            ["Skill",  false, 3], # 内なる平穏
  "InnerPeace+"=>           ["Skill",  false, 4], #
  "Meditate"=>              ["Skill",  false, 0], # 瞑想
  "Meditate+"=>             ["Skill",  false, 0], #
  "Perseverance"=>          ["Skill",  false, 0], # 忍耐
  "Perseverance+"=>         ["Skill",  false, 0], #
  "Pray"=>                  ["Skill",  false, 0], # 祈り
  "Pray+"=>                 ["Skill",  false, 0], #
  "Sanctity"=>              ["Skill",  false, 2], # 高潔
  "Sanctity+"=>             ["Skill",  false, 2], #
  "Vengeance"=>             ["Skill",  false, 2], # 一触即発
  "Vengeance+"=>            ["Skill",  false, 3], #
  "Swivel"=>                ["Skill",  false, 0], # 旋転回避
  "Swivel+"=>               ["Skill",  false, 0], #
  "WaveOfTheHand"=>         ["Skill",  false, 0], # 揺れ動く手
  "WaveOfTheHand+"=>        ["Skill",  false, 0], #
  "Worship"=>               ["Skill",  false, 0], # 崇拝
  "Worship+"=>              ["Skill",  false, 0], #
  "WreathOfFlame"=>         ["Skill",  false, 0], # 華炎輪
  "WreathOfFlame+"=>        ["Skill",  false, 0], #
  "Alpha"=>                 ["Skill",  false, 0], # アルファ
  "Alpha+"=>                ["Skill",  false, 0], #
  "Blasphemy"=>             ["Skill",  false, 0], # 冒涜
  "Blasphemy+"=>            ["Skill",  false, 0], #
  "ConjureBlade"=>          ["Skill",  false, 0], # 剣の召喚
  "ConjureBlade+"=>         ["Skill",  false, 0], #
  "DeusExMachina"=>         ["Skill",  false, 0], # デウスエクスマキナ
  "DeusExMachina+"=>        ["Skill",  false, 0], #
  "Judgement"=>             ["Skill",  false, 0], # 審判
  "Judgement+"=>            ["Skill",  false, 0], #
  "Omniscience"=>           ["Skill",  false, 0], # 全知
  "Omniscience+"=>          ["Skill",  false, 0], #
  "Scrawl"=>                ["Skill",  false, 6], # 走り書き (★割り切り: だいたいいつも6枚くらいドローしている気がする)
  "Scrawl+"=>               ["Skill",  false, 0], #
  "SpiritShield"=>          ["Skill",  false, 0], # 精神障壁
  "SpiritShield+"=>         ["Skill",  false, 0], #
  "Vault"=>                 ["Skill",  false, 0], # 飛び越え
  "Vault+"=>                ["Skill",  false, 0], #
  "Wish"=>                  ["Skill",  false, 0], # 願い事
  "Wish+"=>                 ["Skill",  false, 0], #

  # ----------------------------------------------------------
  # パワー
  # ----------------------------------------------------------
  "BattleHymn"=>            ["Power",  true,  0], # 戦いの賛歌
  "BattleHymn+"=>           ["Power",  true,  0], #
  "Fasting2"=>              ["Power",  true,  0], # 断食
  "Fasting2+"=>             ["Power",  true,  0], #
  "Wireheading"=>           ["Power",  true,  0], # 先見の明
  "Wireheading+"=>          ["Power",  true,  0], #
  "LikeWater"=>             ["Power",  true,  0], # 水の如し
  "LikeWater+"=>            ["Power",  true,  0], #
  "MentalFortress"=>        ["Power",  true,  0], # 不動心
  "MentalFortress+"=>       ["Power",  true,  0], #
  "Nirvana"=>               ["Power",  true,  0], # 涅槃
  "Nirvana+"=>              ["Power",  true,  0], #
  "Adaptation"=>            ["Power",  true,  0], # 猪突猛進 (★割り切り)
  "Adaptation+"=>           ["Power",  true,  0], #
  "Study"=>                 ["Power",  true,  1], # 学習 (★割り切り: 評価と同じ理由で1)
  "Study+"=>                ["Power",  true,  1], #
  "DevaForm"=>              ["Power",  true,  0], # 神人化
  "DevaForm+"=>             ["Power",  true,  0], #
  "Devotion"=>              ["Power",  true,  0], # 信心
  "Devotion+"=>             ["Power",  true,  0], #
  "Establishment"=>         ["Power",  true,  0], # 制定
  "Establishment+"=>        ["Power",  true,  0], #
  "MasterReality"=>         ["Power",  true,  0], # 掌握した現実
  "MasterReality+"=>        ["Power",  true,  0], #

  # ==========================================================
  # 無色
  # ==========================================================

  # ----------------------------------------------------------
  # アタック
  # ----------------------------------------------------------
  "DramaticEntrance"=>      ["Attack", true,  0], # 劇的な入場
  "DramaticEntrance+"=>     ["Attack", true,  0], #
  "FlashofSteel"=>          ["Attack", false, 1], # 剣の一閃
  "FlashofSteel+"=>         ["Attack", false, 1], #
  "MindBlast"=>             ["Attack", false, 0], # マインドブラスト
  "MindBlast+"=>            ["Attack", false, 0], #
  "SwiftStrike"=>           ["Attack", false, 0], # スウィフトストライク
  "SwiftStrike+"=>          ["Attack", false, 0], #
  "HandOfGreed"=>           ["Attack", false, 0], # 強欲の手
  "HandOfGreed+"=>          ["Attack", false, 0], #
  "Bite"=>                  ["Attack", false, 0], # 噛みつき
  "Bite+"=>                 ["Attack", false, 0], #
  "Expunger"=>              ["Attack", false, 0], # 抹殺の短剣
  "Expunger+"=>             ["Attack", false, 0], #
  "RitualDagger"=>          ["Attack", true,  0], # 儀式の短剣
  "RitualDagger+"=>         ["Attack", true,  0], #
  "Shiv"=>                  ["Attack", true,  0], # ナイフ
  "Shiv+"=>                 ["Attack", true,  0], #
  "Smite"=>                 ["Attack", true,  0], # スマイト
  "Smite+"=>                ["Attack", true,  0], #
  "ThroughViolence"=>       ["Attack", true,  0], # 蹂躙
  "ThroughViolence+"=>      ["Attack", true,  0], #

  # ----------------------------------------------------------
  # スキル
  # ----------------------------------------------------------
  "BandageUp"=>             ["Skill",  true,  0], # 包帯
  "BandageUp+"=>            ["Skill",  true,  0], #
  "Blind"=>                 ["Skill",  false, 0], # 目くらまし
  "Blind+"=>                ["Skill",  false, 0], #
  "DarkShackles"=>          ["Skill",  true,  0], # 闇の足枷
  "DarkShackles+"=>         ["Skill",  true,  0], #
  "DeepBreath"=>            ["Skill",  false, 1], # 深呼吸
  "DeepBreath+"=>           ["Skill",  false, 2], #
  "Discovery"=>             ["Skill",  true,  0], # 発見
  "Discovery+"=>            ["Skill",  false, 0], #
  "Enlightenment"=>         ["Skill",  false, 0], # 啓発
  "Enlightenment+"=>        ["Skill",  false, 0], #
  "Finesse"=>               ["Skill",  false, 1], # 技巧
  "Finesse+"=>              ["Skill",  false, 1], #
  "Forethought"=>           ["Skill",  false, 0], # 用心
  "Forethought+"=>          ["Skill",  false, 0], #
  "GoodInstincts"=>         ["Skill",  false, 0], # 直感
  "GoodInstincts+"=>        ["Skill",  false, 0], #
  "Impatience"=>            ["Skill",  false, 2], # 焦燥
  "Impatience+"=>           ["Skill",  false, 3], #
  "JackOfAllTrades"=>       ["Skill",  true,  0], # よろず屋
  "JackOfAllTrades+"=>      ["Skill",  true,  0], #
  "Madness"=>               ["Skill",  true,  0], # 狂気
  "Madness+"=>              ["Skill",  true,  0], #
  "Panacea"=>               ["Skill",  true,  0], # 万能薬
  "Panacea+"=>              ["Skill",  true,  0], #
  "PanicButton"=>           ["Skill",  false, 0], # 非常ボタン
  "PanicButton+"=>          ["Skill",  false, 0], #
  "Purity"=>                ["Skill",  true,  0], # 祓い清め
  "Purity+"=>               ["Skill",  true,  0], #
  "Trip"=>                  ["Skill",  false, 0], # つまづき
  "Trip+"=>                 ["Skill",  false, 0], #
  "Apotheosis"=>            ["Skill",  true,  0], # 神格化
  "Apotheosis+"=>           ["Skill",  true,  0], #
  "Chrysalis"=>             ["Skill",  true,  0], # サナギ
  "Chrysalis+"=>            ["Skill",  true,  0], #
  "MasterofStrategy"=>      ["Skill",  true,  3], # 戦略家
  "MasterofStrategy+"=>     ["Skill",  true,  4], #
  "Metamorphosis"=>         ["Skill",  true,  0], # 羽化
  "Metamorphosis+"=>        ["Skill",  true,  0], #
  "SecretTechnique"=>       ["Skill",  true,  1], # シークレットテクニック
  "SecretTechnique+"=>      ["Skill",  false, 1], #
  "SecretWeapon"=>          ["Skill",  true,  1], # シークレットウェポン
  "SecretWeapon+"=>         ["Skill",  false, 1], #
  "TheBomb"=>               ["Skill",  false, 0], # 爆弾
  "TheBomb+"=>              ["Skill",  false, 0], #
  "ThinkingAhead"=>         ["Skill",  true,  2], # 予測
  "ThinkingAhead+"=>        ["Skill",  false, 2], #
  "Transmutation"=>         ["Skill",  true,  0], # 変異
  "Transmutation+"=>        ["Skill",  true,  0], #
  "Violence"=>              ["Skill",  true,  3], # 暴力
  "Violence+"=>             ["Skill",  true,  4], #
  "Ghostly"=>               ["Skill",  true,  0], # 幻姿
  "Ghostly+"=>              ["Skill",  true,  0], #
  "Beta"=>                  ["Skill",  true,  0], # ベータ
  "Beta+"=>                 ["Skill",  true,  0], #
  "Insight"=>               ["Skill",  true,  2], # 洞察
  "Insight+"=>              ["Skill",  true,  3], #
  "J.A.X."=>                ["Skill",  false, 0], # JAX
  "J.A.X.+"=>               ["Skill",  false, 0], #
  "Miracle"=>               ["Skill",  true,  0], # 奇跡
  "Miracle+"=>              ["Skill",  true,  0], #
  "Safety"=>                ["Skill",  true,  0], # 退避
  "Safety+"=>               ["Skill",  true,  0], #
  "FameAndFortune"=>        ["Skill",  true,  0], # 富と名声(願い効果選択)
  "FameAndFortune+"=>       ["Skill",  true,  0], #

  # ----------------------------------------------------------
  # パワー
  # ----------------------------------------------------------
  "Magnetism"=>             ["Power",  true,  0], # 磁性
  "Magnetism+"=>            ["Power",  true,  0], #
  "Mayhem"=>                ["Power",  true,  0], # 騒乱
  "Mayhem+"=>               ["Power",  true,  0], #
  "Panache"=>               ["Power",  true,  0], # 威風堂々
  "Panache+"=>              ["Power",  true,  0], #
  "SadisticNature"=>        ["Power",  true,  0], # 加虐性
  "SadisticNature+"=>       ["Power",  true,  0], #
  "Omega"=>                 ["Power",  true,  0], # オメガ
  "Omega+"=>                ["Power",  true,  0], #
  "BecomeAlmighty"=>        ["Power",  true,  0], # 完全無欠(願い効果選択)
  "BecomeAlmighty+"=>       ["Power",  true,  0], #
  "LiveForever"=>           ["Power",  true,  0], # 不死(願い効果選択)
  "LiveForever+"=>          ["Power",  true,  0], #

  # ==========================================================
  # 状態異常
  # ==========================================================
  "Burn"=>                  ["Status", false, 0], # 火傷
  "Dazed"=>                 ["Status", true,  0], # めまい
  "Wound"=>                 ["Status", false, 0], # 負傷
  "Slimed"=>                ["Status", true,  0], # 粘液
  "Void"=>                  ["Status", true,  0], # 空虚

  # ==========================================================
  # 呪い
  # ==========================================================
  "AscendersBane"=>         ["Curse",  true,  0], # アセンダーの災厄
  "Clumsy"=>                ["Curse",  true,  0], # 不器用
  "CurseOfTheBell"=>        ["Curse",  false, 0], # 鐘の呪い
  "Decay"=>                 ["Curse",  false, 0], # 腐敗
  "Doubt"=>                 ["Curse",  false, 0], # 疑念
  "Injury"=>                ["Curse",  false, 0], # 怪我
  "Necronomicurse"=>        ["Curse",  false, 0], # 死霊の呪い
  "Normality"=>             ["Curse",  false, 0], # 凡庸
  "Pain"=>                  ["Curse",  false, 0], # 痛み
  "Parasite"=>              ["Curse",  false, 0], # 寄生
  "Pride"=>                 ["Curse",  true,  0], # 傲慢
  "Regret"=>                ["Curse",  false, 0], # 後悔
  "Shame"=>                 ["Curse",  false, 0], # 羞恥
  "Writhe"=>                ["Curse",  false, 0], # 苦悩

  # ==========================================================
  # その他
  # ==========================================================
  "unknown"=>               [], # 未使用
}


