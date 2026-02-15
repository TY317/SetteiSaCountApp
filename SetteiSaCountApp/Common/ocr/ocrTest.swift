//
//  ocrTest.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/07.
//

import SwiftUI
import Vision
import UIKit
import PhotosUI

class OCRService {
    // 読み取りたい項目と、その結果を格納する構造体
    struct OCRResult {
        var totalGames: Int?
        var totalBonus: Int?
    }
    
    //    func scanImage(uiImage: UIImage, completion: @escaping (OCRResult) -> Void) {
    //        print("OCR開始: 画像サイズ \(uiImage.size)") // ← 呼ばれたか確認
    //        guard let cgImage = uiImage.cgImage else {
    //            print("エラー: CGImageの生成に失敗")
    //            return
    //        }
    //
    //        var results = OCRResult()
    //
    //        let request = VNRecognizeTextRequest { request, error in
    //            if let error = error {
    //                print("Visionエラー: \(error.localizedDescription)")
    //                return
    //            }
    //
    //            guard let observations = request.results as? [VNRecognizedTextObservation] else {
    //                print("結果が空でした")
    //                return
    //            }
    //
    //            print("認識されたブロック数: \(observations.count)") // ← 何か見つかったか確認
    //
    //            // 取得結果を配列に変換
    //            // topCandidates(1)：最も自信のある文字1つだけを抽出
    //            // compactMap: 変換: 各ブロックを「一番精度の高いテキスト候補」に変換します。&除去: もし文字がうまく読み取れず、中身が空っぽ（nil）だったブロックがあれば、それを自動的に取り除いて詰めてくれます。
    //
    //            let allLines = observations.compactMap { $0.topCandidates(1).first }
    //
    //            for (index, line) in allLines.enumerated() {
    //                print("読み取りテキスト: \(line.string)") // ← 全テキストをコンソールに吐き出す
    //
    //                let text = line.string
    //                if text.contains("総プレイ数") {
    //                    if let value = self.extractNumber(from: allLines, currentIndex: index) {
    //                        results.totalGames = Int(value)
    //                        print("★総ゲーム数発見: \(value)")
    //                    }
    //                }
    //
    //                if text.contains("総ボーナス") {
    //                    if let value = self.extractNumber(from: allLines, currentIndex: index) {
    //                        results.totalBonus = Int(value)
    //                    }
    //                }
    //            }
    //            completion(results)
    //        }
    //
    //        request.recognitionLevel = .accurate
    //        request.recognitionLanguages = ["ja-JP"]
    //
    //        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
    //
    //        // 非同期実行
    //        DispatchQueue.global(qos: .userInitiated).async {
    //            do {
    //                try handler.perform([request])
    //                print("handler.perform 実行完了") // ← 実行自体は終わったか確認
    //            } catch {
    //                print("解析実行エラー: \(error)")
    //            }
    //        }
    //    }
    
    func scanImage(uiImage: UIImage, completion: @escaping (OCRResult) -> Void) {
        guard let cgImage = uiImage.cgImage else { return }
        var results = OCRResult()
        
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            // 1. 全てのデータを解析結果として保持（テキスト + 座標）
            let allResults = observations.compactMap { observation -> (text: String, minX: CGFloat, minY: CGFloat, maxX: CGFloat, maxY: CGFloat)? in
                guard let candidate = observation.topCandidates(1).first else { return nil }
                // 座標を取得（0.0〜1.0の範囲）
                return (
                    text: candidate.string,
                    minX: observation.boundingBox.minX,
                    minY: observation.boundingBox.minY,
                    maxX: observation.boundingBox.maxX,
                    maxY: observation.boundingBox.maxY,
                )
            }
            
            let imgHeight = uiImage.size.height // 画像のピクセル高さ
            let imgWidth = uiImage.size.width   // 画像のピクセル幅
            
            for (index, item) in allResults.enumerated() {
                let minPixX = Int(imgWidth * item.minX)
                let minPixY = Int(imgWidth * item.minY)
                let maxPixX = Int(imgWidth * item.maxX)
                let maxPixY = Int(imgWidth * item.maxY)
                                    print("index\(index): \(item.text), minX: \(minPixX), minY: \(minPixY), maxX: \(maxPixX), maxY: \(maxPixY)")
                // --- 総プレイ数の抽出 ---
                if item.text.contains("総プレイ数") {
                    // 「総プレイ数」と同じ高さにある別のテキストを探す
                    let sameRowText = allResults.first { otherItem in
                        // 自分自身ではなく、かつ高さ(Y座標)がほぼ同じものを探す
                        abs(otherItem.minY - item.minY) < 0.01 && otherItem.text != item.text
                    }
                    
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        results.totalGames = Int(filtered)
                        print("★一致する高さで発見(総プレイ数): \(target.text) -> \(filtered)")
                    }
                }
                
                // --- 総ボーナスの抽出 ---
                if item.text.contains("総ボーナス") {
                    let sameRowText = allResults.first { otherItem in
                        abs(otherItem.minY - item.minY) < 0.01 && otherItem.text != item.text
                    }
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        results.totalBonus = Int(filtered)
                        print("★一致する高さで発見(総ボーナス): \(target.text) -> \(filtered)")
                    }
                }
                
