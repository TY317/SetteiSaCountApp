//
//  acceleratorViewShutter.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/29.
//

import SwiftUI
import TipKit


// /////////////////////
// Tip：シャッター開放率セクションの説明
// /////////////////////
struct tipUnitAcceleratorNormalChance: Tip {
    var title: Text {
        Text("シャッター開放率")
    }
    
    var message: Text? {
        Text("チャンス目：シャッター閉じた状態で引いたチャンス目回数をカウント\nシャッター開放：チャンス目から開放した回数をカウント")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}

// /////////////////////
// Tip：シャッター開放継続振り分けセクションの説明
// /////////////////////
struct tipUnitAcceleratorShutterOpenGame: Tip {
    var title: Text {
        Text("開放G数振り分け")
    }
    
    var message: Text? {
        Text("シャッターの開放継続G数別にカウント。ゲーム数メモは忘れ防止として必要に応じご利用ください。")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


struct acceleratorViewShutter: View {
    @ObservedObject var accelerator = Accelerator()
    @State var isShowAlert = false
    @FocusState var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 70.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 70.0
    
    var body: some View {
        List {
            // //// シャッター開放率
            Section {
                HStack {
                    // チャンス目回数
                    unitCountButtonVerticalWithoutRatio(
                        title: "チャンス目",
                        count: $accelerator.normalChanceCount,
                        color: .personalSummerLightBlue,
                        minusBool: $accelerator.minusCheck
                    )
                    // シャッター開放回数
                    unitCountButtonVerticalWithoutRatio(
                        title: "ｼｬｯﾀｰ開放",
                        count: $accelerator.normalChanceCountShutterOpen,
                        color: .personalSummerLightPurple,
                        minusBool: $accelerator.minusCheck
                    )
                    // 開放率
                    unitResultRatioPercent2Line(
                        title: "開放率",
                        count: $accelerator.normalChanceCountShutterOpen,
                        bigNumber: $accelerator.normalChanceCount,
                        numberofDicimal: 0,
                        spacerBool: false
                    )
                    .padding(.vertical)
                }
                .popoverTip(tipUnitAcceleratorNormalChance())
                // //// 参考情報リンク
                unitLinkButton(
                    title: "シャッター開放率について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "シャッター開放率",
                            image1: Image("acceleratorShutterOpenRatio")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(acceleratorView95Ci(selection: 9)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("チャンス目からのシャッター開放")
            }
            
            // //// シャッター開放継続G数
            Section {
                // 開放時ゲーム数メモ
                unitTextFieldGamesInput(
                    title: "開放時ゲーム数メモ",
                    inputValue: $accelerator.shutterOpenStartGameMemo
                )
                .popoverTip(tipUnitAcceleratorShutterOpenGame())
                .focused($isFocused)
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button(action: {
                                isFocused = false
                            }, label: {
                                Text("完了")
                                    .fontWeight(.bold)
                            })
                        }
                    }
                }
                HStack {
                    // 18G
                    unitCountButtonVerticalPercent(
                        title: "18G",
                        count: $accelerator.shutterOpenCount18G,
                        color: .personalSummerLightBlue,
                        bigNumber: $accelerator.shutterOpenCountSum,
                        numberofDicimal: 0,
                        minusBool: $accelerator.minusCheck
                    )
                    // 23G
                    unitCountButtonVerticalPercent(
                        title: "23G",
                        count: $accelerator.shutterOpenCount23G,
                        color: .personalSummerLightGreen,
                        bigNumber: $accelerator.shutterOpenCountSum,
                        numberofDicimal: 0,
                        minusBool: $accelerator.minusCheck
                    )
                    // 33G
                    unitCountButtonVerticalPercent(
                        title: "33G",
                        count: $accelerator.shutterOpenCount33G,
                        color: .personalSummerLightRed,
                        bigNumber: $accelerator.shutterOpenCountSum,
                        numberofDicimal: 0,
                        minusBool: $accelerator.minusCheck
                    )
                }
                // 参考情報リンク
                unitLinkButton(
                    title: "開放継続G数の振分けについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "シャッター開放継続G数",
                            image1: Image("acceleratorShutterOpenGame")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(acceleratorView95Ci(selection: 10)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("シャッター開放継続G数")
            }
            
            // 開放中対応チャンス目からの当選
            Section {
                // //// 横画面
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    // //// カウントボタン横並び
                    HStack {
                        // ハズレ
                        unitCountButtonVerticalPercent(
                            title: "ハズレ",
                            count: $accelerator.chanceCountLose,
                            color: .personalSummerLightBlue,
                            bigNumber: $accelerator.chanceCountSum,
                            numberofDicimal: 0,
                            minusBool: $accelerator.minusCheck
                        )
                        // 一方通行
                        unitCountButtonVerticalPercent(
                            title: "一方通行CZ",
                            count: $accelerator.chanceCountWinAccelerator,
                            color: .personalSummerLightPurple,
                            bigNumber: $accelerator.chanceCountSum,
                            numberofDicimal: 0,
                            minusBool: $accelerator.minusCheck
                        )
                        // 打ち止め
                        unitCountButtonVerticalPercent(
                            title: "打ち止めCZ",
                            count: $accelerator.chanceCountWinLastorder,
                            color: .personalSummerLightRed,
                            bigNumber: $accelerator.chanceCountSum,
                            numberofDicimal: 1,
                            minusBool: $accelerator.minusCheck
                        )
                        // //// トータル当選率
                        unitResultRatioPercent2Line(
                            title: "合算当選率",
                            count: $accelerator.chanceCountWinSum,
                            bigNumber: $accelerator.chanceCountSum,
                            numberofDicimal: 0
                        )
                        .padding(.vertical)
                    }
                }
                // //// 縦画面
                else {
                    // //// カウントボタン横並び
                    HStack {
                        // ハズレ
                        unitCountButtonVerticalPercent(
                            title: "ハズレ",
                            count: $accelerator.chanceCountLose,
                            color: .personalSummerLightBlue,
                            bigNumber: $accelerator.chanceCountSum,
                            numberofDicimal: 0,
                            minusBool: $accelerator.minusCheck
                        )
                        // 一方通行
                        unitCountButtonVerticalPercent(
                            title: "一方通行CZ",
                            count: $accelerator.chanceCountWinAccelerator,
                            color: .personalSummerLightPurple,
                            bigNumber: $accelerator.chanceCountSum,
                            numberofDicimal: 0,
                            minusBool: $accelerator.minusCheck
                        )
                        // 打ち止め
                        unitCountButtonVerticalPercent(
                            title: "打ち止めCZ",
                            count: $accelerator.chanceCountWinLastorder,
                            color: .personalSummerLightRed,
                            bigNumber: $accelerator.chanceCountSum,
                            numberofDicimal: 1,
                            minusBool: $accelerator.minusCheck
                        )
                    }
                    // //// トータル当選率
                    unitResultRatioPercent2Line(
                        title: "合算当選率",
                        count: $accelerator.chanceCountWinSum,
                        bigNumber: $accelerator.chanceCountSum,
                        numberofDicimal: 0
                    )
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "対応チャンス目からのCZについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "対応チャンス目抽選",
                            textBody1: "・液晶下部のシャッターが開いた状態で対応するチャンス目を引いた際のCZ当選率に設定差あり",
                            textBody2: "・高設定ほど当選率が高く、打ち止めCZの比率が多くなる",
                            image1: Image("acceleratorChanceRatio")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(acceleratorView95Ci(selection: 1)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("対応チャンス目成立時の抽選")
            }
            
            // その他の設定差情報
            Section {
                // 非対応チャンス目からのCZについて
                unitLinkButton(
                    title: "非対応チャンス目からのCZについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "非対応チャンス目抽選",
                            textBody1: "・シャッターが開いた状態で非対応のチャンス目を引いた際のCZ当選率に設定差あり",
                            textBody2: "・非対応チャンス目からの当選では必ず打ち止めCZとなる",
                            textBody3: "・当選率が低いが、1と6で3倍の差があるため複数回確認できたらチャンスかも",
                            image1: Image("acceleratorNoMatchChanceHit")
                        )
                    )
                )
                // 3連チャンス目からのCZ振り分け
                unitLinkButton(
                    title: "3連チャンス目からのCZについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "3連チャンス目からのCZ",
                            textBody1: "・3連チャンス目成立時はCZ当選濃厚",
                            textBody2: "・CZ種類の振り分けに設定差あり",
                            textBody3: "・高設定ほど打ち止めCZ、一通・打止CZが出てきやすい",
                            image1: Image("acceleratorTripleChance")
                        )
                    )
                )
            } header: {
                Text("その他")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
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
        .navigationTitle("通常時シャッター関連")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $accelerator.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: accelerator.resetShutter)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    acceleratorViewShutter()
}
