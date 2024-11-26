//
//  StepperStyleThree.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/22.
//

import SwiftUI

struct StepperStyleThree: View {
	var StepNum: Int
	@Binding var CurrentStep: Int
	
    var body: some View {
		HStack(spacing: 0) {
			ForEach(0 ..< StepNum, id:\.self) { item in
				Circle().stroke(lineWidth: item <= CurrentStep ? 3 : 25)
					.frame(width: 40, height: item <= CurrentStep ? 40:15)
					.foregroundStyle(item < CurrentStep ? .green : .secondary)
					.overlay {
						if item < CurrentStep {
							Image(systemName: "checkmark").font(.title2)
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
							.foregroundStyle(.green)
					}
				}
			}
		}
		.frame(height: 50)
    }
}

#Preview {
	MyStepper()
}
