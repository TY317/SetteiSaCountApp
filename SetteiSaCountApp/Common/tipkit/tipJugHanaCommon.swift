//
//  tipJugHanaCommon.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/28.
//

import SwiftUI
import TipKit

struct tipJugHanaCommon: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// /////////////////////
// Tip：見メニュー の説明
// /////////////////////
struct tipUnitJugHanaCommonKenView: Tip {
    var title: Text {
        Text("見")
    }
    
    var message: Text? {
        Text("空き台のぶどう・ベル逆算値はこちらで確認。そのまま打ち始めデータとして登録も可能です。")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// /////////////////////
// Tip：実戦メニューの説明
// /////////////////////
struct tipUnitJugHanaCommonJissenView: Tip {
    var title: Text {
        Text("実戦")
    }
    
    var message: Text? {
        Text("実戦する際はこちら\n打ち始めデータ：前任者のデータ入力\n実戦カウント：自分のプレイデータ\n総合結果確認：前任者＋自分のデータで結果確認")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}

// /////////////////////
// Tip：見ページ　打ち始めデータへの登録説明
// /////////////////////
struct tipUnitJugHanaCommonKenDataTohroku: Tip {
    var title: Text {
        Text("打ち始めデータとして登録")
    }
    
    var message: Text? {
        Text("このページのデータを実戦の打ち始めデータとして登録できます。登録すると現在の実戦データはリセットされますのでご注意下さい。")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}

// ////////////////////
// Tip: カウント値直接入力
// ////////////////////
struct tipUnitJugHanaCommonCountInput: Tip {
    var title: Text {
        Text("カウント値 直接入力")
    }
    
    var message: Text? {
        Text("カウントの数値を直接入力したい場合はこちら")
    }
    var image: Image? {
//        Image(systemName: "lightbulb.min")
        Image(systemName: "keyboard")
    }
}



#Preview {
    tipJugHanaCommon()
}
