require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Test for validation" do
    it {should validate_presence_of(:first_name)}
    it {should validate_length_of(:first_name).is_at_most(100)}

    it {should validate_presence_of(:last_name)}
    it {should validate_length_of(:last_name).is_at_most(100)}

    it {should validate_presence_of(:email)}
    it {should validate_length_of(:email).is_at_most(100)}
    it {should validate_uniqueness_of(:email)}

    it {should validate_length_of(:password).is_at_least(8)}
    it {should have_secure_password}
  end
end
