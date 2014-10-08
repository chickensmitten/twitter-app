class Status < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

  validates :creator, presence: true
  validates :body, presence: true, length: {minimum: 10}

  after_save :extract_mentions #this is an active record callback, depending on application rules, if fire every time, we use it here
  #else, we use it in controller

  def extract_mentions #using regex with rubular to capture the word
    mentions = self.body.scan(/@(\w*)/) 
    if mentions.size > 0
      mentions.each do |mention|
        m = mention.first
        user = User.find_by username: m
        if user
          Mention.create(user_id: user.id, status_id: self.id)
        end
      end
    end
  end

end