import SwiftUI

struct ProductDetailView: View {
    @Environment(ContentViewModel.self) private var viewModel
    let product: Product
    
    @State private var editPriceText: String = ""
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        Form {
            Section("Информация") {
                HStack {
                    Text("Название")
                    Spacer()
                    Text(product.title)
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text("Текущая цена")
                    Spacer()
                    Text(String(format: "%.2f ₽", product.price))
                        .foregroundStyle(.secondary)
                }
            }
            
            Section("Редактирование цены") {
                TextField("Новая цена", text: $editPriceText)
                    .keyboardType(.decimalPad)
                
                Button("Сохранить новую цену") {
                    saveNewPrice()
                }
                .disabled(editPriceText.isEmpty)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.yellow.opacity(0.3))         
        
        .navigationTitle("Детали товара")
        .onAppear {
            editPriceText = String(format: "%.2f", product.price)
        }
        .alert("Ошибка", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "Произошла неизвестная ошибка")
        }
    }
    
    private func saveNewPrice() {
        guard let newPrice = Double(editPriceText) else {
            viewModel.errorMessage = "Цена должна быть числом"
            viewModel.showError = true
            return
        }
        
        viewModel.changePrice(for: product, newPrice: newPrice)
    }
}
