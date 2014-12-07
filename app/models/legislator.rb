class Legislator < User
  validate :opencongress_org_email

  def constituants
    if house_district_id
      Voter.where(house_district_id: house_district_id)
    elsif senate_district_id
      Voter.where(senate_district_id: senate_district_id)
    else
      nil
    end
  end

  private
  def opencongress_org_email
    unless email.match(/@opencongress\.org$/)
      errors.add(:email, "must be an opencongress.org address")
    end
  end
end
