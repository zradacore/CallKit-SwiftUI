//
//  CallManager.swift
//  CallKit-SwiftUI
//
//  Created by Владимир Никитин on 22.09.2023.
//

import Foundation
import CallKit
import Combine

typealias ErrorHandler = ((NSError?) -> ())


protocol CallManagerProtocol: ObservableObject{
    var callActions : CallActions! {get set}
    var callIDs : [UUID] {get}
    func addCall(uuid: UUID)
    func removeCall(uuid: UUID)
    func removeAllCalls()
}

class CallManager: NSObject, CallManagerProtocol{
    static let shared = CallManager(callActions: CallActions())
    
    var callActions: CallActions!
    private(set) var callIDs: [UUID] = []
    
    
    required init(callActions: CallActions) {
        self.callActions = callActions
    }
    
    //MARK: Call Management
    
    func addCall(uuid: UUID){
        self.callIDs.append(uuid)
    }
    
    func removeCall(uuid: UUID){
        self.callIDs.removeAll{ $0 == uuid}
    }
    
    func removeAllCalls(){
        self.callIDs.removeAll()
    }
    
    
    
    
    
    
    
}


