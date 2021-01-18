//
//  ContentView.swift
//  CovidTracker
//
//  Created by Software Development HS_902 on 12/15/20.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
struct NewsView:View{
    /*
    init() {
        print("Calling NewsPost.getAllPosts() from NewsView")
        NewsPost.getAllPosts()
        print("NewsView", newsPosts, newsPosts.count)
        for i in newsPosts{
            print("NewsView",i.title)
        }

    }*/
    init(){
        newsPosts.getAllPosts()
        print("Ran get all posts")
    }
    @ObservedObject var newsPosts: NewsRepository = NewsRepository()
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
                    ForEach(newsPosts.newsPosts){post in
                        NewsPostView(title: post.title, date: post.date.dateValue(), content: post.body, image: post.image)
                        
                    }
                }
            }
            .padding()
            .padding(.top, 20)
        }
    }
}

@available(iOS 14.0, *)
struct NewsPostView:View{
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "MM-dd-yy h:mm a"
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
            .foregroundColor(.black)
        Text(dateFormatter.string(from: self.date))
            .font(.caption2)
            .foregroundColor(.black)
        Text(self.content)
            .font(.caption)
            .foregroundColor(.black)
    }
    .padding()
    
        
            Image(uiImage: self.image)
        .resizable()
        .aspectRatio(contentMode: .fit)
    
        }
        .background(Color.init(red: 242/255, green: 242/255, blue: 247/255))
        .cornerRadius(20)
        
        
        
    }
}

@available(iOS 14.0, *)
struct NewsView_Previews: PreviewProvider{
    static var previews: some View {
        NewsView()
    }
}
