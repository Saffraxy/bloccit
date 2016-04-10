require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
#we create a parent topic for post.
  let(:topic) { Topic.create!(name: name, description: description) }

  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }

  let(:post) { topic.posts.create!(title: title, body: body, user: user) }

  it { is_expected.to belong_to(:topic) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:topic) }
  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_length_of(:body).is_at_least(20) }

  describe "attributes" do
    it "has a title, body, and user attribute" do
      expect(post).to have_attributes(title: title, body: body, user: user)
    end
  ##left these in.  Not sure why they aren't in lesson code.
  #  it "responds to title" do
  #    expect(post).to respond_to(:title)
  #  end
  #  it "responds to body" do
  #    expect(post).to respond_to(:body)
  #  end
  end
end
