//
//  ContentView.swift
//  Meetup
//
//  Created by Adam Tokarski on 04/11/2023.
//

import SwiftUI

extension UIImage: Identifiable { }

struct ContentView: View {
	let locationFetcher = LocationFetcher()
	
	@State private var showingPicker = false
	@State private var inputImage: UIImage?
	@State private var photos: [PhotoData] = []
	
	var body: some View {
		NavigationStack {
			VStack {
				List(photos.sorted()) { photoData in
					NavigationLink {
						DetailView(of: photoData)
					} label: {
						HStack {
							Image(uiImage: photoData.image)
								.resizable()
								.scaledToFit()
								.clipShape(.rect(cornerRadius: 10))
								.frame(width: 100, height: 100)
							
							Text(photoData.description)
						}
					}
				}
			}
			.navigationTitle("Meetup")
			.toolbar {
				Button("Add photo", systemImage: "plus") {
					showingPicker = true
				}
			}
			.sheet(isPresented: $showingPicker) {
				ImagePicker(image: $inputImage)
					.ignoresSafeArea()
			}
			.sheet(item: $inputImage) { image in
				PhotoDescription(image: image) { description in
					photos.append(PhotoData(
						imageData: image.jpegData(compressionQuality: 0.8)!,
						description: description,
						latitude: locationFetcher.lastKnownLocation?.latitude ?? 0,
						longitude: locationFetcher.lastKnownLocation?.longitude ?? 0
					))
					
					save()
				}
			}
			.onAppear {
				let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedImages")
				do {
					let data = try Data(contentsOf: savePath)
					photos = try JSONDecoder().decode([PhotoData].self, from: data)
				} catch {
					photos = []
				}
				
				locationFetcher.start()
			}
		}
	}
	
	private func save() {
		let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedImages")
		
		do {
			let data = try JSONEncoder().encode(photos)
			try data.write(to: savePath, options: [.atomic, .completeFileProtection])
		} catch {
			print("Unable to save data: \(error.localizedDescription)")
		}
		
	}
	
}

#Preview {
	ContentView()
}
