//
//  ver260Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/24.
//

import Foundation
import SwiftUI
import TipKit

class Ver260: ObservableObject {
    @AppStorage("ver260KaijiMachineIconBadgeStatus") var kaijiMachineIconBadgeStatus: String = "update"
    @AppStorage("ver260KaijiMenuScreenBadgeStatus") var kaijiMenuScreenBadgeStatus: String = "update"
    @AppStorage("ver260KaijiMenuHiramekiBadgeStatus") var kaijiMenuHiramekiBadgeStatus: String = "update"
    @AppStorage("ver260RslMachineIconBadgeStatus") var rslMachineIconBadgeStatus: String = "new"
    @AppStorage("ver260KaguyaMachineIconBadgeStatus") var kaguyaMachineIconBadgeStatus: String = "update"
    @AppStorage("ver260KaguyaMenuBonusBadgeStatus") var kaguyaMenuBonusBadgeStatus: String = "update"
}


// //////////////////
// Tip：カイジ終了画面
// //////////////////
struct tipVer260KaijiScreen: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("終了画面の示唆内容が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：機種追加
// //////////////////
struct tipVer260MachineAdd: Tip {
    var title: Text {
        Text("機種追加！")
    }
    var message: Text? {
        Text("・レビュースタァライト")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：かぐやボーナス振分け
// //////////////////
struct tipVer260KaguyaBonus: Tip {
    var title: Text {
        Text("新機能")
    }
    var message: Text? {
        Text("連チャンごとの赤7比率をカウントする機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：カイジトネガワ直撃
// //////////////////
struct tipVer260KaijiHiramekiTonegawa: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("閃き前兆移行時のトネガワラッシュ直撃の設定差が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
