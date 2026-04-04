//
//  jormungandViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/04.
//

import SwiftUI

struct jormungandViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
//    @StateObject var jormungand = Jormungand()
    @State var isShowAlert: Bool = false
//    @StateObject var jormungandMemory1 = JormungandMemory1()
//    @StateObject var jormungandMemory2 = JormungandMemory2()
//    @StateObject var jormungandMemory3 = JormungandMemory3()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    jormungandViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
