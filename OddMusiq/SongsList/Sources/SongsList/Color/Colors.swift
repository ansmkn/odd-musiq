import Foundation

enum Theme {
    case light
}

// TODO: create macro for direct use the return type without convertion
struct RGBAColor {
    var hex: UInt64
    var opacity: Double
    
    init(hex: UInt64, opacity: Double = 1.0) {
        self.hex = hex
        self.opacity = opacity
    }
}

var Colors = ColorProvider.shared

class ColorProvider {
    static let shared = ColorProvider(theme: .light)
    
    var theme: Theme
    init(theme: Theme) {
        self.theme = theme
    }
    
    var primaryBackground: RGBAColor {
        RGBAColor(hex: 0xFFFFFF)
    }
    
    var secondaryBackground: RGBAColor {
        RGBAColor(hex: 0x282C33, opacity: 0.5)
    }
    
    var primaryForeground: RGBAColor {
        RGBAColor(hex: 0xFFFFFF)
    }
    
    var accent: RGBAColor {
        RGBAColor(hex: 0xD0021B)
    }
}
