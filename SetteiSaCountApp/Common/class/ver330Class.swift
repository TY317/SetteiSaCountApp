//
//  ver330Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/25.
//

import Foundation
import SwiftUI
import TipKit

class Ver330: ObservableObject {
    @AppStorage("ver330IzaBanchoMachineIconBadgeStaus") var izaBanchoMachineIconBadgeStaus: String = "new"
    @AppStorage("ver330Dmc5MachineIconBadgeStaus") var dmc5MachineIconBadgeStaus: String = "new"
    @AppStorage("ver330RslMachineIconBadgeStaus") var rslMachineIconBadgeStaus: String = "update"
    @AppStorage("ver330RslMenuFirstHitBadgeStaus") var rslMenuFirstHitBadgeStaus: String = "update"
    @AppStorage("ver330IdolMasterMachineIconBadgeStaus") var idolMasterMachineIconBadgeStaus: String = "update"
    @AppStorage("ver330IdolMasterMenuScreenBadgeStaus") var idolMasterMenuScreenBadgeStaus: String = "update"
}


// //////////////////
// Tip：機種追加
// //////////////////
//struct tipVer330MachineAdd: Tip {
//    var title: Text {
//        Text("機種追加！")
//    }
//    var message: Text? {
//        Text("・いざ！番長\n・Devil May Cry5")
//    }
//    var image: Image? {
////        Image(systemName: "exclamationmark.bubble")
//        Image(systemName: "star")
//    }
//}

// //////////////////
// Tip:レビュースタァライト　設定差のあるREG
// //////////////////
struct tipVer330RslReg: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("設定差の大きいREG当選契機の設定2〜5の数値が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip:アイドルマスター　画面
// //////////////////
struct tipVer330IdolMasterScreen: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("画面の示唆詳細が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
