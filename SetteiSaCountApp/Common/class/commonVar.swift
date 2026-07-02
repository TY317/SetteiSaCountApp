//
//  commonVar.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/20.
//

import Foundation
import SwiftUI
import Combine

class commonVar: ObservableObject {
    @AppStorage("contentViewIconDisplayMode") var iconDisplayMode = true      // アイコン表示の切り替え
    let lazyVGridSize: CGFloat = 70
    let lazyVGridSpacing: CGFloat = 20
    let lazyVGridColumnsPortlait: Int = 4
    let lazyVGridColumnsLandscape: Int = 7
    
    let screenScrollHeight: CGFloat = 130
    
    let shimaInitialColumn: Int = 5    // 島合算確認ページのイニシャル行数
    
    let autoGameInterval: CGFloat = 3.95   // 自動G数機能のインターバル時間
    
    // ///////////////////////
    // 起動回数カウント
    // ///////////////////////
    @AppStorage("commonAppLaunchCount") var appLaunchCount: Int = 0
    @AppStorage("commonAppLaunchCountUpLastDateDouble") var appLaunchCountUpLastDateDouble: Double = 0.0
    
    // //// 1日1回アプリ起動回数をカウントアップさせる
    func appLaunchCountUp() {
        // 現在時の取得
        let nowDate = Date()
        let nowDateDouble = nowDate.timeIntervalSince1970
        // 最終カウントアップ時から20時間経過していたらカウントアップさせる
        if (nowDateDouble - appLaunchCountUpLastDateDouble) > 72000 {
            appLaunchCount += 1
            appLaunchCountUpLastDateDouble = nowDateDouble
            print("カウントアップ： \(appLaunchCount) 回")
        } else {
            print("カウントアップなし")
        }
    }
    @Environment(\.requestReview) var requestReview
    @AppStorage("commonTrackingRequested") var trackingRequested: Bool = false
    
    // ////////////////
    // ver3.5.1で追加
    // 初回起動時のバージョン情報を保存しておく
    // ////////////////
    @AppStorage("commonFirstLaunchAppVersion") var firstLaunchAppVersion: String?
    @AppStorage("commonLastLaunchAppVersion") var lastLaunchAppVersion: String?
    
