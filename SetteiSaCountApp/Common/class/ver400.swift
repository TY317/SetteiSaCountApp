//
//  ver400.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/14.
//

import SwiftUI
import SwiftUI
import TipKit


//////////////////
// Tip：リオエース　スイカ
//////////////////
struct tipVer400RioAceNormalSuika: Tip {
    var title: Text {
        Text("機能更新")
    }
    var message: Text? {
        Text("成功抽選の設定差が判明\nカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


////////////////////
//// Tip：バイオRE3　心音レベル
////////////////////
struct tipVer400BioRe3Shinon: Tip {
   var title: Text {
       Text("機能更新")
   }
   var message: Text? {
       Text("心音レベル転落率の設定差が判明\nカウント機能を追加しました")
   }
   var image: Image? {
       Image(systemName: "exclamationmark.bubble")
   }
}


//////////////////
// Tip：攻殻機動隊　殲滅モード移行率
//////////////////
struct tipVer400KokakukidotaiSenmetuMode: Tip {
   var title: Text {
       Text("機能更新")
   }
   var message: Text? {
       Text("CZ失敗後の殲滅モード以降率が判明\nカウント機能を追加しました")
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

