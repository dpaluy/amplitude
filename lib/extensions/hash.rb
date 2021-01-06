class Hash
  def select_keys(*args)
    args.flatten!
    select { |k, _| args.include? k }
  end
end
