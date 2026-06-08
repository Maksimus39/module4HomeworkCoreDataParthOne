import Foundation
import CoreData


// если делать по MVVM то CoreDataManager будет Model, функции CRUD можно сделать как дженерик
class CoreDataManager {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "db")
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext () throws {
        guard viewContext.hasChanges else { return }
        try viewContext.save()
    }
    
    
    // Create
    func createProduct(price: Double, title: String) throws -> Product {
        let product = Product(context: viewContext)
        
        // Создание объекта продукта можно вынести в класс и это будет ViewModel и обработать как do - catch а
        // в блоке catch вывести alert с сообщением пользователю
        product.id = UUID().uuidString
        product.price = price
        product.title = title
        product.date = Date()
        
        try saveContext()
        return product
    }
    
    
    // Read
    
    //Update
    
    //Delete
}
