//
//  ver3271.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/13.
//

import Foundation
import SwiftUI
import TipKit


//////////////////
// Tip：リオエース　リナサイン
//////////////////
struct tipVer3271RioAceRinaSign: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("リナサインの出現率設定差が判明\n設定判別機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


////////////////////
//// Tip：リオエース エースモード
////////////////////
struct tipVer3271RioAceAceMode: Tip {
   var title: Text {
       Text("機能更新")
   }
   var message: Text? {
       Text("エースモードの突入率設定差が判明\nカウント機能を追加しました")
   }
   var image: Image? {
       Image(systemName: "exclamationmark.bubble")
   }
}


//////////////////
// Tip：SAO2 終了画面示唆
//////////////////
struct tipVer3271Sao2ScreenSisa: Tip {
   var title: Text {
       Text("情報更新")
   }
   var message: Text? {
       Text("終了画面の示唆が全て判明")
   }
   var image: Image? {
       Image(systemName: "exclamationmark.bubble")
   }
}


////////////////////
//// Tip：攻殻機動隊　色ごとのCZ成功率
////////////////////
//struct tipVer3270KokakukidotaiCz: Tip {
//   var title: Text {
//       Text("情報更新")
//   }
//   var message: Text? {
//       Text("緑発展の成功率が判明")
//   }
//   var image: Image? {
//       Image(systemName: "exclamationmark.bubble")
//   }
//}
