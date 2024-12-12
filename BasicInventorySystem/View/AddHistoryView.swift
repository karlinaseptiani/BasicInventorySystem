//
//  AddTransactionView.swift
//  BasicInventorySystem
//
//  Created by Karlina Dwi Septiani on 03/12/24.
//

import SwiftUI

struct AddHistoryView: View {
    @State private var jenis = "Masuk"
    @State private var jumlah = ""
    @State private var tanggal = Date()
    
    var itemId: Int
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Form {
                Picker("Jenis Transaksi", selection: $jenis) {
                    Text("Masuk").tag("Masuk")
                    Text("Keluar").tag("Keluar")
                }
                TextField("Jumlah", text: $jumlah)
                    .keyboardType(.numberPad)
                DatePicker("Tanggal", selection: $tanggal, displayedComponents: .date)
            }

            Button(action: {
                DBManager.shared.insertHistory(productId: itemId, type: jenis, quantity: Int(jumlah) ?? 0, date: tanggal)
                
                presentationMode.wrappedValue.dismiss()
                
            }) {
                Text("Simpan Transaksi")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Tambah Transaksi")
    }
}

#Preview {
    AddHistoryView(itemId: 2)
}
