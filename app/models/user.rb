class User < SwellMedia::User

	devise :database_authenticatable, :omniauthable, :registerable, :recoverable, :rememberable, :trackable, authentication_keys: [ :login ], omniauth_providers: [ :facebook, :twitter ]

	has_many	:oauth_credentials


end