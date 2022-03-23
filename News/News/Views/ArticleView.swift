//
//  ArticleView.swift
//  News
//
//  Created by Bhavitha  on 22/03/22.
//

import SwiftUI

struct ArticleView: View {
    
    let article: Hits
    private var useRedText: Bool {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let articleCreatedDate = dateFormatter.date(from: article.created_at ?? "") else {
            fatalError("")
        }

        return Calendar.current.isDate(articleCreatedDate , equalTo: Date(), toGranularity: .day)

    }
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            HStack {
                Text(String(article.points ?? 0))
                    .foregroundColor(useRedText ? .red : .black)
                    .font(.system(size: 18, weight:  .semibold))
                
                Text(article.title ?? "")
                    .foregroundColor(useRedText ? .red : .black)
                    .font(.system(size: 18, weight:  .semibold))
            }
        }
    }
}

/*struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView()
    }
}*/
