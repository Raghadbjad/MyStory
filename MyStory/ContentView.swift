//
//  ContentView.swift
//  MyStory
//
//  Created by Raghad on 14/06/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplash = false
    var body: some View {
        
        if showSplash {
            log()
        }
        else{
            NavigationView {
                ZStack {
                    
                    Image("backg")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .padding(.all, -100)
                    
                        .onAppear{
                            
                        }
                    VStack {
                        
                        Image("im1")
                            .frame(width: 250, height: 250)
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("استمع، تخيل، وعبّر... مرحبًا بك في عالم الحكايات!")
                            .font(.custom("SF Arabic", size: 40))
                            .shadow(radius: 15)
                            .multilineTextAlignment(.center)
                            .fontWeight(.bold)
                            .animation(.easeInOut).onAppear{DispatchQueue.main.asyncAfter(deadline: .now() + 3.0 ){
                                self.showSplash = true
                            }}
                        
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}


import SwiftUI

struct story: View {
    @State private var selectedCharacter: String? = nil
    @Binding var recommendedIntake: Double

    var body: some View {
        ZStack {
    Image("backg")
    .resizable()
    .edgesIgnoringSafeArea(.all)
    VStack {
    VStack {
    Image("prof")
            .frame(width: 100, height:-200)
            .padding(.leading, 1100)
    }
    .padding(.bottom, 190)
    HStack(spacing: 40) {
    Button(action: {
    selectedCharacter = "Boy"
 }) {
VStack {
Image("str1")                                        .frame(width: 450, height:290)
        .padding(10)

    Text("اصنع قصتك")
        .font(.custom("SF Arabic", size: 40))
        .shadow(radius: 15)
        .fontWeight(.bold)
        .foregroundColor(.black)
                                }
                                .padding()
                                .background(selectedCharacter == "Boy" ? Color.blue.opacity(0.2) : Color.white)
                                .cornerRadius(12)
                                .shadow(radius: 3)
                            }
                            Button(action: {
                                selectedCharacter = "Girl"
                            }) {
                                VStack {
                                    Image("str2")
                                        .resizable()
                                        .frame(width: 450, height: 290)
                                    
                                    Text("اكتشف القصص")
                                        .font(.custom("SF Arabic", size: 40))
                                        .shadow(radius: 15)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .padding(10)
                                }
                                .padding()
                                .background(selectedCharacter == "Girl" ? Color.blue.opacity(0.2) : Color.white)
                                .cornerRadius(12)
                                .shadow(radius: 3)
                            }
                        }
                        
                    }
                }
                        }
            
        }
   
#Preview {
    story(recommendedIntake: .constant(9))
}


import SwiftUI

struct log: View {
    @State private var selectedCharacter: String? = nil
    @State private var recommendedIntake: Double = 0.0
    @State var show = false
    
    var body: some View {
//        NavigationView{
            ZStack {
                Image("backg")                        .resizable()
                    .edgesIgnoringSafeArea(.all)
                Text("اختر شخصيتك:")
                    .font(.custom("SF Arabic", size: 50))
                    .shadow(radius: 15)
                    .padding(.bottom, 650)
                
                Button(action: {
                    show = true
                }) {
                    
                    NavigationLink(destination:backup())/*.navigationBarBackButtonHidden(true)*/
                    {
                        Image("button")
                            .frame(width: 100, height:-200)                            .padding(.leading, 900)
                            .padding(.top, 20)
                        
                    }            .navigationBarBackButtonHidden(true)
                }
                
                HStack(spacing: 40) {
                    Button(action: {
                        selectedCharacter = "Boy"
                    }) {
                        VStack {
                            Image("boy")
                                .resizable()
                                .frame(width: 350, height:400)
                            
                            Text("ولد")
                                .font(.custom("SF Arabic", size: 60))
                                .shadow(radius: 15)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(selectedCharacter == "Boy" ? Color.blue.opacity(0.2) : Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                    }
                    
                    Button(action: {
                        selectedCharacter = "Girl"
                    }) {
                        VStack {
                            Image("girl")
                                .resizable()
                                .frame(width: 350, height: 400)
                            
                            Text("بنت")
                                .font(.custom("SF Arabic", size: 60))
                                .shadow(radius: 15)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(selectedCharacter == "Girl" ? Color.blue.opacity(0.2) : Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                    }
                    
                }
            }.fullScreenCover(isPresented: $show) {
                backup()
            }
//        }
        //        NavigationLink(destination: backup()) {
        //            Text("")
        //        }
    }
}



#Preview {
    log()
}



struct backup: View {
    @State private var selectedCharacter: String? = nil
    
    var body: some View {
        ZStack {
            Image("backg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    Image("prof")
                        .frame(width: 100, height:-200)
                        .padding(.leading, 1100)
                    Text("أختر خلفيتك:")
                        .font(.custom("SF Arabic", size: 60))
                        .shadow(radius: 15)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                .padding(.bottom, 20)
                
                HStack(spacing: 40) {
                    Button(action: {
                        selectedCharacter = "Boy"
                    }) {
                        VStack {
                            Image("school")
                                .resizable()
                .frame(width: 450, height:400)
                            
                            Text("المدرسة")
                                .font(.custom("SF Arabic", size: 60))
                                .shadow(radius: 15)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(selectedCharacter == "Boy" ? Color.blue.opacity(0.2) : Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                    }
                    
                    Button(action: {
                        selectedCharacter = "Girl"
                    }) {
                        VStack {
                            Image("home")
                                .resizable()
                                .frame(width: 450, height: 400)
                            
                            Text("المنزل")
                                .font(.custom("SF Arabic", size: 60))
                                .shadow(radius: 15)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(selectedCharacter == "Girl" ? Color.blue.opacity(0.2) : Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                    }
                }
                
            }
        }
                }
            }


#Preview {
    backup()
}
