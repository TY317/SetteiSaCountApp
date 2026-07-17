//
//  ver412.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/07/16.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer412UpdateInfo: Tip {
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
struct tipVer412KarakuriScreen: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("終了画面の示唆が判明")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
