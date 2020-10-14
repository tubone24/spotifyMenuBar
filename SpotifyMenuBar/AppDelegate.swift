//
//  AppDelegate.swift
//  SpotifyMenuBar
//
//  Created by Yu Otsubo on 2020/09/29.
//  Copyright © 2020 tubone24. All rights reserved.
//

import Cocoa
import SpotifyKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBAction func authorize(_ sender: Any) {
        spotifyManager.authorize()
    }
    @IBAction func deauthorize(_ sender: Any) {
        spotifyManager.deauthorize()
    }
    
    //Outlet
    @IBOutlet weak var menu: NSMenu!
    
    let spotifyManager = SpotifyManager(with:
        SpotifyManager.SpotifyDeveloperApplication(
            clientId:     "d42df9084ede4a6f95131a31a641cbd8",
            clientSecret: "0090a1db6b7f46a2938792bef6bcbcce",
            redirectUri:  "spotifymenubar://callback"
        )
    )

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        self.initEventManager()
        
        
        // icon image
        self.statusItem.button?.image = NSImage(imageLiteralResourceName: "menuBarIcon")
        
        // todo
        self.statusItem.highlightMode = true
        //メニューの指定
        self.statusItem.menu = menu
        
        // Next
        let nextItem = NSMenuItem()
        
        nextItem.title = "Next"
        
        nextItem.action = #selector(AppDelegate.quit(_:))
        
        menu.addItem(nextItem)

        // Play/pause
        let playItem = NSMenuItem()
        
        playItem.title = "Play/Pause"
        
        playItem.action = #selector(AppDelegate.quit(_:))
        
        menu.addItem(playItem)
        
        // Previous
        let previousItem = NSMenuItem()
        
        previousItem.title = "Previous"
        
        previousItem.action = #selector(authorize)
        
        menu.addItem(previousItem)

        // Quit App
        let quitItem = NSMenuItem()
        
        quitItem.title = "Quit Application"
        
        quitItem.action = #selector(AppDelegate.quit(_:))
        
        menu.addItem(quitItem)
        
        self.spotifyManager.deauthorize()
        self.spotifyManager.authorize()

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func initEventManager() {
        NSAppleEventManager.shared().setEventHandler(self,
                                                     andSelector: #selector(handleURLEvent),
                                                     forEventClass: AEEventClass(kInternetEventClass),
                                                     andEventID: AEEventID(kAEGetURL))
    }
    //うまく行かない
    @objc func handleURLEvent(event: NSAppleEventDescriptor,
                              replyEvent: NSAppleEventDescriptor) {
        if  let descriptor = event.paramDescriptor(forKeyword: keyDirectObject),
            let urlString  = descriptor.stringValue,
            let urlComponents = URLComponents(string: urlString),
            let queryItems    = (urlComponents.queryItems as [NSURLQueryItem]?) {
            let code = queryItems.filter({ (item) in item.name == "code" }).first?.value!
            if let authorizationCode = code {
                NSLog(code!)
                spotifyManager.saveToken(from: authorizationCode)
            }
        }
    }

    @objc func quit(_ sender: Any){
        
        NSApplication.shared.terminate(self)
    }
}



