class Book < ApplicationRecord
    has_one_attached :image
      belongs_to :user
      has_many :book_comments, dependent: :destroy
      
     validates :title, presence: true
     validates :body, presence: true, length: { maximum: 200 }
     validates :user_id, {presence: true}
     attribute :title, :string
     attribute :body, :string
      
      def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
      end
end
