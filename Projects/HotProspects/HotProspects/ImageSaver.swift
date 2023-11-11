//
//  ImageSaver.swift
//  HotProspects
//
//  Created by Adam Tokarski on 11/11/2023.
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
