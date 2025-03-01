//
//  ver220Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/13.
//

import Foundation
import SwiftUI
import TipKit

class Ver220: ObservableObject {
    @AppStorage("ver220SevenSwordsNewBadgeStatus") var sevenSwordsNewBadgeStatus: String = "new"
    @AppStorage("ver220HanaSerieseNewBadgeStatus") var hanaSerieseNewBadgeStatus: String = "new"
    @AppStorage("ver220StarHanaNewBadgeStatus") var starHanaNewBadgeStatus: String = "new"
    @AppStorage("ver220GodEaterUpdateBadgeStatus") var godEaterUpdateBadgeStatus: String = "update"
    @AppStorage("ver220GodEaterUpdateBadgeStatus2") var godEaterUpdateBadgeStatus2: String = "update"
    @AppStorage("ver220SbjUpdateBadgeStatus") var sbjUpdateBadgeStatus: String = "update"
    @AppStorage("ver220SbjUpdateBadgeStatus2") var sbjUpdateBadgeStatus2: String = "update"
}

// //////////////////
// Tip：機種追加
// //////////////////
//struct tipVer220MachineAdd: Tip {
//    var title: Text {
//        Text("機種追加！")
//    }
//    var message: Text? {
//        Text("・七つの魔剣が支配する\n・スターハナハナ")
//    }
//    var image: Image? {
//        Image(systemName: "exclamationmark.bubble")
//    }
//}

// //////////////////
// Tip：機種追加
// //////////////////
struct tipVer220GodEaterKyoCherryChokugeki: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("・強チェリーからのAT直撃確率の情報を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：機種追加
// //////////////////
struct tipVer220AddLink: Tip {
    var title: Text {
        Text("解析サイトへのリンク追加")
    }
    var message: Text? {
        Text("外部の解析サイトページへ移動します\n(本アプリとの関係はありません)")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
