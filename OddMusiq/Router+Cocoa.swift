import Router

#if canImport(Cocoa)
import Cocoa

class CocoaRouter: Router {
    weak var window: NSWindow?
    
    init(window: NSWindow) {
        self.window = window
    }
    
    func route(to destination: any Destination) {
        fatalError()
    }
}

#endif
