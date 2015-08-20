class CreateBranch
  include Runable
  attr_accessor :branch_name, :project, :username, :head

  def run
    email = `git config --global user.email`
    email_info = email.split "@"
    @username = email_info[0]
    # @project = "jeronpaul/capshare"
    @project = "casejamesc/tester"
    @head = "Authorization: token 532c22ea1b94c63a73198b73324712246bb0983b"

    create_branch
  end

  def create_branch
    branch_info = branch_name.split "#"
    pr_title = branch_info[0]
    issue_number = branch_info[1]
    binding.pry

    puts "creating branch and initial commit..."
    `git pull origin master; git checkout -b #{branch_name}; echo " " >> README.md; git commit -am "Create PRs [ci skip]"; git push origin HEAD;`

    # CREATE PULL REQUEST
    puts "creating pr..."
    url = "https://api.github.com/repos/#{project}/pulls"
    data = "{ \"title\": \"Fixes ##{issue_number}: #{pr_title}\", \"body\": \"##{issue_number}\", \"head\": \"#{branch_name}\", \"base\": \"master\" }"
    # pr_number = `curl --request POST --header \'#{head}\' --data \'#{data}\' #{url} | jq .number`

    # # ADD ASSIGNEE
    # puts "assigning pr..."
    # url = "https://api.github.com/repos/#{project}/issues/#{pr_number}"
    # data = "{ \"assignee\": \"#{username}\" }"
    # `curl --request PATCH --header \'#{head}\' --data \'#{data}\' #{url}`

    # # REMOVE LABELS
    # puts "moving issue to in progress..."
    # url = "https://api.github.com/repos/#{project}/issues/#{issue_number}/labels"
    # `curl --request DELETE --header \'#{head}\' #{url}`
    # sleep 1

    # # ADD LABEL
    # `curl --request POST --header \'#{head}\' --data '[ "In Progress" ]' #{url}`
  end

end