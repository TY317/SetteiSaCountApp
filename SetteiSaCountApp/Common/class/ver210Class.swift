//
//  ver210Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/05.
//

import Foundation
import SwiftUI
import TipKit

class Ver210: ObservableObject {
    @AppStorage("sbjNewBadgeStatus") var sbjNewBadgeStatus: String = "new"
    @AppStorage("ver210JugTopNewBadgeStatus") var ver210JugTopNewBadgeStatus: String = "new"
    @AppStorage("ver210MrJugNewBadgeStatus") var ver210MrJugNewBadgeStatus: String = "new"
    @AppStorage("ver210Funky2NewBadgeStatus") var ver210Funky2NewBadgeStatus: String = "new"
    @AppStorage("ver210GirlsSSNewBadgeStatus") var ver210GirlsSSNewBadgeStatus: String = "new"
}

// //////////////////
// Tip：機種追加
// //////////////////
struct tipVer210MachineAdd: Tip {
    var title: Text {
        Text("機種追加！")
    }
    var message: Text? {
        Text("・スーパーブラックジャック\n・ミスタージャグラー\n・ジャグラーガールズ\n・ファンキージャグラー")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

