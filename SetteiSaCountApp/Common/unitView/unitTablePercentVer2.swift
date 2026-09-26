//
//  unitTablePercentVer2.swift
//  SetteiSaCountApp
//
//  unitTablePercent のリファクタリング版。引数・見た目は unitTablePercent と同じ。
//  特殊値（-1 ＝「?」など）の表示は markText(for:) の switch にまとめてあるので、
//  新しい記号を増やすときは case を1つ足すだけでよい。
//

import SwiftUI

struct unitTablePercentVer2: View {
    var columTitle: String
    var percentList: [Double]
    var numberofDicimal: Int = 0
    var aboutBool: Bool = false
    var maxWidth: CGFloat = 150.0
    var titleLine: Int = 1
    var lineList: [Int] = [1,1,1,1,1,1]
    var titleFont: Font = .body
    var contentFont: Font = .title3
    var colorList: [Color]?
    let valueHstackSpacing: CGFloat = 2
    let unitFont: Font = .caption
    let horizontalPadding: CGFloat = 3.0
    let lineHeight: CGFloat = 29

    // 空欄セルを表す特殊値（背景をグレーにする）
    static let blankValue: Double = -100

    var body: some View {
        VStack(spacing: 0) {
            titleCell
            ForEach(self.percentList.indices, id: \.self) { index in
                valueCell(value: self.percentList[index])
                    .frame(height: rowHeight(index: index))
                    .frame(maxWidth: self.maxWidth)
                    .padding(.horizontal, self.horizontalPadding)
                    .background(backColor(index: index))
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.black, lineWidth: 1)
                    )
            }
        }
    }

    // //// 列タイトル（空文字なら透明の枠だけ置いて高さを揃える）
    private var titleCell: some View {
        let hasTitle = !self.columTitle.isEmpty
        return Text(hasTitle ? self.columTitle : " ")
            .multilineTextAlignment(.center)
            .frame(height: self.lineHeight * CGFloat(self.titleLine))
            .frame(maxWidth: self.maxWidth)
            .padding(.horizontal, self.horizontalPadding)
            .foregroundStyle(hasTitle ? Color.white : Color.clear)
            .fontWeight(.bold)
            .background(hasTitle ? Color.columnTitle : Color.clear)
            .font(self.titleFont)
            .minimumScaleFactor(0.7)
            .overlay(
                RoundedRectangle(cornerRadius: 0)
                    .stroke(hasTitle ? Color.black : Color.clear, lineWidth: 1)
            )
    }

    // //// 値セルの中身
    @ViewBuilder
    private func valueCell(value: Double) -> some View {
        HStack(spacing: self.valueHstackSpacing) {
            if let mark = Self.markText(for: value) {
                boldText(mark)
            } else if value > 0 && value <= 100 {
                if self.aboutBool {
                    Text("約")
                        .foregroundStyle(Color.black)
                        .font(self.unitFont)
                }
                boldText(String(format: "%.\(self.numberofDicimal)f", value))
                Text("%")
                    .foregroundStyle(Color.black)
                    .font(self.unitFont)
                    .minimumScaleFactor(0.7)
            } else {
                // switch に無い特殊値
                boldText("?")
            }
        }
    }

    private func boldText(_ text: String) -> some View {
        Text(text)
            .fontWeight(.bold)
            .font(self.contentFont)
            .foregroundStyle(Color.black)
            .minimumScaleFactor(0.7)
    }

    // //// 特殊値 → 表示する記号（nil のときは数値として表示）
    // 特殊値は「0未満」か「100超」に割り当てる。確率として取りえない範囲なので、実際の数値とぶつからない。
    // 新しい記号を増やすときは case を1つ足すだけでよい。
    static func markText(for value: Double) -> String? {
        switch value {
        case 0: return "-"
        case -1: return "?"          // 非公開
        case -10: return "天井"
        case -80: return "↓"
        case -90: return "★"
        case 1000: return "濃厚"
        case blankValue: return ""   // 空欄（背景はグレー）
        default: return nil
        }
    }

    // //// 行の高さ（lineList で行ごとに何行分にするか指定できる）
    private func rowHeight(index: Int) -> CGFloat {
        let lines = self.lineList.indices.contains(index) ? self.lineList[index] : 1
        return self.lineHeight * CGFloat(lines)
    }

    // //// 背景色（colorList 指定があれば優先。なければ縞模様、空欄セルはグレー）
    private func backColor(index: Int) -> Color {
        if let colorList = self.colorList {
            return colorList.indices.contains(index) ? colorList[index] : .white
        }
        if self.percentList[index] == Self.blankValue {
            return .gray
        }
        return index % 2 == 0 ? Color.tableBlue : Color.white
    }
}

#Preview {
    HStack(spacing: 0) {
        unitTableSettingIndex()
        unitTablePercentVer2(
            columTitle: "Ver2",
            percentList: [12.5, 0, -1, -10, -80, -90],
            numberofDicimal: 1
        )
        unitTablePercent(
            columTitle: "旧",
            percentList: [12.5, 0, -1, -10, -80, -90],
            numberofDicimal: 1
        )
    }
    .padding(.horizontal)
}
