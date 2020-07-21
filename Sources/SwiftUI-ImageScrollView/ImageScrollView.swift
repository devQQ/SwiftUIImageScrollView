//
//  ImageScrollView.swift
//  
//
//  Created by Q Trang on 7/20/20.
//

import SwiftUI

public struct ImageScrollView<Content: View>: View {
    public let numberOfPages: Int
    @Binding public var currentPage: Int
    public let width: CGFloat
    public let height: CGFloat
    public let hidePageIndicators: Bool
    public let content: () -> Content
    
    public let currentPageIndicatorTintColor: UIColor
    public let pageIndicatorTintColor: UIColor
    
    @State var didTapIndicator: Bool = false
    
    public init(numberOfPages: Int, currentPage: Binding<Int>, width: CGFloat, height: CGFloat, hidePageIndicators: Bool = false, @ViewBuilder _ content: @escaping () -> Content, currentPageIndicatorTintColor: UIColor = UIColor.white.withAlphaComponent(0.8), pageIndicatorTintColor: UIColor = UIColor.gray) {
        self.numberOfPages = numberOfPages
        self._currentPage = currentPage
        self.width = width
        self.height = height
        self.hidePageIndicators = hidePageIndicators
        self.content = content
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        self.pageIndicatorTintColor = pageIndicatorTintColor
    }
    
    public var body: some View {
        ZStack(alignment: .bottomLeading) {
            Carousel(numberOfPages: numberOfPages, currentPage: self.$currentPage, width: width, height: height, content)
                .frame(width: width, height: height)
            
            if !self.hidePageIndicators {
                HStack {
                    Spacer()
                    PageControl(currentPage: $currentPage, numberOfPages: numberOfPages, currentPageIndicatorTintColor: currentPageIndicatorTintColor, pageIndicatorTintColor: pageIndicatorTintColor)
                        .padding()
                    Spacer()
                }
            }
        }
    }
}

