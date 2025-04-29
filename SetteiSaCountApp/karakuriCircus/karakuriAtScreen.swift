//
//  karakuriAtScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/06.
//

import SwiftUI

struct karakuriAtScreen: View {
//    @ObservedObject var karakuri = Karakuri()
    @ObservedObject var karakuri: Karakuri
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            Section {
                // //// 画面選択ボタン
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        // デフォルト
                        unitButtonScreenChoice(image: Image("karakuriAtScreenDefault"), keyword: karakuri.atScreenKeywordList[0], currentKeyword: $karakuri.atScreenCurrentKeyword, count: $karakuri.atScreenCountDefault, minusCheck: $karakuri.minusCheck)
                            .popoverTip(tipUnitButtonScreenChoice())
                        // 敵幹部
                        unitButtonScreenChoice(image: Image("karakuriAtScreenEnemy"), keyword: karakuri.atScreenKeywordList[1], currentKeyword: $karakuri.atScreenCurrentKeyword, count: $karakuri.atScreenCountEnemy, minusCheck: $karakuri.minusCheck)
                        // ヒロイン5人
                        unitButtonScreenChoice(image: Image("karakuriAtScreenWomen"), keyword: karakuri.atScreenKeywordList[2], currentKeyword: $karakuri.atScreenCurrentKeyword, count: $karakuri.atScreenCountWomen, minusCheck: $karakuri.minusCheck)
                        // あじのぎい
                        unitButtonScreenChoice(image: Image("karakuriAtScreenAjino"), keyword: karakuri.atScreenKeywordList[3], currentKeyword: $karakuri.atScreenCurrentKeyword, count: $karakuri.atScreenCountAjino, minusCheck: $karakuri.minusCheck)
                        // 3人
                        unitButtonScreenChoice(image: Image("karakuriAtScreen3person"), keyword: karakuri.atScreenKeywordList[4], currentKeyword: $karakuri.atScreenCurrentKeyword, count: $karakuri.atScreenCount3Person, minusCheck: $karakuri.minusCheck)
                        // フランシーヌ
                        unitButtonScreenChoice(image: Image("karakuriAtScreenFran"), keyword: karakuri.atScreenKeywordList[5], currentKeyword: $karakuri.atScreenCurrentKeyword, count: $karakuri.atScreenCountFran, minusCheck: $karakuri.minusCheck)
                    }
                    .frame(height: 120)
                }
                
                // //// 結果表示
                // デフォルト
                unitResultCountListPercent(title: "デフォルト", count: $karakuri.atScreenCountDefault, flashColor: .gray, bigNumber: $karakuri.atScreenCountSum)
                // 敵幹部
                unitResultCountListPercent(title: "奇数＆高設定示唆", count: $karakuri.atScreenCountEnemy, flashColor: .blue, bigNumber: $karakuri.atScreenCountSum)
                // ヒロイン5人
                unitResultCountListPercent(title: "偶数＆高設定示唆", count: $karakuri.atScreenCountWomen, flashColor: .yellow, bigNumber: $karakuri.atScreenCountSum)
                // あじのきい
                unitResultCountListPercent(title: "設定2 以上濃厚", count: $karakuri.atScreenCountAjino, flashColor: .green, bigNumber: $karakuri.atScreenCountSum)
                // 3人
                unitResultCountListPercent(title: "設定4 以上濃厚", count: $karakuri.atScreenCount3Person, flashColor: .red, bigNumber: $karakuri.atScreenCountSum)
                // フランシーヌ
                unitResultCountListPercent(title: "設定6 濃厚", count: $karakuri.atScreenCountFran, flashColor: .orange, bigNumber: $karakuri.atScreenCountSum)
                
                // //// 参考情報リンク
                unitLinkButton(title: "AT終了画面について", exview: AnyView(unitExView5body2image(title: "AT終了画面", textBody1: "・本機でかなり重要な判別要素", textBody2: "・高設定はデフォルト比率が明らかに少なくなるらしい。設定6で5割程度、設定1だと8割程度になるとの噂あり", textBody3: "・とにかくデフォルト以外が出るのがまずはプラス要素。特に5,6はデフォルト以外の出現率が4以下と比較してガンと上がるらしい。", textBody4: "・設定2 以上濃厚画面は設定2で一番出やすいとの噂あり。デフォルトよりましだが、何度も出る＆4以上示唆が全然出ないようだと逆に高設定に期待できないかも！？")))
            } header: {
                Text("AT終了画面")
            }
        }
        .navigationTitle("AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    if karakuri.atScreenCurrentKeyword != "" {
                        unitButtonToolbarScreenSelectReset(currentKeyword: $karakuri.atScreenCurrentKeyword)
                            .popoverTip(tipUnitButtonScreenChoiceClear())
                    } else {
                        unitButtonToolbarScreenSelectReset(currentKeyword: $karakuri.atScreenCurrentKeyword)
                    }
                    unitButtonMinusCheck(minusCheck: $karakuri.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: karakuri.resetAtScreen)
                }
            }
        }
    }
}

#Preview {
    karakuriAtScreen(karakuri: Karakuri())
}
