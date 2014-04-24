
r = SwellMedia::Role.create name: 'godmin'

u = User.create email: 'gk@gkparishphilp.com', name: 'Gk', password: '1234'
u.roles << r

hp = SwellMedia::Page.create title: 'Homepage', content: 'I am a Homepage', status: 'active'
