//
//  PageControl.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import SwiftUI

public struct PageControl: UIViewRepresentable {
    public class Coordinator: NSObject {
        let parent: PageControl
        
        init(parent: PageControl) {
            self.parent = parent
        }
        
        @objc public func pageControlTapped(sender: UIPageControl) {
            self.parent.currentPage = sender.currentPage
        }
    }
    
    @Binding public var currentPage: Int
    public let numberOfPages: Int
    public let currentPageIndicatorTintColor: UIColor
    public let pageIndicatorTintColor: UIColor
    
    public init(currentPage: Binding<Int>, numberOfPages: Int, currentPageIndicatorTintColor: UIColor = UIColor.white.withAlphaComponent(0.9), pageIndicatorTintColor: UIColor = UIColor.black.withAlphaComponent(0.4)) {
        self._currentPage = currentPage
        self.numberOfPages = numberOfPages
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        self.pageIndicatorTintColor = pageIndicatorTintColor
    }
    
    public func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        pageControl.pageIndicatorTintColor = pageIndicatorTintColor
        pageControl.addTarget(context.coordinator, action: #selector(Coordinator.pageControlTapped(sender:)), for: .valueChanged)
        
        return pageControl
    }
    
    public func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

