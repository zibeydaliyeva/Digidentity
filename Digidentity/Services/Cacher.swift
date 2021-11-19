//
//  Filemanager.swift
//  crypto helper
//
//  Created by Зибейда Алекперли on 17.11.21.
//

import Foundation

final class Cacher {
    
    private var destination: URL = URL(fileURLWithPath: NSTemporaryDirectory())
    
    private var cryptoManager = CryptorHelper(password: "cryptoSaving")
    
    private let queue = OperationQueue()
    
    init(fileName: String) {
        
        try? FileManager.default.createDirectory(
            at: self.destination,
            withIntermediateDirectories: true,
            attributes: nil)
            
        destination = destination.appendingPathComponent(
                          fileName, isDirectory: false)
    }
    
    
    func persist<T: Codable>(items: T)  {
        let operation = BlockOperation {
            do {
                let data = try JSONEncoder().encode(items)
                let encryptedData = try self.cryptoManager.encrypt(data: data)
                try encryptedData.write(to: self.destination, options: [.atomicWrite])
            } catch let error {
                 print(error.localizedDescription)
            }
        }
        
        queue.addOperation(operation)
    }
    
    
    func load<T: Codable>() -> T? {
        guard
            let data = try? Data(contentsOf: destination),
            let decryptedData = try? cryptoManager.decrypt(data: data),
            let decoded = try? JSONDecoder().decode(T.self, from: decryptedData)
            else { return nil }
        return decoded
    }
    
}


