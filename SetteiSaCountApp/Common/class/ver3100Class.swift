//
//  ver3100Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/22.
//

import Foundation
import SwiftUI
import TipKit

// //////////////////
// Tip：エヴァ
// //////////////////
struct tipVer3100EvaYakusokuNormal: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("重複当選をカウントする機能を追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：東京リベジャーズ
// //////////////////
struct tipVer3100ToreveKisaki: Tip {
    var title: Text {
        Text("情報追加")
    }
    var message: Text? {
        Text("CZの設定差詳細が判明しました\n設定期待値計算の計算要素にも追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：東京リベジャーズ
// //////////////////
struct tipVer3100ToreveChanceCz: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("通常時チャンス目からのCZ当選率が判明したのでカウント機能を追加しました。設定期待値の計算要素にも追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：エヴァ
// //////////////////
struct tipVer3100EvaFirstHit: Tip {
    var title: Text {
        Text("機能変更")
    }
    var message: Text? {
        Text("前任者の初当りも含めた初当り確率を算出できるようにしました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}

// //////////////////
// Tip：いざ番長
// //////////////////
struct tipVer3100IzaBanchoChokugeki: Tip {
    var title: Text {
        Text("機能追加")
    }
    var message: Text? {
        Text("直撃確率詳細が判明したので、履歴から確率算出と設定判別計算での要素に追加しました")
    }
    var image: Image? {
        Image(systemName: "exclamationmark.bubble")
    }
}
