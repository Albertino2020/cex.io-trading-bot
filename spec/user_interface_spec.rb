require_relative "../lib/user_interface"
describe "#on_start_intro" do
  it "displays introductory message to user on start " do
    expect(on_start_intro).to eql(puts "Are you familiar with the CEX.IO Trading Bot (Y/N)?")
  end
  it "returns always a string object" do
    expect { on_start_intro }.to_not raise_error
    expect(on_start_intro.to_s.class).to eql(String)
    expect(on_start_intro.to_s.class).to_not eql(nil)
  end
  it "raises error if arguments passed " do
    expect { on_start_intro(nil) }.to raise_error(ArgumentError)
    expect { on_start_intro(@authorized) }.to raise_error(ArgumentError)
  end
end
