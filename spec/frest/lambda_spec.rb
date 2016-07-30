require 'spec_helper'
require 'frest/composers'
require 'frest/memory_store'

module FunctionStore
  module_function

  def add(
    x1:,
    x2:
  )

    x1 + x2
  end

  def times(
    x1:,
    x2:
  )

    x1 * x2
  end

  def get(
    id:
  )
    method(id) rescue Frest::Core::NotFound
  end
end

describe Frest::Lambda do
  it 'has a version number' do
    expect(Frest::Lambda::VERSION).not_to be nil
  end

  it 'can create and call a function' do
    m = Frest::MemoryStore
    f = FunctionStore
    lambda = Frest::Lambda
    store = Frest::Composers.priority(endpoints: [f, m])

    store.set(id: 'cc440e9f-9973-4c54-acf2-45f34f7acd45', content: {add: {x1: 1, x2: 2}})
    value = lambda.get(
                id: 'cc440e9f-9973-4c54-acf2-45f34f7acd45', store: store)
    expect(value).to eq(3)
  end
end
