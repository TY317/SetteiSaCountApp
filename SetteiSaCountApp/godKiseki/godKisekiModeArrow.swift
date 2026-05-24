//
//  godKisekiModeArrow.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/24.
//

import SwiftUI

struct godKisekiModeArrow: View {
    @Binding var isPresented: Bool
    var body: some View {
        ScrollView {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "上段青7否定",
                    ],
                    maxWidth: 150,
                    lineList: [1,2,1],
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "裏天国 期待度大",
                    ],
                    maxWidth: 250,
                    lineList: [1,2,1],
                )
            }
        }
        .padding(.vertical)
        .padding(.horizontal)
        .navigationTitle("アルテミスの矢")
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
    godKisekiModeArrow(
        isPresented: $isPresented
    )
}
