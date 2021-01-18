//
//  ContentView.swift
//  CovidTracker
//
//  Created by Asrith Sreeram on 12/15/20.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
struct NewsView:View{
    init() {
        NewsPost.getAllPosts()
        print("NewsView", newsPosts, newsPosts.count)
        for i in newsPosts{
            print("NewsView",i.title)
        }
    }
    var newsPosts: [NewsPost] = NewsPost.newsArr
    var body: some View{
        ScrollView{
            VStack{
                HStack{
                Text("News")
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                Spacer()
                }
                
                VStack(spacing: 20){
                    ForEach(newsPosts){post in
                        NewsPostView(title: post.title, date: post.date.dateValue(), content: post.body, image: post.image)
                        
                    }
                }
            }
            .padding()
            .background(Color.init(red: 196/255, green: 196/255, blue: 196/255))
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

@available(iOS 14.0, *)
struct NewsPostView:View{
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    var title: String
    var date: Date
    var content: String
    var image: UIImage
    @available(iOS 14.0, *)
    @available(iOS 14.0, *)
    var body: some View{
        VStack(alignment: .leading) {
    VStack(alignment: .leading){
        Text(self.title)
            .font(.title2)
        Text(dateFormatter.string(from: self.date))
            .font(.caption2)
        Text(self.content)
            .font(.caption)
            
    }
    .background(Color.white)
    .padding()
    
        
            Image(uiImage: self.image)
        .resizable()
        .aspectRatio(contentMode: .fit)
    
        }
        .background(Color.white)
        .cornerRadius(20)
        
        
        
    }
}

@available(iOS 14.0, *)
struct ContentView_Previews:PreviewProvider{
    static var previews: some View {
        NewsView()
    }
}
