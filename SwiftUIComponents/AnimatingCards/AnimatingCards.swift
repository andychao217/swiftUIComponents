//
//  OnboardingView.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/26.
//

import SwiftUI

struct AnimatingCards: View {
    var body: some View {
		TabView {
			ForEach(0..<5) { item in
				CardView()
			}
		}.tabViewStyle(PageTabViewStyle())
	}
}

#Preview {
    AnimatingCards()
}
