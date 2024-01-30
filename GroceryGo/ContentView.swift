//
//  ContentView.swift
//  GroceryGo
//
//  Created by İrem Sever on 15.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var changeScreen = false
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 30){
                Image("mainmenu")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 800, height: 700)
                Text("GroceryGo")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.green)
                    .offset(y:-550)
                Button(){
                    changeScreen = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 50)
                        Text("Get Started")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                            .bold()
                    }
                }.frame(width: 200, height: 70)
                    .foregroundColor(.green)
                    .offset(y:-100)
            }
            .navigationDestination(isPresented: $changeScreen) {
                ShopView()
            }
        }
    }
}
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }


