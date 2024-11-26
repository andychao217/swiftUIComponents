//
//  CustomNextButtonView.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/26.
//

import SwiftUI

struct CustomNextButtonView: View {
    var body: some View {
		Button {
			print("next")
		} label: {
			HStack {
				Text("Start").foregroundColor(.white)
				Image(systemName: "arrowshape.right.circle.fill")
					.foregroundColor(.black)
			}
			.padding(.horizontal, 16)
			.padding(.vertical, 10)
			.background(
				Capsule().strokeBorder(Color.white, lineWidth: 1.25)
			)
		}
    }
}

#Preview {
    CustomNextButtonView()
}
