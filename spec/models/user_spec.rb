require 'rails_helper'

describe User do
  before(:all) do
     @user = User.create
  end

  [:login, :userstatus_id].each do |attribute|
    it { should validate_presence_of attribute }
  end
  

  [:userstatus].each do |association|
    it { should belong_to(association) }
  end
end
