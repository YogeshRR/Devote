//
//  Persistence.swift
//  Devote
//
//  Created by Yogesh Raut on 27/12/24.
//

import CoreData

struct PersistenceController {
    //MARK: - 1. PERSISTENT CONTROLLER
    static let shared = PersistenceController()

    
    //MARK: - 2. PERSISTENT CONTAINER
    let container: NSPersistentContainer

    //MARK: - 3. INITIALIZATION (load persistent store)
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Devote")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
     //MARK: - 4. PREVIEW CONTAINER.
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = "Sample task \(i)"
            newItem.completion = false
            newItem.id = UUID()
        }
        do {
            try viewContext.save()
        } catch {
            
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
