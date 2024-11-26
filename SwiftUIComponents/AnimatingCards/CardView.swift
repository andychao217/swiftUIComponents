//
//  LEDTextView.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/26.
//

import SwiftUI

struct CardView: View {
	@State private var isAnimation: Bool = false
	
    var body: some View {
		ZStack {
			VStack {
				Image("doraemon")
					.resizable()
					.scaledToFit()
					.shadow(color: Color.black.opacity(0.15), radius: 8, x:6, y:8)
					.scaleEffect(isAnimation ? 1.0 : 0.8)
				Text("Doraemon")
					.foregroundColor(.white)
					.font(.largeTitle)
					.fontWeight(.heavy)
					.shadow(color: Color.black.opacity(0.15), radius: 2, x:2, y:2)
					.scaleEffect(isAnimation ? 1.0 : 0.5)
				
				Text("Doraemon is one of the most popular cartoon character in the world")
					.foregroundColor(.white)
					.multilineTextAlignment(.center)
					.padding(.horizontal, 16)
					.frame(maxWidth: 480)
				
				CustomNextButtonView()
			}
			.padding()
		}
		.onAppear(perform: {
			withAnimation(.easeOut(duration: 0.5)){
				isAnimation = true
			}
		})
		.onDisappear(perform: {
			isAnimation = false
		})
		.frame(minWidth:0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
		.background(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]), startPoint: .top, endPoint: .bottom))
			.cornerRadius(20)
			.padding(.horizontal, 20)
			.padding(.vertical, 50)
		
    }
}

#Preview(traits: .sizeThatFitsLayout, body: {
	CardView()
})
