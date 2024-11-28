//
//  RoundedRecView.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/28.
//

import SwiftUI

struct RoundedRecView: View {
	@Environment(\.colorScheme) private var colorScheme
	var width: CGFloat = 160
	var height: CGFloat = 180
	
	var body: some View {
		RoundedRectangle(cornerRadius: 10, style: .continuous)
			.frame(width: width, height: height)
			.foregroundColor(colorScheme == .dark ? .white : .black)
	}
}

#Preview {
    RoundedRecView()
}
