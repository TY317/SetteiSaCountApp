import SwiftUI
import Combine

struct AutoGameCountModifier: ViewModifier {
    @Binding var isAutoCountOn: Bool
    @Binding var currentGames: Int
    @Binding var nextAutoCountDate: Date?
    var interval: TimeInterval
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    init(isAutoCountOn: Binding<Bool>, currentGames: Binding<Int>, nextAutoCountDate: Binding<Date?>, interval: TimeInterval = 4.1) {
        self._isAutoCountOn = isAutoCountOn
        self._currentGames = currentGames
        self._nextAutoCountDate = nextAutoCountDate
        self.interval = interval
        self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
    }
    
    func body(content: Content) -> some View {
        content
            .onReceive(timer) { _ in
                if isAutoCountOn {
                    if let next = nextAutoCountDate {
                        if Date() >= next {
                            currentGames += 1
                            nextAutoCountDate = Date().addingTimeInterval(interval)
                        }
                    } else {
                        nextAutoCountDate = Date().addingTimeInterval(interval)
                    }
                }
            }
    }
}

extension View {
    func autoGameCount(isOn: Binding<Bool>, currentGames: Binding<Int>, nextDate: Binding<Date?>, interval: TimeInterval = 4.1) -> some View {
        self.modifier(AutoGameCountModifier(isAutoCountOn: isOn, currentGames: currentGames, nextAutoCountDate: nextDate, interval: interval))
    }
}

//#Preview {
//    struct PreviewView: View {
//        @State private var isCounting = false
//        @State private var games = 0
//        @State private var nextDate: Date? = nil
//        
//        var body: some View {
//            VStack(spacing: 20) {
//                Text("Games: \(games)")
//                    .font(.title)
//                Button(isCounting ? "Stop Counting" : "Start Counting") {
//                    isCounting.toggle()
//                    if !isCounting {
//                        nextDate = nil
//                    }
//                }
//            }
//            .padding()
//            .autoGameCount(isOn: $isCounting, currentGames: $games, nextDate: $nextDate)
//        }
//    }
//    PreviewView()
//}
