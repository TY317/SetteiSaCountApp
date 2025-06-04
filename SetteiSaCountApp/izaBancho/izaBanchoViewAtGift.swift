//
//  izaBanchoViewAtGift.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import SwiftUI

struct izaBanchoViewAtGift: View {
    @ObservedObject var izaBancho: IzaBancho
    
    var body: some View {
        List {
            // //// AT突入時の成敗報酬
            Section {
                Text("・AT突入時の成敗報酬は高設定ほど優遇されるらしい")
                Text("・優遇の詳細は現状不明だが、「青7」や「将軍」、「絶頂」がより多く、より早いタイミングに出現するのではと予想される")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: izaBancho.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT突入時の成敗報酬")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    izaBanchoViewAtGift(
        izaBancho: IzaBancho()
    )
}
