//
//  LoadingSpinner.swift
//  CovidTracker
//
//  Created by Software Development HS_902 on 1/9/21.
//  Copyright © 2021 Software Development HS_902. All rights reserved.
//

import SwiftUI
import UIKit

@available(iOS 14.0, *)
struct LoadingSpinner: UIViewRepresentable {
    @Binding var animate: Bool
    
    func makeUIView(context: UIViewRepresentableContext<LoadingSpinner>) -> UIActivityIndicatorView{
        return UIActivityIndicatorView(style: .large)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<LoadingSpinner>) {
        uiView.startAnimating()
    }
}

@available(iOS 14.0, *)
struct LoadingSpinner_Previews: PreviewProvider {
    static var previews: some View {
        LoadingSpinner(animate: .constant(true))
    }
}
