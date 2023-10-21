//
//  ContentView.swift
//  Instafilter
//
//  Created by Adam Tokarski on 20/10/2023.
//

//import CoreImage  // 1
//import CoreImage.CIFilterBuiltins  // 1
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var showImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                showImagePicker = true
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker()
        }
    }
    
// 1
//    @State private var image: Image?
//    var body: some View {
//        VStack {
//            image?
//                .resizable()
//                .scaledToFit()
//        }
//        .onAppear(perform: loadImage)
//    }
//    private func loadImage() {
//        guard let inputImage = UIImage(named: "Icon") else { return }
//        let beginImage = CIImage(image: inputImage)
//        
//        let context = CIContext()
////        let currentFilter = CIFilter.sepiaTone()  // 1
////        let currentFilter = CIFilter.pixellate()  // 2
//        let currentFilter = CIFilter.crystallize()  // 3
////        let currentFilter = CIFilter.twirlDistortion()  // 4
//        currentFilter.inputImage = beginImage
//        
//        let amount = 1.0
//        let inputKeys = currentFilter.inputKeys
//        if inputKeys.contains(kCIInputIntensityKey) {
//            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
//        }
//        
////        currentFilter.intensity = 1  // 1
////        currentFilter.scale = 20  // 2
//        currentFilter.radius = 10  // 3
////        currentFilter.radius = 100  // 4
////        currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)  // 4
//        
//        guard let outputImage = currentFilter.outputImage else { return }
//        
//        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
//            let uiImage = UIImage(cgImage: cgImage)
//            
//            image = Image(uiImage: uiImage)
//        }
//    }
}

#Preview {
    ContentView()
}
