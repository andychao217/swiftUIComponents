//
//  StepperStyleOne.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/22.
//

import SwiftUI

struct StepperStyleOne: View {
	var StepNum: Int
	@Binding var CurrentStep: Int
	
    var body: some View {
		HStack(spacing: 0) {
			ForEach(0 ..< StepNum, id:\.self) { item in
				Circle().stroke(lineWidth: item <= CurrentStep ? 25 : 3)
					.frame(width: 40, height: item <= CurrentStep ? 15:40)
					.foregroundStyle(item < CurrentStep ? .green : .secondary)
					.overlay {
						if item < CurrentStep {
							Image(systemName: "checkmark").font(.title2)
								.foregroundStyle(.white)
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
