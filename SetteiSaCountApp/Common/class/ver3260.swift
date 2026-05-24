//
//  ver3260.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/13.
//

import Foundation
import SwiftUI
import TipKit

//struct tipVer3260UpdateInfo: Tip {
//    var title: Text {
//        Text("機種,機能追加！")
////        Text("機能追加！")
//    }
//    var message: Text? {
//        Text("・バイオRE3\n・スーパーリオエース2")
//    }
//    var image: Image? {
//        Image(systemName: "star")
//    }
//}
//
//
 //////////////////
 // Tip：化物語　解呪連
 //////////////////
struct tipVer3260BakemonoAfterAtKaijuren: Tip {
    var title: Text {
        Text("情報更新")
    }
    var message: Text? {
        Text("AT終了後の解呪連移行率が判明\nカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


//////////////////
// Tip：リオエース　エースモード
//////////////////
struct tipVer3260RioAceMode: Tip {
   var title: Text {
       Text("情報更新")
   }
   var message: Text? {
       Text("エースモードの情報を追加")
   }
   var image: Image? {
       Image(systemName: "exclamationmark.bubble")
   }
}


//////////////////
// Tip：ゴッド　裏天国示唆
//////////////////
struct tipVer3260GodKisekiUratensisa: Tip {
   var title: Text {
       Text("情報更新")
   }
   var message: Text? {
       Text("裏天国示唆の演出情報を追加")
   }
   var image: Image? {
       Image(systemName: "exclamationmark.bubble")
   }
}


//////////////////
// Tip：攻殻機動隊　色ごとのCZ成功率
//////////////////
struct tipVer3260KokakukidotaiCz: Tip {
   var title: Text {
       Text("機能更新")
   }
   var message: Text? {
       Text("発展色ごとの成功率が判明\nカウント機能を追加しました")
   }
   var image: Image? {
       Image(systemName: "exclamationmark.bubble")
   }
}
