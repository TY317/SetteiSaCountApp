//
//  tekkenTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/31.
//

import SwiftUI

struct tekkenTableMode: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("・通常時のAT非当選BIG後は引き戻し、設定変更以外のいずれかに移行")
                Text("・AT後は設定変更以外のいずれかに移行")
                Text("・移行先は前回滞在モードに依存しない")
                Text("・高設定ほど200,400ptの振り分けが優遇")
            }
            
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "〜99pt",
                        "100pt",
                        "200pt",
                        "300pt",
                        "400pt",
                        "500pt",
                        "600pt",
                        "700pt",
                        "800pt",
                        "900pt",
                    ],
                    maxWidth: 80,
                )
                unitTableString(
                    columTitle: "通常A",
                    stringList: [
                        "-",
                        "-",
                        "△",
                        "◎",
                        "△",
                        "◯",
                        "△",
                        "-",
                        "△",
                        "天井"
                    ]
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: [
                        "-",
                        "-",
                        "△",
                        "◎",
                        "△",
                        "◎",
                        "△",
                        "天井",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "通常C",
                    stringList: [
                        "-",
                        "-",
                        "△",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "天国",
                    stringList: [
                        "-",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
            }
            
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "〜99pt",
                        "100pt",
                        "200pt",
                        "300pt",
                        "400pt",
                        "500pt",
                        "600pt",
                        "700pt",
                        "800pt",
                        "900pt",
                    ],
                    maxWidth: 80,
                )
                unitTableString(
                    columTitle: "デビル",
                    stringList: [
                        "-",
                        "▲",
                        "▲",
                        "▲",
                        "▲",
                        "▲",
                        "▲",
                        "▲",
                        "▲",
                        "天井"
                    ]
                )
                unitTableString(
                    columTitle: "設定変更",
                    stringList: [
                        "◯",
                        "◎",
                        "△",
                        "◎",
                        "△",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "引き戻し",
                    stringList: [
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
                    ]
                )
            }
        }
    }
}

#Preview {
    tekkenTableMode()
        .padding(.horizontal)
}
