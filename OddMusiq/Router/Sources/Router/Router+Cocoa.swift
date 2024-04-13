

import SwiftUI

public protocol SwiftUIDestination: Destination {
    func view() -> any SwiftUI.View
}

#if canImport(Cocoa)
import Cocoa
public class CocoaRouter: Router {
    weak var window: NSWindow?
    
    public init(window: NSWindow) {
        self.window = window
    }
    
    public func route(to destination: any Destination) {
        guard let destination = destination as? SwiftUIDestination else {
            fatalError()
        }
        let rootView = destination.view()
        window?.contentView = NSHostingView(rootView: AnyView(rootView))
    }
    
//    public func route(to destination: any SwiftUIDestination) {
//        let rootView = destination.view()
//        window?.contentView = NSHostingView(rootView: AnyView(rootView))
//    }
}

#endif
