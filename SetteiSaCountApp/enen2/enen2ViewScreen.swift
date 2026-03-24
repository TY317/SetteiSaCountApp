//
//  enen2ViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/02.
//

import SwiftUI

struct enen2ViewScreen: View {
    @ObservedObject var enen2: Enen2
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "enen2Screen1",
        "enen2Screen2",
        "enen2Screen3",
        "enen2Screen4",
        "enen2Screen5",
        "enen2Screen6",
    ]
    let upperBeltTextList: [String] = [
        "シルエット",
        "4人",
        "アドラ",
        "第8 消防服",
        "第8 オレンジ服",
        "全員集合",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    let sisaText: [String] = [
        "デフォルト",
        "???",
        "???",
        "高設定濃厚(消防服)",
        "高設定濃厚(ｵﾚﾝｼﾞ服)",
        "高設定濃厚(全員集合)",
    ]
    let flashColorList: [Color] = [
        .gray,
        .blue,
        .yellow,
        .green,
        .red,
        .orange,
    ]
    let indexList: [Int] = [0,1,2,3,4,5]
    
    let items: [String] = ["炎炎ボーナス後", "それ以外"]
    @State var selectedItem: String = "炎炎ボーナス後"
    
    var body: some View {
        List {
            // 画面カウント
            Section {
                // 注意書き
                HStack {
                    Text("⚠️")
                    VStack(alignment: .leading) {
                        Text("・設定示唆は以下の画面")
                        Text("・これ以外にもモード示唆、炎炎激闘ストック示唆の画面もあり")
                    }
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                }
                
                // ピッカー
                VStack {
                    Picker("", selection: self.$selectedItem) {
                        ForEach(self.items, id: \.self) { item in
                            Text(item)
                        }
                    }
                    .pickerStyle(.segmented)
                    .popoverTip(tipVer3221Enen2Screen())
                    Text("それ以外：REG,アクセルボーナス,灰焔ボーナス後")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                // カウントボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(self.indexList, id: \.self) { index in
                            if self.imageNameList.indices.contains(index) &&
                                self.upperBeltTextList.indices.contains(index) &&
                                self.lowerBeltTextList.indices.contains(index) {
                                // 炎炎ボーナス
                                if self.selectedItem == self.items[0] {
                                    unitButtonScreenChoiceVer3(
                                        screen: unitScreenOnlyDisplay(
                                            image: Image(self.imageNameList[index]),
                                            upperBeltText: self.upperBeltTextList[index],
                                            lowerBeltText: self.lowerBeltTextList[index],
                                        ),
                                        screenName: self.imageNameList[index],
                                        selectedScreen: self.$selectedImageName,
                                        count: bindingForScreenBigCount(index: index),
                                        minusCheck: $enen2.minusCheck,
                                        action: enen2.screenSumFunc,
                                    )
                                }
                                
                                // 炎炎ボーナス以外
                                else {
                                    unitButtonScreenChoiceVer3(
                                        screen: unitScreenOnlyDisplay(
                                            image: Image(self.imageNameList[index]),
                                            upperBeltText: self.upperBeltTextList[index],
                                            lowerBeltText: self.lowerBeltTextList[index],
                                        ),
                                        screenName: self.imageNameList[index],
                                        selectedScreen: self.$selectedImageName,
                                        count: bindingForScreenCount(index: index),
                                        minusCheck: $enen2.minusCheck,
                                        action: enen2.screenSumFunc,
                                    )
                                }
                            }
                        }
                    }
                }
                .frame(height: common.screenScrollHeight)
//                .popoverTip(tipVer3210Enen2Screen())
                
                // //// カウント結果
                ForEach(self.indexList, id: \.self) { index in
                    if self.lowerBeltTextList.indices.contains(index) &&
                        self.flashColorList.indices.contains(index) {
                        // 炎炎ボーナス
                        if self.selectedItem == self.items[0] {
                            unitResultCountListPercent(
                                title: self.lowerBeltTextList[index],
                                count: bindingForScreenBigCount(index: index),
                                flashColor: self.flashColorList[index],
                                bigNumber: $enen2.screenCountBigSum,
                                numberofDigit: 0,
                                titleFont: .body,
                            )
                        }
                        
                        // 炎炎ボーナス以外
                        else{
                            unitResultCountListPercent(
                                title: self.lowerBeltTextList[index],
                                count: bindingForScreenCount(index: index),
                                flashColor: self.flashColorList[index],
                                bigNumber: $enen2.screenCountSum,
                                numberofDigit: 0,
                                titleFont: .body,
                            )
                        }
                    }
                }
                
                // 参考情報）示唆画面振分け
                unitLinkButtonViewBuilder(sheetTitle: "設定示唆画面の振分け") {
                    enen2TableScreenRatio(enen2: enen2)
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        enen2View95Ci(
                            enen2: enen2,
                            selection: 3,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    enen2ViewBayes(
                        enen2: enen2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                unitLabelHeaderScreenCount()
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.enen2MenuScreenBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: enen2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("ボーナス終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// 画面選択解除
                unitButtonToolbarScreenSelectReset(
                    currentKeyword: self.$selectedImageName
                )
            }
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $enen2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: enen2.resetScreen)
            }
        }
    }
    
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $enen2.screenCount1
        case 1: return $enen2.screenCount2
        case 2: return $enen2.screenCount3
        case 3: return $enen2.screenCount4
        case 4: return $enen2.screenCount5
        case 5: return $enen2.screenCount6
        default: return .constant(0)
        }
    }
    
    func bindingForScreenBigCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $enen2.screenCountBig1
        case 1: return $enen2.screenCountBig2
        case 2: return $enen2.screenCountBig3
        case 3: return $enen2.screenCountBig4
        case 4: return $enen2.screenCountBig5
        case 5: return $enen2.screenCountBig6
        default: return .constant(0)
        }
    }
}

#Preview {
    enen2ViewScreen(
        enen2: Enen2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
