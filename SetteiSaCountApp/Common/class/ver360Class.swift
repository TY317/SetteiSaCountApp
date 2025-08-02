//
//  ver360Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/27.
//

import Foundation
import SwiftUI
import TipKit

class Ver360: ObservableObject {
    @AppStorage("ver360DarlingMachineIconBadge") var darlingMachineIconBadge: String = "new"
    @AppStorage("ver360ReSwordMachineIconBadge") var reSwordMachineIconBadge: String = "new"
    @AppStorage("ver360YoshimuneMachineIconBadge") var yoshimuneMachineIconBadge: String = "update"
    @AppStorage("ver360YoshimuneMenuNormalBadge") var yoshimuneMenuNormalBadge: String = "update"
    @AppStorage("ver360GuiltyCrown2MachineIconBadge") var guiltyCrown2MachineIconBadge: String = "update"
    @AppStorage("ver360GuiltyCrown2MenuAtBadge") var guiltyCrown2MenuAtBadge: String = "new"
}

// //////////////////
// Tip：吉宗　共通俵
// //////////////////
struct tipVer360YoshimuneCommonTawara: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("共通俵の設定差が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
