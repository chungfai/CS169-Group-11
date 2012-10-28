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

Scenario: Complete a campaign
	When I press "Start a new campaign"

	Then the campaign should be on the "select farmer" page
	When I follow "Fund Farmer1"

	Then the campaign should be on the "enter friends" page
	When I fill in "Friends" with "My Friend <myfriend@bunkmail.com>, Admiral Crunch <friend2@bunkmail.com>"
	And I press "Next"

	Then the campaign should be on the "record video" page
	When I fill in "Video Link" with "http://www.youtube.com/watch?v=dQw4w9WgXcQ"
	And I press "Next"

	Then the campaign should be on the "message template" page
	When I fill in "Template" with "Hi <name>, please watch this video about funding farmers <link>! Thanks!"
	And I press "Next"

	Then the campaign should be on the "send messages" page
	And I should see "Hi <name>, please watch this video about funding farmers <link>! Thanks!"
	And I should see "My Friend"
	And I should see "mailto:myfriend@bunkmail.com"
	And I should see "Admiral Crunch"
	And I should see "mailto:friend2@bunkmail.com"
