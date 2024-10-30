//
//  myTips.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/24.
//

import SwiftUI
import TipKit

struct myTips: View {
    var body: some View {
        Text("Hello, World!")
    }
}


// //////////////////
// Tip：画像選択の説明
// //////////////////
struct tipUnitButtonScreenChoiceFirstTap: Tip {
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
struct tipUnitButtonScreenChoiceSecondTap: Tip {
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
// Tip：画像カウントの説明
// //////////////////
struct tipUnitButtonScreenChoice: Tip {
    var title: Text {
        Text("画面カウント")
    }
    
    var message: Text? {
        Text("タップで選択して、さらにタップでカウント")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// //////////////////
// Tip：データインプットビューでの画像選択の説明
// //////////////////
struct tipUnitButtonScreenChoiceForDataInput: Tip {
    var title: Text {
        Text("画面選択")
    }
    
    var message: Text? {
        Text("タップで選択。選択中の画像が登録されます")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// //////////////////
// Tip：画像選択の解除
// //////////////////
struct tipUnitButtonScreenChoiceClear: Tip {
    var title: Text {
        Text("選択解除")
    }
    
    var message: Text? {
        Text("ボタンタップで選択解除")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// /////////////////////
// Tip：データ全消去
// /////////////////////
struct tipUnitButtonReset: Tip {
    var title: Text {
        Text("データ消去")
    }
    
    var message: Text? {
        Text("ページ内 または機種の全データを消去")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// /////////////////////
// Tip：アイコン表示モード切り替え
// /////////////////////
struct tipUnitButtonIconDisplayMode: Tip {
    var title: Text {
        Text("アイコン表示モード切替")
    }
    
    var message: Text? {
        Text("機種アイコンを並べた表示モード。表示される機種は変わりません。")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// /////////////////////
// Tip：データ読み出しボタンの説明
// /////////////////////
struct tipUnitButtonLoadMemory: Tip {
    var title: Text {
        Text("メモリーデータ読み出し")
    }
    
    var message: Text? {
        Text("メモリーへ保存したデータを読み出すことができます")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// /////////////////////
// Tip：データ上書きボタンの説明
// /////////////////////
struct tipUnitButtonSaveMemory: Tip {
    var title: Text {
        Text("メモリーへ上書き保存")
    }
    
    var message: Text? {
        Text("現在のデータをメモリーへ上書き保存することができます")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


// /////////////////////
// Tip：メモリー機能の説明
// /////////////////////
struct tipUnitButtonMemory: Tip {
    var title: Text {
        Text("メモリー機能")
    }
    
    var message: Text? {
        Text("・現在のデータ保存\n・保存したデータの読み出し\nができます")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


#Preview {
    myTips()
}
