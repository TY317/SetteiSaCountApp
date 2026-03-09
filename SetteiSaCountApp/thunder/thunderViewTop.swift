//
//  thunderViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/09.
//

import SwiftUI

struct thunderViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
//    @StateObject var thunder = Thunder()
    @State var isShowAlert: Bool = false
//    @StateObject var thunderMemory1 = ThunderMemory1()
//    @StateObject var thunderMemory2 = ThunderMemory2()
//    @StateObject var thunderMemory3 = ThunderMemory3()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    thunderViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
