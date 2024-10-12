//
//  kaguyaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/12.
//

import SwiftUI
import TipKit

// ///////////////////////////
// 変数
// ///////////////////////////
class KaguyaSama: ObservableObject {
    
    
    // //////////////////////////
    // 共通
    // //////////////////////////
    @AppStorage("kaguyaMinusCheck") var minusCheck: Bool = false
    
    func resetAll() {
        
    }
}

struct kaguyaViewTop: View {
    @ObservedObject var kaguya = KaguyaSama()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時のモード、示唆
                    NavigationLink(destination: kaguyaViewNormalMode()) {
                        unitLabelMenu(imageSystemName: "sparkle.magnifyingglass", textBody: "通常時のモード、示唆")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "かぐや様は告らせたい")
                }
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButtonReset(isShowAlert: $isShowAlert, action: kaguya.resetAll, message: "この機種のデータを全てリセットします")
            }
        }
    }
}

#Preview {
    kaguyaViewTop()
}
