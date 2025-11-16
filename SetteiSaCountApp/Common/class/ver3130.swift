//
//  ver3130.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/08.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3130UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・ネオプラネット\n・とある科学の超電磁砲2\n・ヴヴヴ2大量更新")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}

// //////////////////
// Tip：vvv2終了画面
// //////////////////
struct tipVer3130vvv2Screen: Tip {
    var title: Text {
        Text("情報追加")
    }
    var message: Text? {
        Text("終了画面の示唆が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：vvv2ラウンド画面
// //////////////////
struct tipVer3130vvv2RushScreen: Tip {
    var title: Text {
        Text("情報追加")
    }
    var message: Text? {
        Text("ラウンド開始画面の示唆が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：vvv2通常演出示唆
// //////////////////
struct tipVer3130vvv2Normal: Tip {
    var title: Text {
        Text("情報追加")
    }
    var message: Text? {
        Text("示唆の詳細が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：vvv2初当り
// //////////////////
struct tipVer3130vvv2FirstHit: Tip {
    var title: Text {
        Text("情報追加")
    }
    var message: Text? {
        Text("AT直撃、革命・決戦比率の詳細が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
