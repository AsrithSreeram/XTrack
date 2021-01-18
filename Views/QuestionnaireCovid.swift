//
//  Questionnaire.swift
//  CovidTracker
//
//  Created by Software Development HS_902 on 12/26/20.
//  Copyright © 2020 Software Development HS_902. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct QuestionnaireCovid: View {
    @ObservedObject var questions = SurveyQuestions()
    @ObservedObject var user = User()
    @State var submitted: Bool = false
    @State var moreQuarantine: Bool = false
    @State var lessQuarantine: Bool = false
    @State var noQuarantine: Bool = false
    
    var body: some View {
        ScrollView{
        VStack{
            HStack{
                Text("Covid Questionnaire")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                Spacer()
                NavigationLink(destination: UpdatesView()){
                    Image(systemName: "xmark")
                }
            }.padding(30)
            .alert(isPresented: $lessQuarantine){
                return Alert(title: Text("Quarantine"), message: Text("We recommend you to quarantine for 5-7 days from now."), dismissButton: .default(Text("Ok")){
                    self.submitted.toggle()
                })
            }
            VStack(spacing: 20){
                Text("Please answer these questions to the best of your ability. By doing so, you save lives. Check all that apply.")
                    .foregroundColor(.black)
                    .frame(height: 100.0)

                VStack{
                    ForEach(0..<self.questions.arrOfQuestions.count){ i in
                        QuestionView(self.questions.arrOfQuestions[i])
                        if i != self.questions.arrOfQuestions.count-1{
                            Divider()
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(25)
            }.padding([.leading, .trailing, .bottom], 20)
            .alert(isPresented: $moreQuarantine){
                return Alert(title: Text("Quarantine"), message: Text("We recommend you to quarantine for 7-14 days from now."), dismissButton: .default(Text("Ok")){
                    self.submitted.toggle()
                })
            }
            NavigationLink(
                destination: SubmitSymptomsFormView(questions, submitted),
                isActive: $submitted) {}
            .alert(isPresented: $noQuarantine){
                    return Alert(title: Text("No Quarantine"), message: Text("Be Cautious"), dismissButton: .default(Text("Ok")){
                        self.submitted.toggle()
                    })
            }
            Button(action: {
                let message = self.user.performEvaluation(questions)
                print("Message in survey", message)
                if message == "14 days of quarantine"{
                    self.moreQuarantine.toggle()
                }else if message == "5-7 days of quarantine"{
                    self.lessQuarantine.toggle()
                }else{
                    self.noQuarantine.toggle()
                }
            }){
                HStack {
                        Text("Submit")
                            .fontWeight(.semibold)
                            .font(.title3)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(30)
            }.padding()
        }
        }.background(Color.init(red: 242/255, green: 242/255, blue: 247/255))
    }
}

@available(iOS 14.0, *)
struct QuestionView: View{
    @ObservedObject var question: Question

    init(_ question: Question){
        self.question=question
    }

    var body: some View{
        HStack{
            Text(question.question)
                .foregroundColor(.black)
            Spacer()
            Button(action: {question.answer = !question.answer}){
                ZStack{
                    Circle()
                        .fill(Color.init(red: 215/255, green: 215/255, blue: 215/255))
                        .frame(width: 25, height: 25)
                
                    if question.answer{
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 12, height: 12)
                    }
                }
            }
        }
    }
}

@available(iOS 14.0, *)
struct QuestionnaireCovid_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireCovid()
    }
}
