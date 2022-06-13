//
//  EditCounterView.swift
//  NewLeaf
//
//  Created by Mohamed Ali Boutaleb on 5/22/22.
//

import SwiftUI

struct EditCounterView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var counter: FetchedResults<Counter>.Element
    
    @State private var title = ""
    @State private var icon = ""
    @State private var color = Color.red
    @State private var date = Date()
    
    @State private var formerTitle = ""
    @State private var formerIcon = ""
    @State private var formerColor = Color.clear
    
    var body: some View {
        NavigationView {
            VStack {
                CounterCellView(title: counter.title!, icon: counter.icon!, color: counter.color!, date: counter.date!)
                    .frame(maxWidth: .infinity, maxHeight: 80)
                    .padding()
                Form {
                    Section {
                        HStack {
                            Text("Title")
                            TextField("Required", text: $title)
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.trailing)
                                .onAppear { title = counter.title!; if formerTitle.isEmpty { formerTitle = counter.title! } }
                                .onChange(of: title) { newTitle in
                                    counter.title = newTitle
                                }
                        }
                        
                        NavigationLink(destination: SelectImageView(icon: $icon)) {
                            HStack {
                                Text("Icon")
                                Spacer()
                                Image(systemName: icon)
                            }
                        }
                        .onAppear { icon = counter.icon!; if formerIcon.isEmpty { formerIcon = counter.icon! } }
                        .onChange(of: icon) { newIcon in
                            counter.icon = newIcon
                        }
                            
                        ColorPicker("Color", selection: $color, supportsOpacity: false)
                            .onAppear { color = Color(hex: counter.color!)!; if formerColor == Color.clear { formerColor = Color(hex: counter.color!)! } }
                            .onChange(of: color) { newColor in
                                counter.color = newColor.toHex()
                            }
                    }
                    Section {
                        Button("Reset Counter") {
                            DataController().resetCounter(counter: counter,
                                                          date: date,
                                                          context: managedObjectContext)
                            dismiss()
                        }
                        .foregroundColor(.red)
                    }
                    Section {
                        Button("Save Changes") {
                            DataController().editCounter(counter: counter,
                                                         title: title,
                                                         icon: icon,
                                                         color: color.toHex()!,
                                                         context: managedObjectContext)
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("Edit Counter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        DataController().editCounter(counter: counter,
                                                     title: formerTitle,
                                                     icon: formerIcon,
                                                     color: formerColor.toHex()!,
                                                     context: managedObjectContext)
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}


/*
 struct EditCounterView_Previews: PreviewProvider {
 static var previews: some View {
 EditCounterView(creatingCounter: .constant(false))
 }
 }
 */
