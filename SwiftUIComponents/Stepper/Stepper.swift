//
//  Stepper.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/22.
//

import SwiftUI

struct Stepper: View {
	@State var StepsNum: Int = 4
	@State var CurrentStep: Int = 0
    var body: some View {
		VStack(spacing: 80) {
			StepperStyleOne(StepNum: StepsNum, CurrentStep: $CurrentStep)
			StepperStyleTwo(StepNum: StepsNum, CurrentStep: $CurrentStep)
			StepperStyleThree(StepNum: StepsNum, CurrentStep: $CurrentStep)
			StepperStyleFour(StepNum: StepsNum, CurrentStep: $CurrentStep)
			
			HStack {
				Button("Back") {
					withAnimation {
						if CurrentStep > 0 {
							CurrentStep -= 1
						}
					}
				}
				.padding(.horizontal)
				.disabled(CurrentStep <= 0)
				
				Button("Next") {
					withAnimation {
						if CurrentStep < StepsNum {
							CurrentStep += 1
						}
					}
				}
				.padding(.horizontal)
				.disabled(CurrentStep >= StepsNum)
			}
			.font(.largeTitle)
			.offset(y: 10)
		}
		.tint(.primary)
		.padding(.horizontal)
    }
}

#Preview {
	Stepper()
}
