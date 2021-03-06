feature 'the sign in process', js: true do
  given(:user) { FactoryGirl.create(:user) }
  before { visit '/#/login' }

  scenario 'user navigates to login pages' do
    expect(page).to have_button('Log in')
  end

  scenario 'user sign in' do
    within(".email-login") do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
    end
    click_button 'Log in'
    expect(page).to have_content('SIMPLE TODO LIST')
  end

  scenario 'user sign in with invalid email' do
    within(".email-login") do
      fill_in 'user[email]', with: 'invalid@gmail.com'
      fill_in 'user[password]', with: user.password
    end
    click_button 'Log in'
    expect(page).to have_content('Wrong email or password')
  end

  scenario 'user navigate to login page when he is already signed in' do
    login_as user, scope: :user
    expect(page).not_to have_button('Log in')
    expect(page).to have_content('Add TODO List')
  end
end
