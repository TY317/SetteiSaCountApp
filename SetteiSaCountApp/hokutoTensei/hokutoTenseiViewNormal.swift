//
//  hokutoTenseiViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/27.
//

import SwiftUI

struct hokutoTenseiViewNormal: View {
    @ObservedObject var hokutoTensei: HokutoTensei
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    
    @State var isShowAlert: Bool = false
    @State var selectedItem: String = "点灯なし"
    let selectList: [String] = [
        "点灯なし",
        "白",
        "白点滅",
        "水色",
        "水色点滅",
        "黄緑",
        "黄緑点滅",
        "金",
    ]
    let sisaList: [String] = [
        "設定示唆なし",
        "設定2・4 示唆",
        "設定3・5 示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    let statusList: [String] = [
        "低確",
        "高確",
    ]
    @State var selectedStatus: String = "低確"
    
    var body: some View {
        List {
            // ---- レア役
            Section {
                // 注意書き
                Text("・低確、通常時での小役成立が対象")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // カウントボタン横並び
                HStack {
                    // 弱チェリー
                    unitCountButtonWithoutRatioWithFunc(
                        title: "弱🍒",
                        count: $hokutoTensei.koyakuCountJakuCherry,
                        color: .personalSummerLightRed,
                        minusBool: $hokutoTensei.minusCheck) {
                            hokutoTensei.koyakuSumFunc()
                        }
                    // 🍉
                    unitCountButtonWithoutRatioWithFunc(
                        title: "🍉",
                        count: $hokutoTensei.koyakuCountSuika,
                        color: .personalSummerLightGreen,
                        minusBool: $hokutoTensei.minusCheck) {
                            hokutoTensei.koyakuSumFunc()
                        }
                    // 弱チェリー
                    unitCountButtonWithoutRatioWithFunc(
                        title: "天破当選",
                        count: $hokutoTensei.koyakuCountTenhaHit,
                        color: .personalSummerLightPurple,
                        minusBool: $hokutoTensei.minusCheck) {
                            hokutoTensei.koyakuSumFunc()
                        }
                }
                // 確率結果
                unitResultRatioPercent2Line(
                    title: "弱🍒・🍉からの当選率",
                    count: $hokutoTensei.koyakuCountTenhaHit,
                    bigNumber: $hokutoTensei.koyakuCountSum,
                    numberofDicimal: 1
                )
                unitLinkButtonViewBuilder(sheetTitle: "弱🍒・🍉からの天破当選") {
                    VStack {
                        VStack(alignment: .leading) {
                            Text("・状態見抜けない場合も多いと思いますがメモ代わりに利用ください")
                            Text("・弱🍒、🍉は低確、通常時共に同じ当選率で1-6で6倍の設定差")
                            Text("・チャンス目、勝舞揃いも設定差あり")
                        }
                        .padding(.bottom)
                        Picker("", selection: self.$selectedStatus) {
                            ForEach(self.statusList, id: \.self) { status in
                                Text(status)
                            }
                        }
                        .pickerStyle(.segmented)
                        HStack(spacing: 0) {
                            unitTableSettingIndex(titleLine: 2,)
                            unitTablePercent(
                                columTitle: "弱🍒・🍉",
                                percentList: hokutoTensei.ratioJakuCherrySuikaTenha,
                                numberofDicimal: 1,
                                titleLine: 2,
                            )
                            if self.selectedStatus == self.statusList[0] {
                                unitTablePercent(
                                    columTitle: "チャンス目\n勝舞揃い",
                                    percentList: hokutoTensei.ratioChanceShobuTenhaTeikaku,
                                    numberofDicimal: 1,
                                    titleLine: 2,
                                )
                            }
                            else {
                                unitTablePercent(
                                    columTitle: "チャンス目\n勝舞揃い",
                                    percentList: hokutoTensei.ratioChanceShobuTenhaKokoaku,
                                    numberofDicimal: 1,
                                    titleLine: 2,
                                )
                            }
                        }
                    }
                }
                unitLinkButtonViewBuilder(sheetTitle: "高確示唆演出") {
                    hokutoTenseiTableKokakuSisa()
                }
                unitLinkButtonViewBuilder(sheetTitle: "レア役停止形") {
                    hokutoTenseiTableKoyakuPattern()
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        hokutoTenseiView95Ci(
                            hokutoTensei: hokutoTensei,
                            selection: 4,
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
                Text("弱レア役からの天破当選率")
            }
            
            // ---- 通常時のモード
            Section {
                // 参考情報）通常時のモード
                unitLinkButtonViewBuilder(sheetTitle: "通常時のモード") {
                    hokutoTenseiTableMode()
                }
                // 参考情報）あべし期待度テーブル
                unitLinkButtonViewBuilder(sheetTitle: "あべし期待度テーブル") {
                    hokutoTenseiTableAbeshi()
                }
                // 参考情報）フェイク前兆発生テーブル
                unitLinkButtonViewBuilder(sheetTitle: "フェイク前兆発生テーブル") {
                    hokutoTenseiTableFake()
                }
            } header: {
                Text("通常時のモード")
            }
            
            // ---- 100Gごとの台枠ランプ
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "100Gごとの台枠ランプ示唆") {
                    hokutoTenseiSubViewMachineLamp()
                }
                // サークルピッカー
                VStack {
                    Text("[上部中央ランプ]")
                        .frame(maxWidth: .infinity, alignment: .center)
                    HStack {
                        Picker("[上部中央ランプ]", selection: self.$selectedItem) {
                            ForEach(self.selectList, id: \.self) { item in
                                Text(item)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 150)
                    }
                }
//                .popoverTip(tipVer3170hokutTenseiLampSisa())
                
                // 示唆＆登録ボタン
                unitCountSubmitWithResult(
                    title: sisaText(item: self.selectedItem),
                    count: bindingCount(item: self.selectedItem),
                    bigNumber: $hokutoTensei.lampCountSum,
                    flushColor: flushColor(item: self.selectedItem),
                    minusCheck: $hokutoTensei.minusCheck) {
                        hokutoTensei.lampSumFunc()
                        hokutoTensei.lampWhiteSumFunc()
                    }
            } header: {
                Text("台枠ランプ カウント")
            }
            
            // //// カウント結果
            Section {
                // 白 点滅・点灯比率
                VStack {
                    Text("[白・白点滅の比率]")
                    HStack {
                        // 白点灯
                        unitResultRatioPercent2Line(
                            title: "白\n(\(self.sisaList[1]))",
                            count: $hokutoTensei.lampCount24Sisa,
                            bigNumber: $hokutoTensei.lampCountWhiteSum,
                            numberofDicimal: 0
                        )
                        // 白点滅
                        unitResultRatioPercent2Line(
                            title: "白点滅\n(\(self.sisaList[2]))",
                            count: $hokutoTensei.lampCount35Sisa,
                            bigNumber: $hokutoTensei.lampCountWhiteSum,
                            numberofDicimal: 0
                        )
                    }
                }
                .popoverTip(tipVer3171hokutoTenseiLampWhite())
                
                ForEach(self.selectList, id: \.self) { item in
                    unitResultCountListPercent(
                        title: sisaText(item: item),
                        count: bindingCount(item: item),
                        flashColor: flushColor(item: item),
                        bigNumber: $hokutoTensei.lampCountSum,
                        numberofDigit: 0,
                    )
                }
                
                // 参考情報）白・白点滅の比率
                unitLinkButtonViewBuilder(sheetTitle: "白・白点滅の比率") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex(titleLine: 2)
                        unitTablePercent(
                            columTitle: "白\n(\(self.sisaList[1]))",
                            percentList: hokutoTensei.ratioLamp24Sisa,
                            titleLine: 2,
                        )
                        unitTablePercent(
                            columTitle: "白点滅\n(\(self.sisaList[2]))",
                            percentList: hokutoTensei.ratioLamp35Sisa,
                            titleLine: 2,
                        )
                    }
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        hokutoTenseiView95Ci(
                            hokutoTensei: hokutoTensei,
                            selection: 2,
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
                Text("台枠ランプ カウント結果")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hokutoTenseiMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hokutoTensei.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $hokutoTensei.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: hokutoTensei.resetNormal)
            }
        }
    }
    
