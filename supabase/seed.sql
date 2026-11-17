-- =========================================================
--  SYLI - starter content (generated from js/data.js)
--  Run AFTER schema.sql. Safe to run more than once.
--  To remove content later, delete it in the admin page.
-- =========================================================

begin;

-- Projects
insert into public.projects (slug, title, status, category, summary, description, lead, location, timeline, highlights, photos, featured, published, sort_order) values
  ('youth-leadership-training', 'Youth Leadership Training', 'Ongoing', 'Leadership', 'Practical workshops on public speaking, teamwork, planning, safeguarding and ethical leadership for young people aged 15 to 30.', 'Most young people in Salima are handed leadership long before anyone teaches them how to hold it. This programme changes that.

Our workshops are deliberately practical. Participants practise speaking in front of a room, plan a small project from start to finish, learn how to budget a few thousand kwacha honestly, and talk openly about safeguarding and consent. No one leaves with a certificate and nothing else — every cohort finishes with a plan, a partner and a next step.

Sessions are run in the community, in spaces young people already trust, and are led by young facilitators who are only a few steps ahead rather than a world away.', 'SYLI training team', 'Salima District', 'Rolling cohorts', array['Public speaking and facilitation practice','Project planning and simple budgeting','Safeguarding and ethical leadership','Every participant leaves with a project plan']::text[], array['assets/photos/workshop-leadership.jpg','assets/photos/workshop-a.jpg','assets/photos/workshop-b.jpg']::text[], true, true, 0),
  ('mentorship-circles', 'Mentorship Circles', 'Ongoing', 'Mentorship', 'Small, consistent groups where emerging leaders learn from mentors across the district — for months, not minutes.', 'One workshop does not make a leader. A relationship does.

Mentorship Circles bring six to ten young people together with a mentor from the district: a health worker, a teacher, a farmer, a business owner, a young professional. They meet regularly, set goals, and talk honestly about what is actually hard.

The circle is small on purpose. It is a place where it is safe to say you failed, where someone notices when you disappear, and where advice comes from someone who knows the road because they walk it.', 'SYLI mentorship team', 'Salima', 'Continuous', array['Small groups of 6–10 young people','Mentors drawn from across Salima','Goal setting with real follow-up','A network that outlasts the programme']::text[], array['assets/photos/workshop-b.jpg']::text[], true, true, 1),
  ('youth-agribusiness-chilli', 'Youth Agribusiness: African Bird''s Eye Chilli', 'Ongoing', 'Livelihoods', 'Young people in Salima are growing African Bird''s Eye chilli as a route out of poverty — and learning the business behind the crop.', 'Leadership means little if a young person still cannot feed their family. So we work on income too.

Our members are growing African Bird''s Eye chilli, a high-value crop that suits the district and can be sold beyond it. But the crop is only half the point. Alongside it, members learn record keeping, pricing, group selling, and how to deal with a season that does not go to plan.

This is youth-led in the most literal sense: the farmers are the members, the decisions are made in the group, and the profit stays in Salima. We are not sleeping on this — and we are not doing it alone.', 'SYLI livelihoods team', 'Salima', 'Seasonal', array['African Bird''s Eye (chilli) production','Record keeping, pricing and group selling','Practical learning from a real harvest','Income that stays in the district']::text[], array['assets/photos/project-chilli.jpg']::text[], true, true, 2),
  ('lakeshore-clean-ups', 'Lakeshore Clean-ups', 'Upcoming', 'Environment', 'Community days to keep the shores of Lake Malawi clean — and to build a habit of care for the place that feeds us.', 'Lake Malawi is not a backdrop for Salima. It is the economy, the water, the food and the identity of the district.

Our lakeshore clean-ups will bring young people, schools and fishing communities together for practical days of clearing waste, talking about plastic, and learning what a healthy shoreline actually needs.

We are still planning the first clean-up. If you are a school, a beach committee, a boat owner or a young person who is tired of seeing the lake treated badly, this is your invitation.', 'Open — volunteers welcome', 'Lake Malawi shoreline, Salima', 'First clean-up being planned', array['Community clean-up days','School and youth club involvement','Practical waste and plastic awareness','Care for the lake as a shared responsibility']::text[], array['assets/photos/shore-salima.jpg']::text[], false, true, 3),
  ('young-changemakers-fund', 'Young Changemakers Fund', 'Upcoming', 'Funding', 'Small grants and hands-on coaching for youth-led ideas that make life better in Salima.', 'Some of the best ideas in Salima need two hundred thousand kwacha and one person who believes in them. Not a lecture. Not a conference. A small, honest grant and someone who answers the phone.

The Young Changemakers Fund is being designed to do exactly that: modest grants for youth-led projects, paired with coaching, simple reporting and a community of other young founders.

We are building the pilot carefully — deciding the criteria, the safeguards and how decisions will be made in the open. If you would like to fund the first cohort or help design it, talk to us.', 'SYLI executive', 'Salima District', 'Pilot in development', array['Small grants for youth-led ideas','Coaching alongside the money','Simple, honest reporting','Decisions made in the open']::text[], array['assets/photos/story-change.jpg']::text[], false, true, 4),
  ('school-outreach', 'School Outreach & Career Talks', 'Upcoming', 'Education', 'Young facilitators visiting schools to talk honestly about choices, health, leadership and what comes after Form Four.', 'Every secondary school in Salima is full of young people making decisions with very little honest information.

Our outreach visits are built around conversation, not a speech. Young facilitators — close enough in age to be believed — talk about subject choices, life after Form Four, health, consent, money and the small decisions that quietly change a life.

We are preparing the first visits with schools in the district. Teachers and head teachers who would like a visit are welcome to reach out.', 'SYLI outreach team', 'Schools across Salima', 'From the next school term', array['Peer-led conversations in schools','Life after Form Four and subject choices','Health, consent and safeguarding','Follow-up with interested students']::text[], array['assets/photos/workshop-a.jpg']::text[], false, true, 5)
on conflict (slug) do nothing;

-- Team
insert into public.members (name, role, team_group, studies, based, focus, bio, quote, email, photo, featured, published, sort_order)
select * from (values
  ('Pemphero Kamapalira', 'Safeguarding & Welfare', 'leadership', 'Public Health, Domasi Development College', 'Salima', 'Keeping young people safe, supported and heard.', 'Pemphero is an Executive Member of Salima Youth Leadership Initiative and a student of Public Health at Domasi Development College. She leads our safeguarding and welfare work: making sure that every space we create is safe for young people, that concerns are taken seriously, and that the person in front of us is treated as a whole person, not a case.', '', '', 'assets/photos/member-pemphero.jpg', true, true, 0),
  ('Wakisa Chipeta', 'Vice Secretary', 'leadership', '', 'Salima', 'Health, records and getting things organised.', 'Wakisa is Vice Secretary and an Executive Member of SYLI. She works as a Health Surveillance Assistant, which means she spends her days at the intersection of health and community trust. At SYLI she keeps our records straight, our meetings moving and our promises written down — so that the work can be repeated and not just remembered.', '', '', 'assets/photos/member-wakisa.jpg', true, true, 1),
  ('Farouk Lihomah', 'Honorary Member', 'honorary', 'Politics & Governance, Mzuzu University', 'Salima / Mzuzu', 'Governance, youth empowerment and community development.', 'Farouk is an Honorary Member of SYLI and studies Politics and Governance at Mzuzu University. He is passionate about governance, youth empowerment and community development in Salima. He brings a national perspective on how policy is made — and a stubborn belief that Salima''s young people should be in the room when it is.', '', '', 'assets/photos/member-farouk.jpg', true, true, 2),
  ('Mercy', 'Executive Member', 'executive', '', 'Salima', 'Community health and member support.', 'Mercy is an Executive Member of SYLI and works as a Health Surveillance Assistant. She supports member care and community outreach, and is one of the people who makes sure a new volunteer is welcomed properly rather than simply signed up.', '', '', '', false, true, 3)
) as v(name, role, team_group, studies, based, focus, bio, quote, email, photo, featured, published, sort_order)
where not exists (select 1 from public.members m where lower(m.name) = lower(v.name));

-- Stories
insert into public.articles (slug, title, standfirst, category, author, date, layout, cover, tags, body, featured, published, sort_order) values
  ('change-does-not-begin-with-wealth', 'Change doesn''t begin with wealth. It begins with someone who dares.', 'A reflection from Salima on why the smallest action can outlast the biggest speech.', 'Essay', 'Salima Youth Leadership Initiative', '2026-10-19'::date, 'feature', 'assets/photos/story-change.jpg', array['Leadership','Salima','Youth']::text[], 'Change does not begin with wealth, power or position. It begins with people who dare to make a difference.

We say this in Salima because we have seen it. Not in a conference hall, but in a group of young people who decided that the way things are is not the way things have to stay.

## The excuse we stopped using

For a long time, the sentence we heard most was some version of *we don''t have enough*. Not enough money. Not enough support. Not enough time. And it is true — there is never enough.

But "not enough" is not a plan. It is a reason to wait. And waiting has a cost that never appears in a budget: another year of young people finishing school and drifting, another year of good ideas dying quietly in a notebook.

> When we unite around a common purpose, even the smallest action can create a lasting impact.

## What small actually looks like

It looks like a mentorship circle of eight people meeting under a tree because there is no room to book. It looks like a member learning to keep a record of every kwacha from a chilli harvest. It looks like a young woman standing up in a room for the first time and finishing her sentence.

None of that is dramatic. All of it compounds.

## A better Salima is built by people who stay

There is a version of ambition that says the best thing a young person from Salima can do is leave. We understand it. But we are building the other version: young people who leave to learn and come back to lead, and young people who never leave at all and lead anyway.

The future of Salima is not in the hands of people who are waiting for us to fail. It is in our hands, and it will be built in small, stubborn pieces.

Together we lead. Together we change Salima.', true, true, 0),
  ('we-are-not-sleeping-chilli', 'We are not sleeping: the chilli that could change a season', 'In Salima, a group of young farmers is betting on African Bird''s Eye chilli — and treating farming as a business, not a last resort.', 'Field notes', 'SYLI Livelihoods Team', '2026-10-11'::date, 'field-note', 'assets/photos/project-chilli.jpg', array['Livelihoods','Farming','Salima']::text[], 'There is a sentence you hear often in Salima when people talk about young people and work: *they are sleeping*.

We want to answer that. We are not sleeping.

## Why chilli

African Bird''s Eye is a small crop with a serious market. It tolerates the district''s conditions, it can be grown on a plot that a family already has, and — when it is dried, graded and sold together — it earns more than most young people are told to expect from farming.

But the crop is not the lesson. The lesson is that farming is a business, and a business needs records.

## What the group is learning

- What it actually costs to grow a plot, written down
- How to price as a group instead of competing with each other
- How to dry and grade so the crop is worth more
- What to do when a season goes wrong

None of this is taught in a classroom. It is taught by doing it, with people who will notice if you stop showing up.

> Ulimi ndi njira imodzi imene achinyamata ku Salima ayikakamira kuti asinthe miyoyo yawo.
> Farming is one of the paths young people in Salima are using to change their lives.

## The point is not chilli

The point is that a young person in Salima can build something here. Not after a scholarship. Not after a visa. Here.

If that sounds small, come and stand in the field at the end of a season and tell us.', true, true, 1),
  ('leadership-is-not-about-age', 'Leadership is not about age. It''s about action.', 'Why we refuse to wait our turn — and what young leadership actually demands.', 'Opinion', 'Salima Youth Leadership Initiative', '2026-10-10'::date, 'feature', 'assets/photos/workshop-leadership.jpg', array['Leadership','Youth']::text[], 'Leadership is not about age. It is about action.

That sentence is easy to put on a poster. It is much harder to live, because age is the easiest reason in the world to tell a young person to wait.

## Waiting is a policy

When a young person is told "not yet", it usually sounds like kindness: gain experience, finish school, build your network. But a whole generation can be kept out of the room by a polite version of "not yet".

We are not asking to be handed leadership. We are asking to be prepared for it, trusted with it, and judged on what we do with it.

## Action looks like showing up

At SYLI, leadership starts with unglamorous things:

- Coming to a meeting you said you would come to
- Keeping a record that someone else can trust
- Speaking up in a room where it is easier to stay quiet
- Doing the small job properly when nobody is watching

> The future of Salima is in our hands. Let''s build it together.

## What we owe the next person

Every young leader here is standing on someone''s patience. A teacher, an aunt, a health worker, a mentor who answered the phone at the wrong time of day.

The least we can do is leave the door open behind us — and make sure the next person walks through it faster than we did.', true, true, 2),
  ('meet-pemphero', 'Meet Pemphero: the quiet work of keeping young people safe', 'Our Safeguarding and Welfare lead on public health, protection and why the person always comes before the programme.', 'Member spotlight', 'SYLI Communications', '2026-11-16'::date, 'feature', 'assets/photos/member-pemphero.jpg', array['Team','Safeguarding','Health']::text[], 'Pemphero Kamapalira is an Executive Member of Salima Youth Leadership Initiative and leads our safeguarding and welfare work. She studies Public Health at Domasi Development College.

## Why safeguarding is not a side issue

In youth work, safeguarding is often treated as a form to sign so that a programme can start. At SYLI, it is part of the programme itself.

When an organisation grows faster than its care, young people can share something difficult and find that nobody is ready to receive it. The response is to build the care in from the beginning: clear expectations, trusted adults, and the discipline to follow up.

## Public health, in a youth organisation

Public health is not a separate topic that you schedule for one afternoon. It shows up in how a room is arranged, how consent is asked for, and whether a girl who stops attending is followed up instead of forgotten.

That is the lens Pemphero brings to the role — a reminder that a programme is only as safe as the habits around it.

## What safeguarding means here

Safeguarding is not suspicion. It is preparation. It is the difference between a safe space and a space that merely calls itself one.

We are proud to have her on our team.', true, true, 3),
  ('meet-wakisa', 'Meet Wakisa: the record-keeping that keeps a young organisation honest', 'Our Vice Secretary on health work, records and the unglamorous habits that help a young organisation last.', 'Member spotlight', 'SYLI Communications', '2026-11-14'::date, 'feature', 'assets/photos/member-wakisa.jpg', array['Team','Health','Governance']::text[], 'Wakisa Chipeta is Vice Secretary and an Executive Member of Salima Youth Leadership Initiative. She works as a Health Surveillance Assistant.

## The organisation you can audit

Youth organisations do not usually fail dramatically. They fail quietly — a promise made twice, a budget no one can reconstruct, a member who stopped coming and no one noticed.

The answer to that is unglamorous and effective: write it down. Minutes, attendance, decisions, follow-ups. Records are how a small team becomes trustworthy, and how good work can be repeated instead of remembered.

## Health at the front desk

Health Surveillance Assistants work in daily contact with families at their most vulnerable. That experience is a useful counterweight in any organisation: it keeps attention on the person in front of you, not just the programme on the page.

## What the role builds

A clear agenda, minutes that reflect what was actually decided, and a follow-up that happens. None of it is photogenic. All of it is how a young organisation becomes one that lasts.

We are proud to have her on our team.', false, true, 4)
on conflict (slug) do nothing;

commit;
