//
//  CreateCounterView.swift
//  NewLeaf
//
//  Created by Mohamed Ali Boutaleb on 5/21/22.
//

import SwiftUI

struct CreateCounterView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @Binding var creatingCounter: Bool
    
    @State private var title = ""
    @State private var icon = "leaf.fill"
    @State private var color = Color.green
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                CounterCellView(title: title, icon: icon, color: color.toHex()!, date: date)
                    .frame(maxWidth: .infinity, maxHeight: 80)
                    .padding()
                Form {
                    Section {
                        HStack {
                            Text("Title")
                            TextField("Required", text: $title)
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.trailing)
                        }
                        NavigationLink(destination: SelectImageView(icon: $icon)) {
                            HStack {
                                Text("Icon")
                                Spacer()
                                Image(systemName: icon)
                            }
                        }
                        ColorPicker("Color", selection: $color, supportsOpacity: false)
                    }
                    Section {
                        Button("Create Counter") {
                            if !title.isEmpty {
                                DataController().addCounter(title: title, icon: icon, color: color.toHex()!, context: managedObjectContext)
                                creatingCounter.toggle()
                            }
                            
                        }
                    }
                }
            }
            .navigationTitle("Create Counter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        creatingCounter.toggle()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}



struct CreateCounterView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCounterView(creatingCounter: .constant(false))
    }
}

struct SelectImageView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var icon: String
    
    let icons = ["leaf.fill", "house", "pencil", "trash", "folder", "doc", "bookmark", "graduationcap", "rosette", "ticket", "paperclip", "person", "command", "peacesign", "globe.europe.africa", "sun.max", "moon", "cloud", "wind", "tornado", "umbrella", "flame", "cursorarrow", "keyboard", "checkmark.seal", "exclamationmark.triangle", "drop", "playpause", "infinity", "megaphone", "speaker.wave.2", "music.note", "magnifyingglass", "mic", "suit.heart", "suit.club", "suit.spade", "suit.diamond", "star", "flag", "location", "bell", "tag", "bolt", "tshirt", "facemask", "brain", "flashlight.on.fill"]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem](repeating: GridItem(.flexible(), spacing: 35), count: 5), spacing: 35) {
                    
                    ForEach(0 ..< icons.count, id: \.self) { icon in
                        ZStack {
                            if self.icon == icons[icon] {
                                Circle()
                                    .foregroundColor(.blue)
                                    .frame(width: 50, height: 50)
                            }
                            Image(systemName: icons[icon])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .onTapGesture {
                                    self.icon = icons[icon]
                                    dismiss()
                                }
                        }
                        
                    }
                }
                .padding(35)
            }
        }
    }
}
