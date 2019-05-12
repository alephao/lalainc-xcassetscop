# frozen_string_literal: true

class Hash
  def sdig(key)
    dig(key.to_s) || dig(key.to_sym)
  end
end
