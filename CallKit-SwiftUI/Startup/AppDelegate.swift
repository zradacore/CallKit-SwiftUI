//
//  AppDelegate.swift
//  CallKit-SwiftUI
//
//  Created by Владимир Никитин on 22.09.2023.
//

import Foundation
import CallKit
import PushKit
import UIKit


class AppDelegate: NSObject, UIApplicationDelegate {

    let pushRegistry = PKPushRegistry(queue: DispatchQueue.main)
    let callManager = CallManager(callActions: CallActions())
    var providerDelegate: ProviderDelegate?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        pushRegistry.delegate = self
        pushRegistry.desiredPushTypes = [.voIP]
        
        providerDelegate = ProviderDelegate(callManager: callManager)
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: PKPushRegistryDelegate {
    // MARK: PKPushRegistryDelegate
    func pushRegistry(_ registry: PKPushRegistry, didUpdate credentials: PKPushCredentials, for type: PKPushType) {
        // Store push credentials on server for the active user. If you want `String` value of the token, use `Data().toHexString()`
        // Register device token to your server.
    }
    
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType) {
        // Handle incoming push with payload
    }
    
    //
    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
        
        // handle incoming push with payload
        // If Call UUID is invalid, call `reportInvalidIncomingCall(completion:)` method
        completion()
    }
    
    func reportInvalidIncomingCall(completion: () -> Void) {
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: "invalid")
        let randomUUID = UUID()
        
        self.providerDelegate?.reportIncomingCall(with: randomUUID)
        completion()
    }
    
  
}
