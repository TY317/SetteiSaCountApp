//
//  unitLinkSectionDMM.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/15.
//

import SwiftUI
import TipKit

struct unitLinkSectionDMM: View {
    var urlString: String
    let hstackSpacing: CGFloat = 15.0
    let rectangleColor: Color = Color(uiColor: .systemGray2)
    let rectangleCornerRadius: CGFloat = 6.0
    let rectanglePadding: CGFloat = 2.5
    let sfSymbolName: String = "link"
    let sfSymbolColor: Color = Color.white
    let sfSymbolSize: CGFloat = 20.0
    let zstackSize: CGFloat = 35.0
    let menuTitle: String = "解析サイトへのリンク"
    let footerText: String = "※ 外部リンクです。本アプリとの関係はありません"
    
    var body: some View {
        Section {
            VStack {
                HStack(spacing: self.hstackSpacing) {
                    ZStack {
                        Rectangle()
                            .foregroundStyle(self.rectangleColor)
                            .cornerRadius(self.rectangleCornerRadius)
                            .padding(self.rectanglePadding)
                        Image(systemName: self.sfSymbolName)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(self.sfSymbolColor)
                            .frame(width: self.sfSymbolSize, height: self.sfSymbolSize, alignment: .center)
                    }
                    .frame(width: self.zstackSize, height: self.zstackSize)
                    VStack {
                        Link(destination: URL(string: self.urlString)!) {
                            Text(self.menuTitle)
                        }
                    }
                    Spacer()
                }
            }
            .padding(.vertical, -10.0)
        } footer: {
            Text(self.footerText)
        }
    }
}

//#Preview {
//    unitLinkSectionDMM()
//}
