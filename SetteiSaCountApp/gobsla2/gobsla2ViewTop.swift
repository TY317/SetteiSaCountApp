//
//  gobsla2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/23.
//

import SwiftUI

struct gobsla2ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
//    @StateObject var hanabi = Hanabi()
    @State var isShowAlert: Bool = false
//    @StateObject var hanabiMemory1 = HanabiMemory1()
//    @StateObject var hanabiMemory2 = HanabiMemory2()
//    @StateObject var hanabiMemory3 = HanabiMemory3()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    gobsla2ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
