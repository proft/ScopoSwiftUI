import SwiftUI

class Theme {
    static func navigationBarColors(bgColor: Color?, titleColor: Color? = nil, tintColor: Color? = nil) {
        let na = UINavigationBarAppearance()
        na.configureWithOpaqueBackground()
        na.backgroundColor = UIColor(bgColor ?? Color.clear)
        na.shadowColor = .clear
        na.titleTextAttributes = [.foregroundColor: UIColor(titleColor ?? .black)]
        na.largeTitleTextAttributes = [.foregroundColor: UIColor(titleColor ?? .black)]
        
        UINavigationBar.appearance().standardAppearance = na
        UINavigationBar.appearance().compactAppearance = na
        UINavigationBar.appearance().scrollEdgeAppearance = na
        
        UINavigationBar.appearance().tintColor = UIColor(tintColor ?? titleColor ?? .black)
    }
}


