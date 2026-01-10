//
//  hokutoTenseiTableAbeshi.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/07.
//

import SwiftUI

struct hokutoTenseiTableAbeshi: View {
    @State var selectedItem: String = "設定変更以外"
    let itemList: [String] = ["設定変更以外","設定変更後",]
    var body: some View {
        VStack {
            Picker("", selection: self.$selectedItem) {
                ForEach(self.itemList, id: \.self) { item in
                    Text(item)
                }
            }
            .pickerStyle(.segmented)
            
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "1〜64",
                        "65〜128",
                        "129〜192",
                        "193〜256",
                        "257〜320",
                        "321〜384",
                        "385〜448",
                        "449〜512",
                        "513〜576",
                        "577〜640",
                        "641〜704",
                        "705〜768",
                        "769〜832",
                        "833〜896",
                        "897〜960",
                        "961〜1024",
                        "1025〜1088",
                        "1089〜1152",
                        "1153〜1216",
                        "1217〜1280",
                        "1281〜1344",
                        "1345〜1408",
                        "1409〜1472",
                        "1473〜1536",
                    ],
                    maxWidth: 100,
                )
                // 設定変更以外
                if self.selectedItem == self.itemList[0] {
                    unitTableString(
                        columTitle: "A",
                        stringList: [
                            "△",
                            "△",
                            "△",
                            "◎",
                            "△",
                            "△",
                            "△",
                            "△",
                            "◯",
                            "△",
                            "△",
                            "△",
                            "△",
                            "◯",
                            "△",
                            "△",
                            "△",
                            "△",
                            "△",
                            "◎",
                            "◯",
                            "◎",
                            "◎",
                            "天井",
                        ],
                        maxWidth: 50,
                    )
                    unitTableString(
                        columTitle: "B",
                        stringList: [
                            "△",
                            "△",
                            "△",
                            "◎",
                            "△",
                            "◯",
                            "△",
                            "△",
                            "△",
                            "△",
                            "△",
                            "◯",
                            "△",
                            "天井",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                        ],
                        maxWidth: 50,
                    )
                }
                // 設定変更後
                else {
                    unitTableString(
                        columTitle: "A",
                        stringList: [
                            "△",
                            "△",
                            "△",
                            "◎",
                            "△",
                            "△",
                            "△",
                            "△",
                            "◯",
                            "△",
                            "△",
                            "△",
                            "△",
                            "◯",
                            "△",
                            "◯",
                            "△",
                            "◯",
                            "△",
                            "天井",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                        ],
                        maxWidth: 50,
                    )
                    unitTableString(
                        columTitle: "B",
                        stringList: [
                            "△",
                            "△",
                            "△",
                            "◎",
                            "△",
                            "◯",
                            "△",
                            "△",
                            "△",
                            "△",
                            "△",
                            "◎",
                            "△",
                            "天井",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                            "grayOut",
                        ],
                        maxWidth: 50,
                    )
                }
//                unitTableString(
//                    columTitle: "B",
//                    stringList: [
//                        "△",
//                        "△",
//                        "△",
//                        "◎",
//                        "△",
//                        "◯",
//                        "△",
//                        "△",
//                        "△",
//                        "△",
//                        "△",
//                        "◯",
//                        "△",
//                        "天井",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                    ],
//                    maxWidth: 50,
//                )
                unitTableString(
                    columTitle: "C",
                    stringList: [
                        "△",
                        "△",
                        "△",
                        "◎",
                        "△",
                        "△",
                        "△",
                        "△",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ],
                    maxWidth: 50,
                )
                unitTableString(
                    columTitle: "天国",
                    stringList: [
                        "◯",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ],
                    maxWidth: 50,
                )
            }
        }
    }
}

#Preview {
    ScrollView {
        hokutoTenseiTableAbeshi()
    }
    .padding(.horizontal)
}
