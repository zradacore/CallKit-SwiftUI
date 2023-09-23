//
//  IncomingInterfaceView.swift
//  CallKit-SwiftUI
//
//  Created by Владимир Никитин on 22.09.2023.
//

import Foundation
import SwiftUI
import CallKit

struct IncomingInterfaceView: View {
    @EnvironmentObject var callManager: CallManager
    
    @Binding var hasActivateCall: Bool
    @Binding var callID: UUID?
    @Binding var receiverName: String
    @State var providerDelegate: ProviderDelegate?
    
    let acceptPublishser = NotificationCenter.default
        .publisher(for: Notification.Name.DidCallAccepted)
    
    var body: some View {
        HStack {
            // MARK: Voice Call
            Button(action: {
                self.receiveCall(from: receiverName, hasVideo: false)
            }) {
                Image(systemName: "phone.arrow.down.left")
            }
        }
        .onReceive(self.acceptPublishser) { _ in
            self.hasActivateCall = true
            self.providerDelegate?.connectedCall(with: self.callID!)
        }
    }
    
    func receiveCall(from callerID: String, hasVideo: Bool) {
        providerDelegate = ProviderDelegate(callManager: callManager)
        
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: callerID)
        let uuid = UUID()
        self.callID = uuid
        
        self.providerDelegate?.reportIncomingCall(with: uuid, remoteUserID: callerID, hasVideo: hasVideo) { error in
            if let error = error { print(error.localizedDescription) }
            else { print("Ring Ring...") }
        }
    }
}
