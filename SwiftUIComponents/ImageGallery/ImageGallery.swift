//
//  ImageGallery.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/26.
//

import SwiftUI

struct ImageGallery: View {
	@StateObject var dataModel = ImageGalleryDataModel()
	
    var body: some View {
		ImageGalleryGridView()
			.environmentObject(dataModel)
    }
}

#Preview {
    ImageGallery()
}
