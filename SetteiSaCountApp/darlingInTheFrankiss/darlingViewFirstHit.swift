//
//  darlingViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/27.
//

import SwiftUI

struct darlingViewFirstHit: View {
    @ObservedObject var ver390: Ver390
    @ObservedObject var darling: Darling
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @State private var lastOrientation: UIDeviceOrientation = .portrait // 直前の向き
    let scrollViewHeightPortrait = 250.0
    let scrollViewHeightLandscape = 150.0
    @State var scrollViewHeight = 250.0
    let spaceHeightPortrait = 300.0
    let spaceHeightLandscape = 0.0
    @State var spaceHeight = 300.0
    let lazyVGridCountPortrait: Int = 3
    let lazyVGridCountLandscape: Int = 5
    @State var lazyVGridCount: Int = 3
    let maxWidth2: CGFloat = 60
    let maxWidth3: CGFloat = .infinity
    let maxWidth4: CGFloat = .infinity
    let maxWidth5: CGFloat = 60
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    
    var body: some View {
        List {
            // //// 履歴登録
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "ゲーム数",
                    inputValue: $darling.inputGame,
                    unitText: "Ｇ",
                )
                .focused($isFocused)
                // ボーナス種類選択
                unitPickerMenuString(
                    title: "初当り種類",
                    selected: $darling.selectedFirstKind,
                    selectlist: darling.selectListFirstKind
                )
                // ボーナス種類選択
                unitPickerMenuString(
                    title: "ボーナス種類",
                    selected: $darling.selectedBonusKind,
                    selectlist: darling.selectListBonusKind
                )
                // ボーナス高確当否
                if darling.selectedBonusKind == darling.selectListBonusKind[0] {
                    HStack {
                        Text("ボーナス高確率")
                        Spacer()
                        Text("-")
                            .foregroundStyle(Color.secondary)
                    }
                } else {
                    unitPickerMenuString(
                        title: "ボーナス高確率",
                        selected: $darling.selectedKokakuHit,
                        selectlist: darling.selectListKokakuHit
                    )
                }
                
                // //// 登録ボタン
                Button {
                    // マイナスチェック入っていれば1行削除
                    if darling.minusCheck {
                        darling.removeLastHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    // 入っていなければデータ登録
                    else {
                        // //// ボーナスハズレ
                        if darling.selectedBonusKind != darling.selectListBonusKind[0] {
                            darling.addHistory()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                        }
                        // //// エピソードボーナス
                        else {
                            darling.selectedKokakuHit = "-"
                            darling.addHistory()
                            UINotificationFeedbackGenerator().notificationOccurred(.success)
                            darling.selectedKokakuHit = darling.selectListKokakuHit[0]
                        }
                    }
                } label: {
                    HStack {
                        Spacer()
                        if darling.minusCheck == false {
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
                            textBody1: "CZ,ボーナス初当りごとに登録して下さい",
                            textBody2: "ゲーム数は液晶ゲーム数を入力して下さい",
                            textBody3: "履歴から\n　　・CZ確率\n　　・ボーナス確率\n　　・ボーナス高確率確率\nを算出します",
                        )
                    }
                }
            }
            
            // //// 設定差参考情報
//            Section {
//                // CZスタート時のレベル
//                unitLinkButtonViewBuilder(sheetTitle: "CZスタート時のレベル") {
//                    VStack {
//                        Text("・CZのレベル4(緑)、レベル5(赤)スタートは高設定ほど優遇")
//                    }
//                }
////                .popoverTip(tipVer370DarlingCzLevel())
//            }
            
            // //// 履歴表示
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let gameArray = decodeIntArray(from: darling.gameArrayData)
                    if gameArray.count > 0 {
                        ForEach(gameArray.indices, id: \.self) { index in
                            let viewIndex = gameArray.count - index - 1
                            let bonusKindArray = decodeStringArray(from: darling.bonusKindArrayData)
                            HStack {
                                // ゲーム数
                                if gameArray.indices.contains(viewIndex) {
                                    
                                    if bonusKindArray.indices.contains(viewIndex) {
                                        // ボーナス当選の場合は黒字で表示
                                        if bonusKindArray[viewIndex] != darling.selectListBonusKind[0] {
                                            Text("\(gameArray[viewIndex])")
                                                .lineLimit(1)
                                                .frame(maxWidth: self.maxWidth2)
                                        }
                                        // AT非当選の場合は()付きグレーで表示
                                        else {
                                            Text("(\(gameArray[viewIndex]))")
                                                .lineLimit(1)
                                                .frame(maxWidth: self.maxWidth2)
                                                .foregroundStyle(Color.secondary)
                                        }
                                    }
                                }
                                // 初当り種類
                                let firstKindArray = decodeStringArray(from: darling.firstKindArrayData)
                                if firstKindArray.indices.contains(viewIndex) {
                                    if firstKindArray[viewIndex] == darling.selectListFirstKind[0] {
                                        Text("CZ(ｺﾈｸﾄ)")
                                            .font(.subheadline)
                                            .lineLimit(1)
                                            .frame(maxWidth: self.maxWidth3)
                                    } else if firstKindArray[viewIndex] == darling.selectListFirstKind[1] {
                                        Text("CZ(ｺｺﾛ)")
                                            .font(.subheadline)
                                            .lineLimit(1)
                                            .frame(maxWidth: self.maxWidth3)
                                    } else {
                                        Text("直撃")
                                            .lineLimit(1)
                                            .frame(maxWidth: self.maxWidth3)
                                    }
                                }
                                // ボーナス種類
                                if bonusKindArray.indices.contains(viewIndex) {
                                    if bonusKindArray[viewIndex] == darling.selectListBonusKind[1]{
                                        Text("DB")
                                            .lineLimit(1)
                                            .frame(maxWidth: self.maxWidth4)
                                    } else if bonusKindArray[viewIndex] == darling.selectListBonusKind[3]{
                                        Text("エピボ")
                                            .lineLimit(1)
                                            .frame(maxWidth: self.maxWidth4)
                                    } else {
                                        Text(bonusKindArray[viewIndex])
                                            .lineLimit(1)
                                            .frame(maxWidth: self.maxWidth4)
                                    }
                                }
                                // ボーナス高確率当否
                                let kokakuArray = decodeStringArray(from: darling.kokakuHitArrayData)
                                if kokakuArray.indices.contains(viewIndex) {
                                    Text(kokakuArray[viewIndex])
                                        .lineLimit(1)
                                        .frame(maxWidth: self.maxWidth5)
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
                    column4: "ボーナス",
                    column5: "高確率",
                    column2MaxWidth: self.maxWidth2,
                    column3MaxWidth: self.maxWidth3,
                    column4MaxWidth: self.maxWidth4,
                    column5MaxWidth: self.maxWidth5,
                )
            }
            
            // //// 初当り確率
            Section {
                // 通常ゲーム数
                HStack {
                    Text("通常ゲーム数")
                    Spacer()
                    Text("\(darling.normalGame)    G")
                        .foregroundStyle(Color.secondary)
                }
                // 確率横並び
                HStack {
                    // CZ
                    unitResultRatioDenomination2Line(
                        title: "CZ",
                        count: $darling.czCount,
                        bigNumber: $darling.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // ボーナス
                    unitResultRatioDenomination2Line(
                        title: "ボーナス",
                        count: $darling.bonusCount,
                        bigNumber: $darling.normalGame,
                        numberofDicimal: 0,
                        spacerBool: false,
                    )
                    // ボーナス高確率
                    unitResultRatioDenomination2Line(
                        title: "ボナ高確率",
                        count: $darling.kokakuCount,
                        bigNumber: $darling.normalGame,
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
                            denominateList: darling.ratioCz,
                        )
                        unitTableDenominate(
                            columTitle: "ボーナス",
                            denominateList: darling.ratioBonus,
                        )
                        unitTableDenominate(
                            columTitle: "ボーナス高確率",
                            denominateList: darling.ratioKokaku,
                        )
                    }
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        darlingView95Ci(
                            darling: darling,
                            selection: 1
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    darlingViewBayes(
                        ver390: ver390,
                        darling: darling,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("確率集計")
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
//        .resetBadgeOnAppear($ver370.darlingMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: darling.machineName,
                screenClass: screenClass
            )
        }
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
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $darling.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: darling.resetFirstHit)
                }
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
    darlingViewFirstHit(
        ver390: Ver390(),
        darling: Darling(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
