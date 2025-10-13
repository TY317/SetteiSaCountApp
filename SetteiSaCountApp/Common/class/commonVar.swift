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
    // //// 新鬼武者３
    @AppStorage("newOni3MachineIconBadge") var newOni3MachineIconBadge: String = "none"
    // //// クレアの秘宝伝
    @AppStorage("creaMachineIconBadge") var creaMachineIconBadge: String = "none"
    
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
    
    // //// モンスターハンターライズ
    @AppStorage("mhrMachineIconBadge") var mhrMachineIconBadge: String = "none"
    @AppStorage("mhrMenuFirstHitBadge") var mhrMenuFirstHitBadge: String = "none"
    
    
    // //////////////////////////////////////
    // バージョンごとの処理
    // //////////////////////////////////////
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

