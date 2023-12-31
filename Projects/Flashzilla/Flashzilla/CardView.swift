//
//  CardView.swift
//  Flashzilla
//
//  Created by Adam Tokarski on 15/11/2023.
//

import SwiftUI

fileprivate extension RoundedRectangle {
	func fillCardDepending(on offset: CGSize) -> some View {
		if offset.width != 0 {
			return self.fill(offset.width > 0 ? .green : .red)
		} else {
			return self.fill(.white)
		}
	}
}

struct CardView: View {
	let card: Card
	var removal: ((Bool) -> Void)? = nil
	
	@Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
	@Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
	@State private var feedback = UINotificationFeedbackGenerator()
	@State private var isShowingAnswer = false
	@State private var offset = CGSize.zero
	
    var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 25, style: .continuous)
				.fill(differentiateWithoutColor
					  ? .white
					  : .white.opacity(1 - Double(abs(offset.width / 50)))
				)
				.background(
					differentiateWithoutColor
					? nil
					: RoundedRectangle(cornerRadius: 25, style: .continuous)
						.fillCardDepending(on: offset)
				)
				.shadow(radius: 10)
			
			VStack {
				if voiceOverEnabled {
					Text(isShowingAnswer ? card.answer : card.prompt)
						.font(.largeTitle)
						.foregroundStyle(.black)
				} else {
					Text(card.prompt)
						.font(.largeTitle)
						.foregroundStyle(.black)
					
					if isShowingAnswer {
						Text(card.answer)
							.font(.title)
							.foregroundStyle(.gray)
					}
				}
			}
			.padding()
			.multilineTextAlignment(.center)
		}
		.frame(width: 450, height: 250)
		.rotationEffect(.degrees(Double(offset.width / 5)))
		.offset(x: offset.width * 5)
		.opacity(2 - Double(abs(offset.width / 50)))
		.accessibilityAddTraits(.isButton)
		.gesture(
			DragGesture()
				.onChanged { gesture in
					offset = gesture.translation
					feedback.prepare()
				}
				.onEnded { _ in
					if abs(offset.width) > 100 {
						if offset.width > 0 {
							feedback.notificationOccurred(.success)
						} else {
							feedback.notificationOccurred(.error)
						}
						
						removal?(offset.width > 0)
					} else {
						offset = .zero
					}
				}
		)
		.onTapGesture {
			withAnimation {
				isShowingAnswer.toggle()
			}
		}
		.animation(.spring(), value: offset)
    }
}

#Preview {
	CardView(card: Card.example)
}
