//
//  commonViewInfoSheet.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/07.
//

import SwiftUI

struct commonViewInfoSheet: View {
    @Environment(\.dismiss) private var dismiss
    private var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "—"
    }
    
    var body: some View {
        NavigationStack {
            List {
                // バージョン情報
                Section {
                    LabeledContent("バージョン", value: version)
                } header: {
                    Text("アプリ情報")
                }
                
                // おすすめアプリ
                Section {
                    unitAppRecommend(
                        iconImage: "lotteryMemoAppIcon",
                        appTitle: "抽選履歴メモ",
                        appStoreURL: "https://apps.apple.com/jp/app/抽選履歴メモ/id6764254123",
                        previewImages: [
                            "recommendLotteryMemoPreview1",
                            "recommendLotteryMemoPreview2",
                            "recommendLotteryMemoPreview3",
                            "recommendLotteryMemoPreview4",
                            "recommendLotteryMemoPreview5",
                        ],
                        promotionText: "あなたは引き強？引き弱？　パチ屋の抽選何番でどの台を取れたかを記録して、次回入場時の動きをよりスムーズに！自分の引きの強さ数値化や、抽選シミュレーターでの練習といったエンタメ機能も搭載。朝の抽選をもっと楽しく！"
                    )
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
            .navigationTitle("インフォメーション")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("閉じる")
//                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

#Preview {
    commonViewInfoSheet()
}
