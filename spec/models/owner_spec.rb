describe Owner do
  describe "validation" do
    subject { FactoryGirl.build(:owner) }

    #first I'll make sure the factory creates a valid owner...just good practice since if it's not valid, lots of the
    #stuff below no longer holds as a valid test
    it "should be valid" do
      expect(subject).to be_valid
    end

    #you can also do it like this...
    it { should be_valid }

    #here's how you can setup the test to validate that password must be 8 chars
    context "when it has a password under 8 characters" do
      before(:each) do
        subject.password = "1" * 7
      end
      it { should_not be_valid }
    end

    #that context block is useful when you want to wrap lots of tests around the same setup...
    #instead, since this is a single test, you could do:
    it "requires a password of 8 characters" do
      subject.password = "1"*7
      expect(subject).to_not be_valid
    end

    it "requires a name" do
      subject.name = ""
      expect(subject).to_not be_valid
    end

    it "requires an email" do
      subject.email = ""
      expect(subject).to_not be_valid
    end

    # lets add one more validation for email format...
    # you could go nuts on this validation piece, and whole companies are built just on
    # advanced email address validation/info.  We'll keep it simple for now.
    #   http://davidcel.is/blog/2012/09/06/stop-validating-email-addresses-with-regex/
    #  there are some good arguments in favor of not using a big fat regex.
    #
    # I planned on just checking for @ followed by a .
    # while writing this test:
    #
    #   it "requires a valid email format" do
    #     subject.email = "john.doe@missingtld"
    #     expect(subject).to_not be_valid
    #     puts subject.errors.full_messages   # here I was trying to see why this was try...It said "Email is Invalid"
    #   end
    #
    # The test was already passing...even though I thought it should fail
    # (I hadn't added the validation yet, so it should fail)
    #
    # I discovered that Devise's validatable already does email
    # validation for us... sweet.  It's using the regex, so we'll just stick w/ it for now.
    # let's just check one case, since we trust Devise's implementation (mostly)

    it "should require a valid email" do
      subject.email = "john.doe@missingtld"
      expect(subject).to_not be_valid
    end

  end
end
