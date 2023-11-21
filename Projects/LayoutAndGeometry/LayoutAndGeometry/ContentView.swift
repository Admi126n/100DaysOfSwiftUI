//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Adam Tokarski on 19/11/2023.
//

import SwiftUI

extension View {
	func scrollColor(_ fullView: GeometryProxy, _ localView: GeometryProxy) -> some View {
		self.background(Color(
			hue: min(1, localView.frame(in: .global).midY / fullView.size.height),
			saturation: min(1, localView.frame(in: .global).midY / fullView.size.height),
			brightness: 1)
		)
	}
	
	func scrollRotation(_ fullView: GeometryProxy, _ localView: GeometryProxy) -> some View {
		self.rotation3DEffect(
			.degrees(localView.frame(in: .global).minY - fullView.size.height / 2) / 5,
			axis: (x: 0, y: 1, z: 0)
		)
	}
	
	func scrollScaleEffect(_ fullView: GeometryProxy, _ localView: GeometryProxy) -> some View {
		self.scaleEffect(CGSize(
			width: max(localView.frame(in: .global).minY / fullView.frame(in: .local).midY, 0.5),
			height: max(localView.frame(in: .global).minY / fullView.frame(in: .local).midY, 0.5))
		)
	}
}


struct ContentView: View {
	let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
	
	var body: some View {
		GeometryReader { fullView in
			ScrollView {
				ForEach(0..<50) { index in
					GeometryReader { geo in
						Text("Row  #\(index)")
							.font(.title)
							.frame(maxWidth: .infinity)
							.scrollColor(fullView, geo)
							.scrollRotation(fullView, geo)
							.opacity(geo.frame(in: .global).minY / 200)
							.scrollScaleEffect(fullView, geo)
					}
					.frame(height: 40)
				}
			}
		}
	}
}

#Preview {
	ContentView()
}
