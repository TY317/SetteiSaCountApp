//
//  kabaneriUnatoViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/28.
//

import SwiftUI

struct kabaneriUnatoViewNormal: View {
    @ObservedObject var kabaneriUnato: KabaneriUnato
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
            // ---- 発光率
            Section {
                // 注意書き
                unitLabelCautionText {
                    Text("今作も設定差があるかは判明していません")
                }
                
                // カウントボタン横並び
                HStack {
                    // 発光なし
                    unitCountButtonPercentWithFunc(
                        title: "発光なし",
                        count: $kabaneriUnato.flushCountMiss,
                        color: .personalSummerLightBlue,
                        bigNumber: $kabaneriUnato.flushCountSum,
                        numberofDicimal: 0,
                        minusBool: $kabaneriUnato.minusCheck) {
                            kabaneriUnato.flushSumFunc()
                        }
                    // 発光あり
                    unitCountButtonPercentWithFunc(
                        title: "発光あり",
                        count: $kabaneriUnato.flushCountHit,
                        color: .personalSummerLightRed,
                        bigNumber: $kabaneriUnato.flushCountSum,
                        numberofDicimal: 0,
                        minusBool: $kabaneriUnato.minusCheck) {
                            kabaneriUnato.flushSumFunc()
                        }
                }
                
                // 参考情報）発光率
                unitLinkButtonViewBuilder(sheetTitle: "[⚠️前作情報] 発光率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "発光率",
                            percentList: kabaneriUnato.ratioFlush
                        )
                    }
                }
                
                // 参考情報）レア役停止系
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止系") {
                    VStack(alignment: .leading) {
                        Text("・前作同様")
                        Text("・レア役はチャンス目のみ")
                        Text("・チャンス目図柄が停止してリプレイ・ベル揃いなしでチャンス目")
                        Text("・全リール適当押しでOK")
                    }
                }
            } header: {
                HStack {
                    Text("1個チャンス目 発光率")
                    unitToolbarButtonQuestion {
                        unitExView5body2image(
                            title: "発光率",
                            textBody1: "好機なし＆発光sしていないチャンス目が単独で出現した時がカウント対象"
                        )
                    }
                }
            }
            
            // ---- 下段ベル
            Section {
                // ゲーム数入力
                unitTextFieldNumberInputWithUnit(
                    title: "ゲーム数",
                    inputValue: $kabaneriUnato.normalGame,
                    unitText: "Ｇ",
                )
                .focused($isFocused)
                
                // カウント
                unitCountButtonVerticalDenominate(
                    title: "下段ベル",
                    count: $kabaneriUnato.koyakuCountLowerBell,
                    color: .personalSpringLightYellow,
                    bigNumber: $kabaneriUnato.normalGame,
                    numberofDicimal: 0,
                    minusBool: $kabaneriUnato.minusCheck,
                    flushColor: .yellow,
                )
                .popoverTip(tipVer3211KabaneriUnatoLowerBell())
                
                // 参考情報）下段ベル確率
                unitLinkButtonViewBuilder(sheetTitle: "下段ベル確率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTableDenominate(
                            columTitle: "下段ベル",
                            denominateList: kabaneriUnato.ratioLowerBell
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        kabaneriUnatoView95Ci(
                            kabaneriUnato: kabaneriUnato,
                            selection: 1
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    kabaneriUnatoViewBayes(
                        kabaneriUnato: kabaneriUnato,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("下段ベル")
            }
            
            // ---- 周期
            Section {
                // 参考情報）周期について
                unitLinkButtonViewBuilder(sheetTitle: "周期について") {
                    VStack(alignment: .leading) {
                        Text("・カバネチャンス目成立時に加算されるカバネポイントが規定を超えると周期到達")
                        Text("・周期到達時は海門前兆へ移行")
                        Text("・150G消化で2周期目、300G消化で3周期目へ強制的に進む")
                    }
                }
                
                // 参考情報）高設定時の挙動
                unitLinkButtonViewBuilder(sheetTitle: "注目ポイント") {
                    VStack(alignment: .leading) {
                        Text("・高設定は1・2周期でのボーナス当選率が33%以上！？")
                        Text("・3周期目での当選は高設定ほど優遇")
                    }
                }
            } header: {
                Text("周期")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kabaneriUnatoMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kabaneriUnato.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
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
                unitButtonMinusCheck(minusCheck: $kabaneriUnato.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kabaneriUnato.resetNormal)
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
    kabaneriUnatoViewNormal(
        kabaneriUnato: KabaneriUnato(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
