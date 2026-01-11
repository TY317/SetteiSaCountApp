//
//  enen2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/11.
//

import SwiftUI

struct enen2ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
//    @StateObject var enen2 = enen2()
    @State var isShowAlert: Bool = false
//    @StateObject var enen2Memory1 = enen2Memory1()
//    @StateObject var enen2Memory2 = enen2Memory2()
//    @StateObject var enen2Memory3 = enen2Memory3()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    enen2ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
