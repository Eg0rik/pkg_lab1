//
//  ContentView.swift
//  laba1
//
//  Created by MAC on 9/11/23.
//

import SwiftUI

func rgbToString(_ value: Double) -> String {
    String(Int(value))
}

func cmykToString(_ value: Double) -> String {
    String(round(value*100)/100)
}

func hlsToString(_ value:Double) -> String {
    String(round(value*100)/100)
}

struct ContentView: View {

    @State var data = Data()

    var arr:[String] = ["CMYK","RGB","HLS"]

    var body: some View {


        VStack {

            Picker("choose", selection: $data.selected) {

                ForEach(arr,id: \.self) { item in
                    Text(item)
                        .tag(item)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            switch data.selected {

                case "CMYK":

                    VStack {

                        Text(data.selected)

                        MyRectangle(color: data.myColor)

                        Spacer()

                        HStack {

                            Text("r:\(rgbToString(data.r)) g:\(rgbToString(data.g)) b:\(rgbToString(data.b))")
                        }
                        .padding(.vertical)

                        Divider()

                        Group {

                            Text("C: \(cmykToString(data.C))")

                            Slider(value: $data.C,in: 0...1)
                                .padding()
                                .onChange(of: data.C) { _ in
                                    data.cmykToRGB()
                                }

                            Text("M: \(cmykToString(data.M))")
                            Slider(value: $data.M,in: 0...1)
                                .padding()
                                .onChange(of: data.M) { _ in
                                    data.cmykToRGB()
                                }

                            Text("Y: \(cmykToString(data.Y))")
                            Slider(value: $data.Y,in: 0...1)
                                .padding()
                                .onChange(of: data.Y) { _ in
                                    data.cmykToRGB()
                                }

                            Text("K: \(cmykToString(data.K))")
                            Slider(value: $data.K,in: 0...1)
                                .padding()
                                .onChange(of: data.K) { _ in
                                    data.cmykToRGB()
                                }
                        }
                    }
                    
                    
                case "RGB":

                    VStack {

                        Text(data.selected)

                        MyRectangle(color: data.myColor)

                        Spacer()

                        Group {

                            Text(rgbToString(data.r))

                            Slider(value: $data.r,in: 0...255)
                                .padding()

                            Text(rgbToString(data.g))

                            Slider(value: $data.g,in: 0...255)
                                .padding()

                            Text(rgbToString(data.b))

                            Slider(value: $data.b,in: 0...255)
                                .padding()
                        }
                    }

                case "HLS":

                    VStack {
                        Text(data.selected)

                        MyRectangle(color: data.myColor)
                        
                        HStack {

                            Text("r:\(rgbToString(data.r)) g:\(rgbToString(data.g)) b:\(rgbToString(data.b))")
                        }
                        .padding(.vertical)

                        Divider()
                        
                        Group {
                            
                            Text("hue: \(hlsToString(data.hue))")
                            
                            Slider(value: $data.hue,in: 0...360)
                                .padding()
                                .onChange(of: data.hue) { _ in
                                    data.HLStoRGB()
                                    print("hue")
                                }

                            Text("lightness: \(hlsToString(data.lightness))")

                            Slider(value: $data.lightness,in: 0...1)
                                .padding()
                                .onChange(of: data.lightness) { _ in
                                    data.HLStoRGB()
                                }
                            

                            Text("saturation: \(hlsToString(data.saturation))")

                            Slider(value: $data.saturation,in: 0...1)
                                .padding()
                                .onChange(of: data.saturation) { _ in
                                    data.HLStoRGB()
                                }
                        }

                        Spacer()
                    }

                default:
                    Text("error")
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct MyRectangle: View {

    var color:Color

    var body: some View {

        RoundedRectangle(cornerRadius: 30)
            .fill(color)
            .frame(width:200,height: 100)
            .shadow(radius: 2)
    }
}
