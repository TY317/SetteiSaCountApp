//
//  ver440.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/11.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer440UpdateInfo: Tip {
    var title: Text {
        Text("機種追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer440: Tip {
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
// Tip：
//////////////////
struct tipVer440KokakuCzScreen: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("CZ終了画面 イシカワの設定差が判明\n算出機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer440KokakuIede: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("AT終了時200G・400Gそれぞれの設定差が判明\n個別カウントに対応しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer440BioRe3Bell: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("5枚🔔確率の設定差が判明\nカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：
//////////////////
struct tipVer440BioRe3Point: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("規定ネメシスポイントは滞在状態で振分けが異なります\n通常時・AT中・上位AT中を切り替えてカウントして下さい")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
