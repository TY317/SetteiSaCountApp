//
//  karakuriTableSpotLight.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct karakuriTableSpotLight: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "スポットライトなし",
                    "スポットライトのみ",
                    "しろがねシルエット",
                    "しろがねアップ",
                ],
                maxWidth: 200,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "残り400G以内示唆",
                    "残り200G以内示唆",
                    "残り100G以内示唆",
                ],
                maxWidth: 200,
            )
        }
    }
}

#Preview {
    karakuriTableSpotLight()
        .padding(.horizontal)
}
