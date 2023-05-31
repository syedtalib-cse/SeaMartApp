
import Foundation
struct Offer_banners : Codable {
	let id : String?
	let image : String?
	let category_id : String?
	let title : String?
	let tag : String?
	let content : String?
	let promocode : String?
	let status : String?
	let slider_banner : String?
	let offer_banner : String?
	let trending_banner : String?
	let created_at : String?
	let updated_at : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case image = "image"
		case category_id = "category_id"
		case title = "title"
		case tag = "tag"
		case content = "content"
		case promocode = "promocode"
		case status = "status"
		case slider_banner = "slider_banner"
		case offer_banner = "offer_banner"
		case trending_banner = "trending_banner"
		case created_at = "created_at"
		case updated_at = "updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		image = try values.decodeIfPresent(String.self, forKey: .image)
		category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		tag = try values.decodeIfPresent(String.self, forKey: .tag)
		content = try values.decodeIfPresent(String.self, forKey: .content)
		promocode = try values.decodeIfPresent(String.self, forKey: .promocode)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		slider_banner = try values.decodeIfPresent(String.self, forKey: .slider_banner)
		offer_banner = try values.decodeIfPresent(String.self, forKey: .offer_banner)
		trending_banner = try values.decodeIfPresent(String.self, forKey: .trending_banner)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
	}

}
