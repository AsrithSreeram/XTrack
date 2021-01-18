//
//  TracerView.swift
//  CovidTracker
//
//  Created by Software Development HS_902 on 12/17/20.
//  Copyright © 2020 Software Development HS_902. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct TracerView: View {
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink(
                    destination: QRCodeScannerView()) {
                    HStack {
                        Image(systemName: "camera")
                            .font(.title)
                        Text("Scan QR")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(40)
                }.navigationBarTitle("Tracer")
                Divider().background(Color.blue).frame(width: 200).frame(height: 30)
                NavigationLink(destination: EnterLocationView()) {
                    HStack {
                        Image(systemName: "location")
                            .font(.title)
                        Text("Make QR")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(40)
                }
            }
            
        }
    }
}

@available(iOS 14.0, *)
struct TracerView_Previews: PreviewProvider {
    static var previews: some View {
        TracerView()
    }
}
