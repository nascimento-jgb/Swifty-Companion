//
//  Project.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 29.8.2023.
//

import SwiftUI

struct SingleProject: View {
    
    var name: String
    var marked_at:  String
    var score: Int
    var status: String
    
    var body: some View {
        
        VStack{
            HStack(alignment: .center, spacing: 10){
                VStack(alignment: .leading){
                    Text(name)
                        .foregroundColor(status == "finished" ? .green : .red)
                    Text(calculateDateDifference())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(5)
                
                Text("\(score)")
                    .padding(.top, -12)
                    .foregroundColor(status == "finished" ? .green : .red)
            }
            .padding(.horizontal, 40)
            .padding(6)
        }
    }
    
    
    func calculateDateDifference() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            
            if let date = dateFormatter.date(from: marked_at) {
                let calendar = Calendar.current
                let today = Date()
                
                let components = calendar.dateComponents([.year, .month], from: date, to: today)
                
                if let year = components.year, year >= 1 {
                    if year == 1 {
                        return "1 year ago"
                    } else {
                        return "\(year) years ago"
                    }
                } else if let month = components.month {
                    if month == 1 {
                        return "1 month ago"
                    } else {
                        return "\(month) months ago"
                    }
                }
            }
            return "Date not available"
        }
}

struct SingleProject_Previews: PreviewProvider {
    static var previews: some View {
        SingleProject(name: "CPP Module 00", marked_at: "1 year ago", score: 100, status: "finished")
    }
}
