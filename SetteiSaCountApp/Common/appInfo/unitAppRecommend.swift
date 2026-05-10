//
//  unitAppRecommend.swift
//  lotteryMemoApp
//
//  Created by 横田徹 on 2026/05/02.
//

import SwiftUI

struct unitAppRecommend: View {
    @Environment(\.openURL) private var openURL
    var iconImage: String = "countAppIcon"
    var appTitle: String = "小役カウンター count"
    var appStoreURL: String = "https://apps.apple.com/jp/app/小役カウンターcount-パチスロ設定判別/id6636471924"
    var previewImages: [String] = [
        "recommendCountPreview1",
        "recommendCountPreview2",
        "recommendCountPreview3",
        "recommendCountPreview4",
        "recommendCountPreview5",
        "recommendCountPreview6",
        "recommendCountPreview7",
        "recommendCountPreview8",
    ]
    var promotionText: String = "◆◆ 小役だけじゃない！万能カウントツール ◆◆\nパチスロAT機で必須の終了画面やボイスのカウントはもちろん、初当り履歴のメモ、設定判別計算など様々な機能も備えた最強の小役カウンタが誕生！全機種専用設計なので、面倒な設定も不要！別次元の使いやすさを実現しました！これであなたもガチ勢に！！"
    
    var body: some View {
        DisclosureGroup {
            // プレビュー
            VStack(alignment: .leading) {
                Text("プレビュー")
                    .font(.headline)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(self.previewImages, id: \.self) { name in
                            Image(name)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(8)
                        }
                    }
                }
                .frame(height: 250)
            }
            
            // 説明文
            Text(self.promotionText)
                .font(.caption)
        } label: {
            // Appアイコン＆タイトル＆ボタン
            HStack(spacing: 20) {
                Image(self.iconImage)
                    .resizable()
                    .scaledToFit()
                VStack(alignment: .leading,spacing: 5) {
                    Text(self.appTitle)
                        .font(.title3)
                        .fontWeight(.bold)
                    Button {
                        if let url = URL(string: self.appStoreURL) {
                            openURL(url)
                        }
                    } label: {
                        Text("AppStoreで入手")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .frame(height: 70)
        }
    }
}

#Preview {
    List {
        Section {
            unitAppRecommend()
            unitAppRecommend(
                iconImage: "hikakukakakuAppIcon",
                appTitle: "ヒカクカカク",
                appStoreURL: "https://apps.apple.com/jp/app/ヒカクカカク-価格比較-メモ/id6763712943",
                previewImages: [
                    "recommendHikakukakakuPreview1",
                    "recommendHikakukakakuPreview2",
                    "recommendHikakukakakuPreview3",
                    "recommendHikakukakakuPreview4",
                    "recommendHikakukakakuPreview5",
                ],
                promotionText: "どっちが本当にお得？クーポン込みの実質価格と単価を一瞬で比較。お店ごとの最安値を自動で記録するから、次のお買い物で迷わない。シンプル操作でレジ前でも安心の価格比較アプリ。"
            )
        } header: {
            Text("おすすめアプリ")
        }
    }
}
