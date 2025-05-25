//
//  acceleratorViewCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/04.
//

import SwiftUI
import TipKit

// //////////////////
// Tip：履歴入力の説明
// //////////////////
struct acceleratorTipHistoryInput: Tip {
    var title: Text {
        Text("履歴入力")
    }
    
    var message: Text? {
        Text("CZ当選、AT直撃ごとに入力して下さい。入力結果から\n・CZ初当り確率\n・AT初当り確率　を算出します")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


struct acceleratorViewCz: View {
//    @ObservedObject var accelerator = Accelerator()
    @ObservedObject var accelerator: Accelerator
    @State var isShowAlert: Bool = false
    @State var isShowDataInputView = false
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
//            Section {
//                // //// 横画面
//                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
//                    // //// カウントボタン横並び
//                    HStack {
//                        // ハズレ
//                        unitCountButtonVerticalPercent(
//                            title: "ハズレ",
//                            count: $accelerator.chanceCountLose,
//                            color: .personalSummerLightBlue,
//                            bigNumber: $accelerator.chanceCountSum,
//                            numberofDicimal: 0,
//                            minusBool: $accelerator.minusCheck
//                        )
//                        // 一方通行
//                        unitCountButtonVerticalPercent(
//                            title: "一方通行CZ",
//                            count: $accelerator.chanceCountWinAccelerator,
//                            color: .personalSummerLightPurple,
//                            bigNumber: $accelerator.chanceCountSum,
//                            numberofDicimal: 0,
//                            minusBool: $accelerator.minusCheck
//                        )
//                        // 打ち止め
//                        unitCountButtonVerticalPercent(
//                            title: "打ち止めCZ",
//                            count: $accelerator.chanceCountWinLastorder,
//                            color: .personalSummerLightRed,
//                            bigNumber: $accelerator.chanceCountSum,
//                            numberofDicimal: 1,
//                            minusBool: $accelerator.minusCheck
//                        )
//                        // //// トータル当選率
//                        unitResultRatioPercent2Line(
//                            title: "合算当選率",
//                            count: $accelerator.chanceCountWinSum,
//                            bigNumber: $accelerator.chanceCountSum,
//                            numberofDicimal: 0
//                        )
//                        .padding(.vertical)
//                    }
//                }
//                // //// 縦画面
//                else {
//                    // //// カウントボタン横並び
//                    HStack {
//                        // ハズレ
//                        unitCountButtonVerticalPercent(
//                            title: "ハズレ",
//                            count: $accelerator.chanceCountLose,
//                            color: .personalSummerLightBlue,
//                            bigNumber: $accelerator.chanceCountSum,
//                            numberofDicimal: 0,
//                            minusBool: $accelerator.minusCheck
//                        )
//                        // 一方通行
//                        unitCountButtonVerticalPercent(
//                            title: "一方通行CZ",
//                            count: $accelerator.chanceCountWinAccelerator,
//                            color: .personalSummerLightPurple,
//                            bigNumber: $accelerator.chanceCountSum,
//                            numberofDicimal: 0,
//                            minusBool: $accelerator.minusCheck
//                        )
//                        // 打ち止め
//                        unitCountButtonVerticalPercent(
//                            title: "打ち止めCZ",
//                            count: $accelerator.chanceCountWinLastorder,
//                            color: .personalSummerLightRed,
//                            bigNumber: $accelerator.chanceCountSum,
//                            numberofDicimal: 1,
//                            minusBool: $accelerator.minusCheck
//                        )
//                    }
//                    // //// トータル当選率
//                    unitResultRatioPercent2Line(
//                        title: "合算当選率",
//                        count: $accelerator.chanceCountWinSum,
//                        bigNumber: $accelerator.chanceCountSum,
//                        numberofDicimal: 0
//                    )
//                }
//                // //// 参考情報リンク
//                unitLinkButton(
//                    title: "対応チャンス目からのCZについて",
//                    exview: AnyView(
//                        unitExView5body2image(
//                            title: "対応チャンス目抽選",
//                            textBody1: "・液晶下部のシャッターが開いた状態で対応するチャンス目を引いた際のCZ当選率に設定差あり",
//                            textBody2: "・高設定ほど当選率が高く、打ち止めCZの比率が多くなる",
//                            image1: Image("acceleratorChanceRatio")
//                        )
//                    )
//                )
//                // 95%信頼区間グラフ
//                unitNaviLink95Ci(Ci95view: AnyView(acceleratorView95Ci(selection: 1)))
//                    .popoverTip(tipUnitButtonLink95Ci())
//            } header: {
//                Text("対応チャンス目成立時の抽選")
//            }
            
            // //// 履歴
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let gameArray = decodeIntArray(from: accelerator.gameArrayData)
                    if gameArray.count > 0 {
                        ForEach(gameArray.indices, id: \.self) { index in
                            let viewIndex = gameArray.count - index - 1
                            HStack {
                                // 回数
                                Text("\(viewIndex+1)")
                                    .frame(width: 40.0)
                                // 実ゲーム数
                                if gameArray.indices.contains(viewIndex) {
                                    Text("\(gameArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // CZ種類
                                let czArray = decodeStringArray(from: accelerator.czArrayData)
                                if czArray.indices.contains(viewIndex) {
                                    Text("\(czArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // AT当否
                                let resultArray = decodeStringArray(from: accelerator.resultArrayData)
                                if resultArray.indices.contains(viewIndex) {
                                    Text("\(resultArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            Divider()
                        }
                    }
                    // //// 配列のデータ数が0なら履歴なしを表示
                    else {
                        HStack {
                            Spacer()
                            Text("履歴なし")
                                .font(.title)
                            Spacer()
                        }
                        .padding(.top)
                    }
                }
                .frame(height: self.scrollViewHeight)
                .popoverTip(acceleratorTipHistoryInput())
                // //// 登録、1行削除ボタン
                HStack {
                    Spacer()
                    Button {
                        if accelerator.minusCheck {
                            let gameArray = decodeIntArray(from: accelerator.gameArrayData)
                            if gameArray.count > 0 {
                                accelerator.removeLastHistory()
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                            }
                        } else {
                            isShowDataInputView.toggle()
                        }
                    } label: {
                        if accelerator.minusCheck {
                            Image(systemName: "minus")
                        } else {
                            Image(systemName: "plus")
                        }
                    }
                    .buttonStyle(PlusDeleatButtonStyle(MinusBool: accelerator.minusCheck))
                    .sheet(isPresented: $isShowDataInputView) {
                        acceleratorSubViewDataInputVer2(accelerator: accelerator)
                            .presentationDetents([.medium])
                    }
                    Spacer()
                }
                // //// 参考情報リンク
                // ゲーム数モード
                unitLinkButton(
                    title: "ゲーム数モードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ゲーム数モード",
                            textBody1: "・天井ゲーム数は4つのモードで管理",
                            textBody2: "・設定変更時、AT終了時にモード移行",
                            textBody3: "・天井ゲーム数は液晶ゲーム数ではなく実ゲーム数が対象",
                            textBody4: "・内部的には天井ゲーム数短縮抽選が行われおり、当選時は100G単位で短縮。",
                            tableView: AnyView(acceleratorTableGameMode())
//                            image1: Image("acceleratorGameMode")
                        )
                    )
                )
                // 帯電モード
                unitLinkButton(
                    title: "帯電モードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "帯電モード",
                            textBody1: "・チャンス目高確への移行を管理するモード",
                            textBody2: "・モードによって期待できるゲーム数が変化する",
                            textBody3: "・滞在するゲーム数モードによって帯電モードの振り分けが異なる",
                            textBody4: "・帯電モード3はゲーム数モードCorDのみ振り分けがあるので、ゲーム数末尾0,50どちらも高確へ移行するようであれば早い初当りに期待",
                            tableView: AnyView(acceleratorTableTaidenModeRatio())
//                            image1Title: "[ゲーム数モード毎の帯電モード振り分け]",
//                            image1: Image("acceleratorTaidenModeRatio"),
//                            image2Title: "[高確に期待できるゾーン]",
//                            image2: Image("acceleratorTaidenModeKitai")
                        )
                    )
                )
            } header: {
                unitHeaderHistoryColumns(column2: "ゲーム数", column3: "CZ種類", column4: "AT当否")
            }
            
            // //// 初当り関連まとめ
            Section {
                // //// 通常時ゲーム数
                unitResultCount2Line(title: "通常時ゲーム数", count: $accelerator.playGameSum, spacerBool: false)
                
                // //// 横画面
                if orientation.isLandscape || (orientation.isFlat && lastOrientation.isLandscape) {
                    HStack {
                        // //// CZ
                        // 初当り回数
                        unitResultCount2Line(title: "CZ回数", count: $accelerator.czCount, spacerBool: false)
                        // 初当り確率
                        unitResultRatioDenomination2Line(
                            title: "CZ確率",
                            count: $accelerator.czCount,
                            bigNumber: $accelerator.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // 一方通行CZ確率
                        unitResultRatioDenomination2Line(
                            title: "一通CZ",
                            count: $accelerator.czCountAccelerator,
                            bigNumber: $accelerator.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                        // 打ち止めCZ確率
                        unitResultRatioDenomination2Line(
                            title: "打止CZ",
                            count: $accelerator.czCountLastorder,
                            bigNumber: $accelerator.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
//                        .popoverTip(tipVer200AcceleratorCzRatio())
                        // 一通・打ち止めCZ確率
                        unitResultRatioDenomination2Line(
                            title: "一通・打止",
                            count: $accelerator.czCountBoth,
                            bigNumber: $accelerator.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                    HStack {
                        // //// AT
                        // 初当り回数
                        unitResultCount2Line(title: "AT回数", count: $accelerator.atCount, spacerBool: false)
                        // 初当り確率
                        unitResultRatioDenomination2Line(
                            title: "AT確率",
                            count: $accelerator.atCount,
                            bigNumber: $accelerator.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                }
                // //// 縦画面
                else {
                    // //// CZ
                    VStack(spacing: 10) {
                        HStack {
                            // 初当り回数
                            unitResultCount2Line(title: "CZ回数", count: $accelerator.czCount, spacerBool: false)
                            // 初当り確率
                            unitResultRatioDenomination2Line(
                                title: "CZ確率",
                                count: $accelerator.czCount,
                                bigNumber: $accelerator.playGameSum,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                        }
                        HStack {
                            // 一方通行CZ確率
                            unitResultRatioDenomination2Line(
                                title: "一通CZ",
                                count: $accelerator.czCountAccelerator,
                                bigNumber: $accelerator.playGameSum,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                            // 打ち止めCZ確率
                            unitResultRatioDenomination2Line(
                                title: "打止CZ",
                                count: $accelerator.czCountLastorder,
                                bigNumber: $accelerator.playGameSum,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                            // 一通・打ち止めCZ確率
                            unitResultRatioDenomination2Line(
                                title: "一通・打止",
                                count: $accelerator.czCountBoth,
                                bigNumber: $accelerator.playGameSum,
                                numberofDicimal: 0,
                                spacerBool: false
                            )
                        }
//                        .popoverTip(tipVer200AcceleratorCzRatio())
                    }
                    // //// AT
                    HStack {
                        // 初当り回数
                        unitResultCount2Line(title: "AT回数", count: $accelerator.atCount, spacerBool: false)
                        // 初当り確率
                        unitResultRatioDenomination2Line(
                            title: "AT確率",
                            count: $accelerator.atCount,
                            bigNumber: $accelerator.playGameSum,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                }
                // //// 参考情報リンク
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(acceleratorTableFirstHit())
//                            image1: Image("acceleratorHitRatio"),
//                            image2: Image("acceleratorCzHitRatio")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(acceleratorView95Ci(accelerator: accelerator, selection: 4)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("初当り結果")
            }
            unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "一方通行 とある魔術の禁書目録",
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
        .navigationTitle("CZ,AT 初当り履歴")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $accelerator.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: accelerator.resetHistory)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// /////////////////////////
// データインプットビュー
// /////////////////////////
struct acceleratorSubViewDataInputVer2: View {
    @ObservedObject var accelerator: Accelerator
    @Environment(\.dismiss) private var dismiss
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationView {
            List {
                // ゲーム数入力
                unitTextFieldGamesInput(title: "実ゲーム数", inputValue: $accelerator.inputGame)
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
                // //// サークルピッカー横並び
                HStack {
                    // CZ種類
                    unitPickerCircleString(
                        title: "CZ種類",
                        selected: $accelerator.selectedCz,
                        selectList: accelerator.selectListCz
                    )
                    // 後半パート、前半パートの結果に応じて使い分け
                    if accelerator.selectedCz == accelerator.selectListCz[3]{
                        // AT直撃
                        unitPickerCircleString(
                            title: "AT当否",
                            selected: $accelerator.selectedResultAt,
                            selectList: accelerator.selectListResultAt
                        )
                    } else {
                        // 後半パート、前半失敗
                        unitPickerCircleString(
                            title: "AT当否",
                            selected: $accelerator.selectedResultCz,
                            selectList: accelerator.selectListResultCz
                        )
                    }
                }
                // 登録ボタン
                HStack {
                    Spacer()
                    Button {
                        // //// AT直撃の場合
                        if accelerator.selectedCz == accelerator.selectListCz[3]{
                            accelerator.selectedResult = accelerator.selectedResultAt
                        }
                        // //// CZの場合
                        else {
                            accelerator.selectedResult = accelerator.selectedResultCz
                        }
                        accelerator.addDataHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                        dismiss()
                    } label: {
                        Text("登録")
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
            }
            .navigationTitle("履歴登録")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("閉じる")
                            .fontWeight(.bold)
                    })
                }
            }
        }
    }
}


#Preview {
    acceleratorViewCz(accelerator: Accelerator())
}
