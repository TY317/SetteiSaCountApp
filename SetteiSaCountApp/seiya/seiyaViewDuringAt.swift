//
//  seiyaViewDuringAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct seiyaViewDuringAt: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @ObservedObject var seiya: Seiya
    @State var isShowDestination: Bool = false
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3

    var body: some View {
        List {
            
            // エクストララウンド 対戦相手
            Section {
                // 対戦相手
                unitLinkButtonViewBuilder(sheetTitle: "黄金聖闘士バトルの対戦相手") {
                    VStack(alignment: .leading) {
                        Text("・対戦相手は基本ランダム")
                        Text("・下記聖闘士が出現すれば設定示唆")
                    }
                        .padding(.bottom)
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "シャカ",
                                "ジェミニ"
                            ],
                            maxWidth: 100,
                        )
                        unitTableString(
                            columTitle: "示唆",
                            stringList: [
                                "高設定示唆",
                                "設定4 以上濃厚"
                            ]
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // シャカ
                        unitCountButtonPercentWithFunc(
                            title: "シャカ",
                            count: $seiya.opponentCount1,
                            color: .personalSummerLightGreen,
                            bigNumber: $seiya.opponentCountSum,
                            numberofDicimal: 0,
                            minusBool: $seiya.minusCheck) {
                                seiya.opponentSumFunc()
                            }
                        // ジェミニ
                        unitCountButtonPercentWithFunc(
                            title: "ジェミニ",
                            count: $seiya.opponentCount2,
                            color: .personalSummerLightPurple,
                            bigNumber: $seiya.opponentCountSum,
                            numberofDicimal: 0,
                            minusBool: $seiya.minusCheck) {
                                seiya.opponentSumFunc()
                            }
                        // その他
                        unitCountButtonPercentWithFunc(
                            title: "その他",
                            count: $seiya.opponentCount3,
                            color: .personalSummerLightBlue,
                            bigNumber: $seiya.opponentCountSum,
                            numberofDicimal: 0,
                            minusBool: $seiya.minusCheck) {
                                seiya.opponentSumFunc()
                            }
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("エクストララウンド 対戦相手")
            }
            
            // エクストララウンド キャラ紹介
            Section {
                // バトル後のキャラ紹介
                unitLinkButtonViewBuilder(sheetTitle: "黄金聖闘士バトル勝利後のキャラ紹介") {
                    VStack(alignment: .leading) {
                        Text("・エクストララウンドでのバトル勝利後はキャラ紹介が発生")
                        Text("・1人目は勝利した黄金聖闘士が出現")
                        Text("・2人目はランダム選択でここで下記聖闘士が出現すれば設定示唆")
                    }
                        .padding(.bottom)
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "ムウ",
                                "アイオロス"
                            ],
                            maxWidth: 100,
                        )
                        unitTableString(
                            columTitle: "示唆",
                            stringList: [
                                "高設定示唆",
                                "高設定示唆 強"
                            ]
                        )
                    }
                }

                // カウント
                DisclosureGroup {
                    // カウントボタン横並び
                    HStack {
                        // ムウ
                        unitCountButtonPercentWithFunc(
                            title: "ムウ",
                            count: $seiya.charaCount1,
                            color: .personalSummerLightGreen,
                            bigNumber: $seiya.charaCountSum,
                            numberofDicimal: 0,
                            minusBool: $seiya.minusCheck) {
                                seiya.charaSumFunc()
                            }
                        // アイオロス
                        unitCountButtonPercentWithFunc(
                            title: "アイオロス",
                            count: $seiya.charaCount2,
                            color: .personalSummerLightRed,
                            bigNumber: $seiya.charaCountSum,
                            numberofDicimal: 0,
                            minusBool: $seiya.minusCheck) {
                                seiya.charaSumFunc()
                            }
                        // その他
                        unitCountButtonPercentWithFunc(
                            title: "その他",
                            count: $seiya.charaCount3,
                            color: .personalSummerLightBlue,
                            bigNumber: $seiya.charaCountSum,
                            numberofDicimal: 0,
                            minusBool: $seiya.minusCheck) {
                                seiya.charaSumFunc()
                            }
                    }
                } label: {
                    Text("カウント")
                        .foregroundStyle(Color.blue)
                }
            } header: {
                Text("エクストララウンド キャラ紹介")
            }

        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.seiyaMenuDuringAtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: seiya.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT中")
        .navigationBarTitleDisplayMode(.inline)
        // //// 画面の向き情報の取得部分
        .applyOrientationHandling(
            orientation: self.$orientation,
            lastOrientation: self.$lastOrientation,
            scrollViewHeight: self.$scrollViewHeight,
            spaceHeight: self.$spaceHeight,
            lazyVGridCount: self.$lazyVGridCount,
            scrollViewHeightPortrait: self.scrollViewHeightPortrait,
            scrollViewHeightLandscape: self.scrollViewHeightLandscape,
            spaceHeightPortrait: self.spaceHeightPortrait,
            spaceHeightLandscape: self.spaceHeightLandscape,
            lazyVGridCountPortrait: self.lazyVGridCountPortrait,
            lazyVGridCountLandscape: self.lazyVGridCountLandscape
        )
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $seiya.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: seiya.resetDuringAt)
            }
        }
    }
}

#Preview {
    seiyaViewDuringAt(
        seiya: Seiya(),
    )
    .environmentObject(commonVar())
    .environmentObject(Bayes())
    .environmentObject(InterstitialViewModel())
}
