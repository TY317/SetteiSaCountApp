//
//  hokutoTenseiTableFake.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/20.
//

import SwiftUI

struct hokutoTenseiTableFake: View {
    var body: some View {
        VStack {
            Text("・天命の刻まで移行してのハズレが対象")
                .padding(.bottom)
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
                unitTableString(
                    columTitle: "A",
                    stringList: [
                        "-",
                        "50%",
                        "-",
                        "発生濃厚",
                        "-",
                        "10%以下",
                        "-",
                        "-",
                        "発生濃厚",
                        "10%以下",
                        "10%以下",
                        "10%以下",
                        "10%以下",
                        "発生濃厚",
                        "10%以下",
                        "10%以下",
                        "10%以下",
                        "10%以下",
                        "10%以下",
                        "発生濃厚",
                        "50%",
                        "発生濃厚",
                        "発生濃厚",
                        "天井",
                    ],
                    maxWidth: 60,
                )
                unitTableString(
                    columTitle: "B",
                    stringList: [
                        "10%以下",
                        "50%",
                        "10%以下",
                        "発生濃厚",
                        "10%以下",
                        "50%",
                        "10%以下",
                        "10%以下",
                        "発生濃厚",
                        "10%以下",
                        "10%以下",
                        "50%",
                        "10%以下",
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
                    maxWidth: 60,
                )
                unitTableString(
                    columTitle: "C",
                    stringList: [
                        "10%以下",
                        "50%",
                        "10%以下",
                        "発生濃厚",
                        "10%以下",
                        "50%",
                        "10%以下",
                        "10%以下",
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
                    maxWidth: 60,
                )
                unitTableString(
                    columTitle: "天国",
                    stringList: [
                        "10%以下",
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
                    maxWidth: 60,
                )
            }
        }
    }
}

#Preview {
    hokutoTenseiTableFake()
}
