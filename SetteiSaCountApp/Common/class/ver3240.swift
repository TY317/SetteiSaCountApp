//
//  ver3240.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/13.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3240UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・ミリオンゴッド〜神々の軌跡〜")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


// //////////////////
// Tip：アクダマ　終了画面
// //////////////////
struct tipVer3240AkudamaScreen: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("終了画面示唆の内容が判明")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
