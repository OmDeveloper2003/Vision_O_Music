

import SwiftUI

struct ClipShapeModifier: ViewModifier {
    let isCircle: Bool
    
    func body(content: Content) -> some View {
        VStack{
            if isCircle {
                content.clipShape(Circle())
            } else {
                content.clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
       
    }
}

extension View {
    func cardClipShape(isCircle: Bool) -> some View {
        modifier(ClipShapeModifier(isCircle: isCircle))
    }
}
