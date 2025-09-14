//
//  ver391Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/07.
//

import Foundation
import SwiftUI
import TipKit

class Ver391: ObservableObject {
    @AppStorage("ver391JugSeriesBadge") var jugSeriesBadge: String = "update"
    @AppStorage("ver391HanaSeriesBadge") var hanaSeriesBadge: String = "update"
    @AppStorage("ver391MrJugMachineIconBadge") var mrJugMachineIconBadge: String = "update"
    @AppStorage("ver391girlsSSMachineIconBadge") var girlsSSMachineIconBadge: String = "update"
    @AppStorage("ver391goJug3MachineIconBadge") var goJug3MachineIconBadge: String = "update"
    @AppStorage("ver391happyJugV3MachineIconBadge") var happyJugV3MachineIconBadge: String = "update"
    @AppStorage("ver391funky2MachineIconBadge") var funky2MachineIconBadge: String = "update"
    @AppStorage("ver391imJugExMachineIconBadge") var imJugExMachineIconBadge: String = "update"
//    @AppStorage("ver391starHanaMachineIconBadge") var starHanaMachineIconBadge: String = "update"
//    @AppStorage("ver391draHanaSenkohMachineIconBadge") var draHanaSenkohMachineIconBadge: String = "update"
//    @AppStorage("ver391kingHanaMachineIconBadge") var kingHanaMachineIconBadge: String = "update"
//    @AppStorage("ver391hanaTenshoMachineIconBadge") var hanaTenshoMachineIconBadge: String = "update"
    @AppStorage("ver391mrJugMenuBayesBadge") var mrJugMenuBayesBadge: String = "new"
    @AppStorage("ver391girlsSSMenuBayesBadge") var girlsSSMenuBayesBadge: String = "new"
    @AppStorage("ver391goJug3MenuBayesBadge") var goJug3MenuBayesBadge: String = "new"
    @AppStorage("ver391happyJugV3MenuBayesBadge") var happyJugV3MenuBayesBadge: String = "new"
    @AppStorage("ver391funky2MenuBayesBadge") var funky2MenuBayesBadge: String = "new"
    @AppStorage("ver391imJugExMenuBayesBadge") var imJugExMenuBayesBadge: String = "new"
    @AppStorage("ver391starHanaMenuBayesBadge") var starHanaMenuBayesBadge: String = "new"
    @AppStorage("ver391draHanaSenkohMenuBayesBadge") var draHanaSenkohMenuBayesBadge: String = "new"
    @AppStorage("ver391kingHanaMenuBayesBadge") var kingHanaMenuBayesBadge: String = "new"
    @AppStorage("ver391hanaTenshoMenuBayesBadge") var hanaTenshoMenuBayesBadge: String = "new"
    @AppStorage("ver391vvvMachineIconBadge") var vvvMachineIconBadge: String = "update"
    @AppStorage("ver391VVVMenuBayesBadge") var VVVMenuBayesBadge: String = "new"
    @AppStorage("ver391enenMachineIconBadge") var enenMachineIconBadge: String = "update"
    @AppStorage("ver391enenMenuBayesBadge") var enenMenuBayesBadge: String = "new"
}

struct tipVer391UpdateInfo: Tip {
    var title: Text {
//        Text("機種,機能追加！")
        Text("機能追加！")
    }
    var message: Text? {
        Text("・設定期待値の対応機種追加\n　　・ジャグラー全機種\n　　・ハナハナ全機種\n　　・革命機ヴァルヴレイヴ\n　　・スマスロ炎炎ノ消防隊")
    }
    var image: Image? {
        Image(systemName: "star")
    }
}

