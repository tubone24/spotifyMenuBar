//
//  AppDelegate.swift
//  SpotifyMenuBar
//
//  Created by Yu Otsubo on 2020/09/29.
//  Copyright © 2020 tubone24. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    //Outlet
    @IBOutlet weak var menu: NSMenu!

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application


        // icon image
        self.statusItem.button?.image = NSImage(imageLiteralResourceName: "menuBarIcon")
        
        // todo
        self.statusItem.highlightMode = true
        //メニューの指定
        self.statusItem.menu = menu


        // Quit App
        let quitItem = NSMenuItem()
        
        quitItem.title = "Quit Application"
        
        quitItem.action = #selector(AppDelegate.quit(_:))
        
        menu.addItem(quitItem)

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func quit(_ sender: Any){
        
        NSApplication.shared.terminate(self)
    }
}


