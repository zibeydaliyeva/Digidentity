//
//  CryptorHelper.swift
//  crypto helper
//
//  Created by Зибейда Алекперли on 18.11.21.
//

import Foundation

final class CryptorHelper {
    
    private let salt = AES256.salt()
    private let iv = AES256.iV()
    
    private let password: String
    
    init(password: String) {
        self.password = password
    }

    func encrypt(data: Data) throws -> Data {
        do {
            let key = try AES256.createKey(password: password.data(using: .utf8)!, salt: salt)
            let aes = try AES256(key: key, iv: iv)
            let encryptedCatalogs = try aes.encrypt(data)
            return encryptedCatalogs
        } catch(let error) {
            throw error
        }
    }
    
    func decrypt(data: Data) throws -> Data {
        do {
            let key = try AES256.createKey(password: password.data(using: .utf8)!, salt: salt)
            let aes = try AES256(key: key, iv: iv)
            let decryptedCatalogs = try aes.decrypt(data)
            return decryptedCatalogs
        } catch(let error) {
            throw error
        }
    }

}
