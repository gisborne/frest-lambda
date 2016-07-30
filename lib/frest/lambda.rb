require "frest/lambda/version"

module Frest
  module Lambda
    module_function

    def get(
      id:,
      store:
    )
      x = store.get(id: id)
      return x if x == Frest::Core::NotFound
      k = x.keys.first
      f = store.get(id: k)
      f.call(x[k])
    end
  end
end
