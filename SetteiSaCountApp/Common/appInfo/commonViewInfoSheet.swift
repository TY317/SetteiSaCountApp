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
                        iconImage: "shimazuMakerAppIcon",
                        appTitle: "島図メーカー",
                        appStoreURL: "https://apps.apple.com/jp/app/島図メーカー/id6766023404",
                        previewImages: [
                            "recommendShimazuMakerPreview1",
                            "recommendShimazuMakerPreview2",
                            "recommendShimazuMakerPreview3",
                            "recommendShimazuMakerPreview4",
                            "recommendShimazuMakerPreview5",
                            "recommendShimazuMakerPreview6",
                        ],
                        promotionText: "パチ屋の島図をスマホで作って、台ごとに色付けやメモが残せる——これまでにない、立ち回り用アプリが誕生。マイホをそっくり再現して、その日の状況をまるごと記録。QR コードで仲間と即シェア。前日下見・当日立ち回り・軍団稼働、ぜんぶこれ 1 つ。"
                    )
                    unitAppRecommend(
                        iconImage: "lapTimerAppIcon",
                        appTitle: "LAP&LEAN",
                        appStoreURL: "https://apps.apple.com/jp/app/lap-lean/id6772683694",
                        previewImages: [
                            "recommendLapTimerPreview1",
                            "recommendLapTimerPreview2",
                            "recommendLapTimerPreview3",
                            "recommendLapTimerPreview4",
                            "recommendLapTimerPreview5",
                        ],
                        promotionText: "バイク専用設計だから、ラップタイムだけじゃない——車体のバンク角まで計測できるラップタイマーが誕生。さらにコースは自分で作れるから、プリセットに無いローカルサーキットや練習コースにも対応。GPSラップ・セクター・コーナー分析を推移グラフで可視化し、あなたの走りをデータで速くする。"
                    )
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
