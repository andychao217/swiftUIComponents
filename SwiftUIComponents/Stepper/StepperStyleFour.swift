//
//  StepperStyleFour.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/22.
//

import SwiftUI

struct StepperStyleFour: View {
    var StepNum: Int
    @Binding var CurrentStep: Int

	@Environment(\.colorScheme) var colorScheme
	
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< StepNum, id: \.self) { item in
                Circle()
                    .frame(width: 40, height: item <= CurrentStep ? 40 : 15)
					.foregroundStyle(item < CurrentStep ? colorScheme == .dark ? .black : .white : colorScheme == .dark ? .white : .black)
                    .overlay {
                        if item < CurrentStep {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
								.foregroundStyle(.primary)
                                .transition(.scale)
                        }
                    }
                if item < StepNum - 1 {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 3)
                            .foregroundStyle(.secondary)
                        Rectangle()
                            .frame(height: 3)
                            .frame(maxWidth: item >= CurrentStep ? 0 : .infinity, alignment: .leading)
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
		.background(
			Rectangle()
				.frame(height: 3)
				.foregroundStyle(colorScheme == .dark ? .white : .black)
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.trailing)
		)
    }
}

#Preview {
    Stepper()
}
