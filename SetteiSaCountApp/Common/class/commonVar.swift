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
    // 新トップページ用
    // ----------
    let initMachine: [Machine] = [
        Machine(id: "5555", name: "ジャグラー", fullName: "ジャグラーシリーズ", iconName: "machineIconJuglerSeries", btBadge: false),
        Machine(id: "8787", name: "ハナハナ", fullName: "ハナハナシリーズ", iconName: "machineIconHanahanaSeries", btBadge: false),
        Machine(id: "4943", name: "サンダーV", fullName: "サンダーV", iconName: "thunderMachineIcon", btBadge: true),
        Machine(id: "4930", name: "カバネリ海門", fullName: "カバネリ海門決戦", iconName: "kabaneriUnatoMachineIcon", btBadge: false),
        Machine(id: "4950", name: "ゴブスレ2", fullName: "ゴブリンスレイヤー2", iconName: "gobsla2MachineIcon", btBadge: false),
        Machine(id: "4928", name: "ハナビ", fullName: "ハナビ", iconName: "hanabiMachineIcon", btBadge: false),
        Machine(id: "4926", name: "炎炎2", fullName: "炎炎ノ消防隊2", iconName: "enen2MachineIcon", btBadge: false),
        Machine(id: "4931", name: "攻殻機動隊", fullName: "攻殻機動隊", iconName: "kokakukidotaiMachineIcon", btBadge: false),
        Machine(id: "4913", name: "鉄拳6", fullName: "鉄拳6", iconName: "tekken6MachineIcon", btBadge: false),
        Machine(id: "4909", name: "北斗転生", fullName: "北斗 転生の章2", iconName: "hokutoTenseiMachineIcon", btBadge: false),
        Machine(id: "4924", name: "無職転生", fullName: "無職転生", iconName: "mushotenMachineIcon", btBadge: false),
        Machine(id: "4929", name: "秘宝伝", fullName: "秘宝伝", iconName: "hihodenMachineIcon", btBadge: false),
        Machine(id: "4898", name: "化物語", fullName: "化物語", iconName: "bakemonoMachineIcon", btBadge: false),
        Machine(id: "4873", name: "ネオプラ", fullName: "ネオプラネット", iconName: "neoplaMachineIcon", btBadge: false),
        Machine(id: "4892", name: "超電磁砲2", fullName: "とある科学の超電磁砲2", iconName: "railgunMachineIcon", btBadge: false),
        Machine(id: "4885", name: "ヴヴヴ2", fullName: "革命機ヴァルヴレイヴ2", iconName: "vvv2MachineIcon", btBadge: false),
        Machine(id: "4893", name: "シェイク", fullName: "シェイクBT", iconName: "shakeMachineIcon", btBadge: true),
        Machine(id: "4880", name: "新鬼武者3", fullName: "新鬼武者3", iconName: "newOni3MachineIcon", btBadge: false),
        Machine(id: "4877", name: "銭形5", fullName: "主役は銭形5", iconName: "zeni5MachineIcon", btBadge: false),
        Machine(id: "4860", name: "クレアBT", fullName: "クレアの秘宝伝BT", iconName: "creaMachineIcon", btBadge: true),
        Machine(id: "4849", name: "東リベ", fullName: "東京リベンジャーズ", iconName: "toreveMachineIcon", btBadge: false),
        Machine(id: "4847", name: "アズレン", fullName: "アズールレーン", iconName: "azurLaneMachineIcon", btBadge: false),
        Machine(id: "4855", name: "ダリフラ", fullName: "ダーリン・イン・ザ・フランキス", iconName: "darlingMachineIcon", btBadge: false),
        Machine(id: "4843", name: "転剣", fullName: "転生したら剣でした", iconName: "reSwordMachineIcon", btBadge: false),
        Machine(id: "4830", name: "ヱヴァ約束", fullName: "ヱヴァンゲリヲン〜約束の扉〜", iconName: "evaYakusokuMachineIcon", btBadge: true),
        Machine(id: "4803", name: "わた婚", fullName: "わたしの幸せな結婚", iconName: "watakonMachineIcon", btBadge: false),
        Machine(id: "4790", name: "ギルクラ2", fullName: "ギルティクラウン2", iconName: "guiltyCrown2MachineIcon", btBadge: false),
        Machine(id: "4814", name: "DevilMayCry5", fullName: "Devil May Cry5", iconName: "dmc5MachineIcon", btBadge: false),
        Machine(id: "4805", name: "いざ！番長", fullName: "いざ！番長", iconName: "izaBanchoMachineIcon", btBadge: false),
        Machine(id: "4806", name: "ToLOVEる8.7", fullName: "ToLOVEる TRANCE ver8.7", iconName: "toloveru87MachineIcon", btBadge: false),
        Machine(id: "4788", name: "SEED", fullName: "ガンダムSEED", iconName: "gundamSeedMachineIcon", btBadge: false),
        Machine(id: "4763", name: "緑ドン", fullName: "緑ドン VIVA情熱南米編", iconName: "midoriDonMachineIcon", btBadge: false),
        Machine(id: "4778", name: "吉宗", fullName: "吉宗", iconName: "yoshimuneMachineIcon", btBadge: false),
        Machine(id: "4777", name: "麻雀物語", fullName: "麻雀物語", iconName: "mahjongMachineIcon", btBadge: false),
        Machine(id: "4752", name: "ゴジラ", fullName: "ゴジラ", iconName: "godzillaMachineIcon", btBadge: false),
        Machine(id: "4745", name: "マギレコ", fullName: "マギアレコード", iconName: "magiaMachineIcon", btBadge: false),
        Machine(id: "4706", name: "レビュースタァライト", fullName: "レビュースタァライト", iconName: "rslMachineIcon", btBadge: false),
        Machine(id: "4754", name: "バイオ5", fullName: "バイオハザード5", iconName: "bioMachineIcon", btBadge: false),
        Machine(id: "4734", name: "カイジ狂宴", fullName: "回胴黙示録カイジ 狂宴", iconName: "kaijiMachineIcon", btBadge: false),
        Machine(id: "4715", name: "ありふれ", fullName: "ありふれた職業で世界最強", iconName: "arifureMachineIcon", btBadge: false),
        Machine(id: "4742", name: "東京喰種", fullName: "東京喰種", iconName: "tokyoGhoulMachineIcon", btBadge: false),
        Machine(id: "4719", name: "シャーマンキング", fullName: "シャーマンキング", iconName: "shamanKingMachineIcon", btBadge: false),
        Machine(id: "4712", name: "SBJ", fullName: "スーパーブラックジャック", iconName: "sbjMachineIcon", btBadge: false),
        Machine(id: "4709", name: "七つの魔剣が支配する", fullName: "七つの魔剣が支配する", iconName: "sevenSwordsMachineIcon", btBadge: false),
        Machine(id: "4686", name: "一方通行", fullName: "一方通行 とある魔術の禁書目録", iconName: "acceleratorMachineIcon", btBadge: false),
        Machine(id: "4669", name: "ダンベル", fullName: "ダンベル何キロ持てる？", iconName: "dumbbellMachineIcon", btBadge: false),
        Machine(id: "4681", name: "ダンバイン", fullName: "ダンバイン", iconName: "danvineMachineIcone", btBadge: false),
        Machine(id: "4689", name: "ルパン大航海", fullName: "ルパン3世 大航海者の秘宝", iconName: "lupinMachineIcon", btBadge: false),
        Machine(id: "4676", name: "モンハンライズ", fullName: "モンスターハンター ライズ", iconName: "mhrMachineIcon", btBadge: false),
        Machine(id: "4641", name: "バンドリ!", fullName: "バンドリ!", iconName: "bangdreamMachinIcon", btBadge: false),
        Machine(id: "4658", name: "Re:ゼロ2", fullName: "Re:ゼロ season2", iconName: "rezero2MachineIcon", btBadge: false),
        Machine(id: "4618", name: "かぐや様", fullName: "かぐや様は告らせたい", iconName: "kaguyaMachineIcon", btBadge: false),
        Machine(id: "4579", name: "シンフォギア", fullName: "戦姫絶唱シンフォギア 正義の歌", iconName: "symphoMachineIcon", btBadge: false),
        Machine(id: "4602", name: "ゴッドイーター", fullName: "ゴッドイーター リザレクション", iconName: "godeaterMachinIcon", btBadge: false),
        Machine(id: "4571", name: "ToLOVEる", fullName: "ToLOVEるダークネス", iconName: "toloveruMachineIcon", btBadge: false),
        Machine(id: "4555", name: "スマスロ炎炎", fullName: "スマスロ炎炎ノ消防隊", iconName: "enenMachineIcon", btBadge: false),
        Machine(id: "4501", name: "ゴジエヴァ", fullName: "ゴジラvsエヴァンゲリオン", iconName: "machinIconGoeva", btBadge: false),
        Machine(id: "4450", name: "モンキー5", fullName: "モンキーターン5", iconName: "mt5MachineIconWhite", btBadge: false),
        Machine(id: "4360", name: "からくりサーカス", fullName: "からくりサーカス", iconName: "karakuriMachineIcon", btBadge: false),
        Machine(id: "4301", name: "北斗の拳", fullName: "北斗の拳", iconName: "machineIconHokuto", btBadge: false),
        Machine(id: "4244", name: "ヴヴヴ", fullName: "革命機ヴァルヴレイヴ", iconName: "machineIconVVV", btBadge: false),
        Machine(id: "4160", name: "カバネリ", fullName: "甲鉄城のカバネリ", iconName: "machineIconKabaneri", btBadge: false),
    ]
    // 永続化用のストレージ
