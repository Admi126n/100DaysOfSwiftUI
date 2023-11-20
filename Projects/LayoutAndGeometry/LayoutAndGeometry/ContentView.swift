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

struct OuterView: View {
	var body: some View {
		VStack {
			Text("Top")
			
			InnerView()
				.background(.green)
			
			Text("Botton")
		}
	}
}

struct InnerView: View {
	var body: some View {
		HStack {
			Text("Left")
			
			GeometryReader { geo in
				Text("Center")
					.background(.blue)
					.onTapGesture {
						print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
						
						print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
						
						print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
					}
			}
			.background(.orange)
			
			Text("Right")
		}
	}
}

struct ContentView: View {
	let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
	
	var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(spacing: 0) {
				ForEach(1..<20) { num in
					GeometryReader { geo in
						Text("Number \(num)")
							.font(.largeTitle)
							.padding()
							.background(.red)
							.rotation3DEffect(
								.degrees(-geo.frame(in: .global).minX) / 8, axis: (x: 0.0, y: 1.0, z: 0.0)
							)
							.frame(width: 200, height: 200)
					}
					.frame(width: 200, height: 200)
				}
			}
		}
		
		
		
//		GeometryReader { fullView in
//			ScrollView {
//				ForEach(0..<50) { index in
//					GeometryReader { geo in
//						Text("Row  #\(index)")
//							.font(.title)
//							.frame(maxWidth: .infinity)
//							.background(colors[index % 7])
//							.rotation3DEffect(
//								.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0)
//							)
//					}
//					.frame(height: 40)
//				}
//			}
//		}
	}
}

#Preview {
    ContentView()
}
