feature 'comment', js: true do
  given(:user) { FactoryGirl.create(:user) }
  given!(:project) { FactoryGirl.create(:project, user: user, name: 'test project') }
  given!(:task) { FactoryGirl.create(:task, project: project) }
  given!(:comment) { FactoryGirl.create(:comment, task: task) }

  before do
    login_as user, scope: :user
    visit '/#/'
  end

  scenario 'user add new comment to task' do
    find('.li-task').hover
    within('.task-change') do
      find('.glyphicon-comment').click
    end

    fill_in 'Enter comment name', with: 'New comment'
    find('.comment-add').click

    expect(page).to have_content 'New comment'
  end

  scenario 'user delete comment successfully' do

    find('.li-task').hover
    find('.glyphicon-comment').click
    expect(page).to have_content comment.text
    within('.comments-list') do
      find('.glyphicon-trash').click
    end

    expect(page).not_to have_content comment.text
  end

  scenario 'user can edit his comments' do
    find('.li-task').hover
    find('.glyphicon-comment').click
    within('.comments-list') do
      find('.glyphicon-pencil').click
    end
  end
  
end
