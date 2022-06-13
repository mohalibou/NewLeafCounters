//
//  DataController.swift
//  NewLeaf
//
//  Created by Mohamed Ali Boutaleb on 5/21/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CounterModel")
    
    init() {
        container.loadPersistentStores { desc, error in // load the data
            if let error = error {
                print("Failed to load data: \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data is saved.")
        } catch {
            print("Data is not saved.")
        }
    }
    
    func addCounter(title: String, icon: String, color: String, context: NSManagedObjectContext) {
        let counter = Counter(context: context)
        counter.id = UUID()
        counter.date = Date()
        counter.title = title
        counter.icon = icon
        counter.color = color
        
        save(context: context)
    }
    
    func editCounter(counter: Counter, title: String, icon: String, color: String, context: NSManagedObjectContext) {
        counter.title = title
        counter.icon = icon
        counter.color = color
        
        save(context: context)
    }
    
    func resetCounter(counter: Counter, date: Date, context: NSManagedObjectContext) {
        counter.date = Date()
        
        save(context: context)
    }
    
}
