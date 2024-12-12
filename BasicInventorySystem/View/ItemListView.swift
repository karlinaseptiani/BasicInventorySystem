//
//  ItemListView.swift
//  BasicInventorySystem
//
//  Created by Karlina Dwi Septiani on 03/12/24.
//

import SwiftUI

struct ItemListView: View {
    
    @State private var products: [Product] = []

    var body: some View {
        NavigationView {
            VStack {
                if !products.isEmpty {
                    List ($products, id: \.id) { $product in
                        HStack {
                            if let image = UIImage(contentsOfFile: product.imagePath) {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.gray)
                            }

                            VStack(alignment: .leading) {
                                Text(product.name)
                                    .font(.headline)
                                Text(product.category)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("\(product.price, specifier: "%.2f")")
                                    .font(.subheadline)
                                Text("Stok: \(product.stock)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            NavigationLink(destination: ItemDetailView(productId: product.id)) {
                                
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .listStyle(PlainListStyle())
                } else {
                    
                    Spacer()
                    
                    Text("Belum ada barang tersimpan")
                    
                    Spacer()
                }
                
                NavigationLink(destination: AddItemView()) {
                    Text("Tambah Barang")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.brown)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
            }
            .navigationTitle("Daftar Barang")
            .onAppear {
                products = DBManager.shared.fetchAllProducts()
                for product in products {
                    print("cek name \(product.name)")
                    print("cek harga \(product.price)")

                }
            }
        }
    }
}

#Preview {
    ItemListView()
}
