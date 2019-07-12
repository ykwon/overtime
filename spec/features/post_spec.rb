# frozen_string_literal: true

require 'rails_helper'

describe 'navigator' do
  before do 
    user = User.create(email: 'test@test.com',
                         password: '123456',
                         password_confirmation: '123456',
                         first_name: 'Jon',
                         last_name: 'snow')
      login_as(user, scope: :user)
  end
  describe 'index' do
    it 'can be reached successfully' do
      visit posts_path
      expect(page.status_code).to eq(200)
    end
    it 'has a title of posts' do
      visit posts_path
      expect(page).to have_content(/Posts/)
    end
    it 'has a list of posts' do  
      post1 = Post.create(date: Date.today, rationale: "Post1")
      post2 = Post.create(date: Date.today, rationale: "Post2")
      visit posts_path
      expect(page).to have_content(/Post1 | Post2/)
    end
  end

  describe 'creation' do
    before do      
      visit new_post_path
    end

    it 'has a form that can be reached' do
      expect(page.status_code).to eq(200)
    end
    it 'can be created from new form page' do
      visit new_post_path
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]',with: 'Some rationale'

      click_on 'Save'
      expect(page).to have_content('Some rationale')
    end

    it 'will have a user associated it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'User Association'
      click_on 'Save'
      expect(User.last.posts.last.rationale).to eq('User Association')
    end
  end
end
