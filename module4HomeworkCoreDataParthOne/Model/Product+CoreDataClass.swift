public import Foundation
public import CoreData

public typealias ProductCoreDataClassSet = NSSet

@objc(Product)
public class Product: NSManagedObject { }


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var price: Double
    @NSManaged public var date: Date

}

extension Product : Identifiable {

}

