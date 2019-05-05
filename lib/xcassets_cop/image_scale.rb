module XCAssetsCop
  module ImageScale
    SINGLE = :single
    INDIVIDUAL = :individual
    INDIVIDUAL_AND_SINGLE = :individual_and_single

    def self.available_values
      [SINGLE, INDIVIDUAL, INDIVIDUAL_AND_SINGLE]
    end
  end
end
