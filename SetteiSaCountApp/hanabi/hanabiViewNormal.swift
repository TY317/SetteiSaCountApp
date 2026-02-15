//
//  hanabiViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/02.
//

import SwiftUI

struct hanabiViewNormal: View {
    @ObservedObject var hanabi: Hanabi
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    var body: some View {
        List {
            
        }
    }
}

#Preview {
    hanabiViewNormal(
        hanabi: Hanabi(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
