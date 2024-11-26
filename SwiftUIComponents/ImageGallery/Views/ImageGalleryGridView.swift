//
//  GridView.swift
//  SwiftUIComponents
//
//  Created by Andy Chao on 2024/11/26.
//

import SwiftUI

struct ImageGalleryGridView: View {
	@EnvironmentObject var dataModel: ImageGalleryDataModel
	@Namespace private var animation
	
	private static let initialColumns = 3
	@State private var isAddingPhoto = false
	@State private var isEditing = false
	
	@State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
	@State private var numColumns = initialColumns
	
	private var columnsTitle: String {
		let columnCount = gridColumns.count
		let columnText = NSLocalizedString("column_text", comment: "Column text for grid layout")
		return columnCount > 1 ? "\(columnCount) \(columnText)" : "1 \(columnText)"
	}
	
    var body: some View {
		NavigationStack {
			ZStack {
				VStack {
					if isEditing {
						CustomStepper(title: columnsTitle, range: 1...8, columns: $gridColumns)
							.padding()
					}
					
					ScrollView {
						LazyVGrid(columns: gridColumns) {
							ForEach(dataModel.items) { item in
								GeometryReader { geo in
									NavigationLink(value: item) {
										ImageGalleryGridItemView(size: geo.size.width, item: item)
									}
								}
								.matchedTransitionSource(id: item.id, in: animation) { config in
									config
										.background(.clear)
										.clipShape(.rect(cornerRadius: 20))
								}
								.cornerRadius(8)
								.aspectRatio(1, contentMode: .fit)
								.overlay(alignment: .topTrailing) {
									if isEditing {
										Button {
											withAnimation {
												dataModel.removeItem(item)
											}
										} label: {
											Image(systemName: "xmark.circle.fill")
												.font(.title2)
												.symbolRenderingMode(.palette)
												.foregroundStyle(.gray, .white)
										}
										.offset(x: -3, y: 3)
									}
								}
							}
						}
						.padding()
					}
					.navigationDestination(for: ImageGalleryItem.self) { index in
						GeometryReader { geo in
							ImageGalleryDetailView(item: index)
								.frame(width: geo.size.width, height: geo.size.height)
						}
						.padding(5)
						.navigationTitle("detail")
						.navigationBarTitleDisplayMode(.inline)
						.navigationTransition(.zoom(sourceID: index.id, in: animation))
					}
				}
			}
			.navigationTitle("image_gallery")
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					Button {
						withAnimation {
							isEditing.toggle()
						}
					} label: {
						Text(isEditing ? "done" : "edit")
					}
				}
				
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						isAddingPhoto = true
					} label: {
						Image(systemName: "plus")
					}
					.disabled(isEditing)
				}
			}
		}
		.sheet(isPresented: $isAddingPhoto) {
			PhotoPicker()
		}
    }
}
