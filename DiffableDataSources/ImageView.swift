//
//  ImageView.swift
//  DiffableDataSources
//
//  Created by Joshua Homann on 4/24/21.
//

import FetchImage
import SwiftUI

struct ImageView: View {
  let url: URL

  @StateObject private var image = FetchImage()

  var body: some View {
    ZStack {
      Rectangle().fill(Color(.systemGray6))
      image.view?
        .resizable()
        .aspectRatio(contentMode: .fill)
        .clipped()
    }
    .onAppear { image.load(url) }
    .onDisappear(perform: image.reset)
  }
}
