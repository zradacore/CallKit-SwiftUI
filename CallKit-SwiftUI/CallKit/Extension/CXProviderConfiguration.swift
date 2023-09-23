//
//  CxProviderConfiguration.swift
//  CallKit-SwiftUI
//
//  Created by Владимир Никитин on 22.09.2023.
//

import Foundation
import CallKit
import UIKit


extension CXProviderConfiguration {
    
    static var custom: CXProviderConfiguration {
        
        let configuration = CXProviderConfiguration()
        
        // Native call log shows video icon if it was video call.
        configuration.supportsVideo = true
        configuration.maximumCallsPerCallGroup = 1
        
        // Support generic type to handle *User ID*
        configuration.supportedHandleTypes = [.generic]
        
        // Icon image forwarding to app in CallKit View
        if let iconImage = UIImage(named: "AppIcon") {
            configuration.iconTemplateImageData = iconImage.pngData()
        }
        
        // Ringing sound
        configuration.ringtoneSound = "Rington.caf"
        
        return configuration
    }
}
