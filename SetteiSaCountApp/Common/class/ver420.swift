//
//  ver420.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/07/19.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer420UpdateInfo: Tip {
    var title: Text {
        Text("機種追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer420BioRe3Ratio: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("レア役からの当選率 設定差が全て判明")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer420BioRe3Cz: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("スルー天井振分けの情報を追加")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
