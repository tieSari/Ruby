module UsersHelper
  def froze(param)
    if (param.froze==true)
      param.update_attribute(:froze, false)
    else
      param.update_attribute(:froze, true)
    end
    param.save
  end
end
