//
//  ver300Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import Foundation
import SwiftUI
import TipKit

class Ver300: ObservableObject {
    @AppStorage("ver300IdolMasterMachineIconBadgeStatus") var idolMasterMachineIconBadgeStatus: String = "new"
    @AppStorage("ver300KaijiMachineIconBadgeStatus") var kaijiMachineIconBadgeStatus = "update"
    @AppStorage("ver300KaijiMenuModeBadgeStatus") var kaijiMenuModeBadgeStatus = "update"
    @AppStorage("ver300KaijiMenuVoiceBadgeStatus") var kaijiMenuVoiceBadgeStatus = "update"
    @AppStorage("ver300KaijiMenuTonegawaRushBadgeStatus") var kaijiMenuTonegawaRushBadgeStatus = "new"
    @AppStorage("ver300KaijiMenuHanchoRushBadgeStatus") var kaijiMenuHanchoRushBadgeStatus = "new"
    @AppStorage("ver300MahjongMachineIconBadgeStatus") var mahjongMachineIconBadgeStatus = "update"
    @AppStorage("ver300MahjongMenuVoiceBadgeStatus") var mahjongMenuVoiceBadgeStatus = "update"
    @AppStorage("ver300MagiaMachineIconBadgeStatus") var magiaMachineIconBadgeStatus: String = "update"
    @AppStorage("ver300MagiaMenuBonusScreenBadgeStatus") var magiaMenuBonusScreenBadgeStatus: String = "update"
    @AppStorage("ver300GodeaterMachineIconBadgeStatus") var godeaterMachineIconBadgeStatus: String = "update"
    @AppStorage("ver300GodeaterMenuNormalBadgeStatus") var godeaterMenuNormalBadgeStatus: String = "new"
    @AppStorage("ver300MidoriDonMachineIconBadgeStatus") var midoriDonMachineIconBadgeStatus: String = "new"
}

// //////////////////
// Tip：機種追加
// //////////////////
struct tipVer300MachineAdd: Tip {
    var title: Text {
        Text("機種追加！")
    }
    var message: Text? {
        Text("・緑ドン\n・アイドルマスター")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：カイジ　CZ確率
// //////////////////
struct tipVer300KaijiMode: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("モード振り分けの数値が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：カイジ　ボイス
// //////////////////
struct tipVer300KaijiVoice: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("ボイス示唆内容が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：麻雀物語　ボイス
// //////////////////
struct tipVer300MahjongVoice: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("ボイスのカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：マギアレコード　ボーナス終了画面
// //////////////////
struct tipVer300MagiaScreen: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("確定系画面の情報が判明したので、画面を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
