class Donation < ActiveRecord::Base
  attr_accessible :email, :amount, :project_id, :user_id, :stripe_token, :readable_amount
  
  belongs_to :project
  belongs_to :user
  
  def readable_amount
    donation_amount = self.amount
    dollars = donation_amount / 100
    cents = donation_amount % 100
    if (cents < 10)
      cents = "0" + String(cents)
    end
    return "$#{dollars}.#{cents}"
  end
  
  def readable_amount=(in_amount)
    parse = /^\$?(?<amount>[\d.-]+)$/.match(in_amount)
    
    self.amount = 0
    
    return if not parse
    
    self.amount = (parse[:amount].to_f * 100).to_i
  end
end