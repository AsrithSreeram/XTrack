//
//  QRCodeView.swift
//  CovidTracker
//
//  Created by Software Development HS_902 on 12/18/20.
//  Copyright © 2020 Software Development HS_902. All rights reserved.
//
import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

@available(iOS 14.0.0, *)
struct QRCodeView: View{
    let context=CIContext()
    let filter=CIFilter.qrCodeGenerator()
    var text: String
    @State var alert: Bool = false
    
    init(_ name: String, _ address: String, _ submitted: Bool) {
        print("Text to Encode:", address)
        self.text=address
        if Location.exists(self.text) == "Error" && submitted{
            Location.init(name, self.text)
        }
    }
    
    var body: some View{
        NavigationView{
            VStack(spacing: 30){
            Image(uiImage: generateQRCodeImage(text))
                .interpolation(.none)
                .resizable()
                .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Button(action: {
                UIPasteboard.general.image = generateQRCodeImage(text)
                alert.toggle()
            }, label: {
                Text("Copy QR")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            })
            .padding(10)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(40)
                Spacer()
            }
            .padding()
            .navigationBarTitle("QR Generator")
        }
        .alert(isPresented: $alert){
            Alert(title: Text("QR Copied!"), message: Text("QR Code has been copied to your clipboard."), dismissButton: .default(Text("Ok")))
        }
    }
    
    func generateQRCodeImage(_ string: String) -> UIImage{
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let qrCodeImage=filter.outputImage{
            if let qrCodeCGImage=context.createCGImage(qrCodeImage, from: qrCodeImage.extent){
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        return UIImage(systemName: "xmark") ?? UIImage()
    }
}
@available(iOS 14.0, *)
struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView("Walmart", "3467 Lincoln Hwy E, Thorndale, PA 19372", true)
    }
}
