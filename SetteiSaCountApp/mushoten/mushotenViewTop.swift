//
//  mushotenViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/03.
//

import SwiftUI

struct mushotenViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
//    @StateObject var mushoten = Mushoten()
    @State var isShowAlert: Bool = false
//    @StateObject var mushotenMemory1 = mushotenMemory1()
//    @StateObject var mushotenMemory2 = mushotenMemory2()
//    @StateObject var mushotenMemory3 = mushotenMemory3()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    mushotenViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
