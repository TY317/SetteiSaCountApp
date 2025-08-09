//
//  ver361Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/06.
//

import Foundation
import SwiftUI
import TipKit

class Ver361: ObservableObject {
    @AppStorage("ver361ReSwordMachineIconBadge") var reSwordMachineIconBadge: String = "update"
    @AppStorage("ver361ReSwordMenuScreenBadge") var reSwordMenuScreenBadge: String = "update"
    @AppStorage("ver361ReSwordMenuFranCharaBadge") var reSwordMenuFranCharaBadge: String = "update"
    @AppStorage("ver361ReSwordMenuAtBadge") var reSwordMenuAtBadge: String = "update"
    @AppStorage("ver361ReSwordMenuFranSleepBadge") var reSwordMenuFranSleepBadge: String = "new"
}


// //////////////////
// Tip：転剣　終了画面示唆
// //////////////////
struct tipVer361ReSwordScreen: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("終了画面の示唆が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// //////////////////
// Tip：転剣　キャラカウント
// //////////////////
struct tipVer361ReSwordChara: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("キャラ紹介の示唆が判明したのでカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
