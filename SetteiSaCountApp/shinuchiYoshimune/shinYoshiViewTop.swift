//
//  shinYoshiViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/29.
//

import SwiftUI

struct shinYoshiViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
//    @StateObject var shinYoshi = shinYoshi()
    @State var isShowAlert: Bool = false
//    @StateObject var shinYoshiMemory1 = shinYoshiMemory1()
//    @StateObject var shinYoshiMemory2 = shinYoshiMemory2()
//    @StateObject var shinYoshiMemory3 = shinYoshiMemory3()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    shinYoshiViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
