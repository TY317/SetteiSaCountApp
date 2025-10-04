#if canImport(UIKit)
import UIKit

extension UIApplication {
    /// Force-resign first responder to dismiss the keyboard from anywhere.
    @MainActor
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
