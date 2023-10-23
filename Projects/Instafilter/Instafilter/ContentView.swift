//
//  ContentView.swift
//  Instafilter
//
//  Created by Adam Tokarski on 20/10/2023.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
	@State private var image: Image?
	@State private var filterIntensity = 0.5
	
	@State private var showImagePicker = false
	@State private var inputImage: UIImage?
	
	@State private var currentFilter = CIFilter.sepiaTone()
	let context = CIContext()
	
	var body: some View {
		NavigationStack {
			VStack {
				ZStack {
					Rectangle()
						.fill(.secondary)
					
					Text("Tap to select a picture")
						.foregroundStyle(.white)
						.font(.headline)
					
					image?
						.resizable()
						.scaledToFit()
				}
				.onTapGesture {
					showImagePicker = true
				}
				
				HStack {
					Text("Intensity")
					
					Slider(value: $filterIntensity)
						.onChange(of: filterIntensity) { applyProcessing() }
				}
				.padding(.vertical)
				
				HStack {
					Button("Change filter") {
						// change filter
					}
					
					Spacer()
					
					Button("Save", action: save)
				}
			}
			.padding([.horizontal, .bottom])
			.navigationTitle("Instafilter")
			.onChange(of: inputImage) { loadImage() }
			.sheet(isPresented: $showImagePicker) {
				ImagePicker(image: $inputImage)
					.ignoresSafeArea()
			}
		}
	}
		
	private func loadImage() {
		guard let inputImage = inputImage else { return }
		
		let beginImagee = CIImage(image: inputImage)
		currentFilter.setValue(beginImagee, forKey: kCIInputImageKey)
		applyProcessing()
	}
	
	private func save() {
		
	}
	
	private func applyProcessing() {
		currentFilter.intensity = Float(filterIntensity)
		
		guard let outputImage = currentFilter.outputImage else { return }
		
		if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
			let uiImage = UIImage(cgImage: cgImage)
			image = Image(uiImage: uiImage)
		}
	}
}

#Preview {
	ContentView()
}
