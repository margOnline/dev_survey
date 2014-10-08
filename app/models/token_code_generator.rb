require 'csv'

class TokenCodeGenerator

  def initialize(args)
    @prefix = args[:prefix]
    @number = args[:number]
  end

  def generate_token_codes
    csv_path = "#{Rails.root}/tmp/#{@prefix}-token_codes-#{Date.today}.csv"
    CSV.open(csv_path, "wb") do |csv|
      puts "Generating #{@number} #{@prefix} tokens..."
      @number.to_i.times do
        token = create_token
        csv << [token.code]
      end
      puts "tokens available in #{csv_path}"
    end
  end

  def create_token
    token = Token.new()
    token.code = random_token_code
    token.save
    token.reload
  end

  private

  def random_token_code
    loop do
      @code = create_token_code
      return @code if Token.where(:code => @code).empty?
    end
  end

  def create_token_code
    @prefix + [*(1..9), *('A'..'Z')].flatten.sample(10).join
  end

end
