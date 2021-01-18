//
//  EnterLocationView.swift
//  CovidTracker
//
//  Created by Software Development HS_902 on 12/18/20.
//  Copyright © 2020 Software Development HS_902. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct EnterLocationView: View {
    @State var name: String = ""
    @State var address: String = ""
    @State var submitted: Bool = false
    var body: some View{
            VStack{
                Text("Enter Location:")
                    .font(.largeTitle)
                TextField("Enter Name", text: $name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Enter Location", text: $address)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    print("Hello Scanning")
                }) {
                    NavigationLink(
                        destination: QRCodeView(name, address, submitted), isActive: $submitted,
                        label: {
                            HStack {
                                Text("Submit Location")
                                        .fontWeight(.semibold)
                                        .font(.title3)
                            }
                            .padding(10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(40)
                        })
                 

                }
            }.edgesIgnoringSafeArea([.top])
    }
}


@available(iOS 14.0, *)
struct EnterLocationView_Previews: PreviewProvider {
    static var previews: some View {
        EnterLocationView()
    }
}
