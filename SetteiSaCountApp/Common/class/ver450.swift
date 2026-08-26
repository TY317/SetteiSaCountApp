//
//  ver450.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/16.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer450UpdateInfo: Tip {
    var title: Text {
        Text("機種追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・やじきた道中記\n・とんでもスキルで異世界放浪メシ\n・喰霊-零-Re")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer450: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：スト6 通常時スマホ演出の示唆
//////////////////
struct tipVer450StreetFighter6SmartPhone: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("通常時スマホ演出の示唆内容を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：禁書目録2 前兆発生ゲーム数での法則
//////////////////
struct tipVer450Index2ZenchoGame: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("前兆発生ゲーム数によるモード示唆を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：SAO2 AT直撃発生率
//////////////////
struct tipVer450Sao2Chokugeki: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("AT直撃発生率の設定差を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：とんスキ スイCZ失敗時のゴブリン残数
//////////////////
struct tipVer450TonskillGoblinRemain: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("スイCZ失敗時のゴブリン残数による設定示唆を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：ワダスタ 引き戻しゾーン移行率
//////////////////
struct tipVer450WorldDaiStarComeBack: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("上位ST後の引き戻しゾーン移行率のカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
