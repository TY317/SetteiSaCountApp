//
//  rezero2ViewHistory.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/31.
//

import SwiftUI
import TipKit

// /////////////////////
// Tip：内部規定ポイント抽選についての説明
// /////////////////////
struct tipRezero2PtDraw: Tip {
    var title: Text {
        Text("内部規定ポイントの抽選確率")
    }
    
    var message: Text? {
        Text("入力されたPtゾーンと当選契機の履歴から内部での規定ポイント抽選の回数と当選確率を算出します")
    }
    var image: Image? {
        Image(systemName: "lightbulb.min")
    }
}


struct rezero2ViewHistory: View {
//    @ObservedObject var rezero2 = Rezero2()
    @ObservedObject var rezero2: Rezero2
    @State var isShowAlert: Bool = false
    @State var isShowDataInputView = false
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
            // //// 履歴
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let gameArray = decodeIntArray(from: rezero2.gameArrayData)
                    if gameArray.count > 0 {
                        ForEach(gameArray.indices, id: \.self) { index in
                            let viewIndex = gameArray.count - index - 1
                            HStack {
                                // 回数
                                Text("\(viewIndex+1)")
                                    .frame(width: 40.0)
                                // ゲーム数
                                if gameArray.indices.contains(viewIndex) {
                                    Text("\(gameArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // Ptゾーン
                                let ptZoneArray = decodeStringArray(from: rezero2.ptZoneArrayData)
                                if ptZoneArray.indices.contains(viewIndex) {
                                    Text("\(ptZoneArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                } else {
                                    Text("-")
                                        .frame(maxWidth: .infinity)
                                }
                                // 当選契機
                                let triggerArray = decodeStringArray(from: rezero2.triggerArrayData)
                                if triggerArray.indices.contains(viewIndex) {
                                    Text("\(triggerArray[viewIndex])")
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
                
                // //// 登録、1行削除ボタン
                HStack {
                    Spacer()
                    Button {
                        if rezero2.minusCheck {
                            let gameArray = decodeIntArray(from: rezero2.gameArrayData)
                            if gameArray.count > 0 {
                                rezero2.removeLastHistory()
                                UINotificationFeedbackGenerator().notificationOccurred(.success)
                            }
                        } else {
                            isShowDataInputView.toggle()
                        }
                    } label: {
                        if rezero2.minusCheck {
                            Image(systemName: "minus")
                        } else {
                            Image(systemName: "plus")
                        }
                    }
                    .buttonStyle(PlusDeleatButtonStyle(MinusBool: rezero2.minusCheck))
                    .sheet(isPresented: $isShowDataInputView) {
                        rezero2SubViewDataInput(rezero2: rezero2)
                            .presentationDetents([.medium])
                    }
                    Spacer()
                }
                // //// 参考情報リンク
                unitLinkButton(title: "規定Ptについて", exview: AnyView(unitExView5body2image(title: "規定Pt", textBody1: "・本機のメイン当選契機で最大天井は1400", textBody2: "・基本的に100Ptごとにゾーンが存在し、百の位が偶数のゾーンがチャンス", textBody3: "・百の位が奇数のゾーンでの当選は高設定ほど多いのではとの噂あり（ただし、特に朝イチは低設定でも奇数ゾーンで当たることもあるらしいので要注意）")))
            } header: {
                unitHeaderHistoryColumns(column2: "実ゲーム数", column3: "Ptゾーン", column4: "当選契機")
            }
            
            // //// AT初当たり
            Section {
                HStack {
                    // 通常時ゲーム数
                    unitResultCount2Line(title: "通常G数", color: .grayBack, count: $rezero2.playGameSum, spacerBool: false)
                    // 初当たり回数
                    unitResultCount2Line(title: "AT回数", color: .grayBack, count: $rezero2.atHitCount, spacerBool: false)
                    // 初当たり確率
                    unitResultRatioDenomination2Line(title: "AT確率", color: .grayBack, count: $rezero2.atHitCount, bigNumber: $rezero2.playGameSum, numberofDicimal: 0, spacerBool: false)
                }
                // //// 参考情報リンク
                unitLinkButton(title: "AT初当たり確率について", exview: AnyView(unitExView5body2image(title: "AT初当たり確率", textBody1: "・AT初当たり確率に設定差あり", image1: Image("rezero2AtHitRatio"))))
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(rezero2View95Ci(rezero2: rezero2, selection: 1)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("AT初当たり")
            }
            
            // //// 内部規定Pt抽選
            Section {
                // 偶数
                VStack {
                    Text("百の位が偶数の抽選")
                    HStack {
                        unitResultCount2Line(
                            title: "抽選回数",
                            color: .grayBack,
                            count: $rezero2.ptDrawGusuCount,
                            spacerBool: false
                        )
                        unitResultCount2Line(
                            title: "当選回数",
                            color: .grayBack,
                            count: $rezero2.ptDrawGusuWinCount,
                            spacerBool: false
                        )
                        unitResultRatioPercent2Line(
                            title: "当選確率",
                            color: .grayBack,
                            count: $rezero2.ptDrawGusuWinCount,
                            bigNumber: $rezero2.ptDrawGusuCount,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                }
                // 奇数
                VStack {
                    Text("百の位が奇数の抽選")
                    HStack {
                        unitResultCount2Line(
                            title: "抽選回数",
                            color: .grayBack,
                            count: $rezero2.ptDrawKisuCount,
                            spacerBool: false
                        )
                        unitResultCount2Line(
                            title: "当選回数",
                            color: .grayBack,
                            count: $rezero2.ptDrawKisuWinCount,
                            spacerBool: false
                        )
                        unitResultRatioPercent2Line(
                            title: "当選確率",
                            color: .grayBack,
                            count: $rezero2.ptDrawKisuWinCount,
                            bigNumber: $rezero2.ptDrawKisuCount,
                            numberofDicimal: 0,
                            spacerBool: false
                        )
                    }
                }
                // 参考情報リンク
                unitLinkButton(
                    title: "内部規定Pt抽選について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "内部規定Pt抽選",
                            textBody1: "・通常開始1G目に次回規定Ptを内部的に決定",
                            textBody2: "・100Pt,200Pt〜の順に下表の抽選を繰り返し、当否を決定",
                            textBody3: "・最大1400Ptで当選。1300までの抽選に漏れたら1400は100％当選という仕組みと思われる",
                            textBody4: "・このアプリでは初当り履歴から内部的な抽選回数と当選確率を算出させています",
                            image1: Image("rezero2PtDraw")
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(rezero2View95Ci(rezero2: rezero2, selection: 3)))
            } header: {
                Text("内部規定Pt抽選")
            }
            .popoverTip(tipRezero2PtDraw())
            
            // //// 引き戻し
            Section {
                HStack {
                    // 引き戻し回数
                    unitResultCount2Line(title: "引き戻し回数", color: .grayBack, count: $rezero2.comebackCount)
                    // 引き戻し確率
                    unitResultRatioPercent2Line(title: "引き戻し確率", color: .grayBack, count: $rezero2.comebackCount, bigNumber: $rezero2.atHitCount, numberofDicimal: 0)
                }
                // //// 参考情報リンク
//                unitLinkButton(title: "引き戻しについて", exview: AnyView(unitExView5body2image(title: "引き戻し（死に戻り）", textBody1: "・AT後32G+αで引き戻しの可能性あり", textBody2: "・引き戻し確率に設定差があるのではとの噂あり。設定6は20%程度で引き戻すとの噂。低設定は数%！？引き戻しが複数回確認できたら期待できるかも。")))
                unitLinkButton(
                    title: "引き戻しについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "引き戻し（死に戻り）",
                            textBody1: "・AT後32G+αで引き戻しの可能性あり",
                            textBody2: "・引き戻し確率に設定差がある",
                            image1: Image("rezero2Comeback")
                        )
                    )
                )
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(Ci95view: AnyView(rezero2View95Ci(rezero2: rezero2, selection: 2)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("引き戻し")
            }
            unitClearScrollSectionBinding(spaceHeight: $spaceHeight)
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "Re:ゼロ season2",
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
        .navigationTitle("AT初当たり履歴")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $rezero2.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: rezero2.resetHistory)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// /////////////////////////
// ビュー：データインプット画面
// /////////////////////////
struct rezero2SubViewDataInput: View {
    @ObservedObject var rezero2: Rezero2
    @Environment(\.dismiss) private var dismiss
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationView {
            List {
                // ゲーム数入力
                unitTextFieldGamesInput(title: "実ゲーム数", inputValue: $rezero2.inputGame)
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
                    // Ptゾーン
                    unitPickerCircleString(title: "Ptゾーン", selected: $rezero2.selectedPt, selectList: rezero2.selectListPtZone)
                    // 当選契機
                    unitPickerCircleString(title: "当選契機", selected: $rezero2.selectedTrigger, selectList: rezero2.selectListTrigger)
                }
                // //// 登録ボタン
                HStack {
                    Spacer()
                    Button {
                        rezero2.addDataHistory()
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
    rezero2ViewHistory(rezero2: Rezero2())
}
