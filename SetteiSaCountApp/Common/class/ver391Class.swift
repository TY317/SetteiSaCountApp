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
    @AppStorage("ver391toreveMachineIconBadge") var toreveMachineIconBadge: String = "update"
    @AppStorage("ver391toreveMenuStartScreenBadge") var toreveMenuStartScreenBadge: String = "new"
    @AppStorage("ver391toreveMenuCycleBadge") var toreveMenuCycleBadge: String = "update"
    @AppStorage("ver391azurLaneMachineIconBadge") var azurLaneMachineIconBadge: String = "update"
    @AppStorage("ver391azurLaneMenuFirstHitBadge") var azurLaneMenuFirstHitBadge: String = "update"
    @AppStorage("ver391azurLaneMenuAkashiBadge") var azurLaneMenuAkashiBadge: String = "update"
    @AppStorage("ver391azurLaneMenuKagaBadge") var azurLaneMenuKagaBadge: String = "update"
    @AppStorage("ver391toreveMenuScreenBadge") var toreveMenuScreenBadge: String = "update"
    @AppStorage("ver391toreveMenuNormalBadge") var toreveMenuNormalBadge: String = "update"
    @AppStorage("ver391toreveMenuTomanChallengeBadge") var toreveMenuTomanChallengeBadge: String = "update"
    @AppStorage("ver391toreveMenuEndingBadge") var toreveMenuEndingBadge: String = "new"
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

// //////////////////
// Tip：東リべ
// //////////////////
struct tipVer391ToreveCycle: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("サブ液晶のミニキャラセリフ、初当たり時の振分けの示唆情報を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：アズールレーン　白青詳細
// //////////////////
struct tipVer391AzurLaneBonus: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("青7確率が判明したので、白・青を分けて入力する機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：アズールレーン　裏ボタン
// //////////////////
struct tipVer391AzurLaneKagaUra: Tip {
    var title: Text {
        Text("情報追加")
    }
    var message: Text? {
        Text("裏ボタンでの示唆が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// //////////////////
// Tip：アズールレーン　明石チャレンジ
// //////////////////
struct tipVer391AzurLaneAkashi: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("明石チャレンジの示唆詳細が判明したのでカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：アズールレーン　加賀バトル
// //////////////////
struct tipVer391AzurLaneKaga: Tip {
    var title: Text {
        Text("情報追加")
    }
    var message: Text? {
        Text("裏ボタンでの示唆が判明したので情報を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：東京リベンジャーズ　終了画面
// //////////////////
struct tipVer391ToreveScreen: Tip {
    var title: Text {
        Text("情報追加")
    }
    var message: Text? {
        Text("示唆の詳細が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：東京リベンジャーズ　共通ベル
// //////////////////
struct tipVer391ToreveNormal: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("共通ベルに設定差あることが判明したのでカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：東京リベンジャーズ　チャレンジ中の昇格
// //////////////////
struct tipVer391ToreveChallengeRise: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("設定1の昇格率が判明したのでカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