    private func sisaText(item: String) -> String {
        switch item {
        case self.selectList[0]: return self.sisaList[0]
        case self.selectList[1]: return self.sisaList[1]
        case self.selectList[2]: return self.sisaList[2]
        case self.selectList[3]: return self.sisaList[3]
        case self.selectList[4]: return self.sisaList[4]
        case self.selectList[5]: return self.sisaList[5]
        case self.selectList[6]: return self.sisaList[6]
        case self.selectList[7]: return self.sisaList[7]
        default: return "???"
        }
    }
    
    private func bindingCount(item: String) -> Binding<Int> {
        switch item {
        case self.selectList[0]: return $hokutoTensei.lampCountNone
        case self.selectList[1]: return $hokutoTensei.lampCount24Sisa
        case self.selectList[2]: return $hokutoTensei.lampCount35Sisa
        case self.selectList[3]: return $hokutoTensei.lampCountHighjaku
        case self.selectList[4]: return $hokutoTensei.lampCountHighKyo
        case self.selectList[5]: return $hokutoTensei.lampCountOver2
        case self.selectList[6]: return $hokutoTensei.lampCountOver4
        case self.selectList[7]: return $hokutoTensei.lampCountOver6
        default: return .constant(0)
        }
    }
    
    private func flushColor(item: String) -> Color {
        switch item {
        case self.selectList[0]: return Color.gray
        case self.selectList[1]: return Color.gray
        case self.selectList[2]: return Color.gray
        case self.selectList[3]: return Color.cyan
        case self.selectList[4]: return Color.blue
        case self.selectList[5]: return Color.green
        case self.selectList[6]: return Color.green
        case self.selectList[7]: return Color.orange
        default: return Color.gray
        }
    }
}

#Preview {
    hokutoTenseiViewNormal(
        hokutoTensei: HokutoTensei(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
