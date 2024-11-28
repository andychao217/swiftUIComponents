//
//  NumberView.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/28.
//

import SwiftUI

struct NumberView: View {
	@Environment(\.colorScheme) private var colorScheme
	var num: Int
	
	var body: some View {
		Text("\(num)").font(.system(size: num >= 10 ? 120 : 180))
			.foregroundColor(colorScheme == .dark ? .black : .white)
	}
}

#Preview {
	NumberView(num: 1)
}
