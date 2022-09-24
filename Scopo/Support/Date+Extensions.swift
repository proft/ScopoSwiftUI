import Foundation

extension Date {
    func toRelativeDate() -> String {
        let df = DateFormatter()
        df.dateStyle = .short
        df.doesRelativeDateFormatting = true
        return df.string(from: self)
    }
}
