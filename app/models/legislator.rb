class Legislator < User
  validate :opencongress_org_email

  def opencongress_org_email
    unless email.match(/@opencongress\.org$/)
      errors.add(:email, "must be an opencongress.org address")
    end
  end
end
