require "./lib/strategy.rb"
require "./lib/cexio.rb"

describe Trade do
  describe Trade::API do
    DEMO_USR = "up131139167".freeze
    DEMO_KEY = "NJGrN6Dev9M57nyxQDaFQzZa4Q".freeze
    DEMO_SECRET = "MI87dH6sDIh1g0aQQNfV1PdaimQ".freeze
    let(:connect) { Trade::API.new(DEMO_USR, DEMO_KEY, DEMO_SECRET) }

    # rubocop: disable Lint/LiteralAsCondition
    describe "#initialize" do
      it "creates the API class instance if all required attibutes are passed" do
        expect(connect.class).to eql(Trade::API)
        expect(connect.api_key).to eql(DEMO_KEY)
        expect(connect.api_secret).to eql(DEMO_SECRET)
        expect(connect.username).to eql(DEMO_USR)
      end
      it "does not create object if required arguments missing" do
        expect { Trade::API.new }.to raise_error(ArgumentError)
        expect { Trade::API.new(DEMO_USR) }.to raise_error(ArgumentError)
        expect { Trade::API.new(DEMO_KEY) }.to raise_error(ArgumentError)
        expect { Trade::API.new(DEMO_USR, DEMO_SECRET) }.to raise_error(ArgumentError)
      end
    end
    # rubocop: enable Lint/LiteralAsCondition
    describe "#autotrade" do
      it "executes live trading operations automatically in the CEX.io trading platform" do
        expect { connect.autotrade }.to_not raise_error
      end
      it "raises error if arguments passed " do
        expect { connect.autotrade(connect) }.to raise_error(ArgumentError)
      end
    end
  end
end
