module Deliver
  # Set the app's availability
  class UploadAvailability
    def upload(options)
      return unless options[:availability_all_territories] || options[:availability_territories]
      app = options[:app]

      country_codes = options[:availability_territories]
      territories = country_codes.map { |territory| Spaceship::Tunes::Territory.from_code(territory) }

      all_territories = app.client.supported_territories
      if options[:availability_all_territories]
        territories = all_territories
      end

      availability = Spaceship::Tunes::Availability.from_territories(territories)
      app.update_availability!(availability)

      UI.success("Successfully set availability for #{territories.count} of #{all_territories.count} territories")
    end
  end
end