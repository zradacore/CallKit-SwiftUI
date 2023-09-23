//
//  CallKit_SwiftUIApp.swift
//  CallKit-SwiftUI
//
//  Created by Владимир Никитин on 22.09.2023.
//

import SwiftUI

@main
struct CallKit_SwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
