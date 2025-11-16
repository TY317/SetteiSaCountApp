//
//  vvv2ViewRush.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/06.
//

import SwiftUI

struct vvv2ViewRush: View {
    @ObservedObject var vvv2: Vvv2
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            // //// ドライブ発生率
            Section {
                // カウントボタン横並び
                HStack {
                    // 10G
                    unitCountButtonPercentWithFunc(
                        title: "10G",
                        count: $vvv2.roundCount10,
                        color: .personalSummerLightBlue,
                        bigNumber: $vvv2.roundCountSum,
                        numberofDicimal: 0,
                        minusBool: $vvv2.minusCheck) {
                            vvv2.roundSumFunc()
                        }
                    // 20G
                    unitCountButtonPercentWithFunc(
                        title: "20G",
                        count: $vvv2.roundCount20,
                        color: .personalSummerLightGreen,
                        bigNumber: $vvv2.roundCountSum,
                        numberofDicimal: 0,
                        minusBool: $vvv2.minusCheck) {
                            vvv2.roundSumFunc()
                        }
                    // ドライブ
                    unitCountButtonPercentWithFunc(
                        title: "ドライブ",
                        count: $vvv2.roundCountDrive,
                        color: .personalSummerLightRed,
                        bigNumber: $vvv2.roundCountSum,
                        numberofDicimal: 0,
                        minusBool: $vvv2.minusCheck) {
                            vvv2.roundSumFunc()
                        }
                }
                
                // ドライブ確率分母
                unitResultRatioDenomination2Line(
                    title: "ドライブ",
                    count: $vvv2.roundCountDrive,
                    bigNumber: $vvv2.roundCountSum,
                    numberofDicimal: 1
                )
            } header: {
                Text("ドライブ発生率")
            }
            
            // //// ラウンド開始画面
            Section {
                Text("右の画像ほど強い示唆となる")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // パターン1
                        unitScreenOnlyDisplay(
                            image: Image("vvv2roundScreen1"),
                            upperBeltText: "マリエ",
                            lowerBeltText: "高設定示唆 弱",
                        )
                        // パターン2
                        unitScreenOnlyDisplay(
                            image: Image("vvv2roundScreen2"),
                            upperBeltText: "ルーン漏れ1号機",
                            lowerBeltText: "高設定示唆 強",
                        )
                        // パターン3
                        unitScreenOnlyDisplay(
                            image: Image("vvv2roundScreen3"),
                            upperBeltText: "200年後のサキ",
                            lowerBeltText: "設定4 以上濃厚",
                        )
                        // パターン4
                        unitScreenOnlyDisplay(
                            image: Image("vvv2roundScreen4"),
                            upperBeltText: "リーゼロッテ",
                            lowerBeltText: "設定6 濃厚",
                        )
                    }
                }
                .frame(height: 120)
                .popoverTip(tipVer3130vvv2RushScreen())
            } header: {
                Text("ラウンド開始画面での示唆")
            }
            
            // //// ハラキリチャレンジ中の夢ちゃん
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "夢夢ちゃん演出での示唆") {
                    VStack(alignment: .leading) {
                        Text("・ハラキリチャレンジ中に夢夢ちゃんピース、夢夢ちゃんミニキャラ群が発生すればドライブ＋設定4以上濃厚")
                    }
                }
            } header: {
                Text("ハラキリチャレンジ中の夢夢ちゃん")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.vvv2MenuRushBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vvv2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("(超)革命ラッシュ")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $vvv2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: vvv2.resetRush)
            }
        }
    }
}

#Preview {
    vvv2ViewRush(
        vvv2: Vvv2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
