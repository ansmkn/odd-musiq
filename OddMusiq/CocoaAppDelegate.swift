import SwiftUI
import Router

#if os(macOS)

import Cocoa

class CocoaApplication: NSApplication {

    let strongDelegate = AppDelegate()

    override init() {
        super.init()
        self.delegate = strongDelegate
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var appCoordinator: AppCoordinator?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.makeKeyAndOrderFront(nil)
        
        appCoordinator = AppCoordinator(router: CocoaRouter(window: window))
        appCoordinator?.start()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

#endif
