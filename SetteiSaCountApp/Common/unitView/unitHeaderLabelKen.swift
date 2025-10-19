//
//  unitHeaderLabelKen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/19.
//

import SwiftUI

struct unitHeaderLabelKen: View {
    var body: some View {
        HStack {
            Text("見")
                .fontWeight(.bold)
                .font(.headline)
            unitToolbarButtonQuestion {
                unitExView5body2image(
                    title: "見",
                    textBody1: "・空き台のデータ確認にご利用下さい",
                    textBody2: "・データ確認：ぶどう・ベル逆算値はこちらで確認。そのまま打ち始めデータとして登録も可能です",
                    textBody3: "・島データ確認：複数台の合算値はこちらで確認",
                )
            }
        }
    }
}

#Preview {
    unitHeaderLabelKen()
}
