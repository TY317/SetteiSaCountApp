//
//  railgunViewDuringAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/15.
//

import SwiftUI

struct railgunViewDuringAt: View {
    @ObservedObject var railgun: Railgun
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "railgunIchimaie1",
        "railgunIchimaie2",
        "railgunIchimaie3",
        "railgunIchimaie4",
        "railgunIchimaie5",
        "railgunIchimaie6",
        "railgunIchimaie7",
    ]
    let upperBeltTextList: [String] = [
        "抱きつき",
        "タンクトップ",
        "水着",
        "シャンプー",
        "4人",
        "美琴・食蜂",
        "アクセラレーター",
    ]
    let lowerBeltTextList: [String] = [
        "調査中",
        "調査中",
        "調査中",
        "調査中",
        "調査中",
        "調査中",
        "調査中",
    ]
    let sisaText: [String] = [
        "抱きつき",
        "タンクトップ",
        "水着",
        "シャンプー",
        "4人",
        "美琴・食蜂",
        "アクセラレーター",
    ]
    let flashColorList: [Color] = [
        .gray,
        .yellow,
        .blue,
        .green,
        .red,
        .red,
        .purple,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6]
    var body: some View {
        List {
            // 獲得枚数表示
            Section {
                unitLinkButtonViewBuilder(sheetTitle: "獲得枚数での示唆") {
                    railgunTableMaisuSisa()
                }
            } header: {
                Text("獲得枚数での示唆")
            }
            
            // 画面カウント
            Section {
                Text("獲得枚数表示の一枚絵で設定を示唆")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // //// 画面カウントボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(self.indexList, id: \.self) { index in
                            if self.imageNameList.indices.contains(index) &&
                                self.upperBeltTextList.indices.contains(index) &&
                                self.lowerBeltTextList.indices.contains(index) {
                                unitButtonScreenChoiceVer3(
                                    screen: unitScreenOnlyDisplay(
                                        image: Image(self.imageNameList[index]),
                                        upperBeltText: self.upperBeltTextList[index],
                                        lowerBeltText: self.lowerBeltTextList[index],
//                                        lowerBeltFont: .body,
//                                        lowerBeltHeight: 35,
                                    ),
                                    screenName: self.imageNameList[index],
                                    selectedScreen: self.$selectedImageName,
                                    count: bindingForScreenCount(index: index),
                                    minusCheck: $railgun.minusCheck,
                                    action: railgun.screenSumFunc,
                                )
                            }
                        }
                    }
                }
                .frame(height: common.screenScrollHeight)
                
                // //// カウント結果
                ForEach(self.indexList, id: \.self) { index in
                    if self.lowerBeltTextList.indices.contains(index) &&
//                        self.flashColorList.indices.contains(index) {
                        self.flashColorList.indices.contains(index) &&
                        self.sisaText.indices.contains(index) {
                        unitResultCountListPercent(
//                            title: self.lowerBeltTextList[index],
                            title: self.sisaText[index],
                            count: bindingForScreenCount(index: index),
                            flashColor: self.flashColorList[index],
                            bigNumber: $railgun.screenCountSum,
                            numberofDigit: 0,
                            titleFont: .body,
                        )
                    }
                }
            } header: {
                unitLabelHeaderScreenCount()
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: railgun.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT中")
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
                unitButtonMinusCheck(minusCheck: $railgun.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: railgun.resetAt)
            }
        }
    }
    
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $railgun.ichimaieCount1
        case 1: return $railgun.ichimaieCount2
        case 2: return $railgun.ichimaieCount3
        case 3: return $railgun.ichimaieCount4
        case 4: return $railgun.ichimaieCount5
        case 5: return $railgun.ichimaieCount6
        case 6: return $railgun.ichimaieCount7
        default: return .constant(0)
        }
    }
}

#Preview {
    railgunViewDuringAt(
        railgun: Railgun(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
