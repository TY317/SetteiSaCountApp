//
//  toreveViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/02.
//

import SwiftUI

struct toreveViewNormal: View {
    @EnvironmentObject var common: commonVar
//    @ObservedObject var ver391: Ver391
    @ObservedObject var toreve: Toreve
    @State var isShowAlert: Bool = false
    @FocusState var isFocused: Bool
    @State var selectedSegment: String = "ミッドナイトモード"
    let segmentList: [String] = ["ミッドナイトモード", "稀咲陰謀"]
    @State var selectedItem: String = "共通ベル"
    let selectList: [String] = ["共通ベル", "通常時チャンス目"]
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    var body: some View {
        List {
            // //// 共通🔔
            Section {
                // //// セグメントピッカー
                Picker("", selection: self.$selectedItem) {
                    ForEach(self.selectList, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)
//                .popoverTip(tipVer3100ToreveChanceCz())
                // 共通ベル
                if self.selectedItem == self.selectList[0] {
                    // 注意書き
                    Text("通常時に左1stで上段平行に揃う共通ベルに設定差あり\nAT中はセグなし15枚ベルがそのフラグという噂あり")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                    // カウントボタン
//                    unitCountButtonVerticalDenominate(
//                        title: "共通🔔",
//                        count: $toreve.bellCount,
//                        color: .personalSpringLightYellow,
//                        bigNumber: $toreve.gameNumberPlay,
//                        numberofDicimal: 0,
//                        minusBool: $toreve.minusCheck,
//                        flushColor: .yellow,
//                    )
                    unitCountButtonVerticalWithoutRatio(
                        title: "共通🔔",
                        count: $toreve.bellCount,
                        color: .personalSpringLightYellow,
                        minusBool: $toreve.minusCheck,
                        flushColor: .yellow,
                    )
//                    .popoverTip(tipVer391ToreveNormal())
                }
                // 通常時チャンス目
                else {
                    // 注意書き
                    Text("通常時のチャンス目からのCZ当選に設定差あり\nチャンス目回数とそこからのCZ当選回数をカウント")
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                    // カウントボタン横並び
                    HStack {
                        // チャンス目
                        unitCountButtonVerticalWithoutRatio(
                            title: "チャンス目",
                            count: $toreve.chanceCzCountChance,
                            color: .personalSummerLightPurple,
                            minusBool: $toreve.minusCheck
                        )
                        // CZ当選
                        unitCountButtonVerticalWithoutRatio(
                            title: "CZ当選",
                            count: $toreve.chanceCzCountCzHit,
                            color: .personalSummerLightRed,
                            minusBool: $toreve.minusCheck
                        )
                    }
                }
                // //// 確率横並び
                HStack {
                    // 共通ベル
                    unitResultRatioDenomination2Line(
                        title: "共通ベル",
                        count: $toreve.bellCount,
                        bigNumber: $toreve.gameNumberPlay,
                        numberofDicimal: 0,
                    )
                    // CZ当選率
                    unitResultRatioPercent2Line(
                        title: "CZ当選率",
                        count: $toreve.chanceCzCountCzHit,
                        bigNumber: $toreve.chanceCzCountChance,
                        numberofDicimal: 0
                    )
                }
                // 参考情報）共通ベル確率
                unitLinkButtonViewBuilder(sheetTitle: "共通🔔確率") {
                    VStack {
                        // 注意書き
                        VStack(alignment: .leading) {
                            Text("・通常時に左1stで上段平行に揃う共通🔔に設定差あり")
                            Text("・AT中は押し順ナビが出て停止系では判別できないケースがあるが、セグなし15枚ベルが共通ベルフラグと言われているのでカウントに加えられるかも！？")
                        }
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "共通🔔",
                                denominateList: toreve.ratioBell,
                            )
                        }
                    }
                }
                .popoverTip(tipVer3110ToreveCommonBell())
                // 参考情報）レア役からのCZ当選率
                unitLinkButtonViewBuilder(sheetTitle: "レア役からのCZ当選率") {
                    VStack {
                        Picker("", selection: self.$selectedSegment) {
                            ForEach(self.segmentList, id: \.self) { czKind in
                                Text(czKind)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.bottom)
                        if self.selectedSegment == self.segmentList[0] {
                            Text("[通常滞在時]")
                                .font(.title2)
                            HStack(spacing: 0) {
                                unitTableSettingIndex()
                                unitTablePercent(
                                    columTitle: "チャンス目",
                                    percentList: toreve.ratioNormalChanceMidNight,
                                    numberofDicimal: 1,
                                )
                                unitTablePercent(
                                    columTitle: "強🍒",
                                    percentList: [toreve.ratioNormalKyoCherryMidNight[0]],
                                    numberofDicimal: 0,
                                    lineList: [6],
                                    colorList: [.white],
                                )
                            }
                            .padding(.bottom)
                            Text("[高確滞在時]")
                                .font(.title2)
                            HStack(spacing: 0) {
                                unitTableSettingIndex()
                                unitTablePercent(
                                    columTitle: "チャンス目",
                                    percentList: [toreve.ratioHighChanceMidNight[0]],
                                    numberofDicimal: 0,
                                    lineList: [6],
                                    colorList: [.white],
                                )
                                unitTablePercent(
                                    columTitle: "強🍒",
                                    percentList: [toreve.ratioHighKyoCherryMidNight[0]],
                                    numberofDicimal: 0,
                                    lineList: [6],
                                    colorList: [.white],
                                )
                            }
                        } else {
                            Text("[通常滞在時]")
                                .font(.title2)
                            HStack(spacing: 0) {
                                unitTableSettingIndex()
                                unitTablePercent(
                                    columTitle: "卍目",
                                    percentList: toreve.ratioNormalManjiKisaki,
                                    numberofDicimal: 1,
                                )
                            }
                            .padding(.bottom)
                            Text("[高確滞在時]")
                                .font(.title2)
                            HStack(spacing: 0) {
                                unitTableSettingIndex()
                                unitTablePercent(
                                    columTitle: "卍目",
                                    percentList: toreve.ratioHighManjiKisaki,
                                    numberofDicimal: 1,
                                )
                            }
                        }
                    }
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        toreveView95Ci(
                            toreve: toreve,
                            selection: 7,
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    toreveViewBayes(
                        toreve: toreve,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("共通ベル、通常時チャンス目")
            }
            
            // //// ゲーム数入力
            Section {
                // 打ち始め入力
                unitTextFieldNumberInputWithUnit(
                    title: "打ち始め",
                    inputValue: $toreve.gameNumberStart,
                    unitText: "Ｇ"
                )
                .focused(self.$isFocused)
                .onChange(of: toreve.gameNumberStart) {
                    let playGame = toreve.gameNumberCurrent - toreve.gameNumberStart
                    toreve.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // 現在入力
                unitTextFieldNumberInputWithUnit(
                    title: "現在",
                    inputValue: $toreve.gameNumberCurrent,
                    unitText: "Ｇ"
                )
                .focused(self.$isFocused)
                .onChange(of: toreve.gameNumberCurrent) {
                    let playGame = toreve.gameNumberCurrent - toreve.gameNumberStart
                    toreve.gameNumberPlay = playGame > 0 ? playGame : 0
                }
                // プレイ数
                unitTextGameNumberWithoutInput(
                    gameNumber: toreve.gameNumberPlay
                )
                
            } header: {
                HStack {
                    Text("ゲーム数入力")
                }
            }
            
            // //// 小役関連
            Section {
                // レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系", linkText: "レア役停止系") {
                    toreveTableKoyakuPattern()
                }
                // 参考情報）中段🍒確率
                unitLinkButtonViewBuilder(sheetTitle: "中段🍒確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "中段🍒",
                            denominateList: [16384,13107.2,10922.7],
                            lineList: [3,2,1],
                            colorList: [.white, .tableBlue, .white],
                        )
                    }
                }
                // 参考情報）レア役からのCZ当選率
//                unitLinkButtonViewBuilder(sheetTitle: "レア役からのCZ当選率") {
//                    VStack {
//                        Picker("", selection: self.$selectedSegment) {
//                            ForEach(self.segmentList, id: \.self) { czKind in
//                                Text(czKind)
//                            }
//                        }
//                        .pickerStyle(.segmented)
//                        .padding(.bottom)
//                        if self.selectedSegment == self.segmentList[0] {
//                            Text("[通常滞在時]")
//                                .font(.title2)
//                            HStack(spacing: 0) {
//                                unitTableSettingIndex()
//                                unitTablePercent(
//                                    columTitle: "チャンス目",
//                                    percentList: toreve.ratioNormalChanceMidNight,
//                                    numberofDicimal: 1,
//                                )
//                                unitTablePercent(
//                                    columTitle: "強🍒",
//                                    percentList: toreve.ratioNormalKyoCherryMidNight,
//                                    numberofDicimal: 0,
//                                )
//                            }
//                            .padding(.bottom)
//                            Text("[高確滞在時]")
//                                .font(.title2)
//                            HStack(spacing: 0) {
//                                unitTableSettingIndex()
//                                unitTablePercent(
//                                    columTitle: "チャンス目",
//                                    percentList: toreve.ratioHighChanceMidNight,
//                                    numberofDicimal: 0,
//                                )
//                                unitTablePercent(
//                                    columTitle: "強🍒",
//                                    percentList: toreve.ratioHighKyoCherryMidNight,
//                                    numberofDicimal: 0,
//                                )
//                            }
//                        } else {
//                            Text("[通常滞在時]")
//                                .font(.title2)
//                            HStack(spacing: 0) {
//                                unitTableSettingIndex()
//                                unitTablePercent(
//                                    columTitle: "卍目",
//                                    percentList: toreve.ratioNormalManjiKisaki,
//                                    numberofDicimal: 1,
//                                )
//                            }
//                            .padding(.bottom)
//                            Text("[高確滞在時]")
//                                .font(.title2)
//                            HStack(spacing: 0) {
//                                unitTableSettingIndex()
//                                unitTablePercent(
//                                    columTitle: "卍目",
//                                    percentList: toreve.ratioHighManjiKisaki,
//                                    numberofDicimal: 1,
//                                )
//                            }
//                        }
//                    }
//                }
            } header: {
                Text("レア役")
            }
            
            // //// 内部状態
            Section {
                // 参考情報）内部状態
                unitLinkButtonViewBuilder(sheetTitle: "内部状態") {
                    HStack(spacing: 0) {
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "種類",
                                "昇格契機",
                                "高確恩恵",
                            ],
                            maxWidth: 100,
                        )
                        unitTableString(
                            columTitle: "",
                            stringList: [
                                "通常・高確の2種類",
                                "主に🍉、弱🍒、卍目",
                                "東卍アクセル、CZ当選が優遇",
                            ],
                            maxWidth: 250,
                        )
                    }
                }
            } header: {
                Text("内部状態")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.toreveMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $toreve.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: toreve.resetNormal)
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
    toreveViewNormal(
//        ver391: Ver391(),
        toreve: Toreve(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
