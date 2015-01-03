class PrimeNumberGenerator
  attr_reader :primes, :number_of_factors
  def initialize(args = {})
    @max = args.fetch(:max)
    @primes = []
    @number_to_test = 2
    @divisor = 2
    @number_of_factors = 0
  end

  def run_trial
    until @number_to_test == @max.to_i
      test_primality
      @primes << @number_to_test if is_prime?
      reset_values
      @number_to_test += 1
    end
  end

  def test_primality
    if @number_to_test % @divisor == 0
      @number_of_factors += 1
      @divisor += 1
      return if @divisor > Math.sqrt(@number_to_test) # primality if no multiples between 2 and square root of n
      self.test_primality
    else
      @divisor += 1
      return if @divisor > Math.sqrt(@number_to_test) # primality if no multiples between 2 and square root of n
      self.test_primality
    end
  end

  def reset_values
    @number_of_factors = 0
    @divisor = 2
  end

  def is_prime?
    if @number_of_factors == 0
      true
    else
      false
    end
  end
end


class PalindromeChecker
  def self.is_palindrome?(input)
    input.to_s.reverse == input.to_s ? true : false
  end
end


class Controller
  def run
    test_cases = []
    # File.open(ARGV[0]).each_line do |line|
    #   test_cases << line
    # end
    test_cases << "1000"
    prime = PrimeNumberGenerator.new({max: test_cases[0]})
    prime.run_trial
    # p prime.primes

    prime.primes.reverse.each do |prime|
      if PalindromeChecker.is_palindrome? prime
        return puts prime
      end
    end
  end
end


Controller.new.run