//
//  ver310Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/05.
//

import Foundation
import SwiftUI
import TipKit

class Ver310: ObservableObject {
    @AppStorage("ver310GundamSeedMachineIconBadgeStatus") var gundamSeedMachineIconBadgeStatus: String = "new"
    @AppStorage("ver310MagiaMachineIconBadgeStatus") var magiaMachineIconBadgeStatus: String = "update"
    @AppStorage("ver300MagiaMenuVoiceBadgeStatus") var magiaMenuVoiceBadgeStatus: String = "update"
    @AppStorage("ver310MagiaMenuEndingBadgeStatus") var magiaMenuEndingBadgeStatus: String = "update"
    @AppStorage("ver310MagiaMenuStoryCharaBadgeStatus") var magiaMenuStoryCharaBadgeStatus: String = "update"
    @AppStorage("ver310MagiaMenuNormalBadgeStatus") var magiaMenuNormalBadgeStatus: String = "update"
    @AppStorage("ver310SbjMachineIconBadgeStatus") var sbjMachineIconBadgeStatus: String = "update"
    @AppStorage("ver310SbjMenuNormalBadgeStatus") var sbjMenuNormalBadgeStatus: String = "update"
    @AppStorage("ver310MidoriDonMachineIconBadgeStatus") var midoriDonMachineIconBadgeStatus: String = "update"
    @AppStorage("ver310MidoriDonMenuFirstHitBadgeStatus") var midoriDonMenuFirstHitBadgeStatus: String = "update"
}

// //////////////////
// Tip：機種追加
// //////////////////
struct tipVer310MachineAdd: Tip {
    var title: Text {
        Text("機種追加！")
    }
    var message: Text? {
        Text("・ガンダムSEED")
    }
    var image: Image? {
//        Image(systemName: "exclamationmark.bubble")
        Image(systemName: "star")
    }
}

// //////////////////
// Tip:マギレコ　ボイス
// //////////////////
struct tipVer310MagiaVoice: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("ボイスの内容と示唆が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip:マギレコ　エンディング
// //////////////////
struct tipVer310MagiaEnding: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("カードの種類と示唆詳細が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}


// //////////////////
// Tip:マギレコ　ストーリー示唆
// //////////////////
struct tipVer310MagiaStoryChara: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("示唆内容詳細が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip:マギレコ　CZ確率詳細
// //////////////////
struct tipVer310MagiaCzRatio: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("CZ当選率の詳細が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip:マギレコ　魔法少女モード
// //////////////////
struct tipVer310MagiaMagicGirlMode: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("魔法少女モードのカウント機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip:SBJ　ピンチ目
// //////////////////
struct tipVer310SbjPinchMe: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("高確転落を示唆するピンチ目の情報を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip:緑ドン　リーチ目リプレイ確率
// //////////////////
struct tipVer310MidoriDonReachReplay: Tip {
    var title: Text {
        Text("解析情報追加")
    }
    var message: Text? {
        Text("リーチ目リプレイの確率が判明しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
