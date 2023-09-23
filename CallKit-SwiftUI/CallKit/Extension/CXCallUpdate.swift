//
//  CXCallUpdate.swift
//  CallKit-SwiftUI
//
//  Created by Владимир Никитин on 22.09.2023.
//

import Foundation
import CallKit

extension CXCallUpdate{
    func update(with remoteUserId: String, hasVideo: Bool, incoming: Bool){
        // другой вызывающий абонент идентифицируется объектом CXHandle
        
        let remoteHandle = CXHandle(type: .generic, value: remoteUserId)
        
        self.remoteHandle = remoteHandle
        self.localizedCallerName = remoteUserId
        self.hasVideo = hasVideo
    }
    
    func onFailed(with uuid: UUID){
        let remoteHandle = CXHandle(type: .generic, value: "Uknown")
        
        self.remoteHandle = remoteHandle
        self.localizedCallerName = "Uknown"
        self.hasVideo = false
    }
}
