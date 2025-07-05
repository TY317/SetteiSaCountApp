//
//  ver340Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/05.
//

import Foundation
import SwiftUI
import TipKit

class Ver340: ObservableObject {
    @AppStorage("ver340GuiltyCrown2MachineIconBadgeStaus") var guiltyCrown2MachineIconBadgeStaus: String = "new"
    @AppStorage("ver340MidoriDonMachineIconBadgeStatus") var midoriDonMachineIconBadgeStatus: String = "update"
    @AppStorage("ver340MidoriDonMenuEndingBadgeStatus") var midoriDonMenuEndingBadgeStatus: String = "new"
    @AppStorage("ver340IzaBanchoMachineIconBadgeStaus") var izaBanchoMachineIconBadgeStaus: String = "update"
    @AppStorage("ver340Dmc5MachineIconBadgeStaus") var dmc5MachineIconBadgeStaus: String = "update"
    @AppStorage("ver340Dmc5MenuFirstHitBadgeStaus") var dmc5MenuFirstHitBadgeStaus: String = "update"
    @AppStorage("ver340IzaBanchoMenuFirstHitBadgeStaus") var izaBanchoMenuFirstHitBadgeStaus: String = "update"
    @AppStorage("ver340IzaBanchoMenuNormalBadgeStaus") var izaBanchoMenuNormalBadgeStaus: String = "update"
}


// //////////////////
// Tip：機種追加
// //////////////////
//struct tipVer340MachineAdd: Tip {
//    var title: Text {
//        Text("機種追加！")
//    }
//    var message: Text? {
//        Text("・ギルティクラウン2")
//    }
//    var image: Image? {
//        Image(systemName: "star")
//    }
//}


// //////////////////
// Tip：いざ番長　小役解析情報
// //////////////////
struct tipVer340IzaBanchoKorakuRatio: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("設定1のみ小役確率が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
