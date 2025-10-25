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
    
    // //// VVV2
    @AppStorage("vvv2MachineIconBadge") var vvv2MachineIconBadge: String = "none"
    
    // //// レールガン
    @AppStorage("railgunMachineIconBadge") var railgunMachineIconBadge = "none"
    
    // //// 新鬼武者３
    @AppStorage("newOni3MachineIconBadge") var newOni3MachineIconBadge: String = "none"
    
    // //// 主役は銭形5
    @AppStorage("zeni5MachineIconBadge") var zeni5MachineIconBadge: String = "none"
    
    // //// クレアの秘宝伝
    @AppStorage("creaMachineIconBadge") var creaMachineIconBadge: String = "none"
    @AppStorage("creaMenuBtBadge") var creaMenuBtBadge: String = "none"
    
    // //// 東京リベンジャーズ
    @AppStorage("toreveMachineIconBadge") var toreveMachineIconBadge: String = "none"
    @AppStorage("toreveMenuFirstHitBadge") var toreveMenuFirstHitBadge: String = "none"
    @AppStorage("toreveMenuNormalBadge") var toreveMenuNormalBadge: String = "none"
    @AppStorage("toreveMenuBayesBadge") var toreveMenuBayesBadge: String = "none"
    @AppStorage("toreveMenuRevengeBadge") var toreveMenuRevengeBadge: String = "none"
    @AppStorage("toreveMenuBurstBadge") var toreveMenuBurstBadge: String = "none"
    @AppStorage("toreveMenuTomanChallengeBadge") var toreveMenuTomanChallengeBadge: String = "none"
    @AppStorage("toreveMenuCycleBadge") var toreveMenuCycleBadge: String = "none"
    
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
    
    // //// シャーマンキング
    @AppStorage("shamanKingMachineIconBadge") var shamanKingMachineIconBadge = "none"
    @AppStorage("shamanKingMenuNormalBadge") var shamanKingMenuNormalBadge = "none"
    
    // //// モンスターハンターライズ
    @AppStorage("mhrMachineIconBadge") var mhrMachineIconBadge: String = "none"
    @AppStorage("mhrMenuFirstHitBadge") var mhrMenuFirstHitBadge: String = "none"
    
    
    // //////////////////////////////////////
    // バージョンごとの処理
    // //////////////////////////////////////
    func ver3120FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.12.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                vvv2MachineIconBadge = "new"
                myJug5MenuShimaBadge = "new"
                jugSeriesBadge = "update"
                myJug5MachineIconBadge = "update"
                urmiraMachineIconBadge = "update"
                urmiraMenuShimaBadge = "new"
                mrJugMachineIconBadge = "update"
                mrJugMenuShimaBadge = "new"
                girlsSSMachineIconBadge = "update"
                girlsSSMenuShimaBadge = "new"
                goJug3MachineIconBadge = "update"
                goJug3MenuShimaBadge = "new"
                happyJugV3MachineIconBadge = "update"
                happyJugV3MenuShimaBadge = "new"
                funky2MachineIconBadge = "update"
                funky2MenuShimaBadge = "new"
                imJugExMachineIconBadge = "update"
                imJugExMenuShimaBadge = "new"
                hanaSeriesBadge = "update"
                starHanaMachineIconBadge = "update"
                starHanaMenuShimaBadge = "new"
                draHanaSenkohMachineIconBadge = "update"
                draHanaSenkohMenuShimaBadge = "new"
                kingHanaMachineIconBadge = "update"
                kingHanaMenuShimaBadge = "new"
                hanaTenshoMachineIconBadge = "update"
                hanaTenshoMenuShimaBadge = "new"
                railgunMachineIconBadge = "new"
                shamanKingMachineIconBadge = "update"
                shamanKingMenuNormalBadge = "update"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
    func ver3110FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.11.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                newOni3MachineIconBadge = "new"
                azurLaneMachineIconBadge = "update"
                azurLaneMenuNormalBadge = "update"
                azurLaneMenuBayesBadge = "update"
                azurLaneMenuKagaBadge = "update"
                azurLaneMenuScreenBadge = "update"
                toreveMachineIconBadge = "update"
                toreveMenuRevengeBadge = "update"
                toreveMenuBayesBadge = "update"
                toreveMenuBurstBadge = "update"
                toreveMenuTomanChallengeBadge = "update"
                toreveMenuCycleBadge = "update"
                toreveMenuNormalBadge = "update"
                mhrMachineIconBadge = "update"
                mhrMenuFirstHitBadge = "update"
                zeni5MachineIconBadge = "new"
                creaMenuBtBadge = "new"
                creaMachineIconBadge = "update"
                dmc5MachineIconBadge = "update"
                dmc5MenuFirstHitBadge = "update"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
    
    func ver3100FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.10.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersionCompare(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                evaYakusokuMachineIconBadge = "update"
                evaYakusokuMenuNormalBadge = "update"
                evaYakusokuMenuBayesBadge = "new"
                creaMachineIconBadge = "new"
                toreveMachineIconBadge = "update"
                toreveMenuFirstHitBadge = "update"
                toreveMenuNormalBadge = "update"
                toreveMenuBayesBadge = "update"
                evaYakusokuMenuFirstHitBadge = "update"
                urmiraMachineIconBadge = "new"
                jugSeriesBadge = "new"
                izaBanchoMachineIconBadge = "update"
                izaBanchoMenuFirstHitBadge = "update"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
}

