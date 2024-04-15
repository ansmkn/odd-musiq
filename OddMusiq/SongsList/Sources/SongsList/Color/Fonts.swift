import Foundation
import SwiftUI

var Fonts = FontsProvider.shared

class ProvidedFont {
    var name: String
    var size: CGFloat
    
    init(name: String, size: CGFloat) {
        self.name = name
        self.size = size
    }
    
    func font() -> SwiftUI.Font {
        SwiftUI.Font.custom(name, size: size)
    }
}

class FontsProvider {
    static let shared = FontsProvider(theme: .light)
    
    var theme: Theme
    init(theme: Theme) {
        self.theme = theme
    }
    
    var primary: ProvidedFont {
        ProvidedFont(name: "Helvetica", size: 26)
    }
}

#if canImport(UIKit)
import UIKit

extension ProvidedFont {
    func asUIFont() -> UIFont {
        UIFont.init(name: name, size: size)!
    }
}


#endif
