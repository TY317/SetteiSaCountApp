//
//  unitViewNewAppRelease.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/07.
//

import SwiftUI

struct unitViewNewAppRelease: View {
    var appIcon: String
    var appName: String
    var promotionText: String
    var appStoreURL: String
    @Environment(\.openURL) private var openURL
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .opacity(0.3)
            GroupBox {
                VStack(spacing: 10) {
                    // アプリアイコン
                    VStack {
                        Image(self.appIcon)
                            .resizable()
                            .scaledToFit()
                        Text(self.appName)
                            .font(.headline)
                    }
                    .frame(height: 120)
                    // プレビュー画像
//                    HStack {
//                        Image("recommendLotteryMemoPreview1")
//                            .resizable()
//                            .scaledToFit()
//                            .cornerRadius(5)
//                        Image("recommendLotteryMemoPreview2")
//                            .resizable()
//                            .scaledToFit()
//                            .cornerRadius(5)
//                        Image("recommendLotteryMemoPreview3")
//                            .resizable()
//                            .scaledToFit()
//                            .cornerRadius(5)
//                    }
//                    .frame(height: 100)
                    
                    // アプリの説明
                    Text(self.promotionText)
                    Text("※ 左上のインフォメーションからいつでも確認できます")
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                    
                    // ボタン横並び
                    HStack {
                        // アプリリンク
                        Button {
                            common.newAppInfoShow = false
                            if let url = URL(string: self.appStoreURL) {
                                openURL(url)
                            }
                        } label: {
                            Text("AppStoreで入手")
                                .frame(maxWidth: 200, alignment: .center)
                                .padding(.vertical, 5)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        // 閉じる
                        Button {
                            common.newAppInfoShow = false
                        } label: {
                            Text("閉じる")
                                .frame(maxWidth: 200, alignment: .center)
                                .padding(.vertical, 5)
                        }
                        .buttonStyle(.bordered)
                    }
                }
            } label: {
                Text("新アプリ情報")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(maxWidth: 400)
            .padding(.horizontal)
        }
    }
}

#Preview {
    unitViewNewAppRelease(
        appIcon: "lotteryMemoAppIcon",
        appName: "抽選履歴メモ",
        promotionText: "あなたは引き強？　パチ屋の朝抽選の記録に特化したアプリが誕生しました！朝の抽選をもっと楽しく！",
        appStoreURL: "https://apps.apple.com/jp/app/抽選履歴メモ/id6764254123",
    )
        .environmentObject(commonVar())
}
