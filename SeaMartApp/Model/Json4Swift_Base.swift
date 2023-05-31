

import Foundation
struct HomeModel : Codable {
	let home : Home?

	enum CodingKeys: String, CodingKey {

		case home = "home"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		home = try values.decodeIfPresent(Home.self, forKey: .home)
	}

}
