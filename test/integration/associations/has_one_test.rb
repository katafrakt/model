require 'test_helper'

describe 'Associations (has_one)' do
  it "returns nil if the association wasn't preloaded" do
    repository = UserRepository.new
    user       = repository.create(name: 'John Doe')
    found      = repository.find(user.id)

    found.avatar.must_equal nil
  end

  it 'preloads the associated record' do
    repository = UserRepository.new
    user       = repository.create(name: 'Baruch Spinoza')
    avatar     = AvatarRepository.new.create(user_id: user.id, url: 'http://www.notarealurl.com/avatar.png')
    found      = repository.find_with_avatar(user.id)
    found.must_equal user
    found.avatar.must_equal avatar
  end

  it 'returns an Avatar' do
    repository = UserRepository.new
    user       = repository.create(name: 'Simone de Beauvoir')
    avatar     = AvatarRepository.new.create(user_id: user.id, url: 'http://www.notarealurl.com/simone.png')
    found      = repository.avatar_for(user)

    found.must_equal avatar
  end

  it 'creates a User with an Avatar' do
    repository = UserRepository.new
    user       = repository.create(name: 'Jean Paul-Sartre')
    repository.create_avatar(user, url: 'http://www.notarealurl.com/sartre.png')
    found = repository.find_with_avatar(user.id)

    found.must_equal user
    found.avatar.url.must_equal 'http://www.notarealurl.com/sartre.png'
  end
end