feature 'the register process', js: true do
  given(:user) { FactoryGirl.create(:user) }
  before { visit '/#/register' }

  scenario 'user navigates to register pages' do
    expect(page).to have_content('SIGN UP')
  end

  scenario 'user register' do
    within(".email-signup") do
      fill_in 'user[email]', with: 'newemail@gmail.com'
      fill_in 'user[password]', with: user.password
      fill_in 'user[confirm_password]', with: user.password
    end
    click_button 'Sign Up'
    expect(page).to have_content('SIMPLE TODO LISTS')
  end

  scenario 'user navigate to login page when he is already sign in' do
    login_as user, scope: :user
    visit '/#/register'
    expect(page).not_to have_button('Log in')
    expect(page).to have_content('SIMPLE TODO LISTS')
  end
end
