RSpec.shared_examples 'owners only' do
  it 'allows owner' do
    login_as(user, scope: :user)
    dispatch_request
    expect { dispatch_request }.not_to raise_error
  end

  it 'disallows users other than owner' do
    login_as(FactoryBot.create(:user), scope: :user)
    expect { dispatch_request }.to raise_error(ActiveRecord::RecordNotFound)
  end
end

RSpec.shared_examples 'NOT just for owners' do
  it 'disallows users other than owner' do
    login_as(FactoryBot.create(:user), scope: :user)
    expect { dispatch_request }.not_to raise_error
  end
end
