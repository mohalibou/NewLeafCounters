//
//  Button+Ext.swift
//  NewLeaf
//
//  Created by Mohamed Ali Boutaleb on 5/24/22.
//

import SwiftUI

extension Button {
    
    init(systemImage: String, action: @escaping () -> Void) where Label == Image {
        self.init(action: action, label: {
            Image(systemName: systemImage)
        })
    }
    
    init(_ title: LocalizedStringKey, systemImage: String, action: @escaping () -> Void) where Label == SwiftUI.Label<Text, Image> {
        self.init(action: action, label: {
            Label(title, systemImage: systemImage)
        })
    }
}
