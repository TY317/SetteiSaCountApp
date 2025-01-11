//
//  dumbbellViewKinnikuBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/02.
//

import SwiftUI

struct dumbbellViewKinnikuBonus: View {
    @ObservedObject var dumbbell = Dumbbell()
    @State var isShowAlert = false
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    @FocusState var isFocused: Bool
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 250.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 250.0
    
    var body: some View {
        List {
            Section {
                // //// ボタン横並び
                HStack {
                    // 1人
                    unitCountButtonVerticalPercent(
                        title: "1人",
                        count: $dumbbell.ainoteCount1Person,
                        color: .personalSummerLightBlue,
                        bigNumber: $dumbbell.ainoteCountSum,
                        numberofDicimal: 0,
                        minusBool: $dumbbell.minusCheck
                    )
                    // 2人
                    unitCountButtonVerticalPercent(
                        title: "2人",
                        count: $dumbbell.ainoteCount2Person,
                        color: .personalSummerLightGreen,
                        bigNumber: $dumbbell.ainoteCountSum,
                        numberofDicimal: 0,
                        minusBool: $dumbbell.minusCheck
                    )
                    // 5人
                    unitCountButtonVerticalPercent(
                        title: "5人",
                        count: $dumbbell.ainoteCount5Person,
                        color: .personalSummerLightRed,
                        bigNumber: $dumbbell.ainoteCountSum,
                        numberofDicimal: 0,
                        minusBool: $dumbbell.minusCheck
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "合いの手の人数について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "合いの手の人数",
                            textBody1: "・100枚獲得毎に合いの手演出が発生",
                            textBody2: "・合いの手の人数で設定を示唆",
                            image1: Image("dumbbellAinote")
                        )
                    )
                )
            } header: {
                Text("合いの手の人数")
            }
            
            // //// 終了画面
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // さやか＆朱美
                        unitButtonScreenChoice(
                            image: Image(dumbbell.kinnikuScreenKeywordList[0]),
                            keyword: dumbbell.kinnikuScreenKeywordList[0],
                            currentKeyword: $dumbbell.kinnikuScreenCurrentKeyword,
                            count: $dumbbell.kinnikuScreenCountDefault,
                            minusCheck: $dumbbell.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // ジーナ＆里美
                        unitButtonScreenChoice(
                            image: Image(dumbbell.kinnikuScreenKeywordList[1]),
                            keyword: dumbbell.kinnikuScreenKeywordList[1],
                            currentKeyword: $dumbbell.kinnikuScreenCurrentKeyword,
                            count: $dumbbell.kinnikuScreenCountDefault,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // 全員集合
                        unitButtonScreenChoice(
                            image: Image(dumbbell.kinnikuScreenKeywordList[2]),
                            keyword: dumbbell.kinnikuScreenKeywordList[2],
                            currentKeyword: $dumbbell.kinnikuScreenCurrentKeyword,
                            count: $dumbbell.kinnikuScreenCountDefault,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // ひびき
                        unitButtonScreenChoice(
                            image: Image(dumbbell.kinnikuScreenKeywordList[3]),
                            keyword: dumbbell.kinnikuScreenKeywordList[3],
                            currentKeyword: $dumbbell.kinnikuScreenCurrentKeyword,
                            count: $dumbbell.kinnikuScreenCountHigh,
                            minusCheck: $dumbbell.minusCheck
                        )
                        // まちお
                        unitButtonScreenChoice(
                            image: Image(dumbbell.kinnikuScreenKeywordList[4]),
                            keyword: dumbbell.kinnikuScreenKeywordList[4],
                            currentKeyword: $dumbbell.kinnikuScreenCurrentKeyword,
                            count: $dumbbell.kinnikuScreenCountHighKyo,
                            minusCheck: $dumbbell.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                //  デフォルト
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $dumbbell.kinnikuScreenCountDefault,
                    flashColor: .gray,
                    bigNumber: $dumbbell.kinnikuScreenCountSum
                )
                //  高設定示唆
                unitResultCountListPercent(
                    title: "高設定示唆",
                    count: $dumbbell.kinnikuScreenCountHigh,
                    flashColor: .green,
                    bigNumber: $dumbbell.kinnikuScreenCountSum
                )
                //  高設定示唆 強
                unitResultCountListPercent(
                    title: "高設定示唆 強",
                    count: $dumbbell.kinnikuScreenCountHighKyo,
                    flashColor: .red,
                    bigNumber: $dumbbell.kinnikuScreenCountSum
                )
            } header: {
                Text("終了画面")
            }
            
            // //// ライジングアッパーチャレンジ
            Section {
                // //// カウントボタン、結果横並び
                HStack {
                    // 失敗
                    unitCountButtonVerticalPercent(
                        title: "失敗",
                        count: $dumbbell.rupCountFailed,
                        color: .personalSummerLightBlue,
                        bigNumber: $dumbbell.rupCountSum,
                        numberofDicimal: 0,
                        minusBool: $dumbbell.minusCheck
                    )
                    // 成功
                    unitCountButtonVerticalPercent(
                        title: "成功",
                        count: $dumbbell.rupCountSuccess,
                        color: .personalSummerLightRed,
                        bigNumber: $dumbbell.rupCountSum,
                        numberofDicimal: 0,
                        minusBool: $dumbbell.minusCheck
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "ライジングアッパーチャレンジについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ライジングアッパーチャレンジ",
                            textBody1: "・金肉ボーナス後に突入する引き戻しCZ",
                            textBody2: "・高設定ほど成功率が優遇されているらしい",
                            textBody3: "・成功率公表値は約56%だが、高設定はこれより高い数値が目安になると思われる"
                        )
                    )
                )
            } header: {
                Text("ライジングアッパーチャレンジ")
            }
            unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
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
        .navigationTitle("金肉ボーナス")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // 画面選択解除
                    unitButtonToolbarScreenSelectReset(currentKeyword: $dumbbell.kinnikuScreenCurrentKeyword)
                        .popoverTip(tipUnitButtonScreenChoiceClear())
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $dumbbell.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: dumbbell.resetKinnikuBonus)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    dumbbellViewKinnikuBonus()
}
