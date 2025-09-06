//
//  ver390Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/02.
//

import Foundation
import SwiftUI
import TipKit

class Ver390: ObservableObject {
    @AppStorage("ver390ToreveMachineIconBadge") var toreveMachineIconBadge: String = "new"
    @AppStorage("ver390DarlingMachineIconBadge") var darlingMachineIconBadge: String = "update"
    @AppStorage("ver390DarlingMenuCzBadgeBadge") var darlingMenuCzBadge: String = "update"
    @AppStorage("ver390DarlingMenuBayesBadge") var darlingMenuBayesBadge: String = "new"
}


struct tipVer390UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
    }
    var message: Text? {
        Text("・東京リベンジャーズを追加\n・設定期待値の対応機種追加\n　　・ダーリン・イン・ザ・フランキス")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


// //////////////////
// Tip：ダリフラ　CZ最終レベル
// //////////////////
struct tipVer390DarlingCz: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("CZ最終レベル別の当選率が判明したのでカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
