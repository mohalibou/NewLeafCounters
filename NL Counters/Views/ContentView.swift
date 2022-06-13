//
//  ContentView.swift
//  NewLeaf
//
//  Created by Mohamed Ali Boutaleb on 5/16/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var counters: FetchedResults<Counter>
    
    @AppStorage("showingOnboardingView") private var showingOnboardingView = true
    @State private var creatingCounter = false
    @State private var editingCounter = false
    @State private var selectedCounter: FetchedResults<Counter>.Element?
    
    var body: some View {
        NavigationView {
            VStack {
                if counters.isEmpty {
                    VStack {
                        HStack {
                            Spacer()
                            Image("NoCounters")
                                .resizable()
                                .scaledToFit()
                        }
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(counters) { counter in
                            TimelineView(.periodic(from: .now, by: 1.0)) { timeline in
                                CounterCellView(title: counter.title ?? "", icon: counter.icon ?? "", color: counter.color ?? "", date: counter.date ?? Date())
                            }
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                selectedCounter = counter
                                editingCounter.toggle()
                            }
                        }
                        .onDelete(perform: deleteCounter)
                        
                    }
                    .listStyle(.inset)
                }
            }
            .navigationTitle("Counters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingOnboardingView.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        creatingCounter.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingOnboardingView) {
            OnboardingView(showingOnboardingView: $showingOnboardingView)
        }
        .sheet(isPresented: $creatingCounter) {
            CreateCounterView(creatingCounter: $creatingCounter)
        }
        .sheet(item: $selectedCounter) { counter in
            EditCounterView(counter: counter)
        }
        .navigationViewStyle(.stack)
    }
    
    func deleteCounter(at offsets: IndexSet) {
        
        withAnimation {
            offsets.map { counters[$0] }.forEach(managedObjectContext.delete)
            DataController().save(context: managedObjectContext)
        }
    }
}

/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 //.preferredColorScheme(.dark)
 }
 }*/

struct CounterCellView: View {
    
    var title: String
    var icon: String
    var color: String
    var date: Date
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity, idealHeight: 80)
                .foregroundColor(Color(hex: color))
                .opacity(0.2)
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(.leading, 30)
                    .padding(.trailing, 15)
                    .foregroundColor(Color(hex: color))
                VStack(alignment: .leading) {
                    title.isEmpty ? Text(" ").bold() : Text(title).bold()
                    TimelineView(.periodic(from: .now, by: 1.0)) { timeline in
                        Text(calcTimeSince(date: date))
                    }
                }
                
                Spacer()
            }
        }
    }
}


