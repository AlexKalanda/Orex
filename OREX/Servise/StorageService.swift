//
//  StorageService.swift
//  OREX
//
//  Created by admin on 12/10/2024.
//

import Foundation
import FirebaseStorage

class StorageService {
    static let shared = StorageService(); private init() {}
    private let bucket = Storage.storage().reference()
    var userAva: StorageReference {
        bucket.child("userAva")
    }
    
    //MARK: - метод выгрузки картинки в базу данных
    func upload(data: Data, for userId: String) async throws {
        let filePath = userAva.child("\(userId).jpg")
        let outMetadata = StorageMetadata()
        outMetadata.contentType = "image/jpeg"
        let imMetaData = try await filePath.putDataAsync(data, metadata: outMetadata)
        print(imMetaData.path!)
    }
    
    //MARK: - метод получения аватаки
    func dowlodPP(byUserId id: String) async throws -> Data {
        let filePath = userAva.child("\(id).jpg")
        let data = try await filePath.data(maxSize: 5 * 1024 * 1024)
        return data
    }
}
