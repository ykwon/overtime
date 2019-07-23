# frozen_string_literal: true

require 'rails_helper'

describe 'navigator' do
  before do 
    @user = FactoryBot.create(:user)
    login_as(@user, :scope => :user)
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
      # Post.create!(date: Date.today, rationale: "Post1" , user_id: @user.id)
      # Post.create!(date: Date.today, rationale: "Post2" , user_id: @user.id)
      FactoryBot.build_stubbed(:post)
      FactoryBot.build_stubbed(:second_post)
      visit posts_path
      expect(page).to have_content(/Rationale|content/)
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
  describe 'edit' do
    before do
      @post = FactoryBot.create(:post)
    end

    it 'can be reached by clicking edit on index page'  do      
      
      visit posts_path
      click_link("edit_#{@post.id}")
      expect(page.status_code).to eq(200)
    end

    it 'can be edited' do
      visit edit_post_path("#{@post.id}")
      # expect(page.status_code).to eq(200)
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]',with: 'Edit content'

      click_on 'Save'
      expect(page).to have_content('Edit content')
    end
  end
end
