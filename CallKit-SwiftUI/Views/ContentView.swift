//
//  ContentView.swift
//  CallKit-SwiftUI
//
//  Created by Владимир Никитин on 22.09.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var callManager: CallManager
    var body: some View {
        
        DialView()
            
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
