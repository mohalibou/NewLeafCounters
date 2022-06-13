//
//  Binding+Ext.swift
//  NewLeaf
//
//  Created by Mohamed Ali Boutaleb on 5/22/22.
//

import SwiftUI

extension Binding {
    func withDefault<Default>(_ defaultValue: Default) -> Binding<Default> where Value == Default? {
        .init(
            get: {
                wrappedValue ?? defaultValue
            },
            set: { newValue in
                wrappedValue = newValue
            }
        )
    }
}
