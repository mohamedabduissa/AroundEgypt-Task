//
//  Experience+MockData.swift
//  AroundEgypt
//
//  Created by MacbookPro on 10/11/2025.
//

@testable import AroundEgypt
import Foundation

extension Experience {
    static var sample: Experience {
        Experience(
            id: "7f209d18-36a1-44d5-a0ed-b7eddfad48d6",
            title: "Abu Simbel Temples",
            coverPhoto: "https://fls-9ff553c9-95cd-4102-b359-74ad35cdc461.367be3a2035528943240074d0096e0cd.r2.cloudflarestorage.com/29/PmA89sBqFNkjDZUVOOaQ8PyEtlIXi7-metaSzNBVFFsaFU4VHhMVmkxZ253emdVNlczTEJRS3BuM1paWDg0MHIzci5qcGVn-.jpg",
            description: "The Abu Simbel temples are two massive rock temples at Abu Simbel, a village in Nubia, southern Egypt, near the border with Sudan. They are situated on the western bank of Lake Nasser, about 230 km southwest of Aswan.",
            viewsNo: 40040,
            likesNo: 3482,
            recommended: 1,
            address: "It is located on the western bank of Lake Nasser, 290 km southwest of Aswan",
            isLiked: false,
            reviewsNo: 3
        )
    }
}

struct ExperienceResponse: Codable {
    let data: [Experience]
}
