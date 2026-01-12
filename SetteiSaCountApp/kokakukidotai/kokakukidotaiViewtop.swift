//
//  kokakukidotaiViewtop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/12.
//

import SwiftUI

struct kokakukidotaiViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
//    @StateObject var kokakukidotai = Kokakukidotai()
    @State var isShowAlert: Bool = false
//    @StateObject var kokakukidotaiMemory1 = KokakukidotaiMemory1()
//    @StateObject var kokakukidotaiMemory2 = KokakukidotaiMemory2()
//    @StateObject var kokakukidotaiMemory3 = KokakukidotaiMemory3()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    kokakukidotaiViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
