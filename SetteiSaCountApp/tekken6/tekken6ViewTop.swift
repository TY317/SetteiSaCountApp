//
//  tekken6ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/29.
//

import SwiftUI

struct tekken6ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var tekken6 = Tekken6()
    @State var isShowAlert: Bool = false
//    @StateObject var tekken6Memory1 = Tekken6Memory1()
//    @StateObject var tekken6Memory2 = Tekken6Memory2()
//    @StateObject var tekken6Memory3 = Tekken6Memory3()
    
    var body: some View {
        NavigationStack {
            List {
                
            }
        }
    }
}

#Preview {
    tekken6ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
