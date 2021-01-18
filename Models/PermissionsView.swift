//
//  PermissionsView.swift
//  CovidTracker
//
//  Created by Software Development HS_902 on 1/2/21.
//  Copyright © 2021 Software Development HS_902. All rights reserved.
//
//


import SwiftUI

@available(iOS 14.0, *)
struct PermissionsView: View {
    
    var body: some View {
        VStack{
            VStack{
                VStack{
                    Text("This app's initiative is to save lives in the pandemic through the use of contact tracing. We assure you that no personal information will be used in any way or form. Our app uses the camera feature which we understand could be sensitive. This is only used when scanning the QR. You can turn off camera allowance for our app in your phone settings but this will omit the scanning QR feature until it is turned back on. You can turn on or off notifications for your convenience. When entering the app, you have the option to allow notifications and this can always be changed in the iPhone settings.")
                        .foregroundColor(.black)
                }
                .padding(10)
                .background(Color.init(red: 242/255, green: 242/255, blue: 247/255))
                .cornerRadius(20)
            }.padding()
            Spacer()
        }.navigationBarTitle("Permissions", displayMode: .inline)
    }
}

@available(iOS 14.0, *)
struct PermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionsView()
    }
}
