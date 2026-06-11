import Foundation
import Observation
import CoreData

@Observable final class ContentViewModel {
    private let coreManager: CoreDataManager
    
    var titleProduct: String = ""
    var priceProduct: String = ""
    var products: [Product] = []
    var errorMessage: String?
    var updateCounter: Int = 0
    var showError: Bool = false
    
    init(coreManager: CoreDataManager) {
        self.coreManager = coreManager
        loadProducts()
    }
    
    // Create
    func createProduct(title: String, price: String) {
        guard let priceValue = Double(price) else {
            self.errorMessage = "Цена должна быть числом"
            self.showError = true
            return
        }
        
        do {
            _ = try coreManager.createProductDB(Product.self) {
                $0.id = UUID().uuidString
                $0.date = Date()
                $0.price = priceValue
                $0.title = title
            }
            loadProducts()
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    // Read
    func loadProducts() {
        do {
            products = try coreManager.fetchProductsDB()
            updateCounter += 1
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    // Update
    func changePrice(for product: Product, newPrice: Double) {
        do {
            try coreManager.updateProductDB(product) {
                $0.price = newPrice
            }
            loadProducts()
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    // Delete
    func deleteProduct(product: Product) {
        do {
            try coreManager.deleteProductID(product)
            loadProducts()
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
}
