//
//  inuyashaViewAim.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/19.
//

import SwiftUI

struct inuyashaViewAim: View {
//    @ObservedObject var inuyasha = Inuyasha()
    @ObservedObject var inuyasha: Inuyasha
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            // //// 狙え成功時の犬夜叉ランプ
            Section {
                HStack {
                    // 白
                    unitCountButtonVerticalPercent(
                        title: "白",
                        count: $inuyasha.inuyashaLampCountWhite,
                        color: .gray,
                        bigNumber: $inuyasha.inuyashaLampCountSum,
                        numberofDicimal: 0,
                        minusBool: $inuyasha.minusCheck
                    )
                    // 青
                    unitCountButtonVerticalPercent(
                        title: "青",
                        count: $inuyasha.inuyashaLampCountBlue,
                        color: .personalSummerLightBlue,
                        bigNumber: $inuyasha.inuyashaLampCountSum,
                        numberofDicimal: 0,
                        minusBool: $inuyasha.minusCheck
                    )
                    // 虹
                    unitCountButtonVerticalPercent(
                        title: "虹",
                        count: $inuyasha.inuyashaLampCountRainbow,
                        color: .personalSummerLightPurple,
                        bigNumber: $inuyasha.inuyashaLampCountSum,
                        numberofDicimal: 0,
                        minusBool: $inuyasha.minusCheck
                    )
                }
                // //// 参考情報のリンク
                unitLinkButton(
                    title: "犬夜叉ランプでの示唆について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "犬夜叉ランプでの示唆",
                            textBody1: "・狙え演出成功時の犬夜叉ランプ色で設定を示唆",
                            image1: Image("inuyashaInuyashaLamp")
                        )
                    )
                )
            } header: {
                Text("狙え成功時の犬夜叉ランプ色")
            }
        }
        .navigationTitle("犬夜叉ランプ")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $inuyasha.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: inuyasha.resetInuyashaLamp)
                }
            }
        }
    }
}

#Preview {
    inuyashaViewAim(inuyasha: Inuyasha())
}
