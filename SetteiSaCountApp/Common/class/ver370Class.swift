//
//  ver370Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/12.
//

import Foundation
import SwiftUI
import TipKit

class Ver370: ObservableObject {
    @AppStorage("ver370JugSeriesBadge") var jugSeriesBadge: String = "update"
    @AppStorage("ver370MyJug5MenuBayesBadge") var myJug5MenuBayesBadge: String = "new"
    @AppStorage("ver370Mt5MachineIconBadge") var mt5MachineIconBadge: String = "update"
    @AppStorage("ver370Mt5MenuBayesBadge") var mt5MenuBayesBadge: String = "new"
    @AppStorage("ver370Mt5MenuRoundScreenBadge") var mt5MenuRoundScreenBadge: String = "update"
    @AppStorage("ver370DarlingMachineIconBadge") var darlingMachineIconBadge: String = "update"
    @AppStorage("ver370DarlingMenuFirstHitBadge") var darlingMenuFirstHitBadge: String = "update"
    @AppStorage("ver370BioMachineIconBadge") var bioMachineIconBadge: String = "update"
    @AppStorage("ver370BioMenuAtBadge") var bioMenuAtBadge: String = "new"
    @AppStorage("ver370EnenMachineIconBadge") var enenMachineIconBadge: String = "new"
}

// //////////////////
// Tip：機種追加
// //////////////////
struct tipVer370MachineAddver2: Tip {
    var title: Text {
        Text("機種,機能追加！")
    }
    var message: Text? {
        Text("・設定期待値の計算機能が登場！\n　第1弾機種はこちら\n　　・マイジャグラー5\n　　・モンキーターンⅤ\n　今後も対応機種拡大予定\n・スマスロ炎炎の消防隊を追加")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}

// //////////////////
// Tip：ダリフラ　CZ開始レベル
// //////////////////
struct tipVer370DarlingCzLevel: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("CZスタート時のレベルについての設定差情報が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：モンキー　シナリオ選択率
// //////////////////
struct tipVer370Mt5SinarioRatio: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("シナリオ選択率の参考情報を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
