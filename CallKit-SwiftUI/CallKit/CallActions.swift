//
//  CallActions.swift
//  CallKit-SwiftUI
//
//  Created by Владимир Никитин on 22.09.2023.
//

import Foundation
import CallKit
import Combine

final class CallActions{
    let callController = CXCallController()
    
    //Create transaction request
    private func requestTransaction(_ transaction: CXTransaction, completionHandler: ErrorHandler?){
        callController.request(transaction) { error in
            guard error == nil else{
                print("Error requesting transaction: \(error?.localizedDescription ?? "")")
                completionHandler?(error as NSError?)
                return
            }
            print("Requested transaction successfully")
            completionHandler?(nil)
        }
    }
    
    
    //Start call with call id
    func startCall(with uuid: UUID, receiverID: String, hasVideo: Bool, completionHandler: ErrorHandler? = nil){
        let handle = CXHandle(type: .generic, value: receiverID)
        
        let startCallAction = CXStartCallAction(call: uuid, handle: handle)
        startCallAction.isVideo = hasVideo
        
        let transaction = CXTransaction(action: startCallAction)
        requestTransaction(transaction, completionHandler: completionHandler)
    }
    
    //End call with call id
    func endCall(with uuid: UUID, completionHandler: ErrorHandler?){
        let endCallAction = CXEndCallAction(call: uuid)
        
        let transaction = CXTransaction(action: endCallAction)
        requestTransaction(transaction, completionHandler: completionHandler)
    }
    
    //Set held call (удержанный)
    func setHeldCall(with uuid: UUID, onHold: Bool, completionHandler: ErrorHandler?){
        let setHeldCallAction = CXSetHeldCallAction(call: uuid, onHold: onHold)
        
        let transaction = CXTransaction(action: setHeldCallAction)
        requestTransaction(transaction, completionHandler: completionHandler)
    }
    
    
    func muteCall(with uuid: UUID, muted: Bool, completionHandler: ErrorHandler?){
        let muteCallAction = CXSetMutedCallAction(call: uuid, muted: muted)
        
        let transaction = CXTransaction(action: muteCallAction)
        requestTransaction(transaction, completionHandler: completionHandler)
    }
    
    
    
    
    
}
