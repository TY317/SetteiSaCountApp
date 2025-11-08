//
//  vvv2View95Ci.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/16.
//

import SwiftUI

struct vvv2View95Ci: View {
    @ObservedObject var vvv2: Vvv2
    @State var selection = 1
    @State var isShow95CiExplain = false
    
    var body: some View {
        TabView(selection: self.$selection) {
            
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vvv2.machineName,
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
    vvv2View95Ci(
        vvv2: Vvv2(),
    )
}
