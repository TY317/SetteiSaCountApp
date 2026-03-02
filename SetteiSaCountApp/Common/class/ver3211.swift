//
//  ver3211.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/02.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3211UpdateInfo: Tip {
    var title: Text {
        Text("機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・カバネリ 海門決戦\n　　下段ベル、設定判別計算\n・攻殻機動隊 他")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}

// //////////////////
// Tip：炎炎　終了画面
// //////////////////
//struct tipVer3210Enen2Screen: Tip {
//    var title: Text {
//        Text("情報更新")
//    }
//    var message: Text? {
//        Text("示唆が全て判明しました")
//    }
//    var image: Image? {
//        Image(systemName: "exclamationmark.bubble")
//    }
//}
