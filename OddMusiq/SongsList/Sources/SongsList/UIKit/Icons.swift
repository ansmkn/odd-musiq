
struct ProvidedIcon {
    var name: String
    init(name: String) {
        self.name = name
    }
}

let Icons = IconsProvider.shared

class IconsProvider {
    
    static let shared = IconsProvider(theme: .light)
    
    var theme: Theme
    init(theme: Theme) {
        self.theme = theme
    }
    
    var pause: ProvidedIcon {
        ProvidedIcon(name: "pause-icon")
    }
    
    var play: ProvidedIcon {
        ProvidedIcon(name: "play-icon")
    }
    
    var download: ProvidedIcon {
        ProvidedIcon(name: "download-icon")
    }
    
}
#if canImport(UIKit)
import UIKit

extension ProvidedIcon {
    var uiImage: UIImage {
        UIImage(named: name, in: Bundle.module, with: nil)!
    }
}

#endif

import SwiftUI

extension ProvidedIcon {
    var image: SwiftUI.Image {
        Image(name, bundle: Bundle.module)
    }
}
