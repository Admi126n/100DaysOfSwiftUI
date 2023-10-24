//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Adam Tokarski on 22/10/2023.
//

import UIKit

class ImageSaver: NSObject {
	var successHandler: (() -> Void)?
	var errorHandler: ((Error) -> Void)?
	
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleated), nil)
    }
    
    @objc func saveCompleated(_ image: UIImage, didFinishSavinWithError error: Error?, contextInfo: UnsafeRawPointer) {
		if let error = error {
			errorHandler?(error)
		} else {
			successHandler?()
		}
    }
}
