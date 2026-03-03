//
//  kokakukidotaiViewCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/29.
//

import SwiftUI

struct kokakukidotaiViewCz: View {
    @ObservedObject var kokakukidotai: Kokakukidotai
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @AppStorage("kokakukidotaiLastEpisode") var selectedItem: String = "暴走の証明"
    let itemList: [String] = ["暴走の証明", "恵まれし者たち"]
    
    @State var isShowAlert: Bool = false
    @State var selectedImageName: String = ""
    let imageNameList: [String] = [
        "kokakukidotaiCzScreen1",
        "kokakukidotaiCzScreen2",
        "kokakukidotaiCzScreen3",
        "kokakukidotaiCzScreen4",
        "kokakukidotaiCzScreen5",
        "kokakukidotaiCzScreen6",
        "kokakukidotaiCzScreen7",
        "kokakukidotaiCzScreen8",
        "kokakukidotaiCzScreen9",
        "kokakukidotaiCzScreen10",
    ]
    let upperBeltTextList: [String] = [
        "青空",
        "笑い男マーク",
        "オペ子 3人",
        "タチコマ",
        "トグサ家",
        "イシカワ",
        "青空＋9課",
        "素子",
        "バカンス(素子＆バトー)",
        "金背景 9課",
    ]
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "復活期待度 50%",
        "奇数示唆",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定1,4,5,6濃厚",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    let lowerBeltTextList2: [String] = [
        "デフォルト",
        "復活期待度 50%",
        "奇数示唆",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定2 以上濃厚",
        "設定1,4,5,6濃厚\n＋高設定示唆 強",
        "設定4 以上濃厚",
        "設定6 濃厚",
    ]
    let flashColorList: [Color] = [
        .gray,
        .gray,
        .blue,
        .yellow,
        .green,
        .red,
        .cyan,
        .pink,
        .orange,
        .purple,
    ]
    let indexList: [Int] = [0,1,2,3,4,5,6,7,8,9]
    
    var body: some View {
        List {
            // エピソードの順番
            Section {
                // 注意書き
                Text("前回エピソードのメモとしてご利用ください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // ピッカー
                unitPickerMenuString(
                    title: "前回エピソード",
                    selected: self.$selectedItem,
                    selectlist: self.itemList
                )
                
                // 参考情報）エピソードの順番
                unitLinkButtonViewBuilder(sheetTitle: "エピソードの順番について") {
                    VStack(alignment: .leading) {
                        Text("・S.A.Mのエピソードは「暴走の証明」と「恵まれし者たち」の2種類")
                        Text("・基本は交互に発生するが、同一エピソードが2連続すると設定2以上濃厚となる")
                        Text("・連続は間にタチコマの家出やATがあっても有効。以下の例はいずれも設定2以上濃厚となる")
                        Text("例1) 暴走の証明 → タチコマの家出 → 暴走の証明")
                        Text("例2) 恵まれし者たち → AT → 恵まれし者たち")
                    }
                }
            } header: {
                Text("S.A.M エピソードの順番")
            }
            
            // CZ終了画面の示唆
            Section {
                DisclosureGroup {
                    // カウントボタン
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
                                        minusCheck: $kokakukidotai.minusCheck,
                                        action: kokakukidotai.czScreenSumFunc,
                                    )
                                }
                            }
                        }
                    }
                    .frame(height: common.screenScrollHeight)
                    
                    // //// カウント結果
                    ForEach(self.indexList, id: \.self) { index in
//                        if self.lowerBeltTextList.indices.contains(index) &&
                        if self.lowerBeltTextList2.indices.contains(index) &&
                            self.flashColorList.indices.contains(index) {
    //                        self.flashColorList.indices.contains(index) &&
    //                        self.sisaText.indices.contains(index) {
                            unitResultCountListPercent(
                                title: self.lowerBeltTextList2[index],
    //                            title: self.sisaText[index],
                                count: bindingForScreenCount(index: index),
                                flashColor: self.flashColorList[index],
                                bigNumber: $kokakukidotai.czScreenCountSum,
                                numberofDigit: 0,
                                titleFont: .body,
                            )
                        }
                    }
                } label: {
                    Text("終了画面カウント")
                        .foregroundStyle(Color.blue)
                }
                .popoverTip(tipVer3211KokakukidotaiCz())

            } header: {
                unitLabelHeaderScreenCount(title: "終了画面")
            }
//            kokakukidotaiSubViewCzScreen()
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kokakukidotaiMenuCzBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kokakukidotai.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("CZ")
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
                unitButtonMinusCheck(minusCheck: $kokakukidotai.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: kokakukidotai.resetCz)
            }
        }
    }
    
    func bindingForScreenCount(index: Int) -> Binding<Int> {
        switch index {
        case 0: return $kokakukidotai.czScreenCountDefault
        case 1: return $kokakukidotai.czScreenCountFukkatu
        case 2: return $kokakukidotai.czScreenCountKisu
        case 3: return $kokakukidotai.czScreenCountGusu
        case 4: return $kokakukidotai.czScreenCountHighJaku
        case 5: return $kokakukidotai.czScreenCountHighKyo
        case 6: return $kokakukidotai.czScreenCountOver2
        case 7: return $kokakukidotai.czScreenCountOver1456
        case 8: return $kokakukidotai.czScreenCountOver4
        case 9: return $kokakukidotai.czScreenCountOver6
        default: return .constant(0)
        }
    }
}

#Preview {
    kokakukidotaiViewCz(
        kokakukidotai: Kokakukidotai(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
