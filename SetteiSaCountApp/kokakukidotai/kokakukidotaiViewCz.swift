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
