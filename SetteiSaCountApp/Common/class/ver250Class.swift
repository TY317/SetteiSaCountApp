//
//  ver250Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/11.
//

import Foundation
import SwiftUI
import TipKit

class Ver250: ObservableObject {
    @AppStorage("ver250KaijiMachineIconBadgeStatus") var kaijiMachineIconBadgeStatus: String = "new"
    @AppStorage("ver250BioMachineIconBadgeStatus") var bioMachineIconBadgeStatus: String = "new"
    @AppStorage("ver250GhoulMachineIconBadgeStatus") var ghoulMachineIconBadgeStatus: String = "update"
    @AppStorage("ver250ArifureMachineIconBadgeStatus") var arifureMachineIconBadgeStatus: String = "update"
    @AppStorage("ver250ArifureMenuPremiumBadgeStatus") var arifureMenuPremiumBadgeStatus: String = "new"
    @AppStorage("ver250ArifureMenuCharacterBadgeStatus") var arifureMenuCharacterBadgeStatus: String = "update"
    @AppStorage("ver250ArifureMenuAtScreenBadgeStatus") var arifureMenuAtScreenBadgeStatus: String = "update"
    @AppStorage("ver250ArifureMenuEndingBadgeStatus") var arifureMenuEndingBadgeStatus: String = "update"
    @AppStorage("ver250GhoulMenuHistoryBadgeStatus") var ghoulMenuHistoryBadgeStatus: String = "update"
}


// //////////////////
// Tip：機種追加
// //////////////////
struct tipVer250MachineAdd: Tip {
    var title: Text {
        Text("機種追加！")
    }
    var message: Text? {
        Text("・バイオハザード5\n・カイジ 狂宴")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：ありふれキャラ紹介
// //////////////////
struct tipVer250ArifureCharacterRatio: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("キャラ紹介の振り分け率が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：ありふれAT終了画面振り分け
// //////////////////
struct tipVer250ArifureAtScreenRatio: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("AT終了画面の振り分け率が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：ありふれAT終了画面振り分け
// //////////////////
struct tipVer250ArifureEndingRatio: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("レア役時の画面の振り分け率が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：東京グール　裏AT情報
// //////////////////
struct tipVer250GhoulUraAt: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("裏ATの振分け率が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：東京グール　下段リプレイ
// //////////////////
struct tipVer250GhoulGedanReplay: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("下段リプレイの設定差が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
