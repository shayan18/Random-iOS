//
//  ActivityIndicator.swift
//  Random
//
//  Created by Shayan Ali on 02.02.23.
//

import SwiftUI

public struct ActivityIndicator: UIViewRepresentable {
  let style: UIActivityIndicatorView.Style
  let color: UIColor
  @Binding var isAnimating: Bool

  public init(style: UIActivityIndicatorView.Style, color: UIColor = .black, isAnimating: Binding<Bool>) {
    self.style = style
    self.color = color
    _isAnimating = isAnimating
  }

  public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
    let activityIndicator = UIActivityIndicatorView(style: style)
    activityIndicator.color = color
    return activityIndicator
  }

  public func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
    isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
  }
}

