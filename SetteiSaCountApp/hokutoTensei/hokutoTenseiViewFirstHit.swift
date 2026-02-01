//
//  hokutoTenseiViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/31.
//

import SwiftUI

struct hokutoTenseiViewFirstHit: View {
    @ObservedObject var hokutoTensei: HokutoTensei
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
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
    
    var body: some View {
        List {
            Section {
                // 注意書き
                Text("・マイスロを参考に入力して下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "通常ゲーム数",
                    inputValue: $hokutoTensei.normalGame,
                    unitText: "Ｇ",
                )
                .focused(self.$isFocused)
                // 天破 突入回数
                unitTextFieldNumberInputWithUnit(
                    title: "天破の刻 突入回数",
                    inputValue: $hokutoTensei.firstHitCountTenha
                )
                .focused(self.$isFocused)
                .onChange(of: hokutoTensei.firstHitCountTenha, { oldValue, newValue in
                    hokutoTensei.tenhaGame = Int(Double(newValue) * hokutoTensei.tenhaDenoInput)
                })
                // 天破　突入確率
                HStack {
                    Text("天破の刻 突入確率")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Text("1/")
                            .foregroundStyle(Color.secondary)
                        TextField(
                            "天破の刻 突入確率",
                            value: $hokutoTensei.tenhaDenoInput,
                            format: .number,
                        )
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .focused(self.$isFocused)
                        .onChange(of: hokutoTensei.tenhaDenoInput, { oldValue, newValue in
                            hokutoTensei.tenhaGame = Int(Double(hokutoTensei.firstHitCountTenha) * newValue)
                        })
                    }
                }
                // カウントボタン横並び
                HStack {
                    // 天破
//                    unitCountButtonVerticalDenominate(
//                        title: "天破の刻",
//                        count: $hokutoTensei.firstHitCountTenha,
//                        color: .personalSummerLightGreen,
//                        bigNumber: $hokutoTensei.tenhaGame,
//                        numberofDicimal: 0,
//                        minusBool: $hokutoTensei.minusCheck
//                    )
                    // AT
                    unitCountButtonVerticalDenominate(
                        title: "闘神演舞",
                        count: $hokutoTensei.firstHitCountAt,
                        color: .personalSummerLightRed,
                        bigNumber: $hokutoTensei.normalGame,
                        numberofDicimal: 0,
                        minusBool: $hokutoTensei.minusCheck
                    )
                }
                // 参考情報）初当り確率
                unitLinkButtonViewBuilder(sheetTitle: "初当り確率") {
                    VStack {
                        Text("・天破は伝承ループでの当選分も含んだ実質出現率")
                            .padding(.bottom)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableDenominate(
                                columTitle: "天破の刻",
                                denominateList: hokutoTensei.ratioAtFirstHitTenha
                            )
                            unitTableDenominate(
                                columTitle: "闘神演舞",
                                denominateList: hokutoTensei.ratioAtFirstHitAt
                            )
                        }
                    }
                }
    //            .popoverTip(tipVer3171hokutoTenseiTenha())
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        hokutoTenseiView95Ci(
                            hokutoTensei: hokutoTensei,
                            selection: 3,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    hokutoTenseiViewBayes(
                        hokutoTensei: hokutoTensei,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("初当り")
            }
            
            // あべし登録
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "規定あべし",
                    inputValue: $hokutoTensei.inputGame,
                    unitText: "あべし",
                )
                .focused($isFocused)
//                .popoverTip(tipVer3170hokutTenseiAbeshiHistory())
                // //// 登録ボタン
                Button {
                    // マイナスチェック入っていれば1行削除
                    if hokutoTensei.minusCheck {
                        hokutoTensei.removeLastHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                    // 入っていなければデータ登録
                    else {
                        hokutoTensei.addHistory()
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                } label: {
                    HStack {
                        Spacer()
                        if hokutoTensei.minusCheck == false {
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
                    Text("規定あべし登録")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "規定あべし",
                            textBody1: "・規定あべし到達ごとに登録して下さい",
                        )
                    }
                }
            }
            
            // あべし履歴
            Section {
                ScrollView {
                    // //// 配列のデータ数が0以上なら履歴表示
                    let gameArray = decodeIntArray(from: hokutoTensei.gameArrayData)
                    if gameArray.count > 0 {
                        VStack {
                            Text("※ 設定変更時以外のテーブルを参照")
                                .foregroundStyle(Color.secondary)
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            HStack {
                                Text("")
                                    .frame(maxWidth: .infinity)
                                HStack {
                                    Text("A")
                                        .frame(maxWidth: .infinity)
                                    Text("B")
                                        .frame(maxWidth: .infinity)
                                    Text("C")
                                        .frame(maxWidth: .infinity)
                                    Text("天国")
                                        .frame(maxWidth: .infinity)
                                }
                            }
                        }
                        ForEach(gameArray.indices, id: \.self) { index in
                            let viewIndex = gameArray.count - index - 1
                            HStack {
                                // ゲーム数
                                if gameArray.indices.contains(viewIndex) {
                                    // あべし
                                    Text("\(gameArray[viewIndex])")
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                    
                                    // 期待度◯以上ゾーン
                                    // 64以下
                                    if gameArray[viewIndex] <= 64 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "△",
                                            modeB: "△",
                                            modeC: "△",
                                            modeHeaven: "◯"
                                        )
                                    }
                                    // 65-128
                                    else if gameArray[viewIndex] <= 128 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "△",
                                            modeB: "△",
                                            modeC: "△",
                                            modeHeaven: "天井"
                                        )
                                    }
                                    // 129-192
                                    else if gameArray[viewIndex] <= 192 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "△",
                                            modeB: "△",
                                            modeC: "△"
                                        )
                                    }
                                    // 193-256
                                    else if gameArray[viewIndex] <= 256 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "◎",
                                            modeB: "◎",
                                            modeC: "◎"
                                        )
                                    }
                                    // 257-320
                                    else if gameArray[viewIndex] <= 320 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "△",
                                            modeB: "△",
                                            modeC: "△"
                                        )
                                    }
                                    // 321-384
                                    else if gameArray[viewIndex] <= 384 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "△",
                                            modeB: "◯",
                                            modeC: "△"
                                        )
                                    }
                                    // 385-448
                                    else if gameArray[viewIndex] <= 448 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "△",
                                            modeB: "△",
                                            modeC: "△"
                                        )
                                    }
                                    // 449-512
                                    else if gameArray[viewIndex] <= 512 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "△",
                                            modeB: "△",
                                            modeC: "△"
                                        )
                                    }
                                    // 513-576
                                    else if gameArray[viewIndex] <= 576 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "◯",
                                            modeB: "△",
                                            modeC: "天井"
                                        )
                                    }
                                    // 577-704
                                    else if gameArray[viewIndex] <= 704 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "△",
                                            modeB: "△",
                                        )
                                    }
                                    // 705-768
                                    else if gameArray[viewIndex] <= 768 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "△",
                                            modeB: "◯",
                                        )
                                    }
                                    // 769-832
                                    else if gameArray[viewIndex] <= 832 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "△",
                                            modeB: "△",
                                        )
                                    }
                                    // 833-896
                                    else if gameArray[viewIndex] <= 896 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "◯",
                                            modeB: "天井",
                                        )
                                    }
                                    // 897-1216
                                    else if gameArray[viewIndex] <= 1216 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "△",
                                        )
                                    }
                                    // 1217-1280
                                    else if gameArray[viewIndex] <= 1280 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "◎",
                                        )
                                    }
                                    // 1281-1344
                                    else if gameArray[viewIndex] <= 1344 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "◯",
                                        )
                                    }
                                    // 1345-1472
                                    else if gameArray[viewIndex] <= 1472 {
                                        hokutTenseiHitstoryTable(
                                            modeA: "◎",
                                        )
                                    }
                                    // 1473-1536
                                    else {
                                        hokutTenseiHitstoryTable(
                                            modeA: "天井",
                                        )
                                    }
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
                
                // 参考情報）あべし期待度テーブル
                unitLinkButtonViewBuilder(sheetTitle: "あべし期待度テーブル") {
                    hokutoTenseiTableAbeshi()
                }
                // 参考情報）フェイク前兆発生テーブル
                unitLinkButtonViewBuilder(sheetTitle: "フェイク前兆発生テーブル") {
                    hokutoTenseiTableFake()
                }
                
                // 参考情報）設定変更時の256あべしまでの当選率
                unitLinkButtonViewBuilder(sheetTitle: "設定変更時 256までの当選期待度") {
                    VStack {
                        Text("設定変更時 256あべしまでの実質当選期待度")
                            .padding(.bottom)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTableString(
                                columTitle: "期待度",
                                stringList: [
                                    "36%",
                                    "↓",
                                    "↓",
                                    "↓",
                                    "↓",
                                    "53%",
                                ]
                            )
                        }
                    }
                }
                .popoverTip(tipVer3180hokutoTensei256())
            } header: {
                unitHeaderHistoryColumnsWithoutTimes(
                    column2: "規定あべし",
                    column3: "期待度テーブル",
                )
            }
            unitClearScrollSectionBinding(spaceHeight: self.$spaceHeight)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hokutoTenseiMenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hokutoTensei.machineName,
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
                unitButtonMinusCheck(minusCheck: $hokutoTensei.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: hokutoTensei.resetFirstHit)
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
    hokutoTenseiViewFirstHit(
        hokutoTensei: HokutoTensei(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
