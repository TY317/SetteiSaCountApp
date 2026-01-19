//
//  ver3171.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/12.
//

import Foundation
import SwiftUI
import TipKit

// //////////////////
// Tip：秘宝伝　REG中の役示唆
// //////////////////
struct tipVer3171hihodenRegSisa: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("成立役ごとの示唆が判明")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// //////////////////
// Tip：北斗転生　ランプ示唆白の詳細
// //////////////////
struct tipVer3171hokutoTenseiLampWhite: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("白・白点滅の比率詳細が判明\n比率算出、判別機能更新しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

