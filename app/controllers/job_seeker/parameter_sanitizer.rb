class JobSeeker::ParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:social_name, :cpf, :phone, :cv, :email])
  end
end