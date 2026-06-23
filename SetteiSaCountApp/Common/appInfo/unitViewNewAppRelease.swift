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


// ============================================================
// ver4.0.0 新ホーム画面 使い方オンボーディング
// 起動時に一度だけ表示。ミニ画面モックの中で
// ①ツールバータップで編集モード → ②プルプル → ③「−」でホームから非表示 → ④ドラッグ並び替え → ⑤横スワイプでライブラリ
// を1本の連続ループで見せ、閉じるボタンで終了（common.homeOnboardingDone = true）。
// ============================================================
struct unitViewHomeOnboarding: View {
    @EnvironmentObject var common: commonVar

    /// アニメーションのフェーズ 0:タップ 1:プルプル 2:非表示 3:ドラッグ 4:スワイプ
    @State private var phase: Int = 0
    /// タップ波紋用の繰り返しアニメーション
    @State private var tapPulse = false

    /// デモ用アイコン（実機種アイコンを流用）
    private let baseOrder: [String] = [
        "machineIconJuglerSeries", "machineIconHanahanaSeries", "otome5MachineIcon",
        "sao2MachineIcon", "bioRe3MachineIcon", "rioAceMachineIcon"
    ]
    /// 現在の並び順（ドラッグ並び替えで変化）
    @State private var iconOrder: [String] = []

    /// フェーズを進める無限タイマー（1フェーズ約1.8秒）
    private let phaseTimer = Timer.publish(every: 1.8, on: .main, in: .common).autoconnect()

    // ミニ画面の寸法
    private let screenW: CGFloat = 220
    private let bodyH: CGFloat = 240
    private let iconSize: CGFloat = 46

    private let captions = [
        "① ツールバーのボタンで編集モードに",
        "② アイコンがプルプルすれば編集中",
        "③ 「−」ボタンでホーム画面から非表示に",
        "④ ドラッグ＆ドロップで並び替え",
        "⑤ 横スワイプで全機種ライブラリへ"
    ]

    /// プルプル（編集中）はフェーズ1以降
    private var isEditing: Bool { phase >= 1 }
    /// ドラッグで動かすアイコン（先頭を後ろへ移動して見せる）
    private var draggedName: String { baseOrder.first ?? "" }
    /// 「−」で非表示にして見せるアイコン（先頭＝ドラッグ対象とは別を選ぶ）
    private var deleteTargetName: String { baseOrder.count > 1 ? baseOrder[1] : "" }

    /// グリッド内スロットの中心座標（3列×2行）
    private func slotCenter(_ i: Int) -> CGPoint {
        let cols = 3
        let cellW = screenW / CGFloat(cols)
        let cellH: CGFloat = 110
        let topInset: CGFloat = 18
        let r = i / cols
        let c = i % cols
        return CGPoint(x: cellW * (CGFloat(c) + 0.5),
                       y: topInset + cellH * CGFloat(r) + cellH / 2)
    }

