//
//  bangdreamViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/09.
//

import SwiftUI

struct bangdreamViewScreen: View {
//    @ObservedObject var bangdream = Bangdream()
    @ObservedObject var bangdream: Bangdream
    @State var isShowAlert: Bool = false
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
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // 香澄
                        unitButtonScreenChoice(
                            image: Image(bangdream.screenKeywordList[0]),
                            keyword: bangdream.screenKeywordList[0],
                            currentKeyword: $bangdream.screenCurrentKeyword,
                            count: $bangdream.screenCountKasumi,
                            minusCheck: $bangdream.minusCheck
                        )
                        .popoverTip(tipUnitButtonScreenChoice())
                        // 写真
                        unitButtonScreenChoice(
                            image: Image(bangdream.screenKeywordList[1]),
                            keyword: bangdream.screenKeywordList[1],
                            currentKeyword: $bangdream.screenCurrentKeyword,
                            count: $bangdream.screenCountPhoto,
                            minusCheck: $bangdream.minusCheck
                        )
                        // ミニキャラ
                        unitButtonScreenChoice(
                            image: Image(bangdream.screenKeywordList[2]),
                            keyword: bangdream.screenKeywordList[2],
                            currentKeyword: $bangdream.screenCurrentKeyword,
                            count: $bangdream.screenCountMinichara,
                            minusCheck: $bangdream.minusCheck
                        )
                        // 良スタンプ
                        unitButtonScreenChoice(
                            image: Image(bangdream.screenKeywordList[3]),
                            keyword: bangdream.screenKeywordList[3],
                            currentKeyword: $bangdream.screenCurrentKeyword,
                            count: $bangdream.screenCountRyoStamp,
                            minusCheck: $bangdream.minusCheck
                        )
                        // 優スタンプ
                        unitButtonScreenChoice(
                            image: Image(bangdream.screenKeywordList[4]),
                            keyword: bangdream.screenKeywordList[4],
                            currentKeyword: $bangdream.screenCurrentKeyword,
                            count: $bangdream.screenCountYuStamp,
                            minusCheck: $bangdream.minusCheck
                        )
                        // 極スタンプ
                        unitButtonScreenChoice(
                            image: Image(bangdream.screenKeywordList[5]),
                            keyword: bangdream.screenKeywordList[5],
                            currentKeyword: $bangdream.screenCurrentKeyword,
                            count: $bangdream.screenCountKiwamiStamp,
                            minusCheck: $bangdream.minusCheck
                        )
                    }
                }
                .frame(height: 120)
                
                // //// カウント結果
                // 香澄
                unitResultCountListPercent(
                    title: "デフォルト",
                    count: $bangdream.screenCountKasumi,
                    flashColor: .gray,
                    bigNumber: $bangdream.screenCountSum
                )
                // 写真
                unitResultCountListPercent(
                    title: "？（高設定示唆 弱？）",
                    count: $bangdream.screenCountPhoto,
                    flashColor: .blue,
                    bigNumber: $bangdream.screenCountSum
                )
                // ミニキャラ
                unitResultCountListPercent(
                    title: "？（高設定示唆 強？）",
                    count: $bangdream.screenCountMinichara,
                    flashColor: .yellow,
                    bigNumber: $bangdream.screenCountSum
                )
                // 良スタンプ
                unitResultCountListPercent(
                    title: "設定4 以上濃厚",
                    count: $bangdream.screenCountRyoStamp,
                    flashColor: .green,
                    bigNumber: $bangdream.screenCountSum
                )
                // 優スタンプ
                unitResultCountListPercent(
                    title: "設定5 以上濃厚",
                    count: $bangdream.screenCountYuStamp,
                    flashColor: .red,
                    bigNumber: $bangdream.screenCountSum
                )
                // 極スタンプ
                unitResultCountListPercent(
                    title: "設定6 濃厚",
                    count: $bangdream.screenCountKiwamiStamp,
                    flashColor: .purple,
                    bigNumber: $bangdream.screenCountSum
                )
                
                // //// 参考情報リンク
                unitLinkButton(
                    title: "ST終了画面について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ST終了画面",
                            textBody1: "・スタンプのない画面は詳細の発表は未だが、香澄がデフォルトはほぼ間違いなし",
                            textBody2: "・写真とミニキャラはどちらが強いか不明だが、All設定バトル動画での扱いからミニキャラが示唆 強と予想（ミニキャラは設定5,6しか出現しなかった）",
                            textBody3: "・All設定バトルの結果ではデフォルト率が設定5,6で62％、設定2,3は92％とかなりの差。低設定は偏ったのは間違いないと思われるが、高設定はデフォルト率60〜70％以下が目安になると予想"
                        )
                    )
                )
            } header: {
                Text("ST終了画面")
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
        .navigationTitle("ST終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                // 画面選択解除
                unitButtonToolbarScreenSelectReset(currentKeyword: $bangdream.screenCurrentKeyword)
                    .popoverTip(tipUnitButtonScreenChoiceClear())
                // マイナスチェック
                unitButtonMinusCheck(minusCheck: $bangdream.minusCheck)
                // リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: bangdream.resetScreen)
//                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

#Preview {
    bangdreamViewScreen(bangdream: Bangdream())
}
