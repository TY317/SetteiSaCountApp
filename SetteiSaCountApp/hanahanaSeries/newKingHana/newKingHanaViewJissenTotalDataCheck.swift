//
//  newKingHanaViewJissenTotalDataCheck.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/21.
//

import SwiftUI

struct newKingHanaViewJissenTotalDataCheck: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var newKingHana: NewKingHana
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    var body: some View {
        List {
            
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: newKingHana.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("総合結果確認")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    newKingHanaViewJissenTotalDataCheck(
        newKingHana: NewKingHana(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
