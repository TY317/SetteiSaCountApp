//
//  ver352Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/20.
//

import Foundation
import SwiftUI
import TipKit

class Ver352: ObservableObject {
    @AppStorage("ver352EvaYakusokuMachineIconBadge") var evaYakusokuMachineIconBadge: String = "update"
    @AppStorage("ver352EvaYakusokuMenuFirstHitBadge") var evaYakusokuMenuFirstHitBadge: String = "update"
    @AppStorage("ver352Dmc5MachineIconBadge") var dmc5MachineIconBadge: String = "update"
    @AppStorage("ver352Dmc5MenuCzCycleBadge") var dmc5MenuPremiumStBadge: String = "update"
    @AppStorage("ver352Dmc5MenuStBadge") var dmc5MenuStBadge: String = "new"
    @AppStorage("ver352TokyoGhoulMachineIconBadge") var tokyoGhoulMachineIconBadge: String = "update"
    @AppStorage("ver352TokyoGhoulMenuTsukiyamaBadge") var tokyoGhoulMenuTsukiyamaBadge: String = "update"
    @AppStorage("ver352MagiaMachineIconBadge") var magiaMachineIconBadge: String = "update"
    @AppStorage("ver352MagiaMenuMitamaBadge") var magiaMenuMitamaBadge: String = "new"
    @AppStorage("ver352MagiaMenuEpisodeBadge") var magiaMenuEpisodeBadge: String = "new"
    @AppStorage("ver352MagiaMenuStoryOrderBadge") var magiaMenuStoryOrderBadge: String = "new"
}

// //////////////////
// Tip：エヴァ約束　ボーナス詳細
// //////////////////
struct tipVer352EvaYakusokuFirstHit: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("各種ボーナス詳細確率が判明したのでボーナス種類ごとにカウントできるようにしました。")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：DMC5　エンブレム点灯個数
// //////////////////
struct tipVer352Dmc5Emblem: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("上位ST中のエンブレム関連の設定差判明したのでカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：グール　築山
// //////////////////
struct tipVer352GhoulTsukiyama: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("残りG数示唆の詳細が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
