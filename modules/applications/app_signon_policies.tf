resource "okta_app_signon_policy" "passwordless" {
  name        = "Passwordless"
  description = "Authentication Policy that supports passwordless."
}

resource "okta_app_signon_policy_rule" "magic_link" {
  policy_id                   = resource.okta_app_signon_policy.passwordless.id
  name                        = "Magic Link"
  factor_mode                 = "1FA"
  type                        = "ASSURANCE"
  re_authentication_frequency = "PT2H"
}

resource "okta_app_oauth" "my_app" { 
  label = "My App" 
  type = "web" 
  grant_types = ["authorization_code"] 
  redirect_uris = ["http://localhost:3000"] 
  post_logout_redirect_uris = ["http://localhost:3000"] 
  response_types = ["code"] // this is needed to associate the application with the policy 
  authentication_policy = okta_app_signon_policy.my_app_policy.id 
}

resource "okta_app_signon_policy" "my_app_policy" { 
  name = "My App Sign-On Policy" 
  description = "Authentication Policy to be used on my app." 
}
