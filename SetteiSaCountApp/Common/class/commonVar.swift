//
//  commonVar.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/20.
//

import Foundation
import SwiftUI

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
    
    // ---- 炎炎２
    @AppStorage("enen2isUnlocked") var enen2isUnlocked: Bool = true
    @AppStorage("enen2MachineIconBadge") var enen2MachineIconBadge: String = "none"
    @AppStorage("enen2MenuNormalBadge") var enen2MenuNormalBadge: String = "none"
    @AppStorage("enen2MenuFirstHitBadge") var enen2MenuFirstHitBadge: String = "none"
    @AppStorage("enen2MenuBayesBadge") var enen2MenuBayesBadge: String = "none"
    
    // ---- 攻殻機動隊
    @AppStorage("kokakukidotaiisUnlocked") var kokakukidotaiisUnlocked: Bool = true
    @AppStorage("kokakukidotaiMachineIconBadge") var kokakukidotaiMachineIconBadge: String = "none"
    @AppStorage("kokakukidotaiMenuNormalBadge") var kokakukidotaiMenuNormalBadge: String = "none"
    @AppStorage("kokakukidotaiMenuFirstHitBadge") var kokakukidotaiMenuFirstHitBadge: String = "none"
    @AppStorage("kokakukidotaiMenuBayesBadge") var kokakukidotaiMenuBayesBadge: String = "none"
    
    // ---- 鉄拳
    @AppStorage("tekken6isUnlocked") var tekken6isUnlocked: Bool = true
    @AppStorage("tekken6MachineIconBadge") var tekken6MachineIconBadge: String = "none"
    @AppStorage("tekken6MenuNormalBadge") var tekken6MenuNormalBadge: String = "none"
    @AppStorage("tekken6MenuFirstHitBadge") var tekken6MenuFirstHitBadge: String = "none"
    @AppStorage("tekken6MenuBayesBadge") var tekken6MenuBayesBadge: String = "none"
    @AppStorage("tekken6MenuScreenBadge") var tekken6MenuScreenBadge: String = "none"
    @AppStorage("tekken6MenuBackBadge") var tekken6MenuBackBadge: String = "none"
    
    // //// 北斗転生
    @AppStorage("hokutoTenseiisUnlocked") var hokutoTenseiisUnlocked: Bool = true
    @AppStorage("hokutoTenseiMachineIconBadge") var hokutoTenseiMachineIconBadge: String = "none"
    @AppStorage("hokutoTenseiMenuNormalBadge") var hokutoTenseiMenuNormalBadge: String = "none"
    @AppStorage("hokutoTenseiMenuBayesBadge") var hokutoTenseiMenuBayesBadge: String = "none"
    @AppStorage("hokutoTenseiMenuFirstHitBadge") var hokutoTenseiMenuFirstHitBadge: String = "none"
    
    // //// 秘宝伝
    @AppStorage("hihodenMachineIconBadge") var hihodenMachineIconBadge: String = "none"
    @AppStorage("hihodenMenuNormalBadge") var hihodenMenuNormalBadge: String = "none"
    @AppStorage("hihodenMenuBayesBadge") var hihodenMenuBayesBadge: String = "none"
    @AppStorage("hihodenMenuFirstHitBadge") var hihodenMenuFirstHitBadge: String = "none"
    @AppStorage("hihodenMenuDuringBonusBadge") var hihodenMenuDuringBonusBadge: String = "none"
    @AppStorage("hihodenMenuLegendBadge") var hihodenMenuLegendBadge: String = "none"
    
    // ---- 無職転生
    @AppStorage("mushotenisUnlocked") var mushotenisUnlocked: Bool = true
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
    
    
    // //////////////////////////////////////
    // バージョンごとの処理
    // //////////////////////////////////////
    func ver3171FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.17.1"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                hihodenMachineIconBadge = "update"
                hihodenMenuDuringBonusBadge = "update"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    func ver3170FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.17.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                shakeisUnlocked = false
                shakeMachineIconBadge = "new"
                railgunMachineIconBadge = "update"
                railgunMenuFirstHitBadge = "update"
                hokutoTenseiMachineIconBadge = "update"
                hokutoTenseiMenuNormalBadge = "update"
                hokutoTenseiMenuFirstHitBadge = "update"
                hokutoTenseiMenuBayesBadge = "update"
                bakemonoMachineIconBadge = "update"
                bakemonoMenuNormalBadge = "update"
                bakemonoMenuBayesBadge = "update"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
    func ver3160FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.16.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                hokutoTenseiMachineIconBadge = "new"
                hokutoTenseiisUnlocked = false
                tekken6MachineIconBadge = "new"
                tekken6isUnlocked = false
                mushotenisUnlocked = false
                mushotenMachineIconBadge = "new"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    func ver3150FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.15.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                hihodenMachineIconBadge = "new"
                tokyoGhoulMachineIconBadge = "update"
                tokyoGhoulMenuFirstHitBadge = "update"
                tokyoGhoulMenuTsukiyamaBadge = "update"
                vvv2MachineIconBadge = "update"
                vvv2MenuScreenBadge = "update"
                vvv2MenuRushBadge = "update"
                vvv2MenuBayesBadge = "update"
                bakemonoMachineIconBadge = "update"
                bakemonoMenuNormalBadge = "update"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    func ver3140FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.14.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                bakemonoMachineIconBadge = "new"
                neoplaMachineIconBadge = "update"
                neoplaMenuNormalBadge = "update"
                railgunMachineIconBadge = "update"
                railgunMenuNormalBadge = "update"
                railgunMenuBayesBadge = "update"
                railgunMenuFirstHitBadge = "update"
                railgunMenuDuringAtBadge = "update"
                vvv2MachineIconBadge = "update"
                vvv2MenuRushBadge = "update"
                vvv2Menu95CiBadge = "new"
                vvv2MenuBayesBadge = "new"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
    func ver3131FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.13.1"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                neoplaMachineIconBadge = "update"
                neoplaMenuNormalBadge = "update"
                neoplaMenuScreenBadge = "update"
                creaMachineIconBadge = "update"
                creaMenuNormalBadge = "update"
                toreveMachineIconBadge = "update"
                toreveMenuFirstHitBadge = "update"
                toreveMenuBayesBadge = "update"
                creaMenuBayesBadge = "update"
                toreveMenuBayesBadge = "update"
                toreveMenuCycleBadge = "update"
                vvv2MachineIconBadge = "update"
                vvv2MenuNormalBadge = "update"
                toreveMenuRushBadge = "update"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
    func ver3130FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.13.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                railgunMachineIconBadge = "new"
                vvv2MachineIconBadge = "update"
                vvv2MenuScreenBadge = "update"
                vvv2MenuAtScreenBadge = "new"
                vvv2MenuRushBadge = "update"
                vvv2MenuNormalBadge = "update"
                vvv2MenuFirstHitBadge = "update"
                neoplaMachineIconBadge = "new"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
