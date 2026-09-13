//
//  aobutaTableFukashigiMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/09/13.
//

import SwiftUI

struct aobutaTableFukashigiMode: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("・6種類の特殊なモードに滞在の可能性あり")
            Text("・リール左のクリスタルにヒロインが登場すると、そのヒロインの不可思議モードに滞在！？")
        }
        VStack(spacing: 20) {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "古賀朋絵",
                        "豊浜のどか",
                        "双葉理央",
                        "桜島麻衣",
                        "梓川かえで",
                        "牧之原翔子",
                    ],
                    maxWidth: 110,
                )
                unitTableString(
                    columTitle: "特徴",
                    stringList: [
                        "次回の規定思春期ポイントが100pt",
                        "アオハルチャンスの報酬が優遇",
                        "つねにアオハルチャンスの高確率状態",
                        "当該の規定思春期ポイントが300or500pt",
                        "次回のCZにかえでが登場",
                        "次回のCZに翔子が登場",
                    ],
                    maxWidth: 260,
                    contentFont: .subheadline,
                )
            }
        }
    }
}

#Preview {
    aobutaTableFukashigiMode()
        .padding(.horizontal)
}
