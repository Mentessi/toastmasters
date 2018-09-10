# frozen_string_literal: true

RSpec.shared_examples 'only logged in users' do
  it 'doesnt allow logged out users' do
    dispatch_request
    expect(response).to redirect_to(new_user_session_path)
  end

  it 'allows logged in users' do
    login_as(user, scope: :user)
    dispatch_request
    expect(response).not_to redirect_to(new_user_session_path)
  end
end

RSpec.shared_examples 'NOT only for logged in users' do
  it 'allows logged out users' do
    dispatch_request
    expect(response).not_to redirect_to(new_user_session_path)
  end
end
