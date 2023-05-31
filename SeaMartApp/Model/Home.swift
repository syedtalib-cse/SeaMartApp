
import Foundation
struct Home : Codable {
	let parent_categories : [Parent_categories]?
	let slider_banners : [Slider_banners]?
	let offer_banners : [Offer_banners]?
	let trending_banners : [String]?
	let trending_products : [Trending_products]?
	let all_products : [All_products]?
    let best_deal_products : [Best_deal_products]?

	enum CodingKeys: String, CodingKey {

		case parent_categories = "parent_categories"
		case slider_banners = "slider_banners"
		case offer_banners = "offer_banners"
		case trending_banners = "trending_banners"
		case trending_products = "trending_products"
		case all_products = "all_products"
        case best_deal_products = "best_deal_products"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		parent_categories = try values.decodeIfPresent([Parent_categories].self, forKey: .parent_categories)
		slider_banners = try values.decodeIfPresent([Slider_banners].self, forKey: .slider_banners)
		offer_banners = try values.decodeIfPresent([Offer_banners].self, forKey: .offer_banners)
		trending_banners = try values.decodeIfPresent([String].self, forKey: .trending_banners)
		trending_products = try values.decodeIfPresent([Trending_products].self, forKey: .trending_products)
		all_products = try values.decodeIfPresent([All_products].self, forKey: .all_products)
        best_deal_products = try values.decodeIfPresent([Best_deal_products].self, forKey: .best_deal_products)
	}

}
