//
//  gobsla2ViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/25.
//

import SwiftUI

struct gobsla2ViewFirstHit: View {
    @ObservedObject var gobsla2: Gobsla2
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
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
    @FocusState var isFocused: Bool
    
    var body: some View {
        List {
            // ---- 履歴登録
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "ゲーム数",
                    inputValue: $gobsla2.inputGame,
                    unitText: "Ｇ",
                )
                .focused($isFocused)
                // 初当り種類選択
                unitPickerMenuString(
                    title: "初当り種類",
                    selected: $gobsla2.selectedKind,
                    selectlist: gobsla2.selectListKind
                )
                // AT当否
                if gobsla2.selectedKind == gobsla2.selectListKind[0] {
                    unitPickerMenuString(
                        title: "AT当否",
                        selected: $gobsla2.selectedAtHit,
                        selectlist: gobsla2.selectListAtHit
                    )
                } else {
                    HStack {
                        Text("AT当否")
                        Spacer()
                        Text(gobsla2.selectListAtHit[1])
                            .foregroundStyle(Color.secondary)
                    }
                }
                
                // //// 登録ボタン
                Button {
                    // マイナスチェック入っていれば1行削除
                    if gobsla2.minusCheck {
                        gobsla2.removeLastHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    // 入っていなければデータ登録
                    else {
                        gobsla2.addHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                } label: {
                    HStack {
                        Spacer()
                        if gobsla2.minusCheck == false {
                            Text("登録")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.blue)
                        } else {
                            Text("1行削除")
                                .fontWeight(.bold)
                                .foregroundStyle(Color.red)
                        }
                        Spacer()
                    }
                }
            } header: {
                HStack {
                    Text("初当り登録")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "初当り登録",
                            textBody1: "CZ,AT直撃ごとに登録して下さい",
                            textBody2: "履歴から\n　　・CZ確率\n　　・AT確率\nを算出します",
                        )
                    }
                }
            }
            
            // ---- 履歴表示
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let gameArray = decodeIntArray(from: gobsla2.gameArrayData)
                    if gameArray.count > 0 {
                        ForEach(gameArray.indices, id: \.self) { index in
                            let viewIndex = gameArray.count - index - 1
                            let atHitArray = decodeStringArray(from: gobsla2.atHitArrayData)
                            HStack {
                                // ゲーム数
                                if gameArray.indices.contains(viewIndex) &&
                                    atHitArray.indices.contains(viewIndex) {
                                    // AT当選の場合は黒字で表示
                                    if atHitArray[viewIndex] != gobsla2.selectListAtHit[0] {
                                        Text("\(gameArray[viewIndex])")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                    }
                                    // AT非当選の場合は()付きグレーで表示
                                    else {
                                        Text("(\(gameArray[viewIndex]))")
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity)
                                            .foregroundStyle(Color.secondary)
                                    }
                                }
                                // 初当り種類
                                let kindArray = decodeStringArray(from: gobsla2.kindArrayData)
                                if kindArray.indices.contains(viewIndex) {
                                    Text(kindArray[viewIndex])
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                }
                                // ボーナス種類
                                if atHitArray.indices.contains(viewIndex) {
                                    Text(atHitArray[viewIndex])
                                        .lineLimit(1)
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
            } header: {
                unitHeaderHistoryColumnsWithoutTimes(
                    column2: "ゲーム数",
                    column3: "初当り種類",
                    column4: "AT当否",
                )
            }
            
            // ---- 初当り確率
            Section {
                // 通常ゲーム数
                unitTextGameNumberWithoutInput(gameNumber: gobsla2.normalGame)
                
                // 確率横並び
                HStack {
                    // CZ
                    unitResultRatioDenomination2Line(
                        title: "CZ",
                        count: $gobsla2.czCount,
                        bigNumber: $gobsla2.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // ボーナス
                    unitResultRatioDenomination2Line(
                        title: "AT",
                        count: $gobsla2.atCount,
                        bigNumber: $gobsla2.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                }
                
                // //// 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率", linkText: "初当り確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "CZ",
                            denominateList: gobsla2.ratioFirstHitCz,
                        )
                        unitTableDenominate(
                            columTitle: "AT",
                            denominateList: gobsla2.ratioFirstHitAt,
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        gobsla2View95Ci(
                            gobsla2: gobsla2,
                            selection: 4
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    gobsla2ViewBayes(
                        gobsla2: gobsla2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("初当り確率")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.gobsla2MenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: gobsla2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
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
                unitButtonMinusCheck(minusCheck: $gobsla2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: gobsla2.resetFirstHit)
            }
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
    }
}

#Preview {
    gobsla2ViewFirstHit(
        gobsla2: Gobsla2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
