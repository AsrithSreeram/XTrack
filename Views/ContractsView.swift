//
//  ContractsView.swift
//  Pods
//
//  Created by Software Development HS_902 on 12/17/20.
//

import SwiftUI

@available(iOS 14.0, *)
struct ContractsView: View {
    
    var body: some View {
        VStack{
            VStack{
                VStack{
                    Text("This app's initiative is to save lives in the pandemic through the use of contact tracing. We assure you that no personal information will be used in any way or form. While using this app, you are expected to be truthful and not withhold any information to save lives! We urge you to consider the consequences of lying as it may cause thousands of deaths and an even more prolonged pandemic. All data, including names and locations, collected by this app will remain confidential and will not be sold or publicized to others.")
                        .foregroundColor(.black)
                }
                .padding(10)
                .background(Color.init(red: 242/255, green: 242/255, blue: 247/255))
                .cornerRadius(20)
            }.padding()
            Spacer()
        }.navigationBarTitle("Contracts", displayMode: .inline)
    }
}

@available(iOS 14.0, *)
struct ContractsView_Previews: PreviewProvider {
    static var previews: some View {
        ContractsView()
    }
}
