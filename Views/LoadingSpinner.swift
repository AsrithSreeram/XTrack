//
//  LoadingSpinner.swift
//  CovidTracker
//

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
