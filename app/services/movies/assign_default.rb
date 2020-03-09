# frozen_string_literal: true

module Movies
  class AssignDefault
    def self.call(title)
      new.call(title)
    end

    def call(title)
      {'data' => {
        'attributes'=> {
          'title' => title,
          'plot' => Faker::Lorem.paragraph(5),
          'rating' => generate_random_rating,
          'poster' => '/deadpool.jpg'
          }
        }
      }
    end

    private

    def generate_random_rating
      rand(0..10) * 0.1 + rand(1..9)
    end
  end
end
