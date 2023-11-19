//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Adam Tokarski on 19/11/2023.
//

import SwiftUI

extension VerticalAlignment {
	enum MidAccountAndName: AlignmentID {
		static func defaultValue(in context: ViewDimensions) -> CGFloat {
			context[.top]
		}
	}
	
	static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
    var body: some View {
		HStack(alignment: .midAccountAndName) {
			VStack {
				Text("@twostraws")
					.alignmentGuide(.midAccountAndName) { d in
						d[VerticalAlignment.center]
					}
				
				Image(.example)
					.resizable()
					.scaledToFit()
					.frame(width: 64, height: 64)
			}
			
			VStack {
				Text("Full name:")
				
				Text("Paul Hudson")
					.font(.largeTitle)
					.alignmentGuide(.midAccountAndName) { d in
						d[VerticalAlignment.center]
					}
			}
		}
		
		
		
// 3
//		VStack(alignment: .leading) {
//			ForEach(0..<10) { position in
//				Text("Number \(position)")
//					.alignmentGuide(.leading) { _ in
//						Double(position) * -10
//					}
//			}
//		}
//		.background(.red)
//		.frame(width: 400, height: 400)
//		.background(.blue)
	
// 2
//		VStack(alignment: .leading) {
//			Text("Hello, World!")
//				.alignmentGuide(.leading) { dimension in
//					dimension[.trailing]
//				}
//			
//			Text("This is a longer line of text")
//		}
//		.background(.red)
//		.frame(width: 400, height: 400)
//		.background(.blue)

// 1
//		Text("Hello, world!")
//			.frame(width: 300, height: 300, alignment: .topLeading)
//			.background(.green)
    }
}

#Preview {
    ContentView()
}
