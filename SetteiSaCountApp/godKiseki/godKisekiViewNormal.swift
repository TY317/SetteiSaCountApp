//
//  godKisekiViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/13.
//

import SwiftUI

struct godKisekiViewNormal: View {
    @ObservedObject var godKiseki: GodKiseki
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowDestination: Bool = false
    
    var body: some View {
        List {
            // 小役関連
            Section {
                // 小役停止形
                unitLinkButtonViewBuilder(sheetTitle: "小役停止形") {
                    godKisekiKoyakuPattern()
                }
            } header: {
                Text("小役")
            }
            
            // モード
            Section {
                // モード概要
                unitLinkButtonViewBuilder(sheetTitle: "モード概要") {
                    godKisekiTableModeGaiyo()
                }
                
                // モード示唆
                HStack {
                    Spacer()
                    Button {
                        self.isShowDestination.toggle()
                    } label: {
                        Text(">> モード示唆")
                    }
                    .sheet(
                        isPresented: self.$isShowDestination
                    ) {
//                        NavigationView {
//                            ScrollView {
//                                self.destination()
//                                    .padding(.bottom, 40)
//                            }
//                            .padding(.horizontal)
//                            // //// タイトル
//                            .navigationTitle(self.sheetTitle)
//                            .toolbarTitleDisplayMode(.inline)
//                            // //// ツールバー閉じるボタン
//                            .toolbar {
//                                ToolbarItem(placement: .automatic) {
//                                    Button(action: {
//                                        self.isShowDestination = false
//                                    }, label: {
//                                        Text("閉じる")
//                                            .fontWeight(.bold)
//                                    })
//                                }
//                            }
//                        }
                        godKisekiNaviModeSisa(isPresented: self.$isShowDestination)
                            .presentationDetents([.large])
                    }
                }
            } header: {
                Text("モード")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.godKisekiMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: godKiseki.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    godKisekiViewNormal(
        godKiseki: GodKiseki(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
