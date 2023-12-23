//
//  Model.swift
//  laba1
//
//  Created by MAC on 9/11/23.
//

import Foundation
import SwiftUI

struct Data {
    
    var selected = "RGB" {
        
        willSet {
            
            if selected == "RGB" && newValue == "CMYK" {
                rgbToCMYK()
            }
            else if selected == "CMYK" {
                cmykToRGB()
            }
            else if selected == "HLS" {
                HLStoRGB()
            }
            else {
                rgbToHLS()
            }
        }
    }
    
    var r:Double = 255
    var g:Double = 255
    var b:Double = 255
    
    var K:Double = 0
    var M:Double = 0
    var C:Double = 0
    var Y:Double = 0
    
    var hue:Double = 0
    var lightness:Double = 0
    var saturation:Double = 0
    
    
    var myColor:Color {
        Color(red: r/255.0, green: g/255.0, blue: b/255.0)
    }
    
    mutating func rgbToCMYK() {
        
        let arr:[Double] = [1 - r/255, 1 - g/255, 1 - b/255]
        
        K = arr.min()!
        C = (1 - r/255 - K)/(1 - K)
        M = (1 - g/255 - K)/(1 - K)
        Y = (1 - b/255 - K)/(1 - K)
    }
    
    mutating func cmykToRGB() {
        
        r = 255*(1 - C)*(1 - K)
        g = 255*(1 - M)*(1 - K)
        b = 255*(1 - Y)*(1 - K)
    }
    
    mutating func HLStoRGB () {
        
        let C = (1 - abs(2 * lightness - 1)) * saturation
        let H = hue/60
        let X = C * (1 - abs(H.truncatingRemainder(dividingBy: 2) - 1))
        let m = lightness - C / 2.0

        switch hue {
                
            case 0..<60:
                r = C
                g = X
                b = 0
            case 60..<120:
                r = X
                g = C
                b = 0
            case 120..<180:
                r = 0
                g = C
                b = X
            case 180..<240:
                r = 0
                g = X
                b = C
            case 240..<300:
                r = X
                g = 0
                b = C
            default:
                r = C
                g = 0
                b = X
        }

        r += m
        g += m
        b += m

        // Убедитесь, что значения находятся в диапазоне от 0 до 1
//        r = min(1, max(0, r))
//        g = min(1, max(0, g))
//        b = min(1, max(0, b))

        // Переводим значения обратно в диапазон от 0 до 255
        r *= 255
        g *= 255
        b *= 255
    }
    
    mutating func rgbToHLS() {
        
        let r = r / 255.0
        let g = g / 255.0
        let b = b / 255.0

        let maxColor = max(r, max(g, b))
        let minColor = min(r, min(g, b))

        lightness = (maxColor + minColor) / 2.0

        if maxColor == minColor {
            saturation = 0.0
            hue = 0.0
        } else {
            let delta = maxColor - minColor

            saturation = delta / (1 - abs(2*lightness - 1))

            if maxColor == r {
                hue = ((g - b) / delta + (g < b ? 6.0 : 0.0)) * 60.0
            } else if maxColor == g {
                hue = ((b - r) / delta + 2.0) * 60.0
            } else {
                hue = ((r - g) / delta + 4.0) * 60.0
            }
        }
    }

    
}
