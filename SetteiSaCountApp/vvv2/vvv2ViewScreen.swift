//
//  vvv2ViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/06.
//

import SwiftUI

struct vvv2ViewScreen: View {
    @ObservedObject var vvv2: Vvv2
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "vvv2Screen1",
        "vvv2Screen2",
        "vvv2Screen3",
        "vvv2Screen4",
        "vvv2Screen5",
        "vvv2Screen6",
        "vvv2Screen7",
        "vvv2Screen8",
    ]
    let upperBeltTextList: [String] = [
        "白枠",
        "青枠１",
        "青枠２",
        "赤枠１",
        "赤枠２",
        "紫枠",
        "銀枠",
        "金枠",
    ]
    let lowerBeltTextList: [String] = [
        "？？？",
        "？？？",
        "？？？",
        "？？？",
        "？？？",
        "？？？",
        "？？？",
        "？？？",
    ]
    let sisaText: [String] = [
        "白枠",
        "青枠１",
        "青枠２",
        "赤枠１",
        "赤枠２",
        "紫枠",
        "銀枠",
        "金枠",
    ]
    let flashColorList: [Color] = [
        .gray,
        .blue,
        .blue,
        .red,
        .red,
        .purple,
        .gray,
        .orange,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6,7]
    
    var body: some View {
        List {
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
                                minusCheck: $vvv2.minusCheck,
                                action: vvv2.screenSumFunc,
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
                        bigNumber: $vvv2.screenCountSum,
                        numberofDigit: 0,
                        titleFont: .body,
                    )
                }
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vvv2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("CZ・ボーナス終了画面")
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
                unitButtonMinusCheck(minusCheck: $vvv2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: vvv2.resetScreen)
            }
        }
    }
    
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $vvv2.screenCountDefault
        case 1: return $vvv2.screenCountBlue1
        case 2: return $vvv2.screenCountBlue2
        case 3: return $vvv2.screenCountRed1
        case 4: return $vvv2.screenCountRed2
        case 5: return $vvv2.screenCountPurple
        case 6: return $vvv2.screenCountSilver
        case 7: return $vvv2.screenCountGold
        default: return .constant(0)
        }
    }
}

#Preview {
    vvv2ViewScreen(
        vvv2: Vvv2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
