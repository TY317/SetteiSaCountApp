//
//  unitLabelHeaderScreenCount.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/06.
//

import SwiftUI

struct unitLabelHeaderScreenCount: View {
    var body: some View {
        HStack {
            Text("画面カウント")
            unitToolbarButtonQuestion {
                unitExView5body2image(
                    title: "画面カウント",
                    textBody1: "・画面を選択した状態でもう一度タップするとカウントできます",
                    textBody2: "・選択解除は画面上部のボタンでできます",
                    textBody3: "・画像はイメージです。実際の画面と人数やポーズ、持ち物、背景など詳細は異なる場合があります",
                )
            }
        }
    }
}

#Preview {
    unitLabelHeaderScreenCount()
}
