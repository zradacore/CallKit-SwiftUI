//
//  DialView.swift
//  CallKit-SwiftUI
//
//  Created by Владимир Никитин on 22.09.2023.
//

import Foundation
import SwiftUI
import CallKit


struct DialView: View{
    
    // Access singletone
    @EnvironmentObject var callManager: CallManager
    
    @State var hasActivateCall : Bool = false
    @State var callID: UUID? = nil
    @State var receiverID: String = ""
    @State var receivers = Receiver.receivers
    @State var receiver : Receiver? = nil
    @State var providerDelegate: ProviderDelegate?
    let acceptPublishser = NotificationCenter.default
        .publisher(for: Notification.Name.DidCallAccepted)
   
    
    var body: some View{
        ZStack{
            VStack(alignment: .leading) {
                
                Text("Contact list").font(.title).fontWeight(.bold).padding()
                
                List(receivers) { receiver in
                    
                    VStack{
                        HStack{
                            Image(receiver.imageName).resizable().frame(width: 50, height: 50)
                            Text(receiver.name).font(.title3)
                            Spacer()
                            
                        }
                        
                        
                        HStack{
                            
                            Image(systemName: "phone.fill.arrow.up.right").resizable().frame(width: 25, height: 25).onTapGesture {
                                startCall(to: receiver, hasVideo: false)
                            }
                            .padding(.trailing)
                            
                            Button {
                                //Logic for video call
                            } label: {
                                Image(systemName: "video.fill").resizable().frame(width: 35, height: 25)
                            }.padding(.leading, 4)
                            
                            Spacer()
                          
                            Image(systemName: "phone.arrow.down.left").resizable().frame(width: 25, height: 25).onTapGesture {
                                receiveCall(from: receiver.name, hasVideo: false)
                                self.receiver = receiver
                            }
                            
                            
                        }.padding(.top, 5).foregroundColor(.black)
                        
                        
                    }
                }
                Spacer()
            }.background(Color(UIColor.secondarySystemBackground))
               
                    if hasActivateCall && receiver != nil{
                        ActiveCallView(hasActivateCall: $hasActivateCall, callID: $callID, receiver: $receiver)
                    }
            
        } .onReceive(self.acceptPublishser) { _ in
            self.hasActivateCall = true
            print("On receive accepted", hasActivateCall)
            self.providerDelegate?.connectedCall(with: self.callID!)
        }
    }
    
    
    func startCall(to receiver: Receiver, hasVideo: Bool) {
        
        
        let uuid = UUID()
        self.callID = uuid
        
        self.callManager.callActions.startCall(with: uuid, receiverID: receiver.id, hasVideo: hasVideo) { error in
            if let error = error { print(error.localizedDescription) }
            else {
                self.receiver = receiver
                self.hasActivateCall = true
            }
        }
    }
    
    func receiveCall(from caller: String, hasVideo: Bool) {
        providerDelegate = ProviderDelegate(callManager: callManager)
        
        print("1")
        let update = CXCallUpdate()
        print("2")
        update.remoteHandle = CXHandle(type: .generic, value: caller)
        print("3")
        let uuid = UUID()
        print("4")
        self.callID = uuid
        print("5")
        
        self.providerDelegate?.reportIncomingCall(with: uuid, remoteUserID: caller, hasVideo: hasVideo) { error in
            if let error = error { print("Error incoming call"); print(error.localizedDescription) }
            else { print("Ring Ring...") }
        }
    }
}

struct DialView_Previews: PreviewProvider{
    static var previews: some View{
        DialView()
    }
}


