//
//  shinYoshiTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/31.
//

import SwiftUI

struct shinYoshiTableMode: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("・100〜600ptで周期到達")
                Text("・AT後に5回先までのモードが決定\n　6回目以降はCZ失敗ごとに1回ずつモード抽選")
                Text("・CZ終了で次のモードに切り替わる")
            }
            .padding(.bottom)
            
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: ["通常A","通常B","通常C","天国",],
                    maxWidth: 80,
                    lineList: [1,1,2,2]
                )
                unitTableString(
                    columTitle: "特徴",
                    stringList: [
                        "・百の位偶数ポイントがチャンス",
                        "・百の位奇数ポイントがチャンス",
                        "・300pt以下で周期到達\n・周期当選時はATに当選",
                        "・200pt以下で周期到達\n・天国移行率は約43%",
                    ],
                    maxWidth: 300,
                    lineList: [1,1,2,2]
                )
            }
            .padding(.bottom)
            
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "1周期目",
                        "2周期目",
                        "3周期目",
                        "4周期目",
                        "5周期目",
                        "6周期目",
                    ],
                    maxWidth: 80,
                )
                unitTableString(
                    columTitle: "通常A",
                    stringList: [
                        "grayOut",
                        "◯",
                        "◯",
                        "△",
                        "△",
                        "天井",
                    ],
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: [
                        "grayOut",
                        "◯",
                        "◯",
                        "天井",
                        "grayOut",
                        "grayOut",
                    ],
                )
                unitTableString(
                    columTitle: "通常C",
                    stringList: [
                        "grayOut",
                        "◯",
                        "◯",
                        "天井",
                        "grayOut",
                        "grayOut",
                    ],
                )
                unitTableString(
                    columTitle: "天国",
                    stringList: [
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ],
                )
            }
        }
    }
}

#Preview {
    shinYoshiTableMode()
        .padding(.horizontal)
}
