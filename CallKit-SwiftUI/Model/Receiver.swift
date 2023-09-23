//
//  Receivers.swift
//  CallKit-SwiftUI
//
//  Created by Владимир Никитин on 22.09.2023.
//

import Foundation



struct Receiver: Identifiable{
    let id = UUID().uuidString
    let name: String
    let imageName: String
}

extension Receiver{
    static let receivers = [
        Receiver(name: "Olivia", imageName: "human1"),
        Receiver(name: "Vladimir", imageName: "human3"),
        Receiver(name: "Adam", imageName: "human2")
    ]
}

