//
//  Machine.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/21.
//

import Foundation
import SwiftUI

struct Machine: Identifiable, Codable, Equatable {
    var id: String      // 一意のID,DMMリンクの下4桁を使う
    var name: String    // アイコン表示名
    var fullName: String     // 正式名称
    var onHome: Bool = true    // ホーム画面への表示
    var iconName: String // 画像名
    var isUnlocked: Bool = true    // リワード解放ロック解放
    var unlockDate: Double = 0.0    // 24時間開放用の時刻設定
    var badgeStatus: String = "none"    // 更新、新のバッジ
    var btBadge: Bool     // BTバッジ
    
    // 省略して書くための専用のイニシャライザ
    init(
        id: String,
        name: String,
        fullName: String,
        iconName: String,
        btBadge: Bool,
        // 以下はデフォルト値を指定しておく
        onHome: Bool = true,
        isUnlocked: Bool = true,
        unlockDate: Double = 0.0,
        badgeStatus: String = "none"
    ) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.iconName = iconName
        self.btBadge = btBadge
        self.onHome = onHome
        self.isUnlocked = isUnlocked
        self.unlockDate = unlockDate
        self.badgeStatus = badgeStatus
    }
}
