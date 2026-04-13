//
//  godKisekiViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/13.
//

import SwiftUI

struct godKisekiViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
//    @StateObject var godKiseki = GodKiseki()
    @State var isShowAlert: Bool = false
//    @StateObject var godKisekiMemory1 = GodKisekiMemory1()
//    @StateObject var godKisekiMemory2 = GodKisekiMemory2()
//    @StateObject var godKisekiMemory3 = GodKisekiMemory3()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    godKisekiViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
