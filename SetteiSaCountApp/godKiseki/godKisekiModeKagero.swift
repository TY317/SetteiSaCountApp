//
//  godKisekiModeKagero.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/18.
//

import SwiftUI

struct godKisekiModeKagero: View {
    @Binding var isPresented: Bool
    var body: some View {
        ScrollView {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "All偶数",
                        "All奇数",
                        "その他",
                    ],
                    maxWidth: 80,
                    lineList: [1,2,1],
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "偶数揃い濃厚",
                        "奇数テンパイで前兆示唆\nその他は表モード示唆",
                        "GG前兆以上濃厚",
                    ],
                    maxWidth: 250,
                    lineList: [1,2,1],
                )
            }
        }
        .padding(.top)
        .navigationTitle("陽炎")
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
    godKisekiModeKagero(
        isPresented: $isPresented
    )
}
