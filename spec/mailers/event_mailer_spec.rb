
require "spec_helper"
describe EventMailer do
  it "should queue and verify a simple email" do
    participant = FactoryGirl.build(:participant)
    participant.email = "carlos.peix@kleer.la"

    email = EventMailer.welcome_new_event_participant(participant).deliver

    ActionMailer::Base.deliveries.empty?.should_not be true
    email.to.should == ["carlos.peix@kleer.la"]
  end

  it "should send standard prices text info if custom prices text is empty" do
    participant = FactoryGirl.build(:participant)
    participant.email = "carlos.peix@kleer.la"
    participant.event.list_price = 200

    email = EventMailer.welcome_new_event_participant(participant).deliver

    text_message = email.body.parts.find {|p| p.content_type.match /plain/}.body.raw_source
    text_message.should include("(ARS) $ 200.00")
  end

  it "should send standard prices html info if custom prices html is empty" do
    participant = FactoryGirl.build(:participant)
    participant.email = "carlos.peix@kleer.la"
    participant.event.list_price = 200

    email = EventMailer.welcome_new_event_participant(participant).deliver

    html_message = email.body.parts.find {|p| p.content_type.match /html/}.body.raw_source
    html_message.should include("(ARS) $ 200.00")
  end
end
