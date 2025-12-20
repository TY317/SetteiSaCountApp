//
//  ver3150.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/13.
//

import Foundation
import TipKit

struct tipVer3150UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・秘宝伝")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}

// //////////////////
// Tip：グール　引き戻し
// //////////////////
struct tipVer3150GhoulComeBack: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("引き戻し当選率が判明！\n引き戻しカウントに更新しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：グール　モードの法則
// //////////////////
struct tipVer3150GhoulModesisa: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("前兆とモード示唆の法則が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
