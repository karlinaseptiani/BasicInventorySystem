//
//  ItemDetailView.swift
//  BasicInventorySystem
//
//  Created by Karlina Dwi Septiani on 03/12/24.
//

import SwiftUI

struct ItemDetailView: View {
    @State private var histories: [History] = []
    @State private var products: Product = Product(id: 0, name: "-", description: "-", category: "-", price: 0.0, stock: 0, imagePath: "")
    
    var productId: Int

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Image(uiImage: UIImage(contentsOfFile: products.imagePath) ?? UIImage(systemName: "photo")!)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
                
                Text(products.name)
                    .font(.largeTitle)
                    .bold()
                Text(products.description)
                    .font(.body)
                    .foregroundColor(.gray)
                HStack {
                    Text("Harga: Rp \(products.price, specifier: "%.2f")")
                    Spacer()
                    Text("Stok: \(products.stock)")
                }
                .font(.headline)
                .padding(.vertical)
            }
            .padding()

            Divider()

            Text("Riwayat Barang")
                .font(.headline)
            
            
            List ($histories, id: \.id) { $histories in
                VStack(alignment: .leading) {
                    Text("Jenis: \(histories.type)")
                        .font(.headline)
                    Text("Jumlah: \(histories.quantity)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Tanggal: \(histories.date)")
                        .font(.subheadline)
                }
            }

            NavigationLink(destination: AddHistoryView(itemId: productId)) {
                Text("Tambah Riwayat")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Detail Barang")
        .onAppear {
            histories = DBManager.shared.fetchHistories(forProductId: productId)
            products = DBManager.shared.loadDetailProducts(productId: productId)
        }
    }
}


//#Preview {
//    let sample = Product(id: 1, name: "-", description: "-", category: "-", price: 1, stock: 1, imagePath: "")
//    ItemDetailView(product: sample)
//}
