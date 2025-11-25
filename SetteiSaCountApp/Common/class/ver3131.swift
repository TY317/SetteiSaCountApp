//
//  ver3131.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/22.
//

import Foundation
import SwiftUI
import TipKit

//struct tipVer3131UpdateInfo: Tip {
//    var title: Text {
//        Text("機種,機能追加！")
////        Text("機能追加！")
//    }
//    var message: Text? {
//        Text("・ネオプラネット\n・とある科学の超電磁砲2\n・ヴヴヴ2大量更新")
//    }
//    var image: Image? {
//        Image(systemName: "star")
//    }
//}


// //////////////////
// Tip：ネオプラ 星座、終了画面
// //////////////////
struct tipVer3131neoplaNormal: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("星座、終了画面の示唆が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// //////////////////
// Tip：ネオプラ 星座、終了画面
// //////////////////
struct tipVer3131neoplaScreen: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("終了画面の示唆が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// //////////////////
// Tip：クレア　小役、重複
// //////////////////
struct tipVer3131creaNormal: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("小役確率、重複当選確率が判明！\nカウント機能と解析情報更新しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：クレア　小役、重複
// //////////////////
struct tipVer3131creaBayes: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("小役確率、重複当選確率が判明！\n計算要素に加えました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// //////////////////
// Tip：ツールバー
// //////////////////
struct tipVer3131Toolbar: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("・ダークモードへの切り替え機能を追加しました\n・表示モードの切替えUIを微修正しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// //////////////////
// Tip：東リべ　初当り
// //////////////////
struct tipVer3131ToreveFirsthit: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("モードごとの初当り種類振分けが判明！\nカウント機能追加＆情報更新しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：東リべ　ベイズ
// //////////////////
struct tipVer3131ToreveBayes: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("モードごとの初当り種類振分けが判明！\n計算要素に加えました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// //////////////////
// Tip：東リべ　周期
// //////////////////
struct tipVer3131ToreveCycle: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("周期×モード×設定ごとの当選率詳細が判明!\n参考として比較的設定差の大きい2,3周期目の当選率を履歴から自動算出機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：vvv2 モード
// //////////////////
struct tipVer3131vvv2Mode: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("ポイント、周期の振分けやモード移行率の詳細が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
