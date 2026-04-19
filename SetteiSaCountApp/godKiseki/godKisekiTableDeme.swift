//
//  godKisekiTableDeme.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/18.
//

import SwiftUI

struct godKisekiTableDeme: View {
    @Binding var isPresented: Bool
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "期待度＆前兆示唆",
                        stringList: [
                            "奇数テンパイ",
                            "奇数のみ",
                            "左偶数＋ケツ奇数テンパイ",
                            "左奇数＋ケツ奇数テンパイ",
                            "奇数頭の順目",
                            "奇数ハサミ(中も奇数)",
                            "Vハサミ(中は奇数)",
                        ],
                        maxWidth: 250,
                    )
                    unitTableString(
                        columTitle: "期待度",
                        stringList: [
                            "低",
                            "↓",
                            "↓",
                            "↓",
                            "↓",
                            "↓",
                            "高",
                        ],
                        maxWidth: 70
                    )
                }
                
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "リーチ目",
                        stringList: [
                            "1V3 (イビサ島)",
                            "223 (富士山)",
                            "315 (最高)",
                            "4V8 (渋谷)",
                            "526 (小次郎)",
                            "634 (武蔵)",
                            "808 (八百屋)",
                            "V31 (Vサイン)",
                        ],
                        maxWidth: 250,
                    )
                }
                
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "高モード滞在示唆",
                        stringList: [
                            "偶数頭の順目",
                            "左偶数＋ケツ0テンパイ",
                            "左奇数＋ケツ0テンパイ",
                            "38V (雅)",
                            "461 (鎧)",
                            "468 (ヨーロッパ)",
                            "631 (無罪)",
                            "831 (野菜)",
                        ],
                        maxWidth: 250,
                    )
                }
            }
        }
        .padding(.vertical)
        .padding(.horizontal)
        .navigationTitle("液晶出目法則")
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
    godKisekiTableDeme(
        isPresented: $isPresented
    )
        .padding(.horizontal)
}
