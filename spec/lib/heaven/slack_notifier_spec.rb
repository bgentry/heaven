require "spec_helper"

describe "Heaven::Notifier::Slack" do
  it "handles pending notifications" do
    n = Heaven::Notifier::Slack.new(fixture_data("deployment-pending"))

    result = [
      "[#123456](https://gist.github.com/fa77d9fb1fe41c3bb3a3ffb2c) ",
      ": [atmos](https://github.com/atmos) is deploying ",
      "[my-robot](https://github.com/atmos/my-robot/tree/break-up-notifiers) ",
      "to production"
    ]

    expect(n.default_message).to eql result.join("")
  end

  it "handles successful deployment statuses" do
    n = Heaven::Notifier::Slack.new(fixture_data("deployment-success"))

    result = [
      "[#11627](https://gist.github.com/fa77d9fb1fe41c3bb3a3ffb2c) ",
      ": [atmos](https://github.com/atmos)'s production deployment of ",
      "[my-robot](https://github.com/atmos/my-robot) ",
      "is done! "
    ]
    expect(n.default_message).to eql result.join("")
  end

  it "handles failure deployment statuses" do
    n = Heaven::Notifier::Slack.new(fixture_data("deployment-failure"))

    result = [
      "[#123456](https://gist.github.com/fa77d9fb1fe41c3bb3a3ffb2c) ",
      ": [atmos](https://github.com/atmos)'s production deployment of ",
      "[my-robot](https://github.com/atmos/my-robot) ",
      "failed. "
    ]
    expect(n.default_message).to eql result.join("")
  end
end
