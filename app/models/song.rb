require 'pry'
class Song < ActiveRecord::Base
	validates :title, presence: true
	validate :different_artist_and_year
	validates :released, inclusion: {in: [true, false]}

	validates :release_year, presence: true, if: :released
	validates :release_year, numericality: {less_than_or_equal_to: Date.today.year}, if: :released
	validates :artist_name, presence: true




	def different_artist_and_year
		songs = self.class.all 
		if songs.any?{|song| song.title == self.title && song.artist_name == self.artist_name && song.release_year == self.release_year}
			errors.add(:title, "cannot have the same song title by the same artist in the same year")
		end
	end

end
