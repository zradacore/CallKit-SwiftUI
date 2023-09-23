//
//  CXProvider.swift
//  CallKit-SwiftUI
//
//  Created by Владимир Никитин on 22.09.2023.
//

import Foundation
import CallKit


extension CXProvider{
    
    // Чтобы обеспечить инициализацию только сразу. Ленивое хранимое свойство не гарантирует этого.
    
    static var custom: CXProvider{
        
        let configuration = CXProviderConfiguration.custom
        let provider = CXProvider(configuration: configuration)
        
        return provider
    }
}
