//
//  Playground.swift
//  CH3_Group13
//
//  Created by RyanMFDR on 23/05/26.
//
import SwiftUI

struct Playground: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing:12) {
                Rectangle()
                    .fill(Color.gray)
                    .frame(height:180)
                
                VStack(alignment:.leading, spacing: 8) {
                    Text("Category")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.blue.opacity(0.15))
                        .foregroundColor(.blue)
                        .cornerRadius(20)
                    
                    Text("Event Title")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    HStack{
                        Image(systemName: "calendar")
                        Text("Date")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
        
                    HStack{
                        Image(systemName: "mappin")
                        Text("Location")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.black)
                            .frame(height: 120)
                            .cornerRadius(16)

                        Image(systemName: "lock.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                    }
                    Button(action: {
                            print("Register tapped")
                        }) {
                            Text("Register")
                                        .fontWeight(.semibold)
                                        .frame(maxWidth:.infinity,alignment: .center)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                }
                    
                }
            }.cornerRadius(20)
                .padding()
                .shadow(radius: 5)
                .background(Color.white)
            
        }
    }
}

#Preview {
    Playground()
}
