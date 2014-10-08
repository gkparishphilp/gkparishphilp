

u = User.create email: 'gk@gkparishphilp.com', name: 'Gk', password: '1234'
u.admin!

hp = SwellMedia::Page.create title: 'Homepage', content: 'I am a Homepage', status: 'active'
