#TODO: Add refresh token rotation configuration (Okta provider needs to be updated to enable this feature

resource "okta_app_oauth" "customer_portal" {
  status         = "ACTIVE"
  label          = "Customer Portal"
  type           = "web"
  redirect_uris  = ["https://localhost:44369/signin-oidc", "https://localhost:44369/Customer", "https://oauth.pstmn.io/v1/callback"]
  post_logout_redirect_uris = ["https://localhost:44369/signout-callback-oidc"]
  login_uri      = "https://localhost:44369/signin-oidc"
  grant_types    = ["client_credentials", "authorization_code", "refresh_token"]
  response_types = ["code"]
  consent_method = "TRUSTED"
  refresh_token_rotation = "ROTATE"
  skip_users = true
  skip_groups = true
  refresh_token_leeway = 60
}

resource "okta_app_oauth" "example" { 
  status = "ACTIVE" 
  label = "Example Portal" 
  type = "web" 
  redirect_uris = ["https://localhost:44378/signin-oidc", "https://localhost:44378/Customer", "https://oauth.pstmn.io/v1/callback"]
  post_logout_redirect_uris = ["https://localhost:44378/signout-callback-oidc"] 
  login_uri = "https://localhost:4437811/signin-oidc" 
  grant_types = ["client_credentials", "authorization_code", "refresh_token"]
  response_types = ["code"] 
  consent_method = "TRUSTED"
  refresh_token_rotation = "ROTATE" 
  skip_users = true 
  skip_groups = true
  refresh_token_leeway = 60
}

resource "okta_auth_server" "test_server" {
  audiences = ["api://iatcore.com"] 
  description = "Auth Server that handles test apps" 
  name = "Test Server" 
  issuer_mode = "ORG_URL" 
  status = "ACTIVE" 
}

resource "okta_auth_server_scope" "test_scope" { 
  auth_server_id = okta_auth_server.test_server.id
  description = "This allows the test server to view your IATCore account information." 
  name = "iat.account.read" 
}

resource "okta_auth_server_claim" "test_claim" { 
  auth_server_id = okta_auth_server.test_server.id 
  name = "Type" 
  value = "user.userType" 
  scopes = [ okta_auth_server_scope.test_scope.name ] 
  claim_type = "IDENTITY"
}
