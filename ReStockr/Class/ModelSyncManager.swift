//
//  ModelSyncManager.swift
//  ReStockr
//
//  Created by Maria Jiao on 4/21/25.
//

import Foundation

enum ModelSyncManager {
    static func uploadCSVAndDownloadModel(csvURL: URL) {
        guard let serverURL = URL(string: "http://localhost:5000/upload") else { return } // Use your real IP for devices

        var request = URLRequest(url: serverURL)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        let filename = "purchase_history.csv"
        let mimetype = "text/csv"

        if let fileData = try? Data(contentsOf: csvURL) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
            body.append(fileData)
            body.append("\r\n".data(using: .utf8)!)
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        }

        let task = URLSession.shared.uploadTask(with: request, from: body) { data, response, error in
            if let error = error {
                print("Upload error: \(error)")
                return
            }

            guard let data = data else {
                print("No model received from server")
                return
            }

            // Save model
            let modelURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                .appendingPathComponent("PurchasePredictor.mlmodel")

            do {
                try data.write(to: modelURL)
                print("Model downloaded to: \(modelURL.path)")
            } catch {
                print("❌ Failed to save model: \(error)")
            }
        }

        task.resume()
    }
}

