//
//  ver3180.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/25.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3180UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・炎炎ノ消防隊2\n・攻殻機動隊")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}

// //////////////////
// Tip：北斗転生　設定変更時の256
// //////////////////
struct tipVer3180hokutoTensei256: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("設定変更時の256までの当選期待度が判明")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：鉄拳6 レア役からの直撃
// //////////////////
struct tipVer3180tekken6RareDirect: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("レア役からのボーナス直撃設定差が判明\nカウント機能追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
