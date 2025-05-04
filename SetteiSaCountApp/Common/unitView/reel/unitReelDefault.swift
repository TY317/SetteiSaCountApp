//
//  unitReelDefault.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/03.
//

import SwiftUI

struct unitReelDefault: View {
    let reelWidth: CGFloat = 60
    let reel1KomaHeigt: CGFloat = 40
    var body: some View {
        Rectangle()
            .frame(maxWidth: self.reelWidth)
            .frame(height: self.reel1KomaHeigt)
//            .frame(maxWidth: self.reelWidth, maxHeight: self.reel1KomaHeigt)
            .foregroundStyle(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 0) // 四角の輪郭
                    .stroke(Color.black, lineWidth: 1) // 黒色の線を追加
            )
    }
}

#Preview {
    unitReelDefault()
}
