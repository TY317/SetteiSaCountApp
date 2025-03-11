//
//  ver230Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/20.
//

import Foundation
import SwiftUI
import TipKit

class Ver230: ObservableObject {
    @AppStorage("ver230TokyoGhoulNewBadgeStatus") var tokyoGhoulNewBadgeStatus: String = "new"
    @AppStorage("ver230ShamanKingNewBadgeStatus") var shamanKingNewBadgeStatus: String = "new"
    @AppStorage("ver230SbjMachineIconBadgeStatus") var sbjMachineIconBadgeStatus: String = "update"
    @AppStorage("ver230SbjMenuNormalBadgeStatus") var sbjMenuNormalBadgeStatus: String = "update"
    @AppStorage("ver230SbjMenuDiceCheckBadgeStatus") var sbjMenuDiceCheckBadgeStatus: String = "update"
}

// //////////////////
// Tip：機種追加
// //////////////////
//struct tipVer230MachineAdd: Tip {
//    var title: Text {
//        Text("機種追加！")
//    }
//    var message: Text? {
//        Text("・東京喰種\n・シャーマンキング")
//    }
//    var image: Image? {
//        Image(systemName: "exclamationmark.bubble")
//    }
//}

// //////////////////
// Tip：SBJ高確示唆演出
// //////////////////
struct tipVer230SbjKokakuSisaUpdate: Tip {
    var title: Text {
        Text("参考情報更新")
    }
    var message: Text? {
        Text("高確示唆演出の情報を更新しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：SBJ赤ダイス
// //////////////////
struct tipVer230SbjRedDiceUpdate: Tip {
    var title: Text {
        Text("参考情報更新")
    }
    var message: Text? {
        Text("赤ダイスについての情報を追記しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
