//
//  ContentView.swift
//  basicChatbot
//
//  Created by Vincent Cloutier on 2021-12-31.
//

import SwiftUI

struct ContentView: View {
    @State private var messageText = ""
    @State var messages: [String] = ["Welcome to ChatShrink 2.0! Please skip any pleasantries and tell me how you feel."]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(messages, id: \.self) { message in
                        // check if message is from user or bot and display view accordingly
                        if message.contains("[USER]") {
                            let userMessage = message.replacingOccurrences(of: "[USER]", with: "")
                            individualMessageView(msg: userMessage, isUserMessage: true)
                        } else {
                            individualMessageView(msg: message, isUserMessage: false)
                        }
                    }
                }
                
                HStack {
                    TextField("Message", text: $messageText)
                        .padding()
                        .background(.regularMaterial)
                        .cornerRadius(10)
                    
                    Button {
                        postMessage(msg: messageText)
                    } label: {
                        Image(systemName: "paperplane.fill")
                    }
                    .disabled(messageText.isEmpty)
                    .padding()
                    .font(.title)
                    
                }
                .padding()
            }
            .navigationTitle("Shrink")
        }
    }
    func postMessage(msg: String) {
        withAnimation {
            messages.append("[USER]" + msg)
            self.messageText = ""
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    messages.append(getBotResponse(message: msg))
                }
            }
        }
    }
}
