//
//  Analogue_Watch_Interface.swift
//  Dolphin_practice
//
//  Created by 박찬영 on 2020/02/14.
//  Copyright © 2020 박찬영. All rights reserved.
//

import SwiftUI

struct Analogue_Watch_Interface: View {
    
    var body : some View{
        WatchView()
    }
    
}

struct Analogue_Watch_Interface_Previews: PreviewProvider {
    static var previews: some View {
        Analogue_Watch_Interface()
    }
}

struct WatchView : View{
    var diameter : CGFloat = 200
    var smallCapsuleHeight : CGFloat = 5
    var bigCapsuleHeight : CGFloat = 10
    
    @State var hours : Double = 0.0
    @State var minutes : Double = 0.0
    @State var seconds : Double = 0.0
    
    var body : some View{
        VStack{
            createWatch()
            Text("\(hours < 10 ? "0" : "")\(Int(hours)):\(minutes < 10 ? "0" : "")\(Int(minutes)):\(seconds < 10 ? "0" : "")\(Int(seconds))")
                .font(.system(size:70, weight: .black))
        }.onAppear{
            let date = Date()
            self.hours = self.getTimeComponent(from: date, format: "HH")
            self.minutes = self.getTimeComponent(from: date, format: "mm")
            self.seconds = self.getTimeComponent(from: date, format: "ss")
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                let date = timer.fireDate
                
                self.hours = self.getTimeComponent(from: date, format: "HH")
                self.minutes = self.getTimeComponent(from: date, format: "mm")
                self.seconds = self.getTimeComponent(from: date, format: "ss")
            }
        }
    }
    
    func createWatch() -> some View {
        let angle = 360/60
        let hourAngle = 360/12
        let interval = 360/angle
        
        let hourLength : CGFloat = diameter / 2 * 0.4
        let minuteLength : CGFloat = diameter / 2 * 0.7
        let secondLength : CGFloat = diameter / 2 * 0.8
        
        return ZStack {
            WatchFrame(size : self.diameter + 40, borderSize: 20)
            
            ForEach(0..<interval){ i in
                self.createSecondMark(position: i, angle : angle)
            }
            
            WatchHand(handWidth: 2, handHeight: hourLength, color: Color.black)
                .offset(y: -(hourLength/2) + 1.0)
                .rotationEffect(Angle(degrees: hours * Double(hourAngle) + (Double(hourAngle) * minutes / 60.0)), anchor: .center)
            
            WatchHand(handWidth: 2, handHeight: minuteLength, color: Color.black)
                .offset(y: -(minuteLength/2) + 1.0)
                .rotationEffect(Angle(degrees: minutes * Double(angle) + (Double(angle) * seconds / 60.0)), anchor: .center)
            
            WatchHand(handWidth: 2, handHeight: secondLength, color: Color.red)
                .offset(y: -(secondLength/2) + 1.0)
                .rotationEffect(Angle(degrees: seconds * Double(angle)), anchor: .center)
            
            
        }
    }
    
    func createSecondMark(position : Int, angle : Int) -> some View{
        if position.isMultiple(of: 5){
            return Capsule().frame(width : 2, height: self.bigCapsuleHeight)
                .offset(y:self.diameter/2 - self.bigCapsuleHeight/2).rotationEffect(Angle(degrees: Double(position * angle))).foregroundColor(Color.gray)
        }
        else{
            return Capsule().frame(width : 1, height: self.smallCapsuleHeight)
                .offset(y:self.diameter/2 - self.smallCapsuleHeight/2).rotationEffect(Angle(degrees: Double(position * angle))).foregroundColor(Color.gray)
        }
    }
    
    func getTimeComponent(from date : Date, format : String) -> Double{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.autoupdatingCurrent
        let component = formatter.string(from: date)
        
        if let value = Double(component) {
            return value
        }
        return 0.0
    }
}

struct WatchHand : View {
    var handWidth : CGFloat = 10
    var handHeight : CGFloat = 100
    var color : Color = Color.blue
    
    var body: some View {
        VStack(spacing : -(handWidth/2)){
            Capsule()
                .frame(width: handWidth, height: handHeight)
                .foregroundColor(color)
            Circle()
                .frame(width:handWidth*2,height: handWidth * 2)
                .foregroundColor(color)
        }
    }
}

struct WatchFrame : View{
    var size : CGFloat = 200
    var borderSize : CGFloat = 20
    
    var body : some View{
        ZStack{
            Circle()
                .frame(width:size,height:size)
                .foregroundColor(Color.clear)
                .background(RadialGradient(gradient: Gradient(colors: [Color.white,Color.black]), center: .center, startRadius: size*0.41, endRadius: size))
            
            Circle()
            .stroke(style: StrokeStyle(lineWidth: borderSize))
                .frame(width : size,height: size)
                .foregroundColor(.white)
            
        }.cornerRadius(size/2)
            .shadow(color:Color.gray.opacity(0.3), radius: 12, x:0,y:0)
    }
}
