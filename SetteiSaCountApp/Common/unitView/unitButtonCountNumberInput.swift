//
//  unitButtonCountNumberInput.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/03.
//

import SwiftUI

struct unitButtonCountNumberInput: View {
    @State private var isShowInputView: Bool = false
    @State var inputView: AnyView
    var body: some View {
        Button {
            self.isShowInputView.toggle()
        } label: {
            Image(systemName: "keyboard")
        }
        .sheet(isPresented: self.$isShowInputView) {
            self.inputView
                .presentationDetents([.large])
        }
    }
}

#Preview {
    unitButtonCountNumberInput(
        inputView: AnyView(mrJugSubViewCountInput(
            mrJug: MrJug()
        ))
    )
}
