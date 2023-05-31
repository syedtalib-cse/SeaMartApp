
import Foundation
struct Parent_categories : Codable {
	let id : String?
	let parent_id : String?
	let name : String?
	let description : String?
	let url : String?
	let icon : String?
	let status : String?
	let sort : String?
	let created_at : String?
	let updated_at : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case parent_id = "parent_id"
		case name = "name"
		case description = "description"
		case url = "url"
		case icon = "icon"
		case status = "status"
		case sort = "sort"
		case created_at = "created_at"
		case updated_at = "updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		parent_id = try values.decodeIfPresent(String.self, forKey: .parent_id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		icon = try values.decodeIfPresent(String.self, forKey: .icon)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		sort = try values.decodeIfPresent(String.self, forKey: .sort)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
	}

}