//    @AppStorage("savedMachinesData") private var savedMachinesData: String = ""
    
    // 配列が更新されたら自動で保存
    @Published var machines: [Machine] = [] {
        didSet {
//            saveMachines()
        }
    }
    
//    init() {
//        loadMachines()
//        machines = initMachine
//    }
//    
//    // 保存ロジック（JSON変換）
//    private func saveMachines() {
//        if let encoded = try? JSONEncoder().encode(machines) {
//            let jsonString = String(data: encoded, encoding: .utf8) ?? ""
//            // 無駄な書き込みを減らすため、内容が変わった時だけAppStorageを更新
//            if savedMachinesData != jsonString {
//                savedMachinesData = jsonString
//            }
//        }
//    }
//    
//    // 読み込みロジック
//    private func loadMachines() {
//        if let data = savedMachinesData.data(using: .utf8),
//           let decoded = try? JSONDecoder().decode([Machine].self, from: data) {
//            self.machines = decoded
//        } else {
//            // データがない場合の初期値設定
//            self.machines = self.initMachine
//        }
//    }
    
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
    }
    
    // //////////////////////////////////////
    // バージョンごとの処理
    // //////////////////////////////////////
    func ver3221FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.22.1"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                dmc5MachineIconBadge = "update"
                dmc5MenuPremiumStBadge = "update"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
    
    func ver3220FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.22.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                thunderisUnlocked = false
                thunderMachineIconBadge = "new"
                kabaneriUnatoMenuOmikujiBadge = "update"
                kabaneriUnatoMachineIconBadge = "update"
                enen2MachineIconBadge = "update"
                enen2MenuNormalBadge = "update"
                newOni3MachineIconBadge = "update"
                newOni3MenuFirstHitBadge = "update"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
    func ver3211FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.21.1"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                kabaneriUnatoMachineIconBadge = "update"
                kabaneriUnatoMenuNormalBadge = "update"
                kokakukidotaiMenuCzBadge = "update"
                kokakukidotaiMachineIconBadge = "update"
                tekken6MachineIconBadge = "update"
                tekken6MenuCzBadge = "new"
                gobsla2MachineIconBadge = "update"
                gobsla2MenuEndingBadge = "new"
                kabaneriUnatoMenuHayajiroBadge = "new"
                hihodenMachineIconBadge = "update"
                hihodenMenuDuringBonusBadge = "update"
                hihodenMenuNormalBadge = "update"
                hihodenMenuLegendBadge = "update"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
    
    // //////////////////////////////////////
    // バージョンごとの処理
    // //////////////////////////////////////
    func ver3210FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.21.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                gobsla2isUnlocked = false
                gobsla2MachineIconBadge = "new"
                enen2MachineIconBadge = "update"
                enen2MenuScreenBadge = "update"
                enen2MenuRegBadge = "update"
                enen2MenuNormalBadge = "update"
                kabaneriUnatoisUnlocked = false
                kabaneriUnatoMachineIconBadge = "new"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
    func ver3200FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.20.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                newKingHanaisUnlocked = false
                hanaSeriesBadge = "new"
                newKingHanaMachineIconBadge = "new"
                kokakukidotaiMachineIconBadge = "update"
                kokakukidotaiMenuAfterAtBadge = "new"
                hanabiMachineIconBadge = "update"
                hanabiMenuRegBadge = "new"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
    func ver3190FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.19.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                hanabiisUnlocked = false
                hanabiMachineIconBadge = "new"
                tekken6MachineIconBadge = "update"
                tekken6MenuScreenBadge = "update"
                kokakukidotaiMachineIconBadge = "update"
                kokakukidotaiMenuCzBadge = "update"
                mushotenMachineIconBadge = "update"
                mushotenMenuFirstHitBadge = "update"
                hokutoTenseiMachineIconBadge = "update"
                hokutoTenseiMenuNormalBadge = "update"
                kokakukidotaiMenuNormalBadge = "update"
                enen2MachineIconBadge = "update"
                enen2MenuRegBadge = "update"
                enen2MenuScreenBadge = "update"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
//    func ver3180FirstLaunch() {
//        // 比較対象となるバージョンを設定
//        let targetVersion: String = "3.18.0"
//        
//        if firstLaunchAppVersion != nil {
//            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
//            if isVersionCompare(lastVersion, lessThan: targetVersion) {
//                print("\(targetVersion)未満からアップデートされました")
//                kokakukidotaiisUnlocked = false
//                kokakukidotaiMachineIconBadge = "new"
//                hokutoTenseiMenuTengekiBadge = "new"
//                hokutoTenseiMachineIconBadge = "update"
//                hokutoTenseiMenuFirstHitBadge = "update"
//                tekken6MachineIconBadge = "update"
//                tekken6MenuNormalBadge = "update"
//                tekken6MenuBonusBadge = "new"
//                hokutoTenseiMenuBayesBadge = "update"
//                tekken6MenuBayesBadge = "update"
//                enen2isUnlocked = false
//                enen2MachineIconBadge = "new"
//            }
//            else {
//                print("\(targetVersion)以上です")
//            }
//        } else {
//            print("初回起動です")
//        }
//    }
}

