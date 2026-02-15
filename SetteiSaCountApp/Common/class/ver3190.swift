//
//  ver3190.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/15.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3190UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・スマスロ ハナビ")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


// //////////////////
// Tip：鉄拳　終了画面示唆判明
// //////////////////
struct tipVer3190TekkenScreen: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("赤背景画面の示唆が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// //////////////////
// Tip：攻殻機動隊　CZ終了画面示唆判明
// //////////////////
struct tipVer3190KokakukidotaiCzScreen: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("CZ終了画面の一部示唆が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// //////////////////
// Tip：無職転生　本気ボーナス確率
// //////////////////
struct tipVer3190MushotenHonki: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("本気ボーナス当選の設定差が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
