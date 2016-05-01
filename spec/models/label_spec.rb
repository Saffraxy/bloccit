require 'rails_helper'

RSpec.describe Label, type: :model do
  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:label) { create(:label) }
  ##remove for nowlet(:label2) { create(:label2) }

  it { is_expected.to have_many :labelings }
  it { is_expected.to have_many(:topics).through(:labelings) }
  it { is_expected.to have_many(:posts).through(:labelings) }

  describe "labelings" do
    it "allows the same label to be associated with a different topic and post" do
      topic.labels << label
      post.labels << label

      topic_label = topic.labels[0]
      post_label = post.labels[0]
      expect(topic_label).to eql(post_label)
    end
  end

  describe ".update_labels" do
    it "takes a comma delimited string and returns an array of Labels" do
      labels = "#{label.name}, #{label.name}"
      labels_as_a = [label, label]
      expect(Label.update_labels(labels)).to eq(labels_as_a)
    end
  end

end
