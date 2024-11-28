//
//  MyTabBarItemView.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/28.
//

import SwiftUI

struct MyTabBarItemView: View {
	let image: String
	
	@Environment(\.colorScheme) private var colorScheme
	@Binding var selectedTab: String
	
	var body: some View {
		GeometryReader { button in
			Button {
				withAnimation(.linear(duration: 0.3)) {
					selectedTab = image
				}
			} label: {
				VStack {
					Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
						.offset(y: selectedTab == image ? -5 : 0)
						.scaleEffect(selectedTab == image ? 1.2 : 1.0)
						.foregroundColor(selectedTab == image ? .accentColor : colorScheme == .dark ? .white : .gray)
					
					RoundedRectangle(cornerRadius: 1)
						.frame(width: 20, height: 2)
						.opacity(selectedTab == image ? 1.0 : 0.0)
						.padding(.top, 1)
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
		.frame(height: 50)
	}
}
