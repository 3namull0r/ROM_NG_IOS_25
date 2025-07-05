//
//  PageControl.swift
//  DontJudge
//
//  Created by 3namull0r on 05/07/2025.
//
import SwiftUI

struct PageControl: UIViewRepresentable {
  @Binding var currentPage: Int?
  var numberOfPages: Int
  
  func makeUIView(context: Context) -> UIPageControl {
    let control = UIPageControl()
    control.pageIndicatorTintColor = UIColor.blue.withAlphaComponent(0.15)
    control.currentPageIndicatorTintColor = .blue
    control.addTarget(context.coordinator, action: #selector(Coordinator.pageChanged(_:)), for: .valueChanged)
    return control
  }
  
  func updateUIView(_ uiView: UIPageControl, context: Context) {
    uiView.numberOfPages = numberOfPages
    uiView.currentPage = currentPage ?? 0
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject {
    var control: PageControl
    
    init(_ control: PageControl) {
      self.control = control
    }
    
    @objc func pageChanged(_ sender: UIPageControl) {
      control.currentPage = sender.currentPage
    }
  }
}
