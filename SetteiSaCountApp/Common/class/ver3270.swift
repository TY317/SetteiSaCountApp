//
//  ver3270.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/30.
//

import Foundation
import SwiftUI
import TipKit

struct tipVer3270UpdateInfo: Tip {
    var title: Text {
        Text("機種,機能追加！")
//        Text("機能追加！")
    }
    var message: Text? {
        Text("・戦国乙女5\n・S.A.O 2")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}


//////////////////
// Tip：ゴッド軌跡　昇格Z-Zone
//////////////////
struct tipVer3270GodKisekiZzoneRise: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("GG当選時のZ-ZONE昇格率が判明\nカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


////////////////////
//// Tip：ゴッド軌跡　小役での当選率
////////////////////
struct tipVer3270GodKisekiKoyakuHit: Tip {
   var title: Text {
       Text("情報更新")
   }
   var message: Text? {
       Text("小役からのGG当選率の情報を追加")
   }
   var image: Image? {
       Image(systemName: "exclamationmark.bubble")
   }
}


//////////////////
// Tip：カバネリ　3周期当選率
//////////////////
struct tipVer3270KabaneriCycle3: Tip {
   var title: Text {
       Text("機能更新")
   }
   var message: Text? {
       Text("3周期目での当選率設定差が判明\nカウント機能を追加")
   }
   var image: Image? {
       Image(systemName: "exclamationmark.bubble")
   }
}


//////////////////
// Tip：攻殻機動隊　色ごとのCZ成功率
//////////////////
struct tipVer3270KokakukidotaiCz: Tip {
   var title: Text {
       Text("情報更新")
   }
   var message: Text? {
       Text("緑発展の成功率が判明")
   }
   var image: Image? {
       Image(systemName: "exclamationmark.bubble")
   }
}
