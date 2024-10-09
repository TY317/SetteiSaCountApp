//
//  goevaViewAtScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/28.
//

import SwiftUI

struct goevaViewAtScreen: View {
    @ObservedObject var goeva = Goeva()
    @State var isShowAlert = false
    
    var body: some View {
//        NavigationView {
            List {
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // 初号機
                        unitButtonScreenChoice(image: Image("goevaAtScreenShogoki"), keyword: goeva.atScreenShogokiKeyword, currentKeyword: $goeva.atScreenCurrentKeyword, count: $goeva.atScreenShogokiCount, minusCheck: $goeva.minusCheck)
                            .popoverTip(tipUnitButtonScreenChoice())
                        // 零号機
                        unitButtonScreenChoice(image: Image("goevaAtScreenZerogoki"), keyword: goeva.atScreenZerogokiKeyword, currentKeyword: $goeva.atScreenCurrentKeyword, count: $goeva.atScreenZerogokiCount, minusCheck: $goeva.minusCheck)
                        // 8号機
                        unitButtonScreenChoice(image: Image("goevaAtScreen8goki"), keyword: goeva.atScreen8gokiKeyword, currentKeyword: $goeva.atScreenCurrentKeyword, count: $goeva.atScreen8gokiCount, minusCheck: $goeva.minusCheck)
                        // 2号機
                        unitButtonScreenChoice(image: Image("goevaAtScreen2goki"), keyword: goeva.atScreen2gokiKeyword, currentKeyword: $goeva.atScreenCurrentKeyword, count: $goeva.atScreen2gokiCount, minusCheck: $goeva.minusCheck)
                        // モスラ
                        unitButtonScreenChoice(image: Image("goevaAtScreenMosura"), keyword: goeva.atScreenMosuraKeyword, currentKeyword: $goeva.atScreenCurrentKeyword, count: $goeva.atScreenMosuraCount, minusCheck: $goeva.minusCheck)
                        // ゴジエヴァ
                        unitButtonScreenChoice(image: Image("goevaAtScreenGoeva"), keyword: goeva.atScreenGoevaKeyword, currentKeyword: $goeva.atScreenCurrentKeyword, count: $goeva.atScreenGoevaCount, minusCheck: $goeva.minusCheck)
                        // カヲル
                        unitButtonScreenChoice(image: Image("goevaAtScreenKaoru"), keyword: goeva.atScreenKaoruKeyword, currentKeyword: $goeva.atScreenCurrentKeyword, count: $goeva.atScreenKaoruCount, minusCheck: $goeva.minusCheck)
                    }
                }
                .frame(height: 120)
                
                // //// 結果表示
                // 初号機
                unitResultCountListPercent(title: "デフォルト", count: $goeva.atScreenShogokiCount, flashColor: .gray, bigNumber: $goeva.atScreenCountSum)
                // 零号機
                unitResultCountListPercent(title: "偶数設定示唆", count: $goeva.atScreenZerogokiCount, flashColor: .yellow, bigNumber: $goeva.atScreenCountSum)
                // 8号機
                unitResultCountListPercent(title: "高設定示唆(弱)", count: $goeva.atScreen8gokiCount, flashColor: .pink, bigNumber: $goeva.atScreenCountSum)
                // 2号機
                unitResultCountListPercent(title: "高設定示唆(強)", count: $goeva.atScreen2gokiCount, flashColor: .red, bigNumber: $goeva.atScreenCountSum)
                // モスラ
                unitResultCountListPercent(title: "設定4以上濃厚", count: $goeva.atScreenMosuraCount, flashColor: .orange, bigNumber: $goeva.atScreenCountSum)
                // ゴジエヴァ
                unitResultCountListPercent(title: "設定5以上濃厚", count: $goeva.atScreenGoevaCount, flashColor: .purple, bigNumber: $goeva.atScreenCountSum)
                // カヲル
                unitResultCountListPercent(title: "設定6濃厚", count: $goeva.atScreenKaoruCount, flashColor: .green, bigNumber: $goeva.atScreenCountSum)
            }
            .navigationTitle("AT終了画面")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonToolbarScreenSelectReset(currentKeyword: $goeva.atScreenCurrentKeyword)
                            .popoverTip(tipUnitButtonScreenChoiceClear())
                        unitButtonMinusCheck(minusCheck: $goeva.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: goeva.resetAtScreen)
                    }
                }
            }
//        }
//        .navigationTitle("AT終了画面")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonToolbarScreenSelectReset(currentKeyword: $goeva.atScreenCurrentKeyword)
//                        .popoverTip(tipUnitButtonScreenChoiceClear())
////                        .popoverTip(tipUnitButtonScreenChoiceClear())
//                    unitButtonMinusCheck(minusCheck: $goeva.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: goeva.resetAtScreen)
//                }
//            }
//        }
    }
}

#Preview {
    goevaViewAtScreen()
}
