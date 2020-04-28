# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.
shared_examples 'an unauthorised route' do |route|
  it 'redirects to the route path' do
    expect(post(route)).to redirect_to(new_user_session_path)
  end
end

shared_examples 'a modifying POST route' do |action, model_method|
  before(:all) do
    @user = create(:user).tap do |u|
      u.maintainer = false
      u.enthusiast = false
      u.save
    end
  end

  before(:each) do
    sign_in @user
  end

  it 'updates the field(s) on the model' do
    expect  do
      post action
      @user.reload
    end.to change { @user.send(model_method) }.from(false).to(true)
  end
end

RSpec.describe UsersController, type: :controller do
  context 'when signed in' do
    it_should_behave_like 'a modifying POST route', :maintainer, :maintainer
    it_should_behave_like 'a modifying POST route', :enthusiast, :enthusiast
    it_should_behave_like 'a modifying POST route', :maintainer_and_enthusiast,
                          :maintainer
    it_should_behave_like 'a modifying POST route', :maintainer_and_enthusiast,
                          :enthusiast
  end

  context 'when not signed in' do
    it_should_behave_like 'an unauthorised route', :maintainer
    it_should_behave_like 'an unauthorised route', :enthusiast
    it_should_behave_like 'an unauthorised route', :maintainer_and_enthusiast
  end

  it 'should redirect to the root if the user is not public' do
    @user = random_user.tap do |u|
      u.public = false
      u.save
    end
    sign_in @user
    expect(put(:update, params: {
                 id: @user.id, user: @user.attributes
               })).to redirect_to root_path
  end

  it 'should redirect to the root if the user is not public' do
    @user = random_user.tap do |u|
      u.public = true
      u.save
    end
    sign_in @user
    expect(put(:update, params: {
                 id: @user.id, user: @user.attributes
               })).to redirect_to @user
  end
end
