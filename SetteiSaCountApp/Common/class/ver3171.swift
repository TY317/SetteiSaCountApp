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

// //////////////////
// Tip：北斗転生　天破
// //////////////////
struct tipVer3171hokutoTenseiTenha: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("天破の刻 実質出現率が判明\n情報、判別機能更新しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：北斗転生　弱レア役からの天破当選率
// //////////////////
struct tipVer3171hokutoTenseiRareTenha: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("弱レアやくからの天破当選率が判明\n情報、カウント機能更新しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// //////////////////
// Tip：シェイク　小役確率
// //////////////////
struct tipVer3171ShakeKoyaku: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("小役確率の設定差が判明\n情報、判別機能更新しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// //////////////////
// Tip：化物語　レア役からのCZ
// //////////////////
struct tipVer3171BakemonoRareCz: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("レア役からのCZ当選率が判明\n情報、カウント機能更新しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
