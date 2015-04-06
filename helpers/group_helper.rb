module GroupHelper
  def group_selected?
    vars.has_key? :group
  end

  def group
    vars[:group]
  end
end
