//
//  ver380Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/18.
//

import Foundation
import SwiftUI
import TipKit

class Ver380: ObservableObject {
    @AppStorage("ver380TokyoGhoulMachineIconBadge") var tokyoGhoulMachineIconBadge: String = "update"
    @AppStorage("ver380TokyoGhoulMenuBayesBadge") var tokyoGhoulMenuBayesBadge: String = "new"
    @AppStorage("ver380HokutoMachineIconBadge") var hokutoMachineIconBadge: String = "update"
    @AppStorage("ver380HokutoMenuBayesBadge") var hokutoMenuBayesBadge: String = "new"
    @AppStorage("ver380HokutoMenuNormalBadge") var hokutoMenuNormalBadge: String = "update"
    @AppStorage("ver380EvaYakusokuMachineIconBadge") var evaYakusokuMachineIconBadge: String = "update"
    @AppStorage("ver380EvaYakusokuMenuNormalBadge") var evaYakusokuMenuNormalBadge: String = "update"
}

// //////////////////
// Tip：機種追加
// //////////////////
struct tipVer380MachineAddver2: Tip {
    var title: Text {
        Text("機種,機能追加！")
    }
    var message: Text? {
        Text("・設定期待値の対応機種追加\n　　・東京喰種\n　　・スマスロ北斗の拳")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}

// //////////////////
// Tip：ダリフラ　CZ開始レベル
// //////////////////
struct tipVer380hokutoNormal: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("設定期待値計算用にレア役回数を入力する機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：エヴァ　重複確率
// //////////////////
struct tipVer380EvaYakusokuNormal: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("成立役別のボーナス重複当選率が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
