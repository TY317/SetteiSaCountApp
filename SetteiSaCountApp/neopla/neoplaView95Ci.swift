//
//  neoplaView95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/09.
//

import SwiftUI

struct neoplaView95Ci: View {
    @ObservedObject var neopla: Neopla
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: neopla.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("95%信頼区間グラフ")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButton95CiExplain(isShow95CiExplain: isShow95CiExplain)
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    neoplaView95Ci(
        neopla: Neopla(),
    )
}