    var body: some View {
        ZStack {
            // 暗転背景
            Rectangle()
                .ignoresSafeArea()
                .opacity(0.45)

            // カード
            VStack(spacing: 14) {
                VStack(spacing: 4) {
                    Text("ホーム画面が新しくなりました")
                        .font(.title3).fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text("アイコンの並び替えや、全機種ライブラリへのアクセスができます")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }

                // ミニ画面モックアップ（アニメ）
                mockup

                // ステップ説明（フェーズで切替）
                Text(captions[min(phase, captions.count - 1)])
                    .font(.subheadline).fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(height: 40)
                    .id(phase)
                    .transition(.opacity)

                // 閉じる
                Button {
                    common.homeOnboardingDone = true
                } label: {
                    Text("閉じる")
                        .frame(maxWidth: 240)
                        .padding(.vertical, 6)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(UIColor.secondarySystemBackground))
            )
            .padding(.horizontal, 24)
            .frame(maxWidth: 420)
        }
        .onAppear {
            iconOrder = baseOrder
            withAnimation(.easeOut(duration: 0.9).repeatForever(autoreverses: false)) {
                tapPulse = true
            }
        }
        .onReceive(phaseTimer) { _ in
            let next = (phase + 1) % 5
            withAnimation(.easeInOut(duration: 0.7)) {
                if next == 0 {
                    // ループ先頭で初期状態へ戻す（非表示・並び替えをリセット）
                    iconOrder = baseOrder
                }
                if next == 3 {
                    // 先頭アイコンを末尾へ移動＝ドラッグ並び替えを表現
                    if !iconOrder.isEmpty {
                        let moved = iconOrder.removeFirst()
                        iconOrder.append(moved)
                    }
                }
                phase = next
            }
            if next == 2 {
                // 指が「−」をタップ → 少し遅れてアイコンがポンッと消える（ホームから非表示）
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        iconOrder.removeAll { $0 == deleteTargetName }
                    }
                }
            }
        }
    }

    // MARK: - ミニ画面モックアップ
    private var mockup: some View {
        VStack(spacing: 0) {
            // 上部ツールバー
            HStack(spacing: 10) {
                Text("機種選択").font(.caption2).fontWeight(.semibold)
                Spacer()
                Image(systemName: "circle.lefthalf.filled").font(.caption2)
                ZStack {
                    Image(systemName: "apps.iphone")
                        .font(.callout)
                        .foregroundColor(isEditing ? .red : .primary)
                        .scaleEffect(phase == 0 ? 1.25 : 1.0)
                    // タップの波紋
                    Circle()
                        .stroke(Color.accentColor, lineWidth: 2)
                        .frame(width: 28, height: 28)
                        .scaleEffect(tapPulse ? 1.5 : 0.6)
                        .opacity(phase == 0 ? (tapPulse ? 0.0 : 0.7) : 0.0)
                }
                Image(systemName: "heart").font(.caption2)
            }
            .padding(.horizontal, 12)
            .frame(height: 34)
            .background(Color(UIColor.systemBackground))

            Divider()

            // 本体（グリッド ←→ ライブラリ をスワイプ）
            ZStack(alignment: .topLeading) {
                Color(UIColor.systemGroupedBackground)

                HStack(spacing: 0) {
                    gridPage.frame(width: screenW)
                    libraryPage.frame(width: screenW)
                }
                .frame(width: screenW, alignment: .leading)
                .offset(x: phase == 4 ? -screenW : 0)

                // 横スワイプを示す指
                Image(systemName: "hand.point.up.left.fill")
                    .font(.title2)
                    .foregroundStyle(.primary)
                    .shadow(radius: 2)
                    .position(x: phase == 4 ? 34 : screenW - 30, y: bodyH * 0.62)
                    .opacity(phase == 4 ? 1 : 0)
            }
            .frame(width: screenW, height: bodyH)
            .clipped()

            // ページドット
            HStack(spacing: 6) {
                Circle().frame(width: 6, height: 6)
                    .foregroundStyle(phase == 4 ? Color.secondary.opacity(0.4) : Color.primary)
                Circle().frame(width: 6, height: 6)
                    .foregroundStyle(phase == 4 ? Color.primary : Color.secondary.opacity(0.4))
            }
            .frame(height: 22)
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemBackground))
        }
        .frame(width: screenW)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.primary.opacity(0.15), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.15), radius: 6, y: 3)
    }

    // グリッドページ（スロット配置＋プルプル＋ドラッグ）
    private var gridPage: some View {
        ZStack(alignment: .topLeading) {
            ForEach(Array(iconOrder.enumerated()), id: \.element) { idx, name in
                iconCell(name: name, index: idx)
                    .position(slotCenter(idx))
                    .zIndex(name == draggedName && phase == 3 ? 1 : 0)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .frame(width: screenW, height: bodyH, alignment: .topLeading)
    }

    private func iconCell(name: String, index: Int) -> some View {
        let isDragging = (name == draggedName && phase == 3)
        let isDeleting = (name == deleteTargetName && phase == 2)
        return Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: iconSize, height: iconSize)
            .clipShape(RoundedRectangle(cornerRadius: 11))
            .scaleEffect(isDragging ? 1.18 : 1.0)
            .shadow(color: .black.opacity(isDragging ? 0.3 : 0), radius: 5, y: 2)
            .overlay(alignment: .topLeading) {
                if isEditing {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                        .background(Circle().fill(.white))
                        .scaleEffect(isDeleting ? 1.5 : 1.0)
                        .offset(x: -5, y: -5)
                }
            }
            .overlay(alignment: .bottomTrailing) {
                if isDragging {
                    Image(systemName: "hand.point.up.left.fill")
                        .font(.body)
                        .foregroundStyle(.primary)
                        .shadow(radius: 2)
                        .offset(x: 10, y: 12)
                }
            }
            // 「−」をタップする指（ホームから非表示デモ）
            .overlay(alignment: .topLeading) {
                if isDeleting {
                    Image(systemName: "hand.point.up.left.fill")
                        .font(.body)
                        .foregroundStyle(.primary)
                        .shadow(radius: 2)
                        .offset(x: 4, y: 6)
                }
            }
            .modifier(JitterModifier(
                isEditing: isEditing,
                seed: Double(index) / Double(max(baseOrder.count - 1, 1))
            ))
    }

    // ライブラリページ（メーカー別フォルダ風）
    private var libraryPage: some View {
        VStack(spacing: 10) {
            HStack {
                Text("全機種ライブラリ").font(.caption).fontWeight(.semibold)
                Spacer()
            }
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                makerFolder(label: "北電子", icons: ["machineIconJuglerSeries", "otome5MachineIcon", "sao2MachineIcon", "godKisekiMachineIcon"])
                makerFolder(label: "サミー", icons: ["bioRe3MachineIcon", "machineIconHokuto", "machineIconKabaneri", "rioAceMachineIcon"])
                makerFolder(label: "SANKYO", icons: ["machineIconVVV", "rioAceMachineIcon", "sao2MachineIcon", "otome5MachineIcon"])
                makerFolder(label: "パイオニア", icons: ["machineIconHanahanaSeries", "machineIconJuglerSeries", "bioRe3MachineIcon", "machineIconKabaneri"])
            }
            Spacer(minLength: 0)
        }
        .padding(12)
        .frame(width: screenW, height: bodyH, alignment: .top)
    }

    private func makerFolder(label: String, icons: [String]) -> some View {
        VStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.primary.opacity(0.08))
                .frame(width: 64, height: 64)
                .overlay(
                    LazyVGrid(columns: [GridItem(.fixed(22)), GridItem(.fixed(22))], spacing: 4) {
                        ForEach(Array(icons.prefix(4).enumerated()), id: \.offset) { _, ic in
                            Image(ic).resizable().scaledToFit()
                                .frame(width: 22, height: 22)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
                    .padding(6)
                )
            Text(label).font(.system(size: 9)).foregroundStyle(.secondary)
        }
    }
}

#Preview {
    unitViewHomeOnboarding()
        .environmentObject(commonVar())
}
