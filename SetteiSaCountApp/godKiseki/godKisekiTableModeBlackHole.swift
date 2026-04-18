//
//  godKisekiTableModeBlackHole.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/18.
//

import SwiftUI

struct godKisekiTableModeBlackHole: View {
    @Binding var isPresented: Bool
    var body: some View {
        ScrollView {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "単発",
                        "2連",
                        "3連",
                        "4連",
                    ],
                    maxWidth: 80,
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "天国準備以上の期待大",
                        "デフォルト",
                        "デフォルト",
                        "GG以上濃厚",
                    ],
                    maxWidth: 250,
                )
            }
        }
        .padding(.top)
        .navigationTitle("ブラックホール")
        .navigationBarTitleDisplayMode(.inline)
        // //// ツールバー閉じるボタン
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    self.isPresented = false
                }, label: {
                    Text("閉じる")
                        .fontWeight(.bold)
                })
            }
        }
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = true
    godKisekiTableModeBlackHole(
        isPresented: $isPresented
    )
}
