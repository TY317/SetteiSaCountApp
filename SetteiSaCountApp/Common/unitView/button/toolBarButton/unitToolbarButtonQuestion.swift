//
//  unitToolbarButtonQuestion.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/12.
//

import SwiftUI

struct unitToolbarButtonQuestion<destination: View>: View {
    @ViewBuilder var destination: () -> destination
    @State var isShowExView = false
    var detent: PresentationDetent = .medium
    
    var body: some View {
        Button {
            self.isShowExView.toggle()
        } label: {
            Image(systemName: "questionmark.circle")
        }
//        .popover(isPresented: self.$isShowExView) {
//            self.destination()
//        }
        .sheet(isPresented: self.$isShowExView) {
            self.destination()
                .presentationDetents([self.detent])
        }
        .buttonStyle(.automatic)
    }
}

#Preview {
    unitToolbarButtonQuestion() {
        Text("test")
    }
}
