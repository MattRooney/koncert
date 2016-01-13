require 'test_helper'

class UserTest < ActiveSupport::TestCase
  attr_reader :user
  def create_user
    @user = User.new( { id: 1,
                        name: "Name 1",
                        spotify_id: "Spotify Name 1",
                        email: "name@email.com",
                        oauth_token: ENV["oauth_token"],
                        oauth_token_secret: ENV["oauth_token_secret"] } )
  end

  test "user is valid" do
    create_user

    assert user.valid?
  end

  test "user has a name" do
    create_user

    assert_equal "Name 1", user.name
  end

  test "user has a spotify_id" do
    create_user

    assert_equal "Spotify Name 1", user.spotify_id
  end

  test "user has an email" do
    create_user

    assert_equal "name@email.com", user.email
  end

end
