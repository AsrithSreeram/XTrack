import SwiftUI



@available(iOS 14.0, *)

struct QRCodeScannerView: View {
    
    @ObservedObject var viewModel = ScannerViewModel()
    @State var alertQR = false
    
    @ViewBuilder
    var body: some View {
        
        ZStack {
            
            QRScannerUIView()
                
                .found(r: self.viewModel.onFoundQrCode)
                
                .torchLight(isOn: self.viewModel.torchIsOn)
                
                .interval(delay: self.viewModel.scanInterval)
            if self.viewModel.lastQrCode != "Qr-code goes here"{
                if Location.exists(self.viewModel.lastQrCode)=="None"{
                    NavigationLink(destination: LocationPreview(self.viewModel.lastQrCode), isActive: .constant(true), label: {})
                } else {
                    //alertQR = !alertQR
                    //AlertView(alertQR: alertQR)
                }

            }
            
            
            VStack {
                
                VStack {
                    
                    Text("Scan for QR Codes")
                        
                        .font(.subheadline)
                }
                
                .padding(.vertical, 20)
                
                
                
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        
                        self.viewModel.torchIsOn.toggle()
                        
                    }, label: {
                        
                        Image(systemName: self.viewModel.torchIsOn ? "bolt.fill" : "bolt.slash.fill")
                            
                            .imageScale(.large)
                            
                            .foregroundColor(self.viewModel.torchIsOn ? Color.yellow : Color.blue)
                            
                            .padding()
                        
                    })
                    
                }
                
                .background(Color.white)
                
                .cornerRadius(10)
                
                
                
            }.padding()
            
        }
    }
    
}

@available(iOS 14.0, *)
struct AlertView: View{
    @State var alertQR: Bool
    var body: some View{
        VStack{
            
        }.alert(isPresented: $alertQR) {
            Alert(title: Text("QR-Code"), message: Text("QR Code couldn't be recognized. Please try again."), dismissButton: .default(Text("Ok")))
        }
    }
}




@available(iOS 14.0, *)

struct QRCodeScannerView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        QRCodeScannerView()
        
    }
    
}

