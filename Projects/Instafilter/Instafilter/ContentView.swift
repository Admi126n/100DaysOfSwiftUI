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
	@State private var filterRadius = 0.5
	
	@State private var showImagePicker = false
	@State private var inputImage: UIImage?
	@State private var processedImage: UIImage?
	
	@State private var currentFilter: CIFilter = CIFilter.sepiaTone()
	let context = CIContext()
	
	@State private var showFilterSheet = false
	
	var disableSaveButton: Bool {
		if let _ = image { return false }
		return true
	}
	
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
					Text("Radius")
					
					Slider(value: $filterRadius)
						.onChange(of: filterRadius) { applyProcessing() }
				}
				.padding(.vertical)
				
				HStack {
					Button("Change filter") { showFilterSheet = true }
					
					Spacer()
					
					Button("Save", action: save)
						.disabled(disableSaveButton)
				}
			}
			.padding([.horizontal, .bottom])
			.navigationTitle("Instafilter")
			.onChange(of: inputImage) { loadImage() }
			.sheet(isPresented: $showImagePicker) {
				ImagePicker(image: $inputImage)
					.ignoresSafeArea()
			}
			.confirmationDialog("Select a filter", isPresented: $showFilterSheet) {
				Button("Crystallize") { setFilter(CIFilter.crystallize()) }
				Button("Edges") { setFilter(CIFilter.edges()) }
				Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
				Button("Pixellate") { setFilter(CIFilter.pixellate()) }
				Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
				Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
				Button("Vignette") { setFilter(CIFilter.vignette()) }
				Button("X Ray") { setFilter(CIFilter.xRay()) }
				Button("Box Blur") { setFilter(CIFilter.boxBlur()) }
				Button("Kaleidoscope") { setFilter(CIFilter.kaleidoscope()) }
				Button("Cancel", role: .cancel) { }
			}
		}
	}
		
	private func loadImage() {
		guard let inputImage = inputImage else { return }
		
		let beginImage = CIImage(image: inputImage)
		currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
		applyProcessing()
	}
	
	private func save() {
		guard let processedImage = processedImage else { return }
		
		let imageSaver = ImageSaver()
		imageSaver.successHandler = {
			print("Succes")
		}
		
		imageSaver.errorHandler = {
			print("Oops!, \($0.localizedDescription)")
		}
		
		imageSaver.writeToPhotoAlbum(image: processedImage)
	}
	
	private func applyProcessing() {
		let inputKeys = currentFilter.inputKeys
		
		if inputKeys.contains(kCIInputIntensityKey) {
			currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
		}
		if inputKeys.contains(kCIInputRadiusKey) {
			currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
		}
		if inputKeys.contains(kCIInputScaleKey) {
			currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
		}
		if inputKeys.contains(kCIInputAngleKey) {
			currentFilter.setValue(filterRadius * 10, forKey: kCIInputAngleKey)
		}
		
		guard let outputImage = currentFilter.outputImage else { return }
		
		if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
			let uiImage = UIImage(cgImage: cgImage)
			image = Image(uiImage: uiImage)
			processedImage = uiImage
		}
	}
	
	private func setFilter(_ filter: CIFilter) {
		currentFilter = filter
		loadImage()
	}
}

#Preview {
	ContentView()
}
