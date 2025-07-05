//
//  kaguyaViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/15.
//

import SwiftUI

struct kaguyaViewEnding: View {
//    @ObservedObject var kaguya = KaguyaSama()
    @ObservedObject var kaguya: KaguyaSama
    @State var isShowAlert = false
    
    var body: some View {
        List {
            Section {
                // //// カウントボタン横並び
                HStack {
                    // 風船ゲーム
                    unitCountButtonVerticalPercent(title: "風船\nゲーム", count: $kaguya.endingCountBaloon, color: .personalSummerLightBlue, bigNumber: $kaguya.endingCountSum, numberofDicimal: 0, minusBool: $kaguya.minusCheck)
                    // 2人の恋の行方
                    unitCountButtonVerticalPercent(title: "2人の恋\nの行方", count: $kaguya.endingCountKoiNoYukue, color: .personalSpringLightYellow, bigNumber: $kaguya.endingCountSum, numberofDicimal: 0, minusBool: $kaguya.minusCheck, flushColor: .yellow)
                    // 白銀
                    unitCountButtonVerticalPercent(title: "\n白銀", count: $kaguya.endingCountShirogane, color: .personalSummerLightGreen, bigNumber: $kaguya.endingCountSum, numberofDicimal: 0, minusBool: $kaguya.minusCheck)
                    // かぐや
                    unitCountButtonVerticalPercent(title: "\nかぐや", count: $kaguya.endingCountKaguya, color: .personalSummerLightRed, bigNumber: $kaguya.endingCountSum, numberofDicimal: 0, minusBool: $kaguya.minusCheck)
                }
                // 参考情報リンク
                unitLinkButton(
                    title: "エンディングのエピソードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "エンディングのエピソード",
                            textBody1: "・エピソード種類で設定を示唆",
                            textBody2: "・風船、恋の行方がデフォルト。かぐや、白銀が高設定＆奇偶示唆",
                            textBody3: "・大量上乗せなどで早期にエンディング到達時は、2人の恋の行方が選択されるらしい。枚数など詳しい条件は不明。",
//                            image1: Image("kaguyaEnding")
                            tableView: AnyView(kaguyaTableEnding())
                        )
                    )
                )
            } header: {
                Text("エピソードのカウント")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "かぐや様は告らせたい",
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディングのエピソード")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $kaguya.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: kaguya.resetEnding)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    kaguyaViewEnding(kaguya: KaguyaSama())
}
