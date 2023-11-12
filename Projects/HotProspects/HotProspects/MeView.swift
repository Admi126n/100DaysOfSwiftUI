//
//  MeView.swift
//  HotProspects
//
//  Created by Adam Tokarski on 09/11/2023.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
	@AppStorage("name") private var name = "Anonymous"
	@AppStorage("email") private var emailAddress = "you@yoursite.com"
	@State private var qrCode = UIImage()
	
	private let context = CIContext()
	private let filter = CIFilter.qrCodeGenerator()
	
    var body: some View {
		NavigationStack {
			Form {
				TextField("Name", text: $name)
					.textContentType(.name)
					.font(.title)
				
				TextField("Email address", text: $emailAddress)
					.textContentType(.emailAddress)
					.font(.title)
				
				HStack {
					Spacer()
					
					Image(uiImage: qrCode)
						.resizable()
						.interpolation(.none)
						.scaledToFit()
						.frame(width: 200, height: 200)
						.contextMenu {
							Button {
								let imageSaver = ImageSaver()
								imageSaver.writeToPhotoAlbum(image: qrCode)
							} label: {
								Label("Save to photos", systemImage: "square.and.arrow.down")
							}
						}
					
					Spacer()
				}
			}
			.navigationTitle("Your code")
			.onAppear(perform: updateCode)
			.onChange(of: name) { updateCode() }
			.onChange(of: emailAddress) { updateCode() }
		}
    }
	
	private func updateCode() {
		qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
	}
	
	private func generateQRCode(from string: String) -> UIImage {
		filter.message = Data(string.utf8)
		
		if let outputImage = filter.outputImage {
			if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
				return UIImage(cgImage: cgImage)
			}
		}
		
		return UIImage(systemName: "xmark.circle") ?? UIImage()
	}
}

#Preview {
    MeView()
}
