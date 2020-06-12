require_relative '../lib/strategy.rb'
require_relative '../lib/cexio.rb'

describe Trade do
  describe Trade::API do
    DEMO_USR = 'up131139167'.freeze
    DEMO_KEY = 'NJGrN6Dev9M57nyxQDaFQzZa4Q'.freeze
    DEMO_SECRET = 'MI87dH6sDIh1g0aQQNfV1PdaimQ'.freeze
    let(:connect) { Trade::API.new(DEMO_USR, DEMO_KEY, DEMO_SECRET) }
    describe '#initialize' do
      it 'creates the API class instance if all required attibutes are passed' do
        expect(connect.class).to eql(Trade::API)
        expect(connect.api_key).to eql(DEMO_KEY)
        expect(connect.api_secret).to eql(DEMO_SECRET)
        expect(connect.username).to eql(DEMO_USR)
      end
      it 'does not create object if required arguments missing' do
        expect { Trade::API.new }.to raise_error(ArgumentError)
        expect { Trade::API.new(DEMO_USR) }.to raise_error(ArgumentError)
        expect { Trade::API.new(DEMO_KEY) }.to raise_error(ArgumentError)
        expect { Trade::API.new(DEMO_USR, DEMO_SECRET) }.to raise_error(ArgumentError)
      end
    end

    describe '#autotrade' do
      it 'executes live trading operations automatically in the CEX.io trading platform' do
        expect { connect.autotrade }.to_not raise_error
      end
      it 'raises error if arguments passed ' do
        expect { connect.autotrade(connect) }.to raise_error(ArgumentError)
      end
    end

    describe '#demotrade' do
      it 'executes demo trading operations automatically.' do
        expect { connect.demotrade }.to_not raise_error
      end
      it 'raises error if arguments passed ' do
        expect { connect.demotrade(connect) }.to raise_error(ArgumentError)
      end
    end
    describe '#balance' do
      it 'returns account balances for all currency pairs' do
        expect(connect.balance.class).to eql(Hash)
      end
      it 'does not return a nil object' do
        expect(connect.balance).to_not eql nil
      end
    end
    describe '#getmyfee' do
      it 'returns the list of currently applicable fees for all currency pairs' do
        expect(connect.getmyfee.class).to eql(Hash)
      end
      it 'does not return a nil object' do
        expect(connect.getmyfee).to_not eql nil
      end
    end
    describe '#place_order' do
      it 'places buy/sell orders on the CEX.IO platform' do
        expect(connect.place_order('buy', 1, 1, 'GHS/BTC').class).to eql(Hash)
      end
      it 'does not place orders if arguments missing' do
        expect { connect.place_order }.to raise_error(ArgumentError)
        expect { connect.place_order(1, 1, 'GHS/BTC') }.to raise_error(ArgumentError)
        expect { connect.place_order(1, 'GHS/BTC') }.to raise_error(ArgumentError)
        expect { connect.place_order('buy', 1) }.to raise_error(ArgumentError)
        expect { connect.place_order('buy', 'GHS/BTC') }.to raise_error(ArgumentError)
      end
    end
  end
end
