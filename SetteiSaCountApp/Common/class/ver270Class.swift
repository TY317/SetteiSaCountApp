//
//  ver270Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/03.
//

import Foundation
import SwiftUI
import TipKit

class Ver270: ObservableObject {
    @AppStorage("ver270MagiaMachineIconBadgeStatus") var magiaMachineIconBadgeStatus: String = "new"
    @AppStorage("ver270SevenSwordsMachineIconBadgeStatus") var sevenSwordsMachineIconBadgeStatus = "update"
    @AppStorage("ver270SevenSwordsMenuVoiceBadgeStatus") var sevenSwordsMenuVoiceBadgeStatus = "new"
    @AppStorage("ver270KaijiMachineIconBadgeStatus") var kaijiMachineIconBadgeStatus = "update"
    @AppStorage("ver270KaijiMenuModeBadgeStatus") var kaijiMenuModeBadgeStatus = "new"
    @AppStorage("ver270KaijiMenuRedBigBadgeStatus") var kaijiMenuRedBigBadgeStatus = "new"
    @AppStorage("ver270ShamanKingMachineIconBadgeStatus") var shamanKingMachineIconBadgeStatus = "update"
    @AppStorage("ver270ShamanKingMenuCzFuriwakeBadgeStatus") var shamanKingMenuCzFuriwakeBadgeStatus = "new"
}

// //////////////////
// Tip：機種追加
// //////////////////
//struct tipVer270MachineAdd: Tip {
//    var title: Text {
//        Text("機種追加！")
//    }
//    var message: Text? {
//        Text("・マギアレコード")
//    }
//    var image: Image? {
//        Image(systemName: "exclamationmark.bubble")
//    }
//}
