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
    var maker: String = ""   // メーカー（iconNameから補完。永続化はせずcommonVarでバックフィル）

    // 永続化キー（makerもinitMachine由来で保持。load時にinitMachineの値で上書きされる）
    enum CodingKeys: String, CodingKey {
        case id, name, fullName, onHome, iconName, isUnlocked, unlockDate, badgeStatus, btBadge, maker
    }

    // 寛容なデコード：欠損キーは既定値（将来フィールドを足しても既存保存データを壊さない）
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        id = try c.decode(String.self, forKey: .id)
        name = try c.decodeIfPresent(String.self, forKey: .name) ?? ""
        fullName = try c.decodeIfPresent(String.self, forKey: .fullName) ?? ""
        onHome = try c.decodeIfPresent(Bool.self, forKey: .onHome) ?? true
        iconName = try c.decodeIfPresent(String.self, forKey: .iconName) ?? ""
        isUnlocked = try c.decodeIfPresent(Bool.self, forKey: .isUnlocked) ?? true
        unlockDate = try c.decodeIfPresent(Double.self, forKey: .unlockDate) ?? 0.0
        badgeStatus = try c.decodeIfPresent(String.self, forKey: .badgeStatus) ?? "none"
        btBadge = try c.decodeIfPresent(Bool.self, forKey: .btBadge) ?? false
        maker = try c.decodeIfPresent(String.self, forKey: .maker) ?? ""
    }

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
        badgeStatus: String = "none",
        maker: String = ""
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
        self.maker = maker
    }
}


extension Array where Element == Machine {
    /// 指定したIDの機種のバッジ状態を更新する
    mutating func updateMachineBadgeStatus(id: String, newStatus: String) {
        if let index = self.firstIndex(where: { $0.id == id }) {
            self[index].badgeStatus = newStatus
        }
    }

    /// 指定したIDの機種のロック状態(isUnlocked)を更新する
    mutating func updateMachineIsUnlocked(id: String, isUnlocked: Bool) {
        if let index = self.firstIndex(where: { $0.id == id }) {
            self[index].isUnlocked = isUnlocked
        }
    }
}
