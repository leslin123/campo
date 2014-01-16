require 'test_helper'

class PostsHelperTest < ActionView::TestCase
  test "post_votes" do
    user = create(:user)
    topic = create(:topic)
    create(:post, topic: topic)
    post_up = create(:post, topic: topic)
    post_down= create(:post, topic: topic)
    create(:post_vote, post: post_up, up: true, user: user)
    create(:post_vote, post: post_down, up: false, user: user)

    assert_equal(
      [{ post_id: post_up.id, type: 'up'}, { post_id: post_down.id, type: 'down' }].sort_by{ |v| v[:post_id] },
      post_votes(topic.posts, user).sort_by{ |v| v[:post_id] }
    )
  end
end
