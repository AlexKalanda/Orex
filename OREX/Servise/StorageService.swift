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
    private var profilePicture: StorageReference {
        bucket.child("profilePicture")
    }
}
