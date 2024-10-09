//
//  VVVendScreenTip.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/13.
//

import SwiftUI
import TipKit

struct VVVendScreenTipView: View {
    var body: some View {
        Text("Hello, World!\nccc")
    }
}


// //////////////////
// Tip：履歴追加ボタンの説明
// //////////////////
struct VVVTipCzAddButton: Tip {
    var title: Text {
        Text("履歴の追加")
    }
    var message: Text? {
        Text("タップ後の画面で詳細選択し登録ボタンをタップ")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// //////////////////
// Tip：画像選択の説明
// //////////////////
struct VVVTipEndScreenFirstTap: Tip {
    var title: Text {
        Text("画像の選択")
    }
    var message: Text? {
        Text("画像をタップ")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}

// //////////////////
// Tip：画像カウントの説明
// //////////////////
struct VVVTipEndScreenSecondTap: Tip {
    var title: Text {
        Text("カウントアップ")
    }
    
    var message: Text? {
        Text("もう一度タップ")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// //////////////////
// Tip：マリエ覚醒カウントの説明
// //////////////////
struct VVVTipMarieCount: Tip {
    var title: Text {
        Text("マリエ覚醒カウント")
    }
    
    var message: Text? {
        Text("ボタンタップでカウント")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// //////////////////
// Tip：ドライブ有利区間について
// //////////////////
struct VVVTipDriveBefore: Tip {
    var title: Text {
        Text("有利切断前のドライブ")
    }
    
    var message: Text? {
        Text("最初はこちらでカウント。有利切断については下の説明リンクを参照。")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// //////////////////
// Tip：ドライブ　ボタンの説明１
// //////////////////
struct VVVTipDrive1020Button: Tip {
    var title: Text {
        Text("ドライブ以外")
    }
    
    var message: Text? {
        Text("10G,20Gのセット数はこちらでカウント")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// //////////////////
// Tip：ドライブ　ボタンの説明２
// //////////////////
struct VVVTipDriveDriveButton: Tip {
    var title: Text {
        Text("ハラキリドライブ")
    }
    
    var message: Text? {
        Text("ハラキリドライブのセット数はこちらでカウント")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


#Preview {
    VVVendScreenTipView()
}
