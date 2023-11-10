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
	@State private var name = "Anonymous"
	@State private var emailAddress = "you@yoursite.com"
	
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
					
					Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
						.resizable()
						.interpolation(.none)
						.scaledToFit()
						.frame(width: 200, height: 200)
					
					Spacer()
				}
			}
			.navigationTitle("Your code")
		}
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
