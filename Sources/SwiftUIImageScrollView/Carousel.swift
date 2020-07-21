//
//  Carousel.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import SwiftUI

public struct Carousel<Content: View>: UIViewRepresentable {
    public class Coordinator: NSObject, UIScrollViewDelegate {
        public let parent: Carousel
        
        public init(parent: Carousel) {
            self.parent = parent
        }
        
        public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let page = Int(scrollView.contentOffset.x/UIScreen.main.bounds.size.width)
            parent.currentPage = page
        }
    }
    
    public let numberOfPages: Int
    @Binding public var currentPage: Int
    public let width: CGFloat
    public let height: CGFloat
    public let content: () -> Content

    public init(numberOfPages: Int, currentPage: Binding<Int>, width: CGFloat, height: CGFloat, @ViewBuilder _ content: @escaping () -> Content) {
        self.numberOfPages = numberOfPages
        self._currentPage = currentPage
        self.width = width
        self.height = height
        self.content = content
    }

    public func makeUIView(context: Context) -> UIScrollView {
        let totalWidth: CGFloat = CGFloat(numberOfPages) * width
        
        let scrollView = UIScrollView(frame: .zero)
        scrollView.contentSize = CGSize(width: totalWidth, height: 1.0)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = true
        scrollView.delegate = context.coordinator
        
        let vc = UIHostingController(rootView: content())
        vc.view.frame = CGRect(x: 0, y: 0, width: totalWidth, height: height)
        vc.view.backgroundColor = .clear
        
        scrollView.addSubview(vc.view)
        
        return scrollView
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func offset(for page: Int) -> CGFloat {
        CGFloat(page) * width
    }
    
    public func updateUIView(_ uiView: UIScrollView, context: Context) {
        guard offset(for: currentPage) != uiView.contentOffset.x && currentPage < numberOfPages else {
            return
        }
        
        uiView.setContentOffset(CGPoint(x: CGFloat(currentPage) * width, y: 0), animated: true)
    }
    
    public func nextPage() {
        guard currentPage < numberOfPages else {
            return
        }
        
        currentPage += 1
    }
}

