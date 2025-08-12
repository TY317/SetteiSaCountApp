//
//  bayesInfoButtonBayes.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/12.
//

import SwiftUI

struct bayesInfoButtonBayes: View {
    @State var isShowInfo: Bool = false
    var body: some View {
        Button {
            self.isShowInfo.toggle()
        } label: {
            Image(systemName: "info.circle")
        }
        .sheet(isPresented: self.$isShowInfo) {
            NavigationView {
                PDFKitView(urlString: "bayesMind")
                    .toolbar {
                        ToolbarItem(placement: .automatic) {
                            Button(action: {
//                                dismiss()
                                self.isShowInfo = false
                            }, label: {
                                Text("閉じる")
                                    .fontWeight(.bold)
                            })
                        }
                    }
            }
        }
    }
}

#Preview {
    bayesInfoButtonBayes()
}
