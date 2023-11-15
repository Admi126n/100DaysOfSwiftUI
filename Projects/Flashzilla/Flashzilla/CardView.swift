//
//  CardView.swift
//  Flashzilla
//
//  Created by Adam Tokarski on 15/11/2023.
//

import SwiftUI

struct CardView: View {
	let card: Card
	var removal: (() -> Void)? = nil
	
	@State private var isShowingAnswer = false
	@State private var offset = CGSize.zero
	
    var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 25, style: .continuous)
				.fill(.white)
				.shadow(radius: 10)
			
			VStack {
				Text(card.prompt)
					.font(.largeTitle)
					.foregroundStyle(.black)
				
				if isShowingAnswer {
					Text(card.answer)
						.font(.title)
						.foregroundStyle(.gray)
				}
			}
			.padding()
			.multilineTextAlignment(.center)
		}
		.frame(width: 450, height: 250)
		.rotationEffect(.degrees(Double(offset.width / 5)))
		.offset(x: offset.width * 5)
		.opacity(2 - Double(abs(offset.width / 50)))
		.gesture(
			DragGesture()
				.onChanged { gesture in
					offset = gesture.translation
				}
				.onEnded { _ in
					if abs(offset.width) > 100 {
						removal?()
					} else {
						withAnimation {
							offset = .zero
						}
					}
				}
		)
		.onTapGesture {
			withAnimation {
				isShowingAnswer.toggle()
			}
		}
    }
}

#Preview {
	CardView(card: Card.example)
}
