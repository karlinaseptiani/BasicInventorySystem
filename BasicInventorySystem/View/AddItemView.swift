//
//  AddItemView.swift
//  BasicInventorySystem
//
//  Created by Karlina Dwi Septiani on 03/12/24.
//

import SwiftUI
import UIKit

struct AddItemView: View {
    @State private var namaBarang = ""
    @State private var deskripsi = ""
    @State private var kategori = ""
    @State private var harga = ""
    @State private var stock = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var imagePickerSourceType: UIImagePickerController.SourceType = .photoLibrary

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Informasi Barang")) {
                    TextField("Nama Barang", text: $namaBarang)
                    TextField("Deskripsi", text: $deskripsi)
                    TextField("Kategori", text: $kategori)
                    TextField("Harga", text: $harga)
                        .keyboardType(.numberPad)
                    TextField("Stok", text: $stock)
                        .keyboardType(.numberPad)
                }
                
                Section {
                    Button(action: {
                        imagePickerSourceType = .camera
                        isImagePickerPresented = true
                    }) {
                        HStack {
                            Image(systemName: "camera")
                            Text("Ambil Foto")
                        }
                    }
                }
                
                
                Section {
                    Button(action: {
                        imagePickerSourceType = .photoLibrary
                        isImagePickerPresented = true
                    }) {
                        HStack {
                            Image(systemName: "photo")
                            Text("Pilih dari Galeri")
                        }
                    }
                }

                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .cornerRadius(10)
                }

            }
            

            Button(action: {
                saveProduct()
            }) {
                Text("Simpan")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Tambah Barang")
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage, sourceType: imagePickerSourceType)
        }
    }

    // MARK: - Helper Methods
    private func saveProduct() {
        guard !namaBarang.isEmpty,
              !deskripsi.isEmpty,
              !kategori.isEmpty,
              let hargaValue = Double(harga), // Parsing as Double
              let stockValue = Int(stock) else {
            print("Invalid input")
            print("Harga: \(harga), Stock: \(stock)") // Debugging
            return
        }

        // Save image to local directory
        let imagePath = saveImageToDocumentsDirectory(image: selectedImage)

        // Save product to database
        DBManager.shared.insertProduct(
            name: namaBarang,
            description: deskripsi,
            category: kategori,
            price: hargaValue,
            stock: stockValue,
            imagePath: imagePath
        )

        // Dismiss the view
        presentationMode.wrappedValue.dismiss()
    }

    private func saveImageToDocumentsDirectory(image: UIImage?) -> String {
        guard let image = image,
              let data = image.jpegData(compressionQuality: 0.8) else {
            return ""
        }

        let fileName = UUID().uuidString + ".jpg"
        let filePath = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)

        do {
            try data.write(to: filePath)
            return filePath.path
        } catch {
            print("Failed to save image: \(error)")
            return ""
        }
    }
}


#Preview {
    AddItemView()
}
