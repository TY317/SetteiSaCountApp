//
//  akudamaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/05.
//

import SwiftUI

struct akudamaViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
//    @StateObject var akudama = Akudama()
    @State var isShowAlert: Bool = false
//    @StateObject var akudamaMemory1 = AkudamaMemory1()
//    @StateObject var akudamaMemory2 = AkudamaMemory2()
//    @StateObject var akudamaMemory3 = AkudamaMemory3()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    akudamaViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
