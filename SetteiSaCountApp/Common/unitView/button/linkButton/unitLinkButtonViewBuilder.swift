//
//  unitLinkButtonViewBuilder.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/19.
//

import SwiftUI

struct unitLinkButtonViewBuilder<destination: View>: View {
    //    var linkText: String?
    var sheetTitle: String
    var linkText: String?
    @State var isShowDestination: Bool = false
    var detent: PresentationDetent = .medium
    @ViewBuilder var destination: () -> destination
//    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                self.isShowDestination.toggle()
            } label: {
                if let linkText = self.linkText {
                    Text(">> \(linkText)")
                        .foregroundStyle(Color.blue)
                } else {
                    Text(">> \(self.sheetTitle)について")
                }
            }
            .sheet(
                isPresented: self.$isShowDestination
            ) {
                NavigationView {
                    ScrollView {
                        self.destination()
                            .padding(.bottom, 40)
                    }
                    .padding(.horizontal)
                    // //// タイトル
                    .navigationTitle(self.sheetTitle)
                    .toolbarTitleDisplayMode(.inline)
                    // //// ツールバー閉じるボタン
                    .toolbar {
                        ToolbarItem(placement: .automatic) {
                            Button(action: {
                                self.isShowDestination = false
                            }, label: {
                                Text("閉じる")
                                    .fontWeight(.bold)
                            })
                        }
                    }
                }
                .presentationDetents([self.detent])
            }
        }
    }
}

#Preview {
    unitLinkButtonViewBuilder(
        sheetTitle: "機械割",
        linkText: "機械割",
    ) {
//        NavigationView {
            Text("test")
//        }
    }
}
