//
//  rioAceTablePushSideLamp.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/10.
//

import SwiftUI

struct rioAceTablePushSideLamp: View {
    var body: some View {
        VStack {
            Text("・スイカ成立時の第3停止後、PUSHボタン両サイドのランプで成功抽選当選を示唆")
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "ふわっと光る",
                        "交互に点滅",
                        "高速点滅",
                    ]
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "デフォルト",
                        "当選期待度 35%",
                        "当選期待度 75%",
                    ]
                )
            }
        }
    }
}

#Preview {
    rioAceTablePushSideLamp()
}
