//
//  ArticleView.swift
//  News
//
//  Created by Bhavitha  on 22/03/22.
//

import SwiftUI

struct ArticleView: View {
    
    let article: Hits
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            HStack {
                Text(String(article.points ?? 0))
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight:  .semibold))
                
                Text(article.title ?? "")
                    .foregroundColor(.black)
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
