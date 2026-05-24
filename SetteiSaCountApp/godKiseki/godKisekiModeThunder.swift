//
//  godKisekiModeThunder.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/24.
//

import SwiftUI

struct godKisekiModeThunder: View {
    @Binding var isPresented: Bool
    var body: some View {
        ScrollView {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "奇数非テンパイ",
                        "下段黄7\n＋テンパイハズレ",
                    ],
                    maxWidth: 150,
                    lineList: [1,2,1],
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "裏天国 期待度大",
                        "裏天国 濃厚",
                    ],
                    maxWidth: 250,
                    lineList: [1,2,1],
                )
            }
        }
        .padding(.vertical)
        .padding(.horizontal)
        .navigationTitle("雷")
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
    godKisekiModeThunder(
        isPresented: $isPresented
    )
}
