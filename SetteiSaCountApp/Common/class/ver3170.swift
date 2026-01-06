//
//  ver3170.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3170UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・シェイクBT")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


// //////////////////
// Tip：レールガン　エピボ直撃
// //////////////////
struct tipVer3170railgunEpisode: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("エピソードボーナス直撃当選率の設定差が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
