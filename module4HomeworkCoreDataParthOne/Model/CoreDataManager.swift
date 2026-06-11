import Foundation
import CoreData

class CoreDataManager {
    private let container: NSPersistentContainer
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    func saveContext() throws {
        guard viewContext.hasChanges else { return }
        try viewContext.save()
    }
    
    
    func createProductDB<T: NSManagedObject>(_ type: T.Type, configure: (T) -> Void) throws -> T {
        let entity = T(context: viewContext)
        configure(entity)
        try saveContext()
        return entity
    }
    
    
    func fetchProductsDB() throws -> [Product] {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Product.date, ascending: false)]
        
        return try viewContext.fetch(request)
    }
    
   
    func updateProductDB<T: NSManagedObject>(_ entity: T, configure: (T) -> Void) throws {
        configure(entity)
        try saveContext()
    }
    
  
    func deleteProductID(_ product: Product) throws {
        viewContext.delete(product)
        try saveContext()
    }
}
