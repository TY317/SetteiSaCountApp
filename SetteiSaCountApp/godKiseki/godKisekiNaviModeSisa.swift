//
//  godKisekiNaviModeSisa.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/18.
//

import SwiftUI

struct godKisekiNaviModeSisa: View {
    @Binding var isPresented: Bool
    var body: some View {
        NavigationStack {
            List {
                // 液晶出目法則
                NavigationLink(destination: godKisekiTableDeme(
                    isPresented: self.$isPresented
                )) {
                    unitLabelMenu(
                        imageSystemName: "numbers",
                        textBody: "液晶出目法則"
                    )
                }
                
                // ステージチェンジ
                NavigationLink(destination: godKisekiTableModeStageChange(
                    isPresented: self.$isPresented
                )) {
                    unitLabelMenu(
                        imageSystemName: "signpost.right.and.left.fill",
                        textBody: "ステージチェンジ"
                    )
                }
                
                // 光の風
                NavigationLink(destination: godKisekiTableHikariNoKaze(
                    isPresented: self.$isPresented
                )) {
                    unitLabelMenu(
                        imageSystemName: "wind.snow",
                        textBody: "光の風"
                    )
                }
                
                // ブラックホール
                NavigationLink(destination: godKisekiTableModeBlackHole(
                    isPresented: self.$isPresented
                )) {
                    unitLabelMenu(
                        imageSystemName: "moonphase.new.moon.inverse",
                        textBody: "ブラックホール"
                    )
                }
                
                // 陽炎
                NavigationLink(destination: godKisekiModeKagero(
                    isPresented: self.$isPresented
                )) {
                    unitLabelMenu(
                        imageSystemName: "heat.waves",
                        textBody: "陽炎"
                    )
                }
                
                // 雷
                NavigationLink(destination: godKisekiModeThunder(
                    isPresented: self.$isPresented
                )) {
                    unitLabelMenu(
                        imageSystemName: "bolt.fill",
                        textBody: "雷"
                    )
                }
                
                // アルテミスの矢
                NavigationLink(destination: godKisekiModeArrow(
                    isPresented: self.$isPresented
                )) {
                    unitLabelMenu(
                        imageSystemName: "figure.archery",
                        textBody: "アルテミスの矢"
                    )
                }
                
                // 遅れ
                NavigationLink(destination: godKisekiTableModeOkure(
                    isPresented: self.$isPresented
                )) {
                    unitLabelMenu(
                        imageSystemName: "music.note",
                        textBody: "遅れ"
                    )
                }
            }
            .navigationTitle("モード示唆")
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
}

#Preview {
//    ScrollView {
    @Previewable @State var isPresented: Bool = true
        godKisekiNaviModeSisa(
            isPresented: $isPresented
        )
//    }
//    .padding(.horizontal)
}
