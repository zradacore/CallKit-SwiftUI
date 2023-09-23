//
//  View+CornerRadius.swift
//  CallKit-SwiftUI
//
//  Created by Владимир Никитин on 23.09.2023.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
