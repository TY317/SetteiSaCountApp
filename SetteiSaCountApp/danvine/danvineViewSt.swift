//
//  danvineViewSt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/31.
//

import SwiftUI

struct danvineViewSt: View {
    @ObservedObject var danvine = Danvine()
    @State var isShowAlert = false
    
    var body: some View {
        List {
            // //// ST中ボーナス 狙え演出時のランプ色
            Section {
                // //// カウントボタン
                HStack {
                    // 白・青
                    unitCountButtonVerticalPercent(
                        title: "白・青",
                        count: $danvine.chamLampCountWhitBlue,
                        color: .personalSummerLightBlue,
                        bigNumber: $danvine.chamLampCountSum,
                        numberofDicimal: 0,
                        minusBool: $danvine.minusCheck
                    )
                    // 黄
                    unitCountButtonVerticalPercent(
                        title: "黄",
                        count: $danvine.chamLampCountYellow,
                        color: .personalSpringLightYellow,
                        bigNumber: $danvine.chamLampCountSum,
                        numberofDicimal: 1,
                        minusBool: $danvine.minusCheck,
                        flushColor: .yellow
                    )
                    // 緑
                    unitCountButtonVerticalPercent(
                        title: "緑",
                        count: $danvine.chamLampCountGreen,
                        color: .personalSummerLightGreen,
                        bigNumber: $danvine.chamLampCountSum,
                        numberofDicimal: 1,
                        minusBool: $danvine.minusCheck
                    )
                    // 赤
                    unitCountButtonVerticalPercent(
                        title: "赤",
                        count: $danvine.chamLampCountRed,
                        color: .personalSummerLightRed,
                        bigNumber: $danvine.chamLampCountSum,
                        numberofDicimal: 1,
                        minusBool: $danvine.minusCheck
                    )
                }
                // //// 参考情報
                unitLinkButton(
                    title: "狙え演出時のランプ色について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "狙え演出時のランプ色",
                            textBody1: "・ST中ボーナスで発生する中リール狙え演出時のチャムランプ色で設定を示唆",
                            textBody2: "・チャムランプは台枠左にあり。数回点滅したら消えるため見逃さないよう注意",
                            image1: Image("danvineChamLamp"),
                            image2: Image("danvineChamLampRatio")
                        )
                    )
                )
            } header: {
                Text("ST中ボーナス 狙え演出時のランプ色")
            }
            
            // //// オーラアタック
            Section {
                // カウントボタン、結果表示
                HStack {
                    // アタックなし
                    unitCountButtonVerticalWithoutRatio(
                        title: "アタックなし",
                        count: $danvine.auraAttackCountNone,
                        color: .personalSummerLightBlue,
                        minusBool: $danvine.minusCheck
                    )
                    // アタックあり
                    unitCountButtonVerticalWithoutRatio(
                        title: "アタックあり",
                        count: $danvine.auraAttackCountWin,
                        color: .personalSummerLightRed,
                        minusBool: $danvine.minusCheck
                    )
                    // アタック確率
                    unitResultRatioDenomination2Line(
                        title: "アタック率",
                        count: $danvine.auraAttackCountWin,
                        bigNumber: $danvine.auraAttackCountSum,
                        numberofDicimal: 1,
                        spacerBool: false
                    )
                    .padding(.vertical)
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "オーラアタックについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "オーラアタック",
                            textBody1: "・上位ST中のオーラアタックに設定差があると言われている",
                            textBody2: "・高設定は1/4以上との噂あり"
                        )
                    )
                )
            } header: {
                Text("上位ST中のオーラアタック")
            }
            
            // //// 聖戦士への道
            Section {
                unitLinkButton(
                    title: "聖戦士への道 初期ゲーム数について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "聖戦士への道",
                            textBody1: "・継続ゲーム数は10・20・30Gのいずれか",
                            textBody2: "・20、30Gの場合も基本はLAST 10Gから始まり、消化後に継続する形で進行",
                            textBody3: "・初期表示の段階でLAST 20、30Gから始まった場合は設定示唆となる",
                            image1: Image("danvineSeisenshi")
                        )
                    )
                )
            } header: {
                Text("聖戦士への道 初期ゲーム数")
            }
        }
        .navigationTitle("ST中")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $danvine.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: danvine.resetSt)
                }
            }
        }
    }
}

#Preview {
    danvineViewSt()
}
