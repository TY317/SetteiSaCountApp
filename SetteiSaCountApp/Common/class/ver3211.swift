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
// Tip：カバネリ２　下段ベル
// //////////////////
struct tipVer3211KabaneriUnatoLowerBell: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("下段ベルの設定差が判明\nカウント、設定判別機能追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// //////////////////
// Tip：攻殻機動隊　CZ
// //////////////////
struct tipVer3211KokakukidotaiCz: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("終了画面示唆、視覚HACK設定差が判明\nカウント機能追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
