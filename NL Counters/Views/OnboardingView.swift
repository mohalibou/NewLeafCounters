//
//  OnboardingView.swift
//  NewLeaf
//
//  Created by Mohamed Ali Boutaleb on 5/24/22.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var showingOnboardingView: Bool
    
    @State private var tabViewIndex = 0
    
    var body: some View {
        VStack {
            TabView(selection: $tabViewIndex) {
                PageView(imageName: "Onboarding1",
                         name: "Welcome to \nNew Leaf Counters",
                         description: "This is an app dedicated to helping you track how long you stay away from your bad habits.").tag(0)
                PageView(imageName: "Onboarding2",
                         name: "How To Create \na New Counter",
                         description: "Once you're on the main menu, press the plus button on the top right. It will open up a menu that will allow you to create your first counter.").tag(1)
                PageView(imageName: "Onboarding3",
                         name: "How To Delete \na Counter",
                         description: "If you want to get rid of a counter, swipe left on the counter, and press the delete button that shows up.").tag(2)
                PageView(imageName: "Onboarding4",
                         name: "How To Edit/Reset \na Counter",
                         description: "If you want to edit the title, icon, or color, or just want to reset the counter, just tap on the counter. It will open up the edit menu, where you may change what you wish.").tag(3)
                PageView(imageName: "Onboarding5",
                         name: "How To Get Help",
                         description: "If you ever need me again to guide you through the app, just press the info icon on the top left. It will open the same screen you're on right now and guide you through the whole process. Have fun!").tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            HStack {
                
                Button(action: {showingOnboardingView.toggle()}) {
                    HStack {
                        Text("Skip")
                            .font(.system(size: 17, weight: .bold))
                            .frame(width: 120, height: 44)
                            .foregroundColor(.gray)
                            .cornerRadius(8)
                            .padding(.leading, 40)
                    }
                }
                Spacer()
                
                
                Button(action: {tabViewIndex != 4 ? tabViewIndex += 1 : showingOnboardingView.toggle()}) {
                    HStack {
                        if (tabViewIndex != 4) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 17, weight: .bold))
                                .frame(width: 120, height: 44)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .padding(.trailing, 40)
                        } else {
                            Text("Get Started")
                                .font(.system(size: 17, weight: .bold))
                                .frame(width: 120, height: 44)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .padding(.trailing, 40)
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(showingOnboardingView: .constant(false))
    }
}

struct PageView: View {
    
    var imageName: String
    var name: String
    var description: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .padding()
                .frame(maxWidth: 500)
            Text(name)
            //.font(.system(size: 60, weight: .bold, design: .default))
                .font(.largeTitle).bold()
                .multilineTextAlignment(.center)
            //.foregroundColor(.white)
                .padding()
            Text(description)
                .font(.subheadline)
                .frame(width: 300)
                .multilineTextAlignment(.center)
            //.foregroundColor(.white)
        }
    }
}
