//
//  dumbbellCzAtScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/02.
//

import SwiftUI

struct dumbbellCzAtScreen: View {
//    @ObservedObject var dumbbell = Dumbbell()
    @ObservedObject var dumbbell: Dumbbell
    @State var isShowAlert: Bool = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @FocusState var isFocused: Bool
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 200.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 200.0
    
    var body: some View {
        List {
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // ひびき
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[0]),
                            keyword: dumbbell.czBonusScreenKeywordList[0],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountDefault,
                            minusCheck: $dumbbell.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // サウナ
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[10]),
                            keyword: dumbbell.czBonusScreenKeywordList[10],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountMode,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 白枠 朱美
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[1]),
                            keyword: dumbbell.czBonusScreenKeywordList[1],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountOver2Sisa,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 白枠 さやか
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[2]),
                            keyword: dumbbell.czBonusScreenKeywordList[2],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountGusuSisa,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 白枠 朱美
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[3]),
                            keyword: dumbbell.czBonusScreenKeywordList[3],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountOver3Sisa,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 白枠 朱美
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[4]),
                            keyword: dumbbell.czBonusScreenKeywordList[4],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountKisuSisa,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 赤枠
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[5]),
                            keyword: dumbbell.czBonusScreenKeywordList[5],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountHigh,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 紫枠
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[6]),
                            keyword: dumbbell.czBonusScreenKeywordList[6],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountOverTokutei,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 銀枠 ドレス
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[7]),
                            keyword: dumbbell.czBonusScreenKeywordList[7],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountOver4,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 銀枠 水着
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[8]),
                            keyword: dumbbell.czBonusScreenKeywordList[8],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountOver4Kyo,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 金枠
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[9]),
                            keyword: dumbbell.czBonusScreenKeywordList[9],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCountOver6,
                            minusCheck: $dumbbell.minusCheck
                        )
//                        // サウナ
//                        unitButtonScreenChoice(
//                            image: Image(dumbbell.czBonusScreenKeywordList[10]),
//                            keyword: dumbbell.czBonusScreenKeywordList[10],
//                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
//                            count: $dumbbell.czBonusScreenCountMode,
//                            minusCheck: $dumbbell.minusCheck
//                        )
                        // トランプ
                        unitButtonScreenChoice(
                            image: Image(dumbbell.czBonusScreenKeywordList[11]),
                            keyword: dumbbell.czBonusScreenKeywordList[11],
                            currentKeyword: $dumbbell.czBonusScreenCurrentKeyword,
                            count: $dumbbell.czBonusScreenCount1or6,
                            minusCheck: $dumbbell.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $dumbbell.czBonusScreenCountDefault,
                    flashColor: .gray,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
                // モード示唆
                VStack(spacing:0) {
                    unitResultCountListPercent(
                        title: "モード示唆",
                        count: $dumbbell.czBonusScreenCountMode,
                        flashColor: .brown,
                        bigNumber: $dumbbell.czBonusScreenCountSum
                    )
                    Text("※ 人数少ないほど早い規定カロリーに期待")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                // 設定2 以上示唆
                unitResultCountListPercent(
                    title: "設定2 以上示唆",
                    count: $dumbbell.czBonusScreenCountOver2Sisa,
                    flashColor: .blue,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
                // 偶数示唆
                unitResultCountListPercent(
                    title: "偶数示唆",
                    count: $dumbbell.czBonusScreenCountGusuSisa,
                    flashColor: .brown,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
                // 設定3 以上示唆
                unitResultCountListPercent(
                    title: "設定3 以上示唆",
                    count: $dumbbell.czBonusScreenCountOver3Sisa,
                    flashColor: .yellow,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
                // 奇数示唆
                unitResultCountListPercent(
                    title: "奇数示唆",
                    count: $dumbbell.czBonusScreenCountKisuSisa,
                    flashColor: .cyan,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
                // 高設定示唆
                unitResultCountListPercent(
                    title: "高設定示唆",
                    count: $dumbbell.czBonusScreenCountHigh,
                    flashColor: .red,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
                // 特定設定以上濃厚
                unitResultCountListPercent(
                    title: "設定2 以上濃厚",
                    count: $dumbbell.czBonusScreenCountOverTokutei,
                    flashColor: .purple,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
                // 設定4 以上濃厚
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $dumbbell.czBonusScreenCountOver4,
                    flashColor: .gray,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
                // 設定4 以上濃厚 強
//                VStack(spacing:0) {
                    unitResultCountListPercent(
                        title: "設定5 以上濃厚",
                        count: $dumbbell.czBonusScreenCountOver4Kyo,
                        flashColor: .gray,
                        bigNumber: $dumbbell.czBonusScreenCountSum
                    )
//                    Text("※ 紫枠 ドレスより強い")
//                        .foregroundStyle(Color.secondary)
//                        .font(.footnote)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
                // 設定6 濃厚
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $dumbbell.czBonusScreenCountOver6,
                    flashColor: .orange,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
//                // モード示唆
//                VStack(spacing:0) {
//                    unitResultCountListPercent(
//                        title: "モード示唆",
//                        count: $dumbbell.czBonusScreenCountMode,
//                        flashColor: .brown,
//                        bigNumber: $dumbbell.czBonusScreenCountSum
//                    )
//                    Text("※ 人数少ないほど早い規定カロリーに期待")
//                        .foregroundStyle(Color.secondary)
//                        .font(.footnote)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
                // 設定1or6 濃厚
                unitResultCountListPercent(
                    title: "設定1 or 6 濃厚",
                    count: $dumbbell.czBonusScreenCount1or6,
                    flashColor: .pink,
                    bigNumber: $dumbbell.czBonusScreenCountSum
                )
                // //// 参考情報リンク
                unitLinkButton(
                    title: "画面の振り分けについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "終了画面振り分け",
                            textBody1: "・朝イチは特定設定濃厚画面の出現率がアップ。朝イチがひびき・サウナだった場合は次回の画面で出現率アップ",
                            textBody2: "・差枚マイナス2500枚時の画面でも特定設定濃厚画面の出現率がアップ",
                            textBody3: "・トランプは設定1での確率は極めて低いらしい。出現すれば設定6の期待大",
                            image1: Image("dumbbellCzBonusScreenRatio")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(dumbbellView95Ci(dumbbell: dumbbell, selection: 8)))
//                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("CZ・AT終了画面")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ダンベル何キロ持てる？",
                screenClass: screenClass
            )
        }
        // //// 画面の向き情報の取得部分
        .onAppear {
            // ビューが表示されるときにデバイスの向きを取得
            self.orientation = UIDevice.current.orientation
            // 向きがフラットでなければlastOrientationの値を更新
            if self.orientation.isFlat {
                
            }
            else {
                self.lastOrientation = self.orientation
            }
            if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                self.scrollViewHeight = self.scrollViewHeightLandscape
                self.spaceHeight = self.spaceHeightLandscape
            } else {
                self.scrollViewHeight = self.scrollViewHeightPortrait
                self.spaceHeight = self.spaceHeightPortrait
            }
            // デバイスの向きの変更を監視する
            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                self.orientation = UIDevice.current.orientation
                // 向きがフラットでなければlastOrientationの値を更新
                if self.orientation.isFlat {
                    
                }
                else {
                    self.lastOrientation = self.orientation
                }
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    self.scrollViewHeight = self.scrollViewHeightLandscape
                    self.spaceHeight = self.spaceHeightLandscape
                } else {
                    self.scrollViewHeight = self.scrollViewHeightPortrait
                    self.spaceHeight = self.spaceHeightPortrait
                }
            }
        }
        .onDisappear {
            // ビューが非表示になるときに監視を解除
            NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        .navigationTitle("CZ・AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonToolbarScreenSelectReset(currentKeyword: $dumbbell.czBonusScreenCurrentKeyword)
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $dumbbell.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: dumbbell.resetCzBonusScreen)
//                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    dumbbellCzAtScreen(dumbbell: Dumbbell())
}
