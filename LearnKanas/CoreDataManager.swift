import Foundation
import CoreData
import SwiftUI

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "KanaDataModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Erro ao carregar Core Data: \(error)")
            }
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Erro ao salvar Core Data: \(error)")
            }
        }
    }
}
