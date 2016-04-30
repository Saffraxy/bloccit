require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { create(:topic) }

  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:labelings) }
  it { is_expected.to have_many(:labels).through(:labelings) }

# we confirm that a topic responds to the appropriate attributes.
  describe "attributes" do
    it "responds to name and description attributes" do
      expect(topic).to have_attributes(name: topic.name, description: topic.description )
    end

    it "responds to public" do
      expect(topic).to respond_to(:public)
    end
# we confirm that the public attribute is set to true by default.
    it "is public by default" do
      expect(topic.public).to be(true)
    end

  end
end
