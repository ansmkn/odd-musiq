import SwiftUI

extension RGBAColor {
    func asColor() -> Color {
        let r = Double((hex >> 16) & 0xFF) / 255.0
        let g = Double((hex >> 8) & 0xFF) / 255.0
        let b = Double(hex & 0xFF) / 255.0
        return SwiftUI.Color(red: r, green: g, blue: b, opacity: opacity)
    }
}
