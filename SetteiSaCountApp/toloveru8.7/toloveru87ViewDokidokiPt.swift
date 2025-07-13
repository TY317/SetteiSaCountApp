//
//  toloveru87ViewDokidokiPt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/21.
//

import SwiftUI

struct toloveru87ViewDokidokiPt: View {
    @ObservedObject var toloveru87: Toloveru87
    @State var isShowAlert = false
    @State var isShowAlertLeft = false
    @State var isShowAlertCenter = false
    @State var isShowAlertRight = false
    
    var body: some View {
        List {
            Section {
                Text("前作と同じ仕様という前提で作成しています")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
            }
            
            // //// 関連情報
            Section {
                // 基本情報
                unitLinkButton(
                    title: "基本情報",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "どきどきポイント",
                            textBody1: "・チャンス目成立時に獲得できる内部ポイント",
                            textBody2: "・150ptに到達するとCZへ突入",
                            textBody3: "・内部状態やアイテム所持状況で獲得できるポイントが変動する",
                            tableView: AnyView(toloveruTableDokidokiDefault())
                        )
                    )
                )
                // チャンス目成立時の獲得ポイントについて
                unitLinkButton(
                    title: "チャンス目成立時の獲得ptについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "チャンス目成立時の獲得pt",
                            textBody1: "・内部状態、どきどき高確、所持アイテム,チャンス目種類で獲得ptが異なる",
                            tableView: AnyView(toloveruTableDokidokiPt())
                        )
                    )
                )
                // ポイント示唆
                unitLinkButton(
                    title: "ポイント示唆について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ポイント示唆",
                            tableView: AnyView(toloveru87TablePtSisa())
                        )
                    )
                )
            } header: {
                Text("どきどきポイント関連情報")
            }
            
            // //// ポイントカウント
            Section {
                Text("ポイント蓄積量のメモ代わりとして活用ください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                HStack {
                    VStack {
                        Text("[左]")
                            .font(.title)
                        // +1pt
                        unitPlusButton(
                            count: $toloveru87.dokiPtLeft,
                            plusNumber: 1,
                            buttonColor: .pink,
                            minusCheck: toloveru87.minusCheck
                        )
                        // +10pt
                        unitPlusButton(
                            count: $toloveru87.dokiPtLeft,
                            plusNumber: 10,
                            buttonColor: .pink,
                            minusCheck: toloveru87.minusCheck
                        )
                        // +75pt
                        unitPlusButton(
                            count: $toloveru87.dokiPtLeft,
                            plusNumber: 75,
                            buttonColor: .pink,
                            minusCheck: toloveru87.minusCheck
                        )
                        // 推定ポイント
                        unitResultCount2Line(
                            title: "左 推定pt",
                            color: .personalSummerLightRed,
                            count: $toloveru87.dokiPtLeft,
                            spacerBool: false
                        )
                        .padding(.top, 5)
                        // リセットボタン
                        unitButtonResetBorderedStyle(
                            isShowAlert: self.$isShowAlertLeft,
                            buttonText: "左ﾘｾｯﾄ",
                            action: toloveru87.resetDokiDokiPointLeft,
                            message: "左チャンス目の推定ポイントのみリセットします"
                        )
                    }
                    VStack {
                        Text("[中]")
                            .font(.title)
                        // +1pt
                        unitPlusButton(
                            count: $toloveru87.dokiPtCenter,
                            plusNumber: 1,
                            buttonColor: .green,
                            minusCheck: toloveru87.minusCheck
                        )
                        // +10pt
                        unitPlusButton(
                            count: $toloveru87.dokiPtCenter,
                            plusNumber: 10,
                            buttonColor: .green,
                            minusCheck: toloveru87.minusCheck
                        )
                        // +75pt
                        unitPlusButton(
                            count: $toloveru87.dokiPtCenter,
                            plusNumber: 75,
                            buttonColor: .green,
                            minusCheck: toloveru87.minusCheck
                        )
                        // 推定ポイント
                        unitResultCount2Line(
                            title: "中 推定pt",
                            color: .personalSummerLightGreen,
                            count: $toloveru87.dokiPtCenter,
                            spacerBool: false
                        )
                        .padding(.top, 5)
                        // リセットボタン
                        unitButtonResetBorderedStyle(
                            isShowAlert: self.$isShowAlertCenter,
                            buttonText: "中ﾘｾｯﾄ",
                            action: toloveru87.resetDokiDokiPointCenter,
                            message: "中チャンス目の推定ポイントのみリセットします"
                        )
                    }
                    VStack {
                        Text("[右]")
                            .font(.title)
                        // +1pt
                        unitPlusButton(
                            count: $toloveru87.dokiPtRight,
                            plusNumber: 1,
                            buttonColor: .purple,
                            minusCheck: toloveru87.minusCheck
                        )
                        // +10pt
                        unitPlusButton(
                            count: $toloveru87.dokiPtRight,
                            plusNumber: 10,
                            buttonColor: .purple,
                            minusCheck: toloveru87.minusCheck
                        )
                        // +75pt
                        unitPlusButton(
                            count: $toloveru87.dokiPtRight,
                            plusNumber: 75,
                            buttonColor: .purple,
                            minusCheck: toloveru87.minusCheck
                        )
                        // 推定ポイント
                        unitResultCount2Line(
                            title: "右 推定pt",
                            color: .personalSummerLightPurple,
                            count: $toloveru87.dokiPtRight,
                            spacerBool: false
                        )
                        .padding(.top, 5)
                        // リセットボタン
                        unitButtonResetBorderedStyle(
                            isShowAlert: self.$isShowAlertRight,
                            buttonText: "右ﾘｾｯﾄ",
                            action: toloveru87.resetDokiDokiPointRight,
                            message: "右チャンス目の推定ポイントのみリセットします"
                        )
                    }
                }
            } header: {
                Text("ポイント推定カウント")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ToLOVEるver8.7",
                screenClass: screenClass
            )
        }
        .navigationTitle("どきどきポイント")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $toloveru87.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: toloveru87.resetDokiDokiPoint)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    toloveru87ViewDokidokiPt(
        toloveru87: Toloveru87()
    )
}