//    func ver3120FirstLaunch() {
//        // 比較対象となるバージョンを設定
//        let targetVersion: String = "3.12.0"
//        
//        if firstLaunchAppVersion != nil {
//            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
//            if isVersionCompare(lastVersion, lessThan: targetVersion) {
//                print("\(targetVersion)未満からアップデートされました")
//                vvv2MachineIconBadge = "new"
//                myJug5MenuShimaBadge = "new"
//                jugSeriesBadge = "update"
//                myJug5MachineIconBadge = "update"
//                urmiraMachineIconBadge = "update"
//                urmiraMenuShimaBadge = "new"
//                mrJugMachineIconBadge = "update"
//                mrJugMenuShimaBadge = "new"
//                girlsSSMachineIconBadge = "update"
//                girlsSSMenuShimaBadge = "new"
//                goJug3MachineIconBadge = "update"
//                goJug3MenuShimaBadge = "new"
//                happyJugV3MachineIconBadge = "update"
//                happyJugV3MenuShimaBadge = "new"
//                funky2MachineIconBadge = "update"
//                funky2MenuShimaBadge = "new"
//                imJugExMachineIconBadge = "update"
//                imJugExMenuShimaBadge = "new"
//                hanaSeriesBadge = "update"
//                starHanaMachineIconBadge = "update"
//                starHanaMenuShimaBadge = "new"
//                draHanaSenkohMachineIconBadge = "update"
//                draHanaSenkohMenuShimaBadge = "new"
//                kingHanaMachineIconBadge = "update"
//                kingHanaMenuShimaBadge = "new"
//                hanaTenshoMachineIconBadge = "update"
//                hanaTenshoMenuShimaBadge = "new"
//                railgunMachineIconBadge = "new"
//                shamanKingMachineIconBadge = "update"
//                shamanKingMenuNormalBadge = "update"
//                shamanKingMenuQualifyBadge = "new"
//                shamanKingMenuBayesBadge = "new"
//                tokyoGhoulMachineIconBadge = "update"
//                tokyoGhoulMenuSuperHighBadge = "new"
////                newOni3MachineIconBadge = "update"
////                newOni3MenuBonusBadge = "update"
//            }
//            else {
//                print("\(targetVersion)以上です")
//            }
//        } else {
//            print("初回起動です")
//        }
//    }
//    
//    func ver3110FirstLaunch() {
//        // 比較対象となるバージョンを設定
//        let targetVersion: String = "3.11.0"
//        
//        if firstLaunchAppVersion != nil {
//            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
//            if isVersionCompare(lastVersion, lessThan: targetVersion) {
//                print("\(targetVersion)未満からアップデートされました")
//                newOni3MachineIconBadge = "new"
//                azurLaneMachineIconBadge = "update"
//                azurLaneMenuNormalBadge = "update"
//                azurLaneMenuBayesBadge = "update"
//                azurLaneMenuKagaBadge = "update"
//                azurLaneMenuScreenBadge = "update"
//                toreveMachineIconBadge = "update"
//                toreveMenuRevengeBadge = "update"
//                toreveMenuBayesBadge = "update"
//                toreveMenuBurstBadge = "update"
//                toreveMenuTomanChallengeBadge = "update"
//                toreveMenuCycleBadge = "update"
//                toreveMenuNormalBadge = "update"
//                mhrMachineIconBadge = "update"
//                mhrMenuFirstHitBadge = "update"
//                zeni5MachineIconBadge = "new"
//                creaMenuBtBadge = "new"
//                creaMachineIconBadge = "update"
//                dmc5MachineIconBadge = "update"
//                dmc5MenuFirstHitBadge = "update"
//            }
//            else {
//                print("\(targetVersion)以上です")
//            }
//        } else {
//            print("初回起動です")
//        }
//    }
//    
//    func ver3100FirstLaunch() {
//        // 比較対象となるバージョンを設定
//        let targetVersion: String = "3.10.0"
//        
//        if firstLaunchAppVersion != nil {
//            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
//            if isVersionCompare(lastVersion, lessThan: targetVersion) {
//                print("\(targetVersion)未満からアップデートされました")
//                evaYakusokuMachineIconBadge = "update"
//                evaYakusokuMenuNormalBadge = "update"
//                evaYakusokuMenuBayesBadge = "new"
//                creaMachineIconBadge = "new"
//                toreveMachineIconBadge = "update"
//                toreveMenuFirstHitBadge = "update"
//                toreveMenuNormalBadge = "update"
//                toreveMenuBayesBadge = "update"
//                evaYakusokuMenuFirstHitBadge = "update"
//                urmiraMachineIconBadge = "new"
//                jugSeriesBadge = "new"
//                izaBanchoMachineIconBadge = "update"
//                izaBanchoMenuFirstHitBadge = "update"
//            }
//            else {
//                print("\(targetVersion)以上です")
//            }
//        } else {
//            print("初回起動です")
//        }
//    }
}

