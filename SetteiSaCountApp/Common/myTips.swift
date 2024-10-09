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



#Preview {
    myTips()
}
