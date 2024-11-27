//
//  StepperStyleTwo.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/22.
//

import SwiftUI

struct StepperStyleTwo: View {
	var StepNum: Int
	@Binding var CurrentStep: Int
	
    var body: some View {
		HStack(spacing: 0) {
			ForEach(0 ..< StepNum, id:\.self) { item in
				let stepText = NSLocalizedString("step", comment: "Step text for StepperStyleTwo")
				Circle().stroke(lineWidth: 3)
					.frame(width: 40, height: 40)
					.foregroundStyle(item < CurrentStep ? .primary : .secondary)
					.overlay {
						Text("\(stepText) \(item + 1)")
							.fixedSize()
							.offset(x: 3, y: 45)
							.foregroundStyle(item < CurrentStep ? .primary : .secondary)
					}
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
    }
}

#Preview {
	MyStepper()
}
