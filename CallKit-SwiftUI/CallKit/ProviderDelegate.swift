//
//  ProviderDelegate.swift
//  CallKit-SwiftUI
//
//  Created by Владимир Никитин on 22.09.2023.
//

import AVFoundation
import UIKit
import CallKit

extension Notification.Name{
    static let DidCallEnd = Notification.Name("DidCallEnd")
    
    static let DidCallAccepted = Notification.Name("DidCallAccepted")
}

class ProviderDelegate: NSObject, CXProviderDelegate, CXCallObserverDelegate{
   
    let callManager: CallManager
    private let provider: CXProvider
    
    init(callManager: CallManager) {
        self.callManager = callManager
        provider = CXProvider(configuration: CXProviderConfiguration())
        
        super.init()
        
        provider.setDelegate(self, queue: nil)
    }
    
    func reportIncomingCall(with uuid: UUID, remoteUserID: String, hasVideo: Bool, completionHandler: ErrorHandler? = nil) {
        // Update call based on DirectCall object
        let update = CXCallUpdate()
        update.update(with: remoteUserID, hasVideo: hasVideo, incoming: true)
        
        provider.reportNewIncomingCall(with: uuid, update: update) { error in
            guard error == nil else {
                completionHandler?(error as NSError?)
                return
            }
            
            // Add call to call manager
            self.callManager.addCall(uuid: uuid)
        }
    }
    
    
    //observe call duration
    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        if call.isOutgoing && call.hasConnected {
                
               }
        
        if call.hasEnded {
                
            }
    }
    
    
    
    func reportIncomingCall(with uuid: UUID) {
        // Update call based on DirectCall object
        let update = CXCallUpdate()
        update.onFailed(with: uuid)
        
        provider.reportNewIncomingCall(with: uuid, update: update) { error in
            self.provider.reportCall(with: uuid, endedAt: Date(), reason: .failed)
        }
    }
    
    func endCall(with uuid: UUID, endedAt: Date, reason: CXCallEndedReason) {
        self.provider.reportCall(with: uuid, endedAt: endedAt, reason: reason)
    }
    
    func connectedCall(with uuid: UUID) {
        self.provider.reportOutgoingCall(with: uuid, connectedAt: Date())
    }
    
    
    func providerDidReset(_ provider: CXProvider) {
        self.callManager.removeAllCalls()
    }
    
    // configure audio session
    func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        
        
      
        self.callManager.addCall(uuid: action.callUUID)
        self.connectedCall(with: action.callUUID)
        
        action.fulfill()
    }
    
    // Accept call
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        
        
        NotificationCenter.default.post(name: NSNotification.Name.DidCallAccepted, object: nil)

        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        
        // 1. Stop audio
        
        // 2. End call
        NotificationCenter.default.post(name: NSNotification.Name.DidCallEnd, object: nil)
        
        action.fulfill()
        
        // 3. Remove the ended call from callManager.
        self.callManager.removeAllCalls()
    }
    
    func provider(_ provider: CXProvider, perform action: CXSetHeldCallAction) {
        // update holding state
        switch action.isOnHold {
        case true:
            // Stop audio
            // Stop video
            action.fulfill()
        case false:
            // Play audio
            // Play video
            action.fulfill()
        }
    }
    
    func provider(_ provider: CXProvider, perform action: CXSetMutedCallAction) {

        // Stop / start audio by using `action.isMuted`
        
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
        // Start audio
    }
    
    func provider(_ provider: CXProvider, didDeactivate audioSession: AVAudioSession) {
        // Restart any non-call related audio now that the app's audio session has been
        // de-activated after having its priority restored to normal.
    }
    
}
