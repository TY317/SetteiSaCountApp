import SwiftUI

public struct UnitToolbarButtonCountDirectInputEnumFocus<Field: Hashable, Content: View>: View {
    @ViewBuilder public var inputView: () -> Content
    public var focus: FocusState<Field?>.Binding
    @State private var isShowInputView: Bool = false
    @Environment(\.dismiss) private var dismiss

    public init(
        focus: FocusState<Field?>.Binding,
        @ViewBuilder inputView: @escaping () -> Content
    ) {
        self.focus = focus
        self.inputView = inputView
    }

    public var body: some View {
        Button {
            isShowInputView.toggle()
        } label: {
            Image(systemName: "keyboard")
        }
        .sheet(isPresented: $isShowInputView) {
            NavigationStack {
                List {
                    Section {
                        inputView()
                    }
                }
                .navigationTitle("カウント値 直接入力")
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button(action: {
                            self.isShowInputView = false
                        }, label: {
                            Text("閉じる")
                                .fontWeight(.bold)
                        })
                    }
//                    ToolbarItemGroup(placement: .keyboard) {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button(action: {
                                self.focus.wrappedValue = nil
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }, label: {
                                Text("完了")
                                    .fontWeight(.bold)
                            })
                        }
//                        Spacer()
//                        Button("完了") {
//                            self.focus.wrappedValue = nil
//                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                        }
                    }
                }
            }
        }
    }
}

#Preview {
    enum PField: Hashable { case sample }
    struct Demo: View {
        @FocusState private var f: PField?
        @State private var v: Int = 0
        var body: some View {
            VStack(spacing: 16) {
                TextField("Value", value: $v, format: .number)
                    .keyboardType(.numberPad)
                    .focused($f, equals: .sample)
                UnitToolbarButtonCountDirectInputEnumFocus<PField, AnyView>(focus: $f) {
                    AnyView(
                        VStack {
                            Text("Sheet")
                            TextField("Sheet Value", value: $v, format: .number)
                                .keyboardType(.numberPad)
                                .focused($f, equals: .sample)
                        }
                        .padding()
                    )
                }
            }
            .padding()
        }
    }
    return Demo()
}

