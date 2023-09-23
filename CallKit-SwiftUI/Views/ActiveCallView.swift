//
//  ActiveCallView.swift
//  CallKit-SwiftUI
//
//  Created by Владимир Никитин on 22.09.2023.
//

import SwiftUI

struct ActiveCallView: View {
    @EnvironmentObject var callManager: CallManager
    
    @State var onAppear : Bool = false
    @Binding var hasActivateCall: Bool
    @Binding var callID: UUID?
    @State var isMuted: Bool = false
    @Binding var receiver: Receiver?
    var body: some View {
        VStack{
            
                AvatarView().padding(.top, 100)
                Spacer()
                if onAppear{
                    CallFunctionalityPanel().transition(.move(edge: .bottom))
                }
            
            
        }.ignoresSafeArea(edges: .all).background(Color.white) .onAppear{
            withAnimation {
                onAppear.toggle()
            }
        }
           
        
    }
    
    
    
    
    @ViewBuilder
    func AvatarView()-> some View{
        VStack{
            Circle().fill(Color.mint).frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.width / 1.5).overlay {
                Image(receiver?.imageName ?? "person.fill").resizable().frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.width / 1.5)
            }
            Text(receiver?.name ?? "Error person").font(.largeTitle).bold()
        }
    }
    
    func CallFunctionalityPanel() -> some View{
        Rectangle().cornerRadius(45, corners: [.topLeft,.topRight]).frame(height: 150).overlay {
            HStack{
                Button {
                    withAnimation {
                        muteAudio()
                    }
                    
                } label: {
                    isMuted ? Image(systemName: "mic.slash.circle.fill").resizable().frame(width: 50, height: 50).foregroundColor(.white) : Image(systemName: "mic.circle.fill").resizable().frame(width: 50, height: 50).foregroundColor(.white)
                }
                
                Spacer()
                
                Button {
                    endCall()
                } label: {
                    Image(systemName: "phone.circle.fill").resizable().frame(width: 50, height: 50).foregroundColor(.red)
                }
                
                
            }.padding(.horizontal, 100)
        }
    }
    
    func muteAudio() {
        self.isMuted.toggle()
        guard let callID = self.callID else { return }
        self.callManager.callActions.muteCall(with: callID, muted: self.isMuted) { error in
            if let error = error { print(error.localizedDescription) }
            else { print("Audio On/Off state has been cahnged successfully") }
        }
    }
    
    func endCall() {
        guard let callID = self.callID else { return }
        self.callManager.callActions.endCall(with: callID) { error in
            if let error = error { print(error.localizedDescription) }
            else { self.hasActivateCall = false }
        }
    }
    
    
}




struct ActiveCallView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveCallView(hasActivateCall: .constant(true), callID: .constant(UUID()), receiver: .constant(Receiver(name: "Human", imageName: "human1"))).environmentObject(CallManager(callActions: CallActions()))
    }
}