    func saveInitialVersionIfNeeded() {
        // すでに保存されていたら何もしない
        guard firstLaunchAppVersion == nil else { return }
        
        // 現在のバージョンを取得
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            firstLaunchAppVersion = version
            print("初回起動バージョンを保存: \(version)")
        }
    }
    func saveAppVersions() {
        // 現在のバージョンを取得
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            
            // 初回起動バージョンは一度だけ保存
            if firstLaunchAppVersion == nil {
                firstLaunchAppVersion = version
                print("初回起動バージョンを保存: \(version)")
            } else {
                print("初回起動ではありません")
            }
            
            // 最新起動バージョンは毎回更新
            lastLaunchAppVersion = version
            print("最新起動バージョンを更新: \(version)")
        }
    }
    
    // ----------
    // ver3.25.0より
    // 新アプリ関連のインフォメーション
    // ----------
    @AppStorage("commonNewAppInfoShowed") var newAppInfoShow: Bool = false

    // ----------
    // ver4.0.0 新ホーム画面の使い方オンボーディング
    // 初回起動で一度だけ表示。閉じると true になり以後表示しない（再表示導線なし）。
    // 既存ユーザーも新規キーのため初期値 false ＝ 未完了 → 表示される。
    // ----------
    @AppStorage("homeOnboardingDoneVer4") var homeOnboardingDone: Bool = false

    // ----------
    // 新トップページ用
    // ----------
    let initMachine: [Machine] = [
        Machine(id: "5010", name: "戦コレ6", fullName: "戦国コレクション6", iconName: "sencole6MachineIcon", btBadge: false, maker: "コナミ"),
        Machine(id: "5019", name: "からくり2", fullName: "からくりサーカス2", iconName: "karakuri2MachineIcon", btBadge: false, maker: "SANKYO"),
        Machine(id: "5555", name: "ジャグラー", fullName: "ジャグラーシリーズ", iconName: "machineIconJuglerSeries", btBadge: false, maker: "北電子"),
        Machine(id: "8787", name: "ハナハナ", fullName: "ハナハナシリーズ", iconName: "machineIconHanahanaSeries", btBadge: false, maker: "パイオニア"),
        Machine(id: "5009", name: "戦国乙女5", fullName: "戦国乙女5", iconName: "otome5MachineIcon", btBadge: false, maker: "平和"),
        Machine(id: "5025", name: "SAO2", fullName: "ソードアート・オンラインⅡ", iconName: "sao2MachineIcon", btBadge: false, maker: "大都技研"),
        Machine(id: "4974", name: "バイオRE3", fullName: "バイオハザードRE:3", iconName: "bioRe3MachineIcon", btBadge: false, maker: "エンターライズ"),
        Machine(id: "4984", name: "リオエース2", fullName: "スーパーリオエース2", iconName: "rioAceMachineIcon", btBadge: false, maker: "山佐"),
        Machine(id: "4961", name: "ゴッド軌跡", fullName: "ミリオンゴッド〜神々の軌跡〜", iconName: "godKisekiMachineIcon", btBadge: false, maker: "UNIVERSAL"),
        Machine(id: "4970", name: "ヨルムンガンド", fullName: "ヨルムンガンド", iconName: "jormungandMachineIcon", btBadge: false, maker: "山佐"),
        Machine(id: "4983", name: "真打吉宗", fullName: "真打 吉宗", iconName: "shinYoshiMachineIcon", btBadge: false, maker: "大都技研"),
        Machine(id: "4956", name: "アクダマドライブ", fullName: "アクダマドライブ", iconName: "akudamaMachineIcon", btBadge: false, maker: "SANYO"),
        Machine(id: "4943", name: "サンダーV", fullName: "サンダーV", iconName: "thunderMachineIcon", btBadge: true, maker: "UNIVERSAL"),
        Machine(id: "4930", name: "カバネリ海門", fullName: "カバネリ海門決戦", iconName: "kabaneriUnatoMachineIcon", btBadge: false, maker: "サミー"),
        Machine(id: "4950", name: "ゴブスレ2", fullName: "ゴブリンスレイヤー2", iconName: "gobsla2MachineIcon", btBadge: false, maker: "藤商事"),
        Machine(id: "4928", name: "ハナビ", fullName: "ハナビ", iconName: "hanabiMachineIcon", btBadge: false, maker: "UNIVERSAL"),
        Machine(id: "4926", name: "炎炎2", fullName: "炎炎ノ消防隊2", iconName: "enen2MachineIcon", btBadge: false, maker: "SANKYO"),
        Machine(id: "4931", name: "攻殻機動隊", fullName: "攻殻機動隊", iconName: "kokakukidotaiMachineIcon", btBadge: false, maker: "サミー"),
        Machine(id: "4913", name: "鉄拳6", fullName: "鉄拳6", iconName: "tekken6MachineIcon", btBadge: false, maker: "山佐"),
        Machine(id: "4909", name: "北斗転生", fullName: "北斗 転生の章2", iconName: "hokutoTenseiMachineIcon", btBadge: false, maker: "サミー"),
        Machine(id: "4924", name: "無職転生", fullName: "無職転生", iconName: "mushotenMachineIcon", btBadge: false, maker: "ニューギン"),
        Machine(id: "4929", name: "秘宝伝", fullName: "秘宝伝", iconName: "hihodenMachineIcon", btBadge: false, maker: "大都技研"),
        Machine(id: "4898", name: "化物語", fullName: "化物語", iconName: "bakemonoMachineIcon", btBadge: false, maker: "サミー"),
        Machine(id: "4873", name: "ネオプラ", fullName: "ネオプラネット", iconName: "neoplaMachineIcon", btBadge: false, maker: "山佐"),
        Machine(id: "4892", name: "超電磁砲2", fullName: "とある科学の超電磁砲2", iconName: "railgunMachineIcon", btBadge: false, maker: "藤商事"),
        Machine(id: "4885", name: "ヴヴヴ2", fullName: "革命機ヴァルヴレイヴ2", iconName: "vvv2MachineIcon", btBadge: false, maker: "SANKYO"),
        Machine(id: "4893", name: "シェイク", fullName: "シェイクBT", iconName: "shakeMachineIcon", btBadge: true, maker: "大都技研"),
        Machine(id: "4880", name: "新鬼武者3", fullName: "新鬼武者3", iconName: "newOni3MachineIcon", btBadge: false, maker: "エンターライズ"),
        Machine(id: "4877", name: "銭形5", fullName: "主役は銭形5", iconName: "zeni5MachineIcon", btBadge: false, maker: "平和"),
        Machine(id: "4860", name: "クレアBT", fullName: "クレアの秘宝伝BT", iconName: "creaMachineIcon", btBadge: true, maker: "大都技研"),
        Machine(id: "4849", name: "東リベ", fullName: "東京リベンジャーズ", iconName: "toreveMachineIcon", btBadge: false, maker: "サミー"),
        Machine(id: "4847", name: "アズレン", fullName: "アズールレーン", iconName: "azurLaneMachineIcon", btBadge: false, maker: "京楽"),
        Machine(id: "4855", name: "ダリフラ", fullName: "ダーリン・イン・ザ・フランキス", iconName: "darlingMachineIcon", btBadge: false, maker: "Spiky"),
        Machine(id: "4843", name: "転剣", fullName: "転生したら剣でした", iconName: "reSwordMachineIcon", btBadge: false, maker: "コナミ"),
        Machine(id: "4830", name: "ヱヴァ約束", fullName: "ヱヴァンゲリヲン〜約束の扉〜", iconName: "evaYakusokuMachineIcon", btBadge: true, maker: "SANKYO"),
        Machine(id: "4803", name: "わた婚", fullName: "わたしの幸せな結婚", iconName: "watakonMachineIcon", btBadge: false, maker: "コナミ"),
        Machine(id: "4790", name: "ギルクラ2", fullName: "ギルティクラウン2", iconName: "guiltyCrown2MachineIcon", btBadge: false, maker: "UNIVERSAL"),
        Machine(id: "4814", name: "DevilMayCry5", fullName: "Devil May Cry5", iconName: "dmc5MachineIcon", btBadge: false, maker: "エンターライズ"),
        Machine(id: "4805", name: "いざ！番長", fullName: "いざ！番長", iconName: "izaBanchoMachineIcon", btBadge: false, maker: "大都技研"),
        Machine(id: "4806", name: "ToLOVEる8.7", fullName: "ToLOVEる TRANCE ver8.7", iconName: "toloveru87MachineIcon", btBadge: false, maker: "平和"),
        Machine(id: "4788", name: "SEED", fullName: "ガンダムSEED", iconName: "gundamSeedMachineIcon", btBadge: false, maker: "SANKYO"),
        Machine(id: "4763", name: "緑ドン", fullName: "緑ドン VIVA情熱南米編", iconName: "midoriDonMachineIcon", btBadge: false, maker: "UNIVERSAL"),
        Machine(id: "4778", name: "吉宗", fullName: "吉宗", iconName: "yoshimuneMachineIcon", btBadge: false, maker: "大都技研"),
        Machine(id: "4777", name: "麻雀物語", fullName: "麻雀物語", iconName: "mahjongMachineIcon", btBadge: false, maker: "平和"),
        Machine(id: "4752", name: "ゴジラ", fullName: "ゴジラ", iconName: "godzillaMachineIcon", btBadge: false, maker: "ニューギン"),
        Machine(id: "4745", name: "マギレコ", fullName: "マギアレコード", iconName: "magiaMachineIcon", btBadge: false, maker: "UNIVERSAL"),
        Machine(id: "4706", name: "レビュースタァライト", fullName: "レビュースタァライト", iconName: "rslMachineIcon", btBadge: false, maker: "オーイズミ"),
        Machine(id: "4754", name: "バイオ5", fullName: "バイオハザード5", iconName: "bioMachineIcon", btBadge: false, maker: "エンターライズ"),
        Machine(id: "4734", name: "カイジ狂宴", fullName: "回胴黙示録カイジ 狂宴", iconName: "kaijiMachineIcon", btBadge: false, maker: "サミー"),
        Machine(id: "4715", name: "ありふれ", fullName: "ありふれた職業で世界最強", iconName: "arifureMachineIcon", btBadge: false, maker: "SANKYO"),
        Machine(id: "4742", name: "東京喰種", fullName: "東京喰種", iconName: "tokyoGhoulMachineIcon", btBadge: false, maker: "Spiky"),
        Machine(id: "4719", name: "シャーマンキング", fullName: "シャーマンキング", iconName: "shamanKingMachineIcon", btBadge: false, maker: "UNIVERSAL"),
        Machine(id: "4712", name: "SBJ", fullName: "スーパーブラックジャック", iconName: "sbjMachineIcon", btBadge: false, maker: "山佐"),
        Machine(id: "4709", name: "七つの魔剣が支配する", fullName: "七つの魔剣が支配する", iconName: "sevenSwordsMachineIcon", btBadge: false, maker: "コナミ"),
        Machine(id: "4686", name: "一方通行", fullName: "一方通行 とある魔術の禁書目録", iconName: "acceleratorMachineIcon", btBadge: false, maker: "藤商事"),
        Machine(id: "4669", name: "ダンベル", fullName: "ダンベル何キロ持てる？", iconName: "dumbbellMachineIcon", btBadge: false, maker: "SANKYO"),
        Machine(id: "4681", name: "ダンバイン", fullName: "ダンバイン", iconName: "danvineMachineIcone", btBadge: false, maker: "サミー"),
        Machine(id: "4689", name: "ルパン大航海", fullName: "ルパン3世 大航海者の秘宝", iconName: "lupinMachineIcon", btBadge: false, maker: "平和"),
        Machine(id: "4676", name: "モンハンライズ", fullName: "モンスターハンター ライズ", iconName: "mhrMachineIcon", btBadge: false, maker: "エンターライズ"),
        Machine(id: "4641", name: "バンドリ!", fullName: "バンドリ!", iconName: "bangdreamMachinIcon", btBadge: false, maker: "平和"),
        Machine(id: "4658", name: "Re:ゼロ2", fullName: "Re:ゼロ season2", iconName: "rezero2MachineIcon", btBadge: false, maker: "大都技研"),
        Machine(id: "4618", name: "かぐや様", fullName: "かぐや様は告らせたい", iconName: "kaguyaMachineIcon", btBadge: false, maker: "SANKYO"),
        Machine(id: "4579", name: "シンフォギア", fullName: "戦姫絶唱シンフォギア 正義の歌", iconName: "symphoMachineIcon", btBadge: false, maker: "SANKYO"),
        Machine(id: "4602", name: "ゴッドイーター", fullName: "ゴッドイーター リザレクション", iconName: "godeaterMachinIcon", btBadge: false, maker: "山佐"),
        Machine(id: "4571", name: "ToLOVEる", fullName: "ToLOVEるダークネス", iconName: "toloveruMachineIcon", btBadge: false, maker: "平和"),
        Machine(id: "4555", name: "スマスロ炎炎", fullName: "スマスロ炎炎ノ消防隊", iconName: "enenMachineIcon", btBadge: false, maker: "SANKYO"),
        Machine(id: "4501", name: "ゴジエヴァ", fullName: "ゴジラvsエヴァンゲリオン", iconName: "machinIconGoeva", btBadge: false, maker: "SANKYO"),
        Machine(id: "4450", name: "モンキー5", fullName: "モンキーターン5", iconName: "mt5MachineIconWhite", btBadge: false, maker: "山佐"),
        Machine(id: "4360", name: "からくりサーカス", fullName: "からくりサーカス", iconName: "karakuriMachineIcon", btBadge: false, maker: "SANKYO"),
        Machine(id: "4301", name: "北斗の拳", fullName: "北斗の拳", iconName: "machineIconHokuto", btBadge: false, maker: "サミー"),
        Machine(id: "4244", name: "ヴヴヴ", fullName: "革命機ヴァルヴレイヴ", iconName: "machineIconVVV", btBadge: false, maker: "SANKYO"),
        Machine(id: "4160", name: "カバネリ", fullName: "甲鉄城のカバネリ", iconName: "machineIconKabaneri", btBadge: false, maker: "サミー"),
    ]
    // 永続化用のストレージ
    @AppStorage("savedMachinesData") private var savedMachinesData: String = ""
    
    // 配列が更新されたら自動で保存
    @Published var machines: [Machine] = [] {
        didSet {
            saveMachines()
        }
    }
    
    init() {
        loadMachines()
        loadJuglerMachines()
        loadHanahanaMachines()
//        machines = initMachine
    }
    
    // 保存ロジック（JSON変換）
    private func saveMachines() {
        if let encoded = try? JSONEncoder().encode(machines) {
            let jsonString = String(data: encoded, encoding: .utf8) ?? ""
            // 無駄な書き込みを減らすため、内容が変わった時だけAppStorageを更新
            if savedMachinesData != jsonString {
                savedMachinesData = jsonString
            }
        }
    }
    
    // 読み込みロジック（initMachineをカタログ＋固定項目の正とし、保存はユーザー状態のみマージ）
    private func loadMachines() {
        if let data = savedMachinesData.data(using: .utf8),
           let decoded = try? JSONDecoder().decode([Machine].self, from: data),
           !decoded.isEmpty {
            self.machines = Self.merged(saved: decoded, catalog: initMachine)
        } else {
            // 保存なし → カタログそのまま
            self.machines = initMachine
        }
    }

    // 保存(ユーザー状態)とカタログ(固定項目)をidでマージ。
    // 保存の並び順を維持し、固定項目(名前/アイコン/メーカー/btBadge)はカタログで上書き、
    // ユーザー状態(表示/解放/バッジ)だけ引き継ぐ。新機種は先頭、消えた機種は除外。
    static func merged(saved: [Machine], catalog: [Machine]) -> [Machine] {
        let byId = Dictionary(catalog.map { ($0.id, $0) }, uniquingKeysWith: { a, _ in a })
        var result: [Machine] = []
        var seen = Set<String>()
        for s in saved {
            guard let base = byId[s.id] else { continue }  // カタログから消えた機種は除外
            var m = base
            m.onHome = s.onHome
            m.isUnlocked = s.isUnlocked
            m.unlockDate = s.unlockDate
            m.badgeStatus = s.badgeStatus
            result.append(m)
            seen.insert(s.id)
        }
        let newOnes = catalog.filter { !seen.contains($0.id) }  // 新機種は先頭（カタログ順）
        return newOnes + result
    }

    // ----------
    // ジャグラー系 機種選択（ホーム方式の並び替えページ用）
    // idは各ジャグラーページの unitLinkSectionDMM のURL下4桁
    // ----------
    let initJuglerMachine: [Machine] = [
        Machine(id: "4683", name: "ウルミラ", fullName: "ウルトラミラクルジャグラー", iconName: "urmiraMachineIcon", btBadge: false, maker: "北電子"),
        Machine(id: "4588", name: "ミスター", fullName: "ミスタージャグラー", iconName: "mrJugMachineIcon", btBadge: false, maker: "北電子"),
        Machine(id: "4540", name: "ガールズSS", fullName: "ジャグラーガールズSS", iconName: "girlsSSMachineIcon", btBadge: false, maker: "北電子"),
        Machine(id: "4375", name: "ゴージャグ3", fullName: "ゴーゴージャグラー3", iconName: "goJug3MachineIcon", btBadge: false, maker: "北電子"),
        Machine(id: "4230", name: "ハッピーV3", fullName: "ハッピージャグラーV3", iconName: "machineIconHappyJugV3", btBadge: false, maker: "北電子"),
        Machine(id: "4029", name: "マイジャグ5", fullName: "マイジャグラー5", iconName: "machineIconMyJug5", btBadge: false, maker: "北電子"),
        Machine(id: "3961", name: "ファンキー2", fullName: "ファンキージャグラー2", iconName: "funky2MachineIcon", btBadge: false, maker: "北電子"),
        Machine(id: "3626", name: "アイムEX", fullName: "アイムジャグラーEX", iconName: "imJugExMachinIcon", btBadge: false, maker: "北電子"),
    ]
    @AppStorage("savedJuglerMachinesData") private var savedJuglerMachinesData: String = ""
    @Published var juglerMachines: [Machine] = [] {
        didSet { saveJuglerMachines() }
    }
    private func saveJuglerMachines() {
        if let encoded = try? JSONEncoder().encode(juglerMachines) {
            let jsonString = String(data: encoded, encoding: .utf8) ?? ""
            if savedJuglerMachinesData != jsonString {
                savedJuglerMachinesData = jsonString
            }
        }
    }
    private func loadJuglerMachines() {
        if let data = savedJuglerMachinesData.data(using: .utf8),
           let decoded = try? JSONDecoder().decode([Machine].self, from: data),
           !decoded.isEmpty {
            self.juglerMachines = Self.merged(saved: decoded, catalog: initJuglerMachine)
        } else {
            self.juglerMachines = initJuglerMachine
        }
    }

    // ----------
    // ハナハナ系 機種選択（ホーム方式の並び替えページ用）
    // idは各ハナハナページの unitLinkSectionDMM のURL下4桁
    // ----------
    let initHanahanaMachine: [Machine] = [
        Machine(id: "4912", name: "ニューキング", fullName: "ニューキングハナハナV", iconName: "newKingHanaMachineIcon", btBadge: true, maker: "パイオニア"),
        Machine(id: "4680", name: "スターハナハナ", fullName: "スターハナハナ", iconName: "starHanaMachineIcon", btBadge: false, maker: "パイオニア"),
        Machine(id: "4453", name: "ドラゴン閃光", fullName: "ドラゴンハナハナ閃光", iconName: "machineImageDragonHanahanaSenkoh2", btBadge: false, maker: "パイオニア"),
        Machine(id: "4311", name: "キングハナハナ", fullName: "キングハナハナ", iconName: "kingHanaMachineIcon", btBadge: false, maker: "パイオニア"),
        Machine(id: "4014", name: "鳳凰 天翔", fullName: "ハナハナ鳳凰天翔", iconName: "hanatenshoMachineIcon", btBadge: false, maker: "パイオニア"),
    ]
    @AppStorage("savedHanahanaMachinesData") private var savedHanahanaMachinesData: String = ""
    @Published var hanahanaMachines: [Machine] = [] {
        didSet { saveHanahanaMachines() }
    }
    private func saveHanahanaMachines() {
        if let encoded = try? JSONEncoder().encode(hanahanaMachines) {
            let jsonString = String(data: encoded, encoding: .utf8) ?? ""
            if savedHanahanaMachinesData != jsonString {
                savedHanahanaMachinesData = jsonString
            }
        }
    }
    private func loadHanahanaMachines() {
        if let data = savedHanahanaMachinesData.data(using: .utf8),
           let decoded = try? JSONDecoder().decode([Machine].self, from: data),
           !decoded.isEmpty {
            self.hanahanaMachines = Self.merged(saved: decoded, catalog: initHanahanaMachine)
        } else {
            self.hanahanaMachines = initHanahanaMachine
        }
    }

    // //////////////////////////////////////
    // バッジ
    // //////////////////////////////////////
    // //// ジャグラーシリーズ
    @AppStorage("jugSeriesBadge") var jugSeriesBadge: String = "none"
    // //// ウルトラミラクルジャグラー
    @AppStorage("urmiraMachineIconBadge") var urmiraMachineIconBadge: String = "none"
    @AppStorage("urmiraMenuShimaBadge") var urmiraMenuShimaBadge: String = "none"
    // //// Mrジャグラー
    @AppStorage("mrJugMachineIconBadge") var mrJugMachineIconBadge: String = "none"
    @AppStorage("mrJugMenuShimaBadge") var mrJugMenuShimaBadge: String = "none"
    // //// ガールズ
    @AppStorage("girlsSSMachineIconBadge") var girlsSSMachineIconBadge: String = "none"
    @AppStorage("girlsSSMenuShimaBadge") var girlsSSMenuShimaBadge: String = "none"
    // //// ゴージャグ
    @AppStorage("goJug3MachineIconBadge") var goJug3MachineIconBadge: String = "none"
    @AppStorage("goJug3MenuShimaBadge") var goJug3MenuShimaBadge: String = "none"
    // ハッピーV3
    @AppStorage("happyJugV3MachineIconBadge") var happyJugV3MachineIconBadge:String = "none"
    @AppStorage("happyJugV3MenuShimaBadge") var happyJugV3MenuShimaBadge: String = "none"
    // //// マイジャグ
    @AppStorage("myJug5MachineIconBadge") var myJug5MachineIconBadge: String = "none"
    @AppStorage("myJug5MenuShimaBadge") var myJug5MenuShimaBadge = "none"
    // //// ファンキージャグラー
    @AppStorage("funky2MachineIconBadge") var funky2MachineIconBadge: String = "none"
    @AppStorage("funky2MenuShimaBadge") var funky2MenuShimaBadge: String = "none"
    // //// アイムジャグラー
    @AppStorage("imJugExMachineIconBadge") var imJugExMachineIconBadge: String = "none"
    @AppStorage("imJugExMenuShimaBadge") var imJugExMenuShimaBadge: String = "none"
    
    // //// ハナハナシリーズ
    @AppStorage("hanaSeriesBadge") var hanaSeriesBadge: String = "none"
    // //// ニューキングハナハナ
    @AppStorage("newKingHanaisUnlocked") var newKingHanaisUnlocked: Bool = true
    @AppStorage("newKingHanaTempUnlockDateDouble") var newKingHanaTempUnlockDateDouble: Double = 0.0
    @AppStorage("newKingHanaMachineIconBadge") var newKingHanaMachineIconBadge: String = "none"
    @AppStorage("newKingHanaMenuShimaBadge") var newKingHanaMenuShimaBadge: String = "none"
    // //// スターハナハナ
    @AppStorage("starHanaMachineIconBadge") var starHanaMachineIconBadge: String = "none"
    @AppStorage("starHanaMenuShimaBadge") var starHanaMenuShimaBadge: String = "none"
    // ドラゴンハナハナ
    @AppStorage("draHanaSenkohMachineIconBadge") var draHanaSenkohMachineIconBadge: String = "none"
    @AppStorage("draHanaSenkohMenuShimaBadge") var draHanaSenkohMenuShimaBadge: String = "none"
    // キングハナハナ
    @AppStorage("kingHanaMachineIconBadge") var kingHanaMachineIconBadge: String = "none"
    @AppStorage("kingHanaMenuShimaBadge") var kingHanaMenuShimaBadge: String = "none"
    // ハナハナ鳳凰
    @AppStorage("hanaTenshoMachineIconBadge") var hanaTenshoMachineIconBadge: String = "none"
    @AppStorage("hanaTenshoMenuShimaBadge") var hanaTenshoMenuShimaBadge: String = "none"
    
    
    // ---- 戦国コレクション6
    @AppStorage("sencole6MenuNormalBadge") var sencole6MenuNormalBadge: String = "none"
    @AppStorage("sencole6MenuFirstHitBadge") var sencole6MenuFirstHitBadge: String = "none"
    @AppStorage("sencole6MenuBayesBadge") var sencole6MenuBayesBadge: String = "none"
    @AppStorage("sencole6MenuScreenBadge") var sencole6MenuScreenBadge: String = "none"
    @AppStorage("sencole6MenuDuringAtBadge") var sencole6MenuDuringAtBadge: String = "none"

    // ---- からくりサーカス2
    @AppStorage("karakuri2MenuNormalBadge") var karakuri2MenuNormalBadge: String = "none"
    @AppStorage("karakuri2MenuFirstHitBadge") var karakuri2MenuFirstHitBadge: String = "none"
    @AppStorage("karakuri2MenuBayesBadge") var karakuri2MenuBayesBadge: String = "none"
    @AppStorage("karakuri2MenuScreenBadge") var karakuri2MenuScreenBadge: String = "none"
    
    // ---- 戦国乙女5
    @AppStorage("otome5isUnlocked") var otome5isUnlocked: Bool = true
    @AppStorage("otome5TempUnlockDateDouble") var otome5TempUnlockDateDouble: Double = 0.0
    @AppStorage("otome5MachineIconBadge") var otome5MachineIconBadge: String = "none"
    @AppStorage("otome5MenuNormalBadge") var otome5MenuNormalBadge: String = "none"
    @AppStorage("otome5MenuFirstHitBadge") var otome5MenuFirstHitBadge: String = "none"
    @AppStorage("otome5MenuBayesBadge") var otome5MenuBayesBadge: String = "none"
    @AppStorage("otome5MenuScreenBadge") var otome5MenuScreenBadge: String = "none"
    @AppStorage("otome5MenuHistoryBadge") var otome5MenuHistoryBadge: String = "none"
    @AppStorage("otome5MenuEndingBadge") var otome5MenuEndingBadge: String = "none"
    @AppStorage("otome5MenuAtScreenBadge") var otome5MenuAtScreenBadge: String = "none"
    
    // ---- SAO2
    @AppStorage("sao2isUnlocked") var sao2isUnlocked: Bool = true
    @AppStorage("sao2TempUnlockDateDouble") var sao2TempUnlockDateDouble: Double = 0.0
    @AppStorage("sao2MachineIconBadge") var sao2MachineIconBadge: String = "none"
    @AppStorage("sao2MenuNormalBadge") var sao2MenuNormalBadge: String = "none"
    @AppStorage("sao2MenuFirstHitBadge") var sao2MenuFirstHitBadge: String = "none"
    @AppStorage("sao2MenuBayesBadge") var sao2MenuBayesBadge: String = "none"
    @AppStorage("sao2MenuScreenBadge") var sao2MenuScreenBadge: String = "none"
    @AppStorage("sao2MenuCzBadge") var sao2MenuCzBadge: String = "none"
    @AppStorage("sao2MenuDuringAtBadge") var sao2MenuDuringAtBadge: String = "none"
    @AppStorage("sao2MenuComeBackBadge") var sao2MenuComeBackBadge: String = "none"
    
    // ---- バイオRE3
    @AppStorage("bioRe3isUnlocked") var bioRe3isUnlocked: Bool = true
    @AppStorage("bioRe3TempUnlockDateDouble") var bioRe3TempUnlockDateDouble: Double = 0.0
    @AppStorage("bioRe3MachineIconBadge") var bioRe3MachineIconBadge: String = "none"
    @AppStorage("bioRe3MenuNormalBadge") var bioRe3MenuNormalBadge: String = "none"
    @AppStorage("bioRe3MenuFirstHitBadge") var bioRe3MenuFirstHitBadge: String = "none"
    @AppStorage("bioRe3MenuBayesBadge") var bioRe3MenuBayesBadge: String = "none"
    @AppStorage("bioRe3MenuScreenBadge") var bioRe3MenuScreenBadge: String = "none"
    @AppStorage("bioRe3MenuFigureBadge") var bioRe3MenuFigureBadge: String = "none"
    @AppStorage("bioRe3MenuEndingBadge") var bioRe3MenuEndingBadge: String = "none"
    @AppStorage("bioRe3MenuCzBadge") var bioRe3MenuCzBadge: String = "none"
    
    // ---- リオエース２
    @AppStorage("rioAceisUnlocked") var rioAceisUnlocked: Bool = true
    @AppStorage("rioAceTempUnlockDateDouble") var rioAceTempUnlockDateDouble: Double = 0.0
    @AppStorage("rioAceMachineIconBadge") var rioAceMachineIconBadge: String = "none"
    @AppStorage("rioAceMenuNormalBadge") var rioAceMenuNormalBadge: String = "none"
    @AppStorage("rioAceMenuFirstHitBadge") var rioAceMenuFirstHitBadge: String = "none"
    @AppStorage("rioAceMenuBayesBadge") var rioAceMenuBayesBadge: String = "none"
    @AppStorage("rioAceMenuScreenBadge") var rioAceMenuScreenBadge: String = "none"
    
    // ---- ミリオンゴッド軌跡
    @AppStorage("godKisekiisUnlocked") var godKisekiisUnlocked: Bool = true
    @AppStorage("godKisekiTempUnlockDateDouble") var godKisekiTempUnlockDateDouble: Double = 0.0
    @AppStorage("godKisekiMachineIconBadge") var godKisekiMachineIconBadge: String = "none"
    @AppStorage("godKisekiMenuNormalBadge") var godKisekiMenuNormalBadge: String = "none"
    @AppStorage("godKisekiMenuFirstHitBadge") var godKisekiMenuFirstHitBadge: String = "none"
    @AppStorage("godKisekiMenuBayesBadge") var godKisekiMenuBayesBadge: String = "none"
    
    // ---- アクダマドライブ
    @AppStorage("akudamaisUnlocked") var akudamaisUnlocked: Bool = true
    @AppStorage("akudamaTempUnlockDateDouble") var akudamaTempUnlockDateDouble: Double = 0.0
    @AppStorage("akudamaMachineIconBadge") var akudamaMachineIconBadge: String = "none"
    @AppStorage("akudamaMenuNormalBadge") var akudamaMenuNormalBadge: String = "none"
    @AppStorage("akudamaMenuFirstHitBadge") var akudamaMenuFirstHitBadge: String = "none"
    @AppStorage("akudamaMenuBayesBadge") var akudamaMenuBayesBadge: String = "none"
    @AppStorage("akudamaMenuScreenBadge") var akudamaMenuScreenBadge: String = "none"
    @AppStorage("akudamaMenuEndingBadge") var akudamaMenuEndingBadge: String = "none"
    
    // ---- ヨルムンガンド
    @AppStorage("jormungandisUnlocked") var jormungandisUnlocked: Bool = true
    @AppStorage("jormungandTempUnlockDateDouble") var jormungandTempUnlockDateDouble: Double = 0.0
    @AppStorage("jormungandMachineIconBadge") var jormungandMachineIconBadge: String = "none"
    @AppStorage("jormungandMenuNormalBadge") var jormungandMenuNormalBadge: String = "none"
    @AppStorage("jormungandMenuFirstHitBadge") var jormungandMenuFirstHitBadge: String = "none"
    @AppStorage("jormungandMenuBayesBadge") var jormungandMenuBayesBadge: String = "none"
    @AppStorage("jormungandMenuCzBadge") var jormungandMenuCzBadge: String = "none"
    @AppStorage("jormungandMenuScreenBadge") var jormungandMenuScreenBadge: String = "none"
    @AppStorage("jormungandMenuRegBadge") var jormungandMenuRegBadge: String = "none"
    @AppStorage("jormungandMenuEndingBadge") var jormungandMenuEndingBadge: String = "none"
    @AppStorage("jormungandMenuHighCzBadge") var jormungandMenuHighCzBadge: String = "none"
    
    // ---- 吉宗真打
    @AppStorage("shinYoshiisUnlocked") var shinYoshiisUnlocked: Bool = true
    @AppStorage("shinYoshiTempUnlockDateDouble") var shinYoshiTempUnlockDateDouble: Double = 0.0
    @AppStorage("shinYoshiMachineIconBadge") var shinYoshiMachineIconBadge: String = "none"
    @AppStorage("shinYoshiMenuNormalBadge") var shinYoshiMenuNormalBadge: String = "none"
    @AppStorage("shinYoshiMenuFirstHitBadge") var shinYoshiMenuFirstHitBadge: String = "none"
    @AppStorage("shinYoshiMenuBayesBadge") var shinYoshiMenuBayesBadge: String = "none"
    @AppStorage("shinYoshiMenuOshirasuBadge") var shinYoshiMenuOshirasuBadge: String = "none"
    @AppStorage("shinYoshiMenuScreenBadge") var shinYoshiMenuScreenBadge: String = "none"
    
    // ---- サンダー
    @AppStorage("thunderisUnlocked") var thunderisUnlocked: Bool = true
    @AppStorage("thunderTempUnlockDateDouble") var thunderTempUnlockDateDouble: Double = 0.0
    @AppStorage("thunderMachineIconBadge") var thunderMachineIconBadge: String = "none"
    @AppStorage("thunderMenuNormalBadge") var thunderMenuNormalBadge: String = "none"
    @AppStorage("thunderMenuPlayBadge") var thunderMenuPlayBadge: String = "none"
    @AppStorage("thunderMenuStartBadge") var thunderMenuStartBadge: String = "none"
    @AppStorage("thunderMenuBayesBadge") var thunderMenuBayesBadge: String = "none"
    @AppStorage("thunderMenuScreenBadge") var thunderMenuScreenBadge: String = "none"
    
    // ---- カバネリ海門
    @AppStorage("kabaneriUnatoisUnlocked") var kabaneriUnatoisUnlocked: Bool = true
    @AppStorage("kabaneriUnatoTempUnlockDateDouble") var kabaneriUnatoTempUnlockDateDouble: Double = 0.0
    @AppStorage("kabaneriUnatoMachineIconBadge") var kabaneriUnatoMachineIconBadge: String = "none"
    @AppStorage("kabaneriUnatoMenuNormalBadge") var kabaneriUnatoMenuNormalBadge: String = "none"
    @AppStorage("kabaneriUnatoMenuFirstHitBadge") var kabaneriUnatoMenuFirstHitBadge: String = "none"
    @AppStorage("kabaneriUnatoMenuBayesBadge") var kabaneriUnatoMenuBayesBadge: String = "none"
    @AppStorage("kabaneriUnatoMenuKabaneriBonusBadge") var kabaneriUnatoMenuKabaneriBonusBadge: String = "none"
    @AppStorage("kabaneriUnatoMenuScreenBadge") var kabaneriUnatoMenuScreenBadge: String = "none"
    @AppStorage("kabaneriUnatoMenuOmikujiBadge") var kabaneriUnatoMenuOmikujiBadge: String = "none"
    @AppStorage("kabaneriUnatoMenuHayajiroBadge") var kabaneriUnatoMenuHayajiroBadge: String = "none"
    
    // ---- ゴブリンスレイヤー２
    @AppStorage("gobsla2isUnlocked") var gobsla2isUnlocked: Bool = true
    @AppStorage("gobsla2TempUnlockDateDouble") var gobsla2TempUnlockDateDouble: Double = 0.0
    @AppStorage("gobsla2MachineIconBadge") var gobsla2MachineIconBadge: String = "none"
    @AppStorage("gobsla2MenuNormalBadge") var gobsla2MenuNormalBadge: String = "none"
    @AppStorage("gobsla2MenuFirstHitBadge") var gobsla2MenuFirstHitBadge: String = "none"
    @AppStorage("gobsla2MenuBayesBadge") var gobsla2MenuBayesBadge: String = "none"
    @AppStorage("gobsla2MenuKabutoBadge") var gobsla2MenuKabutoBadge: String = "none"
    @AppStorage("gobsla2MenuScreenBadge") var gobsla2MenuScreenBadge: String = "none"
    @AppStorage("gobsla2MenuEndingBadge") var gobsla2MenuEndingBadge: String = "none"
    
    // ---- ハナビ
    @AppStorage("hanabiisUnlocked") var hanabiisUnlocked: Bool = true
    @AppStorage("hanabiTempUnlockDateDouble") var hanabiTempUnlockDateDouble: Double = 0.0
    @AppStorage("hanabiMachineIconBadge") var hanabiMachineIconBadge: String = "none"
    @AppStorage("hanabiMenuNormalBadge") var hanabiMenuNormalBadge: String = "none"
    @AppStorage("hanabiMenuFirstHitBadge") var hanabiMenuFirstHitBadge: String = "none"
    @AppStorage("hanabiMenuBayesBadge") var hanabiMenuBayesBadge: String = "none"
    @AppStorage("hanabiMenuKenBadge") var hanabiMenuKenBadge: String = "none"
    @AppStorage("hanabiMenuStartBadge") var hanabiMenuStartBadge: String = "none"
    @AppStorage("hanabiMenuPlayBadge") var hanabiMenuPlayBadge: String = "none"
    @AppStorage("hanabiMenuRtReplayBadge") var hanabiMenuRtReplayBadge: String = "none"
    @AppStorage("hanabiMenuRegBadge") var hanabiMenuRegBadge: String = "none"
    
    // ---- 炎炎２
    @AppStorage("enen2isUnlocked") var enen2isUnlocked: Bool = true
    @AppStorage("enen2TempUnlockDateDouble") var enen2TempUnlockDateDouble: Double = 0.0
    @AppStorage("enen2MachineIconBadge") var enen2MachineIconBadge: String = "none"
    @AppStorage("enen2MenuNormalBadge") var enen2MenuNormalBadge: String = "none"
    @AppStorage("enen2MenuFirstHitBadge") var enen2MenuFirstHitBadge: String = "none"
    @AppStorage("enen2MenuBayesBadge") var enen2MenuBayesBadge: String = "none"
    @AppStorage("enen2MenuRegBadge") var enen2MenuRegBadge: String = "none"
    @AppStorage("enen2MenuWanaBadge") var enen2MenuWanaBadge: String = "none"
    @AppStorage("enen2MenuScreenBadge") var enen2MenuScreenBadge: String = "none"
    @AppStorage("enen2MenuEndingBadge") var enen2MenuEndingBadge: String = "none"
    
    // ---- 攻殻機動隊
    @AppStorage("kokakukidotaiisUnlocked") var kokakukidotaiisUnlocked: Bool = true
    @AppStorage("kokakukidotaiTempUnlockDateDouble") var kokakukidotaiTempUnlockDateDouble: Double = 0.0
    @AppStorage("kokakukidotaiMachineIconBadge") var kokakukidotaiMachineIconBadge: String = "none"
    @AppStorage("kokakukidotaiMenuNormalBadge") var kokakukidotaiMenuNormalBadge: String = "none"
    @AppStorage("kokakukidotaiMenuFirstHitBadge") var kokakukidotaiMenuFirstHitBadge: String = "none"
    @AppStorage("kokakukidotaiMenuBayesBadge") var kokakukidotaiMenuBayesBadge: String = "none"
    @AppStorage("kokakukidotaiMenuAtBadge") var kokakukidotaiMenuAtBadge: String = "none"
    @AppStorage("kokakukidotaiMenuScreenBadge") var kokakukidotaiMenuScreenBadge: String = "none"
    @AppStorage("kokakukidotaiMenuCzBadge") var kokakukidotaiMenuCzBadge: String = "none"
    @AppStorage("kokakukidotaiMenuAfterAtBadge") var kokakukidotaiMenuAfterAtBadge: String = "none"
    
    // ---- 鉄拳
    @AppStorage("tekken6isUnlocked") var tekken6isUnlocked: Bool = true
    @AppStorage("tekken6TempUnlockDateDouble") var tekken6TempUnlockDateDouble: Double = 0.0
    @AppStorage("tekken6MachineIconBadge") var tekken6MachineIconBadge: String = "none"
    @AppStorage("tekken6MenuNormalBadge") var tekken6MenuNormalBadge: String = "none"
    @AppStorage("tekken6MenuFirstHitBadge") var tekken6MenuFirstHitBadge: String = "none"
    @AppStorage("tekken6MenuBayesBadge") var tekken6MenuBayesBadge: String = "none"
    @AppStorage("tekken6MenuScreenBadge") var tekken6MenuScreenBadge: String = "none"
    @AppStorage("tekken6MenuBackBadge") var tekken6MenuBackBadge: String = "none"
    @AppStorage("tekken6MenuBonusBadge") var tekken6MenuBonusBadge: String = "none"
    @AppStorage("tekken6MenuCzBadge") var tekken6MenuCzBadge: String = "none"
    
    // //// 北斗転生
    @AppStorage("hokutoTenseiisUnlocked") var hokutoTenseiisUnlocked: Bool = true
    @AppStorage("hokutoTenseiTempUnlockDateDouble") var hokutoTenseiTempUnlockDateDouble: Double = 0.0
    @AppStorage("hokutoTenseiMachineIconBadge") var hokutoTenseiMachineIconBadge: String = "none"
    @AppStorage("hokutoTenseiMenuNormalBadge") var hokutoTenseiMenuNormalBadge: String = "none"
    @AppStorage("hokutoTenseiMenuBayesBadge") var hokutoTenseiMenuBayesBadge: String = "none"
    @AppStorage("hokutoTenseiMenuFirstHitBadge") var hokutoTenseiMenuFirstHitBadge: String = "none"
    @AppStorage("hokutoTenseiMenuTengekiBadge") var hokutoTenseiMenuTengekiBadge: String = "none"
    
    // //// 秘宝伝
    @AppStorage("hihodenMachineIconBadge") var hihodenMachineIconBadge: String = "none"
    @AppStorage("hihodenMenuNormalBadge") var hihodenMenuNormalBadge: String = "none"
    @AppStorage("hihodenMenuBayesBadge") var hihodenMenuBayesBadge: String = "none"
    @AppStorage("hihodenMenuFirstHitBadge") var hihodenMenuFirstHitBadge: String = "none"
    @AppStorage("hihodenMenuDuringBonusBadge") var hihodenMenuDuringBonusBadge: String = "none"
    @AppStorage("hihodenMenuLegendBadge") var hihodenMenuLegendBadge: String = "none"
    
    // ---- 無職転生
    @AppStorage("mushotenisUnlocked") var mushotenisUnlocked: Bool = true
    @AppStorage("mushotenTempUnlockDateDouble") var mushotenTempUnlockDateDouble: Double = 0.0
    @AppStorage("mushotenMachineIconBadge") var mushotenMachineIconBadge: String = "none"
    @AppStorage("mushotenMenuNormalBadge") var mushotenMenuNormalBadge: String = "none"
    @AppStorage("mushotenMenuBayesBadge") var mushotenMenuBayesBadge: String = "none"
    @AppStorage("mushotenMenuFirstHitBadge") var mushotenMenuFirstHitBadge: String = "none"
    @AppStorage("mushotenMenuCzBadge") var mushotenMenuCzBadge: String = "none"
    @AppStorage("mushotenMenuRegBadge") var mushotenMenuRegBadge: String = "none"
    @AppStorage("mushotenMenuScreenBadge") var mushotenMenuScreenBadge: String = "none"
    @AppStorage("mushotenMenuAtBadge") var mushotenMenuAtBadge: String = "none"
    @AppStorage("mushotenMenuEndingBadge") var mushotenMenuEndingBadge: String = "none"
    
    // //// 化物語
    @AppStorage("bakemonoMachineIconBadge") var bakemonoMachineIconBadge: String = "none"
    @AppStorage("bakemonoMenuNormalBadge") var bakemonoMenuNormalBadge: String = "none"
    @AppStorage("bakemonoMenuAtBadge") var bakemonoMenuAtBadge: String = "none"
    @AppStorage("bakemonoMenuScreenBadge") var bakemonoMenuScreenBadge: String = "none"
    @AppStorage("bakemonoMenuFirstHitBadge") var bakemonoMenuFirstHitBadge: String = "none"
    @AppStorage("bakemonoMenuBayesBadge") var bakemonoMenuBayesBadge: String = "none"
    
    // //// ネオプラネット
    @AppStorage("neoplaMachineIconBadge") var neoplaMachineIconBadge: String = "none"
    @AppStorage("neoplaMenuNormalBadge") var neoplaMenuNormalBadge: String = "none"
    @AppStorage("neoplaMenuScreenBadge") var neoplaMenuScreenBadge: String = "none"
    
    // //// VVV2
    @AppStorage("vvv2MachineIconBadge") var vvv2MachineIconBadge: String = "none"
    @AppStorage("vvv2MenuScreenBadge") var vvv2MenuScreenBadge: String = "none"
    @AppStorage("vvv2MenuAtScreenBadge") var vvv2MenuAtScreenBadge: String = "none"
    @AppStorage("vvv2MenuRushBadge") var vvv2MenuRushBadge: String = "none"
    @AppStorage("vvv2MenuNormalBadge") var vvv2MenuNormalBadge: String = "none"
    @AppStorage("vvv2MenuFirstHitBadge") var vvv2MenuFirstHitBadge: String = "none"
    @AppStorage("vvv2Menu95CiBadge") var vvv2Menu95CiBadge: String = "none"
    @AppStorage("vvv2MenuBayesBadge") var vvv2MenuBayesBadge: String = "none"
    
    // //// レールガン
    @AppStorage("railgunMachineIconBadge") var railgunMachineIconBadge = "none"
    @AppStorage("railgunMenuNormalBadge") var railgunMenuNormalBadge = "none"
    @AppStorage("railgunMenuBayesBadge") var railgunMenuBayesBadge = "none"
    @AppStorage("railgunMenuFirstHitBadge") var railgunMenuFirstHitBadge = "none"
    @AppStorage("railgunMenuDuringAtBadge") var railgunMenuDuringAtBadge = "none"
    
    // ---- シェイク
    @AppStorage("shakeisUnlocked") var shakeisUnlocked: Bool = true
    @AppStorage("shakeTempUnlockDateDouble") var shakeTempUnlockDateDouble: Double = 0.0
    @AppStorage("shakeMachineIconBadge") var shakeMachineIconBadge: String = "none"
    @AppStorage("shakeMenuNormalBadge") var shakeMenuNormalBadge: String = "none"
    @AppStorage("shakeMenuBayesBadge") var shakeMenuBayesBadge: String = "none"
    @AppStorage("shakeMenuFirstHitBadge") var shakeMenuFirstHitBadge: String = "none"
    @AppStorage("shakeMenuRegBadge") var shakeMenuRegBadge: String = "none"
    @AppStorage("shakeMenuScreenBadge") var shakeMenuScreenBadge: String = "none"
    @AppStorage("shakeMenuBtBadge") var shakeMenuBtBadge: String = "none"
    
    // //// 新鬼武者３
    @AppStorage("newOni3MachineIconBadge") var newOni3MachineIconBadge: String = "none"
    @AppStorage("newOni3MenuBonusBadge") var newOni3MenuBonusBadge: String = "none"
    @AppStorage("newOni3MenuFirstHitBadge") var newOni3MenuFirstHitBadge: String = "none"
    
    // //// 主役は銭形5
    @AppStorage("zeni5MachineIconBadge") var zeni5MachineIconBadge: String = "none"
    
    // //// クレアの秘宝伝
    @AppStorage("creaMachineIconBadge") var creaMachineIconBadge: String = "none"
    @AppStorage("creaMenuBtBadge") var creaMenuBtBadge: String = "none"
    @AppStorage("creaMenuNormalBadge") var creaMenuNormalBadge: String = "none"
    @AppStorage("creaMenuBayesBadge") var creaMenuBayesBadge: String = "none"
    
    // //// 東京リベンジャーズ
    @AppStorage("toreveMachineIconBadge") var toreveMachineIconBadge: String = "none"
    @AppStorage("toreveMenuFirstHitBadge") var toreveMenuFirstHitBadge: String = "none"
    @AppStorage("toreveMenuNormalBadge") var toreveMenuNormalBadge: String = "none"
    @AppStorage("toreveMenuBayesBadge") var toreveMenuBayesBadge: String = "none"
    @AppStorage("toreveMenuRevengeBadge") var toreveMenuRevengeBadge: String = "none"
    @AppStorage("toreveMenuBurstBadge") var toreveMenuBurstBadge: String = "none"
    @AppStorage("toreveMenuTomanChallengeBadge") var toreveMenuTomanChallengeBadge: String = "none"
    @AppStorage("toreveMenuCycleBadge") var toreveMenuCycleBadge: String = "none"
    @AppStorage("toreveMenuRushBadge") var toreveMenuRushBadge: String = "none"
    
    // //// アズールレーン
    @AppStorage("azurLaneMachineIconBadge") var azurLaneMachineIconBadge: String = "none"
    @AppStorage("azurLaneMenuNormalBadge") var azurLaneMenuNormalBadge: String = "none"
    @AppStorage("azurLaneMenuBayesBadge") var azurLaneMenuBayesBadge: String = "none"
    @AppStorage("azurLaneMenuKagaBadge") var azurLaneMenuKagaBadge: String = "none"
    @AppStorage("azurLaneMenuScreenBadge") var azurLaneMenuScreenBadge: String = "none"
    
    // //// エヴァ約束の扉
    @AppStorage("evaYakusokuMachineIconBadge") var evaYakusokuMachineIconBadge: String = "none"
    @AppStorage("evaYakusokuMenuNormalBadge") var evaYakusokuMenuNormalBadge: String = "none"
    @AppStorage("evaYakusokuMenuBayesBadge") var evaYakusokuMenuBayesBadge: String = "none"
    @AppStorage("evaYakusokuMenuFirstHitBadge") var evaYakusokuMenuFirstHitBadge: String = "none"
    
    // //// いざ番長
    @AppStorage("izaBanchoMachineIconBadge") var izaBanchoMachineIconBadge: String = "none"
    @AppStorage("izaBanchoMenuFirstHitBadge") var izaBanchoMenuFirstHitBadge: String = "none"
    
    // //// デビルメイクライ
    @AppStorage("dmc5MachineIconBadge") var dmc5MachineIconBadge: String = "none"
    @AppStorage("dmc5MenuFirstHitBadge") var dmc5MenuFirstHitBadge: String = "none"
    @AppStorage("dmc5MenuPremiumStBadge") var dmc5MenuPremiumStBadge: String = "none"
    
    // //// 東京グール
    @AppStorage("tokyoGhoulMachineIconBadge") var tokyoGhoulMachineIconBadge: String = "none"
    @AppStorage("tokyoGhoulMenuSuperHighBadge") var tokyoGhoulMenuSuperHighBadge: String = "none"
    @AppStorage("tokyoGhoulMenuFirstHitBadge") var tokyoGhoulMenuFirstHitBadge: String = "none"
    @AppStorage("tokyoGhoulMenuTsukiyamaBadge") var tokyoGhoulMenuTsukiyamaBadge: String = "none"
    
    // //// シャーマンキング
    @AppStorage("shamanKingMachineIconBadge") var shamanKingMachineIconBadge = "none"
    @AppStorage("shamanKingMenuNormalBadge") var shamanKingMenuNormalBadge = "none"
    @AppStorage("shamanKingMenuQualifyBadge") var shamanKingMenuQualifyBadge = "none"
    @AppStorage("shamanKingMenuBayesBadge") var shamanKingMenuBayesBadge = "none"
    
    // //// モンスターハンターライズ
    @AppStorage("mhrMachineIconBadge") var mhrMachineIconBadge: String = "none"
    @AppStorage("mhrMenuFirstHitBadge") var mhrMenuFirstHitBadge: String = "none"
    
    // ---- モンキーターン
    @AppStorage("mt5MachineIconBadge") var mt5MachineIconBadge: String = "none"
    @AppStorage("mt5MenuGekisoBadge") var mt5MenuGekisoBadge: String = "none"
    @AppStorage("mt5MenuBayesBadge") var mt5MenuBayesBadge: String = "none"
    
    // //// スマスロ北斗
    @AppStorage("hokutoMachineIconBadge") var hokutoMachineIconBadge = "none"
    
    // -------
    // リワード広告の強制アンロック
    // -------
    func forcedUnlockReward() {
        hokutoTenseiisUnlocked = true
        tekken6isUnlocked = true
        mushotenisUnlocked = true
        shakeisUnlocked = true
        kokakukidotaiisUnlocked = true
        enen2isUnlocked = true
        hanabiisUnlocked = true
        newKingHanaisUnlocked = true
        kabaneriUnatoisUnlocked = true
        gobsla2isUnlocked = true
        thunderisUnlocked = true
        shinYoshiisUnlocked = true
        jormungandisUnlocked = true
        akudamaisUnlocked = true
        godKisekiisUnlocked = true
    }
    
    // //////////////////////////////////////
    // バージョンごとの処理
    // //////////////////////////////////////
    func ver410FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "4.1.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                machines.updateMachineBadgeStatus(id: "5019", newStatus: "new")
                machines.updateMachineIsUnlocked(id: "5019", isUnlocked: false)
                machines.updateMachineBadgeStatus(id: "5010", newStatus: "new")
                machines.updateMachineIsUnlocked(id: "5010", isUnlocked: false)
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
    func ver400FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "4.0.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                machines.updateMachineBadgeStatus(id: "4984", newStatus: "update")
                rioAceMenuNormalBadge = "update"
                machines.updateMachineBadgeStatus(id: "4974", newStatus: "update")
                bioRe3MenuNormalBadge = "update"
                machines.updateMachineBadgeStatus(id: "4931", newStatus: "update")
                kokakukidotaiMenuNormalBadge = "update"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
    func ver3271FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.27.1"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                otome5MachineIconBadge = "update"
                otome5MenuAtScreenBadge = "new"
                rioAceMachineIconBadge = "update"
                rioAceMenuScreenBadge = "update"
                rioAceMenuNormalBadge = "update"
                bioRe3MachineIconBadge = "update"
                bioRe3MenuNormalBadge = "update"
                sao2MachineIconBadge = "update"
                sao2MenuScreenBadge = "update"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
    func ver3270FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.27.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                jormungandMachineIconBadge = "update"
                jormungandMenuHighCzBadge = "new"
                godKisekiMachineIconBadge = "update"
                godKisekiMenuFirstHitBadge = "update"
                kokakukidotaiMachineIconBadge = "update"
                kokakukidotaiMenuNormalBadge = "update"
                otome5isUnlocked = false
                otome5MachineIconBadge = "new"
                sao2isUnlocked = false
                sao2MachineIconBadge = "new"
                godKisekiMenuNormalBadge = "update"
                kabaneriUnatoMachineIconBadge = "update"
                kabaneriUnatoMenuNormalBadge = "update"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
    func ver3260FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.26.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                bioRe3MachineIconBadge = "update"
                bioRe3MenuCzBadge = "new"
                bakemonoMachineIconBadge = "update"
                bakemonoMenuNormalBadge = "update"
                rioAceMachineIconBadge = "update"
                rioAceMenuNormalBadge = "update"
                godKisekiMachineIconBadge = "update"
                godKisekiMenuNormalBadge = "update"
                kokakukidotaiMachineIconBadge = "update"
                kokakukidotaiMenuNormalBadge = "update"
                newAppInfoShow = true
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
    func ver3250FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.25.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                rioAceisUnlocked = false
                rioAceMachineIconBadge = "new"
                bioRe3isUnlocked = false
                bioRe3MachineIconBadge = "new"
                kabaneriUnatoMachineIconBadge = "update"
                kabaneriUnatoMenuOmikujiBadge = "update"
                newAppInfoShow = true
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
}

