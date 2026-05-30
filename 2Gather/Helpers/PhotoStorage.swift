//
//  PhotoStorage.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 29/05/26.
//

import UIKit

// Saves and loads proof photos to/from the app's Documents directory.
enum PhotoStorage {
    
    // Save a UIImage as JPEG and return the file name (not full path).
    static func saveProofImage(_ image: UIImage, for missionId: UUID) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        let fileName = "\(missionId.uuidString).jpg"
        let url = documentsDirectory.appendingPathComponent(fileName)
        do {
            try data.write(to: url)
            return fileName
        } catch {
            print("PhotoStorage: failed to save — \(error.localizedDescription)")
            return nil
        }
    }
    
    // Load a UIImage from a previously saved file name.
    static func loadProofImage(named fileName: String) -> UIImage? {
        let url = documentsDirectory.appendingPathComponent(fileName)
        return UIImage(contentsOfFile: url.path)
    }

    private static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