                // --- ドンBB回数の抽出 ---
                if item.text.contains("ドンBB") {
                    let sameRowText = allResults.first { otherItem in
                        abs(otherItem.minY - item.minY) < 0.01 && otherItem.text != item.text
                    }
                    if let target = sameRowText {
                        let filtered = target.text.filter { "0123456789".contains($0) }
                        results.totalBonus = Int(filtered)
                        print("★一致する高さで発見(ドンBB回数): \(target.text) -> \(filtered)")
                    }
                }
                
                // --- 赤7回数の抽出 ---
                if item.text.contains("赤七BB") {
                    let sameRowText = allResults.first { otherItem in
                        abs(otherItem.minY - item.minY) < 0.01 &&
                        otherItem.text != item.text &&
                        item.minY > otherItem.minY &&
                        otherItem.minX > 0.5
                    }
                    if let target = sameRowText {
                        if let probValue = self.extractProbability(from: target.text) {
                            // resultsにDouble型の変数を追加しておくとスムーズです
                            // 例: results.aka7Probability = probValue
                            print("★一致する高さで発見(赤7BB分母): \(target.text) -> \(probValue)")
                        }
                    }
                }
            }
            completion(results)
        }
        
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ja-JP"]
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        try? handler.perform([request])
    }
    
    // 近くのテキストから数字だけを抽出する補助関数
    private func extractNumber(from lines: [VNRecognizedText], currentIndex: Int) -> Double? {
        // ターゲットの文字列自体に含まれている数字か、次の要素にある数字をチェック
        let searchText = lines[currentIndex].string
        let filtered = searchText.filter { "0123456789".contains($0) }
        
        if let num = Double(filtered) { return num }
        
        // 次の行も確認（レイアウト対策）
        if currentIndex + 1 < lines.count {
            let nextText = lines[currentIndex + 1].string
            let nextFiltered = nextText.filter { "0123456789".contains($0) }
            return Double(nextFiltered)
        }
        return nil
    }
    
    private func extractProbability(from text: String) -> Double? {
        // 正規表現の解説:
        // 1/ の後にある、数字とドット（小数点）の組み合わせを探す
        // ([0-9.]+) -> 数字またはドットが1回以上続く部分をキャプチャ
        let pattern = #"1/([0-9.]+)"#
        
        if let regex = try? NSRegularExpression(pattern: pattern),
           let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)) {
            
            // キャプチャしたグループ（([0-9.]+)の部分）を取り出す
            if let range = Range(match.range(at: 1), in: text) {
                let numberString = String(text[range])
                return Double(numberString)
            }
        }
        return nil
    }
}

struct ocrTest: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var previewImage: UIImage? // プレビューテスト用
    
    var body: some View {
        List {
            Section {
                
            }
            // ボタンなどのアクション内
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Label("画像から入力", systemImage: "camera.viewfinder")
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        
                        OCRService().scanImage(uiImage: uiImage) { result in
                            DispatchQueue.main.async {
                                // 読み取り成功した数値があれば更新
                                if let games = result.totalGames {
                                    // 例: common.totalGameCount = games
                                    print("総ゲーム数を更新: \(games)")
                                }
                            }
                        }
                    }
                }
            }
            
            // 【デバッグ用】プレビュー時のみ表示される直接ボタン
#if DEBUG
            Button("【テスト】Assetsの画像で解析") {
                // Assets.xcassets に "ocrTest" という名前の画像がある前提
                if let img = UIImage(named: "ocrTest") {
                    self.previewImage = img // 必要なら画面表示用に保持
                    // 直接解析関数を呼ぶ！
                    OCRService().scanImage(uiImage: img) { result in
                        DispatchQueue.main.async {
                            // 読み取り成功した数値があれば更新
                            if let games = result.totalGames {
                                // 例: common.totalGameCount = games
                                print("総ゲーム数を更新: \(games)")
                            }
                        }
                    }
                } else {
                    print("画像 'ocrTest' がAssetsに見つかりません")
                }
            }
            .padding()
            .background(Color.orange.opacity(0.2))
            Image("ocrTest")
#endif
        }
    }
}

#Preview {
    ocrTest()
}
