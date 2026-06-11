import SwiftUI

struct ContentView: View {
    @Environment(ContentViewModel.self) private var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        NavigationStack {
            Form {
                Section("Новый товар") {
                    TextField("Название товара", text: $viewModel.titleProduct)
                    TextField("Цена", text: $viewModel.priceProduct)
                        .keyboardType(.decimalPad)
                }
                
                Section("Список товаров") {
                    if viewModel.products.isEmpty {
                        Text("Список пуст").foregroundStyle(.secondary)
                    } else {
                        ForEach(viewModel.products) { product in
                            NavigationLink(value: product) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(product.title)
                                            .font(.body)
                                        Text(String(format: "%.2f ₽", product.price))
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    viewModel.deleteProduct(product: product)
                                } label: {
                                    Label("Удалить", systemImage: "trash")
                                }
                            }
                        }
                        .id(viewModel.updateCounter)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.indigo.opacity(0.1))
            
            .navigationDestination(for: Product.self) { product in
                ProductDetailView(product: product)
            }
            .navigationTitle("Мои Покупки")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Добавить") {
                        saveProduct()
                        viewModel.titleProduct = ""
                        viewModel.priceProduct = ""
                    }
                    .disabled(viewModel.titleProduct.isEmpty || viewModel.priceProduct.isEmpty)
                }
            }
            .alert("Ошибка", isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage ?? "Неизвестная ошибка")
            }
            .onChange(of: viewModel.errorMessage) { _, newValue in
                if newValue != nil {
                    viewModel.showError = true
                }
            }
        }
    }
    
    
    private func saveProduct() {
        viewModel.createProduct(title: viewModel.titleProduct, price: viewModel.priceProduct)
        if viewModel.errorMessage == nil {
            viewModel.titleProduct = ""
            viewModel.priceProduct = ""
        }
    }
}
