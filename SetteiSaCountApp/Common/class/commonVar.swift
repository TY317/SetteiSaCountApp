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
    
    // //// エヴァ約束の扉
    @AppStorage("evaYakusokuMachineIconBadge") var evaYakusokuMachineIconBadge: String = "none"
    
    
    
    // //////////////////////////////////////
    // バージョンごとの処理
    // //////////////////////////////////////
//    func versionStringToNumbers(_ version: String) -> [Int] {
//        return version.split(separator: ".").compactMap { Int($0) }
//    }

    func isVersion(_ version: String, lessThan target: String) -> Bool {
        let v1 = versionStringToNumbers(version)
        let v2 = versionStringToNumbers(target)

        for i in 0..<max(v1.count, v2.count) {
            let num1 = i < v1.count ? v1[i] : 0
            let num2 = i < v2.count ? v2[i] : 0
            if num1 < num2 { return true }
            if num1 > num2 { return false }
        }
        return false // 同じなら false
    }
    
    
    func ver3100FirstLaunch() {
        // 比較対象となるバージョンを設定
        let targetVersion: String = "3.10.0"
        
        if firstLaunchAppVersion != nil {
            let lastVersion = lastLaunchAppVersion ?? "0.0.0"
            if isVersion(lastVersion, lessThan: targetVersion) {
                print("\(targetVersion)未満からアップデートされました")
                evaYakusokuMachineIconBadge = "update"
            }
            else {
                print("\(targetVersion)以上です")
            }
        } else {
            print("初回起動です")
        }
    }
}

