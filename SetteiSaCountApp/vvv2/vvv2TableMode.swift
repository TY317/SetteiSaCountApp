//
//  vvv2TableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/06.
//

import SwiftUI

struct vvv2TableMode: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("・周期ポイント、周期当落を4つのモードで管理")
                Text("・1周期目は全モード共通で周期ポイント200ptがポイント天井となる")
            }
            .padding(.bottom)
            Text("[規定ポイント期待度テーブル]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "100pt",
                        "200pt",
                        "300pt",
                        "400pt",
                        "500pt",
                        "600pt",
                    ],
                )
                unitTableString(
                    columTitle: "通常A",
                    stringList: ["◎","◯","△","◎","△","天井",]
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: ["◎","◯","◯","◯","◯","天井",]
                )
                unitTableString(
                    columTitle: "通常C",
                    stringList: ["◎","◎","△","天井","grayOut","grayOut",]
                )
                unitTableString(
                    columTitle: "天国",
                    stringList: ["天井","grayOut","grayOut","grayOut","grayOut","grayOut",]
                )
            }
            .padding(.bottom)
            Text("[周期期待度テーブル]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "1周期",
                        "2周期",
                        "3周期",
                        "4周期",
                        "5周期",
                        "6周期",
                    ],
                )
                unitTableString(
                    columTitle: "通常A",
                    stringList: ["◯","◎","△","◯","◯","天井",]
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: ["△","◯","天井","grayOut","grayOut","grayOut",]
                )
                unitTableString(
                    columTitle: "通常C",
                    stringList: ["◯","◯","◯","◯","天井","grayOut",]
                )
                unitTableString(
                    columTitle: "天国",
                    stringList: ["天井","grayOut","grayOut","grayOut","grayOut","grayOut",]
                )
            }
        }
    }
}

#Preview {
    ScrollView {
        vvv2TableMode()
    }
        .padding(.horizontal)
}
