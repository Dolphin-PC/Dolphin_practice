//
//  Analogue_Watch_Interface.swift
//  Dolphin_practice
//
//  Created by 박찬영 on 2020/02/14.
//  Copyright © 2020 박찬영. All rights reserved.
//

import SwiftUI
import Foundation

struct Analogue_Watch_Interface: View {
    @State var isExpanded : Bool = false
    private let headerHeight : CGFloat = 100
    
    var body : some View{
        VStack{
            if !isExpanded{
                Header().transition(.move(edge:.leading))
                WatchView(diameter: 170).transition(.scale)
                SavedTimeZones().transition(.move(edge:.leading))
                BottomNavBar()
                .overlay(
                    ZStack(alignment: .bottom) {
                        HStack{
                            if self.isExpanded{
                                VStack{
                                    Text("Hello world")
                                }
                            }
                        }.frame(width : self.isExpanded ? UIScreen.main.bounds.width : 50, height : self.isExpanded ? UIScreen.main.bounds.height - headerHeight - sheetTop : 50)
                            .background(LinearGradient(gradient: Gradient(colors:[Color(.blue),Color(.purple)]), startPoint: .topTrailing, endPoint: .bottomLeading))
                            .cornerRadius(isExpanded ? 0 : 10)
                            .clipShape(TopRoundedShape(cornerRadius: isExpanded ? 40 : 10))
                            .offset(x: isExpanded ? 0 : UIScreen.main.bounds.width / 3, y: isExpanded ? 0 : -50)
                        
                        AddButton(isExpanded : self.$isExpanded)
                    }, alignment: .bottom
                )
            }
        }
    }
    
}

struct Analogue_Watch_Interface_Previews: PreviewProvider {
    static var previews: some View {
        Analogue_Watch_Interface()
    }
}

struct TopRoundedShape : Shape {
    var cornerRadius : CGFloat = 40
    
    var animatableData: CGFloat{
        get{
            cornerRadius
        }
        
        set{
            cornerRadius = newValue
        }
    }
    
    func path(in rect:CGRect) -> Path{
        var path = Path()
        path.move(to : CGPoint(x:0,y:cornerRadius))
        path.addQuadCurve(to: CGPoint(x: cornerRadius,y:0), control: CGPoint.zero)
        path.addLine(to : CGPoint(x: rect.width - cornerRadius, y:0))
        path.addQuadCurve(to: CGPoint(x:rect.width,y:cornerRadius), control: CGPoint(x:rect.width, y:0))
        path.addLine(to: CGPoint(x:rect.width, y: rect.height))
        path.addLine(to: CGPoint(x:0, y:rect.height))
        path.closeSubpath()
        
        return path
        
    }
}
struct TimeZone : Identifiable {
    let id : UUID
    let Country : String
    let City : String
    let time : String
    
    static func data() -> [TimeZone]{
        return[
            TimeZone(id: UUID(), Country: "USA", City: "Chicago", time: "7:00 AM"),
            TimeZone(id: UUID(), Country: "Croatia", City: "Zagreb", time: "5:00 AM"),
            TimeZone(id: UUID(), Country: "Ireland", City: "Limerick", time: "15:00 AM"),
            TimeZone(id: UUID(), Country: "Burundi", City: "Bujumbura", time: "10:00 AM")
        ]
    }
}

struct TimeZoneView : View {
    var timeZone = TimeZone.data().first!
    
    var body: some View{
        HStack{
            VStack(alignment : .leading) {
                Text(timeZone.Country)
                    .font(.system(size:15,weight: Font.Weight.black))
                Text(timeZone.City)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(timeZone.time).font(.system(size: 20,weight:Font.Weight.black))
        }.frame(maxWidth : .infinity).padding(30).background(Color.white).cornerRadius(20).shadow(color: Color.gray.opacity(0.2), radius: 8, x: 0, y: 8).padding(.horizontal)
            
        
    }
}

struct AddedTimeZoneView : View {
    var timeZone = TimeZone.data().first!
    
    var body : some View{
        VStack(alignment: .leading){
            Text(timeZone.Country)
                .font(.system(size: 15,weight:Font.Weight.black))
            Text(timeZone.City).foregroundColor(Color.gray)
            }.padding().background(Color.white).cornerRadius(20)
            .shadow(color: Color.gray.opacity(0.2), radius: 8, x: 0, y: 0)
    }
}

struct Header : View {
    var headerHeight : CGFloat = 100
    
    var body : some View{
        VStack{
            HStack{
                Spacer()
                Image(systemName: "person.crop.circle")
                    .resizable().frame(width:30,height:30)
                    .padding(.horizontal)
            }
            Text("Burundi")
            Text("Sun, 10 Nov 2019")
        }.frame(height : self.headerHeight)
    }
}

struct SavedTimeZones : View {
    var body : some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                ForEach(TimeZone.data()){ timeZone in
                    TimeZoneView(timeZone: timeZone)
                }
            }
        }
    }
}
struct BottomNavBar : View {
    var body : some View{
        HStack{
            Image(systemName: "square.grid.2x2").resizable().frame(width:20, height:20)
            Spacer()
            Image(systemName: "alarm").resizable().frame(width:20, height:20)
            Spacer()
            Image(systemName: "person").resizable().frame(width:20, height:20)
            Spacer()
            
        }.padding(30).frame(maxWidth: .infinity,alignment: .top).background(Color.white)
        .clipShape(TopRoundedShape(cornerRadius: 30))
            .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: -5)
        
    }
}
struct AddButton : View {
    @Binding var isExpanded : Bool
    var body : some View{
        Button(action : {
            withAnimation(.spring()) {
                self.isExpanded.toggle()
            }
        }){
            Image(systemName: "plus")
            .padding()
                .background(isExpanded ? Color.white : Color.clear)
                .foregroundColor(isExpanded ? Color.black : Color.white)
                .cornerRadius(isExpanded ? 25 : 0)
                .rotationEffect(Angle(degrees: isExpanded ? 45 : 90), anchor: .center)
        }.offset(x:isExpanded ? 0 : UIScreen.main.bounds.width / 3, y: -50 )
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
