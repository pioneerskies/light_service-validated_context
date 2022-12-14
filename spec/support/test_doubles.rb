# frozen_string_literal: true

class ActionExpectingStrictString
  extend LightService::Action

  expects VK.new(:email, Types::Strict::String)

  executed do |context|
    context
  end
end

class ActionExpectingStrictStringWithDefault
  extend LightService::Action

  expects VK.new(:email, Types::Strict::String.default('default@example.com'))

  executed do |context|
    context
  end
end

class ActionExpectingCoercibleString
  extend LightService::Action

  expects VK.new(:email, Types::Coercible::String)

  executed do |context|
    context
  end
end

class ActionExpectingCoercibleInteger
  extend LightService::Action

  expects VK.new(:number, Types::Coercible::Integer)

  executed do |context|
    context
  end
end

class ActionPromisingStrictString
  extend LightService::Action

  promises VK.new(:email, Types::Strict::String)

  executed do |context|
    context.email = 'foo@email.com'
  end
end

class ActionPromisingStrictStringButItDoesNot
  extend LightService::Action

  promises VK.new(:email, Types::Strict::String)

  executed do |context|
    context
  end
end

class ActionPromisingStrictStringWithDefault
  extend LightService::Action

  promises VK.new(:email, Types::Strict::String.default('default@example.com'))

  executed do |context|
    context
  end
end

class ActionPromisingCoercibleString
  extend LightService::Action

  promises VK.new(:email, Types::Coercible::String)

  executed do |context|
    context.email = :'symbol@example.com'
  end
end

class ActionPromisingCoercibleInteger
  extend LightService::Action

  promises VK.new(:number, Types::Coercible::Integer)

  executed do |context|
    context.number = 'fourtytwo'
  end
end

class ActionPromisingCoercibleIntegerWithIgnoredConstain
  extend LightService::Action

  promises VK.new(:number, Types::Coercible::Integer.constrained(:lteq => 40))

  executed do |context|
    context.number = '42'
  end
end

class CustomClass; end # rubocop:disable Lint/EmptyClass

class ActionExpectingCustomClass
  extend LightService::Action

  expects VK.new(:klass, Types.Instance(::CustomClass))

  executed do |context|
    context
  end
end

class ActionFailInsteadOfRaise
  extend LightService::Action
  extend LightService::Context::FailOnValidationError

  expects VK.new(:foo, Types::String)

  executed do |context|
    context
  end
end

class ActionWithCustomValidationMessage
  extend LightService::Action

  expects VK.new(:integer, Types::Strict::Integer, :message => 'Custom validation message')

  executed do |context|
    context
  end
end

class ActionWithCustomValidationMessageI18n
  extend LightService::Action

  expects VK.new(:integer, Types::Strict::Integer, :message => :an_error_message)

  executed do |context|
    context
  end
end

class ActionWithCustomValidationMessageNoRaise
  extend LightService::Action
  extend LightService::Context::FailOnValidationError

  expects VK.new(:integer, Types::Strict::Integer, :message => 'Custom validation message')

  executed do |context|
    context
  end
end
