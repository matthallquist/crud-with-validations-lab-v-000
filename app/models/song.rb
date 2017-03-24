class Song < ActiveRecord::Base
  validates :title, :artist_name, presence: true
  validates :title, uniqueness: { scope: [:release_year, :artist_name],  message: "cannot be repeated by the same artist in the same year" }
  validates :released, exclusion: { in: [nil] }
  with_options if: :released do |song|
    song.validates :release_year, presence: true
    song.validates :release_year, numericality: { less_than_or_equal_to: Date.today.year }
  end
end