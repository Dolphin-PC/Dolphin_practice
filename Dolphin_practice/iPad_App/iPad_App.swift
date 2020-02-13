//
//  iPad_App.swift
//  Dolphin_practice
//
//  Created by 박찬영 on 2020/02/13.
//  Copyright © 2020 박찬영. All rights reserved.
//

import SwiftUI

struct iPad_App: View {
    @State var Hour = 60
    @State var Minute = 60
    var body: some View {
        Text("\(Hour) : \(Minute)")
    }
}

struct large_dots : View{
    var body : some View{
        Group{
            Circle()
                .offset(y:-150)
                .frame(maxWidth:8,maxHeight: 8)
                .foregroundColor(.white)
                .rotationEffect(.degrees(0))
            Circle()
                .offset(y:-150)
                .frame(maxWidth:8,maxHeight: 8)
                .foregroundColor(.white)
                .rotationEffect(.degrees(90))
            Circle()
                .offset(y:-150)
                .frame(maxWidth:8,maxHeight: 8)
                .foregroundColor(.white)
                .rotationEffect(.degrees(180))
            Circle()
                .offset(y:-150)
                .frame(maxWidth:8,maxHeight: 8)
                .foregroundColor(.white)
                .rotationEffect(.degrees(270))
            
        }
    }
}

struct iPad_App_Previews: PreviewProvider {
    static var previews: some View {
        iPad_App()
    }
}

struct watch_face {
    var body : some View{
        ZStack{
        ZStack{
            
            //BackGround
            RadialGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), center: .center, startRadius: 5, endRadius: 500).scaleEffect(1.5)
            
            Circle()
                .stroke(style: .init(lineWidth: 3, lineCap: .round, lineJoin: .round, dash: [0.5,16], dashPhase: 1))
                .frame(maxWidth:300, maxHeight: 300)
                .foregroundColor(.white)
                .opacity(0.3)
            
            large_dots()
            
        }
        
        ZStack{
            Rectangle()
                .frame(width:100, height: 2)
                .foregroundColor(.white)
                .rotationEffect(.degrees(45), anchor: .leading)
                .offset(x : 16, y:6)
            
            Rectangle()
                .frame(width:60, height: 2)
                .foregroundColor(.white)
                .rotationEffect(.degrees(270), anchor : .leading)
                .offset(x : -10, y: -8)
            
            Rectangle()
                .frame(width:200,height:1)
                .foregroundColor(.orange)
            Circle()
                .frame(maxWidth:10,maxHeight: 10)
                .foregroundColor(.orange)
                .offset(x: -100)
            Circle()
                .stroke()
                .frame(maxWidth:20, maxHeight: 20)
                .foregroundColor(.orange)
                .offset(x:110)
        }.offset(x:40)
            
        Circle().frame(maxWidth:20,maxHeight: 20).foregroundColor(.white)
        Circle().frame(maxWidth:15,maxHeight: 15).foregroundColor(.blue)
        Circle().frame(maxWidth:5,maxHeight: 5).foregroundColor(.black)
            
        }
    }
}
