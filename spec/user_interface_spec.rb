require_relative '../lib/user_interface'
require_relative '../lib/strategy'
describe '#on_start_intro' do
  it 'displays introductory message to user on start ' do
    expect(on_start_intro).to eql(puts('Are you familiar with the CEX.IO Trading Bot (Y/N)?'))
  end
  it 'returns always a string object' do
    expect { on_start_intro }.to_not raise_error
    expect(on_start_intro.to_s.class).to eql(String)
    expect(on_start_intro.to_s.class).to_not eql(nil)
  end
  it 'raises error if arguments passed ' do
    expect { on_start_intro(nil) }.to raise_error(ArgumentError)
    expect { on_start_intro(@authorized) }.to raise_error(ArgumentError)
  end
end
describe '#follow_up' do
  it 'displays follow up questions to user on start ' do
    expect(follow_up(true)).to eql(puts('Do you have a CEX.IO API Key (Y/N)?'))
  end
  it 'displays follow up information to new user and question on start ' do
    expect(follow_up(false)).to eql(
      puts(
        "Welcome to the pleasure of automated trading on the world's best cryptocurrency market!

        This software automates all market operations of buying, selling, placing orders, etc.,
        in a secure and profitable way.

        You are not required to have any trading experience. You only need to provide your
        API Key details. CEX.io Bot does the job!

        Do you have an API Key to access this market (Y/N)?"
      )
    )
  end
  it 'returns always an empty object' do
    expect { follow_up(nil) }.to_not raise_error
    expect(follow_up(false).class).to eql(NilClass)
    expect(follow_up(true).to_s.class).to_not eql(nil)
  end
  it 'raises error if no arguments passed ' do
    expect { follow_up }.to raise_error(ArgumentError)
  end
end
describe '#check_key' do
  it 'gets users inputs if user has an API Key' do
    puts 'I am collecting sample API Key details from you. Please type SAMPLE values and press ENTER'
    expect { check_key(true) }.to_not raise_error
  end
  it 'displays follow up information to new user and question if user has no API Key ' do
    expect { follow_up(false) }.to_not raise_error
  end
  it 'does not anything if no argument given' do
    expect { follow_up }.to raise_error(ArgumentError)
  end
end
describe '#connect' do
  it 'connects user to a CEX.io real account if user has an API Key' do
    expect { connect(true) }.to_not raise_error
    @demo = false
    expect(connect(true).class).to eql(Trade::API)
  end
  it "connects user to a CEX.io demo account if user doesn't have an API Key" do
    expect { connect(false) }.to_not raise_error
    @demo = true
    expect(connect(false).class).to eql(Trade::API)
  end

  it 'does not anything if no argument given' do
    expect { connect }.to raise_error(ArgumentError)
  end
end
describe '#on_connection_options' do
  it 'displays introductory message to user on connection' do
    expect(on_connection_options).to eql(puts("What do you want to do next?
        Please choose your desired operation:
        1: Check balance
        2: Start Bot in the automatic trading mode
        3. Get trading fees
        You chose option: "))
  end
  it 'returns always an empty object' do
    expect { on_connection_options }.to_not raise_error
    expect(on_connection_options.class).to eql(NilClass)
    expect(on_connection_options.to_s.class).to_not eql(nil)
  end
  it 'raises error if arguments passed' do
    expect { on_connection_options(nil) }.to raise_error(ArgumentError)
    expect { on_connection_options(@authorized) }.to raise_error(ArgumentError)
  end
end
describe '#on_intro' do
  it 'displays introductory message and guidance to user on operations' do
    expect(on_intro(1)).to eql(puts(@message_intro, @message))
    expect(on_intro(2)).to eql(puts(@message_intro, @message))
    expect(on_intro(3)).to eql(puts(@message_intro, @message))
  end
  it 'returns always an empty object' do
    expect { on_intro(@operation) }.to_not raise_error
    expect(on_intro(@operation).class).to eql(NilClass)
    expect(on_intro(@operation).to_s.class).to_not eql(nil)
  end
  it 'raises error if no argument passed' do
    expect { on_intro }.to raise_error(ArgumentError)
  end
end
describe '#execute' do
  it "executes user's chosen operation" do
    expect { execute(@operation) }.to_not raise_error
  end
  it 'raises error if no argument passed' do
    expect { execute }.to raise_error(ArgumentError)
  end
end
