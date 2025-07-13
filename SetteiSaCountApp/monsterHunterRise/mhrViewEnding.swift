//
//  mhrViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/05.
//

import SwiftUI

struct mhrViewEnding: View {
//    @ObservedObject var mhr = Mhr()
    @ObservedObject var mhr: Mhr
    @State var isShowAlert: Bool = false
    var body: some View {
        List {
            Section {
                Text("エンディング中のレア役時におみくじ演出が発生\nおみくじの色で設定を示唆")
                    .foregroundStyle(.secondary)
                    .font(.footnote)
                // //// ボタン横並び
                HStack {
                    // 青
                    unitCountButtonVerticalPercent(
                        title: "青",
                        count: $mhr.endingCountBlue,
                        color: .personalSummerLightBlue,
                        bigNumber: $mhr.endingCountSum,
                        numberofDicimal: 0,
                        minusBool: $mhr.minusCheck
                    )
                    // 緑
                    unitCountButtonVerticalPercent(
                        title: "緑",
                        count: $mhr.endingCountGreen,
                        color: .personalSummerLightGreen,
                        bigNumber: $mhr.endingCountSum,
                        numberofDicimal: 0,
                        minusBool: $mhr.minusCheck
                    )
                    // 赤
                    unitCountButtonVerticalPercent(
                        title: "赤",
                        count: $mhr.endingCountRed,
                        color: .personalSummerLightRed,
                        bigNumber: $mhr.endingCountSum,
                        numberofDicimal: 0,
                        minusBool: $mhr.minusCheck
                    )
                    // その他
                    unitCountButtonVerticalPercent(
                        title: "その他",
                        count: $mhr.endingCountAny,
                        color: .personalSummerLightPurple,
                        bigNumber: $mhr.endingCountSum,
                        numberofDicimal: 0,
                        minusBool: $mhr.minusCheck
                    )
                }
                // //// 参考情報
                unitLinkButton(
                    title: "色と示唆内容",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "エンディング中のレア役示唆",
//                            image1: Image("mhrEnding")
                            tableView: AnyView(mhrTableEnding())
                        )
                    )
                )
            } header: {
                Text("アイルーおみくじの色")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "モンスターハンター ライズ",
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                // マイナスチェック
                unitButtonMinusCheck(minusCheck: $mhr.minusCheck)
                // リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: mhr.resetEnding)
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

#Preview {
    mhrViewEnding(mhr: Mhr())
}
