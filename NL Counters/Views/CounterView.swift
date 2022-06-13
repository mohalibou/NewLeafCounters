//
//  CounterView.swift
//  NewLeaf
//
//  Created by Mohamed Ali Boutaleb on 5/23/22.
//

import SwiftUI

struct CounterView: View {
    
    @Binding var editingCounter: Bool
    @Binding var counter: FetchedResults<Counter>.Element
    
    var body: some View {
        
        VStack {
            
        }
        
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

/*
struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView()
    }
}
*/
