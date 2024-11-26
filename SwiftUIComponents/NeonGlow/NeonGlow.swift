//
//  ContentView.swift
//  NeonGlow
//
//  Created by Andy Chao on 2024/11/22.
//

import SwiftUI

struct NeonGlow: View {
	@State var Index = 0
	let color: [Color] = [.green, .pink, .blue, .orange, .purple]
	let title: [String] = ["NEON", "GLOW", "LIGHT", "SHINE", "BRIGHT"]
	
	var body: some View {
		Text(title[Index])
			.foregroundColor(.white)
			.font(.system(size: 70, weight: .thin))
			.contentTransition(.numericText(countsDown: false))
			.frame(width: 250)
			.shadow(color: color[Index], radius: 5)
			.shadow(color: color[Index], radius: 5)
			.shadow(color: color[Index], radius: 50)
			.shadow(color: color[Index], radius: 100)
			.shadow(color: color[Index], radius: 200)
			.onTapGesture {
				withAnimation {
					Index = (Index + 1) % color.count
				}
			}
			.onAppear {
				Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
					withAnimation {
						Index = (Index + 1) % color.count
					}
				}
			}
	}
}

#Preview {
	NeonGlow()
}
