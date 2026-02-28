//
//  kabaneriUnatoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/28.
//

import SwiftUI

struct kabaneriUnatoViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
//    @StateObject var kabaneriUnato = KabaneriUnato()
    @State var isShowAlert: Bool = false
//    @StateObject var kabaneriUnatoMemory1 = KabaneriUnatoMemory1()
//    @StateObject var kabaneriUnatoMemory2 = KabaneriUnatoMemory2()
//    @StateObject var kabaneriUnatoMemory3 = KabaneriUnatoMemory3()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    kabaneriUnatoViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
