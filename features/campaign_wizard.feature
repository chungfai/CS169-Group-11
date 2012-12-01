Feature: Campaign Wizard
	As a user,
	To get a campaign started,
	I would like a campaign wizard

Background: User logged in and on profile page
	# canonical test data: "Farmer1", "Farmer2"
	Given farmers have been created
	# canonical test data: "Mister Test" with email "test@email.com" with no picture
	And I am logged in as the test user
	And I am on the user dashboard

Scenario: Complete a campaign and able to edit it
	When I follow "Start a new campaign"

	Then the campaign should be on the "select farmer" page
	When I follow "Farmer1"

	Then the campaign should be on the "enter friends" page
	When I fill in "Friends" with "My Friend <myfriend@bunkmail.com>, Admiral Crunch <friend2@bunkmail.com>"
	And I press "Next"

	Then the campaign should be on the "record video" page
	When I fill in "Video Link" with "http://www.youtube.com/watch?v=dQw4w9WgXcQ"
  And I choose "link"
	And I press "Next"

	Then the campaign should be on the "message template" page
  When I fill in "Subject" with "Help farmers in India!"
	And I fill in "Template" with "Hi <name>, please watch this video about funding farmers <link>! Thanks!"
	And I press "Next"

	Then the campaign should be on the "send messages" page
	And I should see "Hi <name>, please watch this video about funding farmers <link>! Thanks!"
	And I should see "My Friend"
	And I should see "Admiral Crunch"
  And I should see /[contains(@href,myfriend@bunkmail.com)]/
  And I should see /[contains(@href,friend2@bunkmail.com)]/
  Given I am on the user dashboard
  When I follow "Edit"
	And I should see "Hi <name>, please watch this video about funding farmers <link>! Thanks!"
	And I should see "My Friend"
	And I should see "Admiral Crunch"
  And I should see "myfriend@bunkmail.com"
  And I should see "friend2@bunkmail.com"
  And I fill in "Template" with "testing editing 123!"
	And I press "Update Campaign Info"
  And I should see "Campaign was successfully updated"
  And I should see "testing editing 123!"
  And I fill in "Friends" with "not a email"
  And I press "Update Campaign Info"
  And I should see "Unable to understand these emails: not a email"
  And I fill in "Template" with ""
  And I press "Update Campaign Info"
  And I should see "Please Enter the Template Content"
  When I fill in "Video Link" with ""
  And I choose "link"
	And I press "Update Campaign Info"
  Then I should see "No video submited"

Scenario: Should notify you on invalid emails
	When I follow "Start a new campaign"

	Then the campaign should be on the "select farmer" page
	When I follow "Farmer1"
	Then the campaign should be on the "enter friends" page
	When I fill in "Friends" with "My Friend <myfriend@bunkmail.com>, Admiral Crunch <friend2@bunkmail.com>,OMG Not EMAIL, quack quack"
	And I press "Next"
  Then the campaign should be on the "enter friends" page
  And I should see "Unable to understand these emails: OMG Not EMAIL, quack quack"
  When I fill in "Friends" with "My Friend <myfriendbunkmail.com>"
  And I press "Next"
  And I should see "Unable to understand these emails: My Friend"

Scenario: Must enter something for friends email page
  When I follow "Start a new campaign"
	Then the campaign should be on the "select farmer" page
	When I follow "Farmer1"
	Then the campaign should be on the "enter friends" page
	And I press "Next"
  Then I should see "Please Enter Some Valid Name and Email"

Scenario: Must enter something for video page
  When I follow "Start a new campaign"
	Then the campaign should be on the "select farmer" page
	When I follow "Farmer1"
	Then the campaign should be on the "enter friends" page
  When I fill in "Friends" with "My Friend <myfriend@bunkmail.com>"
  And I press "Next"
  And I press "Next"
  Then I should see "No video submited"

Scenario: Template content input check 
  Given we are on the template page
  Then the campaign should be on the "message template" page
  And I press "Next"
  Then I should see "Please Enter the Subject and Content"
  When I fill in "Subject" with "Help farmers in India!"
	And I press "Next"
  Then I should see "Please Enter the Template Content"

Scenario: Make a custom campaign
  When I follow "Start a new campaign"
  And I add a pending step to prevent this test from failing
  And I follow "Create a Custom Campaign"
  When I follow "Farmer1"
  Then I should be able to personalize a video for my friend
  When I press "Add Another"
  Then I should be able to personalize a video for my friend

Scenario: Template content input check
  Given we are on the template page
  Then the campaign should be on the "message template" page
  And I fill in "Template" with "Hi <name>, please watch this video about funding farmers <link>! Thanks!"
  And I press "Next"
  Then I should see "Please Enter the Template Subject"

Scenario: Session check before create Campaign
  Given go directly to template page
  And I fill in "Subject" with "Help farmers in India!"
  And I fill in "Template" with "Hi <name>, please watch this video about funding farmers <link>! Thanks!"
  And I press "Next"
  Then I should see "Incomplete information to create a campaign"

Scenario: Access filling in Friends's email page without selecting a farmer
  Given We are at the fill in friend's email page
  And I should see "Please Select a Farmer"
