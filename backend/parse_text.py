a = ["**Story:**\n\nOnce upon a time, there was a little fish named Finny who lived in a big, blue ocean. He loved to play with his friends, the other fish. They would swim and splash and have lots of fun.\n\nOne day, Finny was swimming alone when he saw something strange. It was a big, black shape with lots of arms and legs. Finny was scared, but he also wanted to know what it was.\n\nHe swam closer and closer until he could see what it was. It was a giant squid! The squid had big, round eyes and a big, beak-like mouth.\n\nFinny was so scared that he swam away as fast as he could. He didn't stop swimming until he was safe in his cave.\n\n**Quiz 1:**\n\nWhere did Finny live?\nA. [X] In a big, blue ocean\nB. In a small, green pond\nC. In a tall, rocky mountain\n\n**Quiz 2:**\n\nWhat did Finny see that scared him?\nA. A giant squid\nB. A big, black fish\nC. [X] A friendly dolphin\n\n**Quiz 3:**\n\nWhat did Finny do when he saw the giant squid?\nA. He swam away as fast as he could\nB. He tried to hide in a cave\nC. He asked the squid to play with him\n\n**Values:**\n\n* Curiosity\n* Bravery\n* Friendship", '**القصة:**\n\nذات مرة، كانت هناك سمكة صغيرة تدعى فيني تعيش في محيط كبير أزرق. لقد أحب اللعب مع أصدقائه الأسماك الأخرى. كانوا يسبحون ويتناثرون ويستمتعون كثيرًا.\n\nفي أحد الأيام، كانت فيني تسبح بمفردها عندما رأت شيئًا غريبًا. كان شكلًا أسود كبيرًا به الكثير من الأذرع والساقين. كانت فيني خائفة، لكنها أرادت أيضًا معرفة ما هو.\n\nسبحت أقرب وأقرب حتى تمكنت من رؤية ما هو. لقد كان حبارًا عملاقًا! كان للحبار عيون كبيرة مستديرة وفم كبير يشبه المنقار.\n\nكانت فيني خائفة للغاية لدرجة أنها سبحت بعيدًا بأسرع ما يمكن. لم تتوقف عن السباحة حتى وصلت إلى كهفها سالمة.\n\n**الاختبار 1:**\n\nأين عاشت فيني؟\nأ. [X] في محيط كبير أزرق\nب. في بركة صغيرة خضراء\nج. في جبل شاهق صخري\n\n**الاختبار 2:**\n\nماذا رأت فيني أخافها؟\nأ. حبار عملاق\nب. سمكة سوداء كبيرة\nج. [X] دولفين ودود\n\n**الاختبار 3:**\n\nماذا فعلت فيني عندما رأت الحبار العملاق؟\nأ. سبحت بعيدًا بأسرع ما يمكن\nب. حاولت الاختباء في كهف\nج. طلبت من الحبار اللعب معها\n\n**القيم:**\n\n* الفضول\n* الشجاعة\n* الصداقة']
a = "---------\n".join(a)

arabic_english = a.split("---------")
if(arabic_english[0].find("**Story:**") == -1): # arabic is first, invert it
    arabic_english[0] , arabic_english[1] = arabic_english[1] , arabic_english[0]


english = arabic_english[0]
en_story , en_quizs_value = english.split("**Quiz 1:**")
en_quizs, en_value = en_quizs_value.split("**Values:**")
en_story = en_story.strip()
en_value = en_value.strip() # removes stuff that is not usefull
en_qz_1,en_quizs = en_quizs.split("**Quiz 2:**")
en_qz_2 , en_qz_3 = en_quizs.split("**Quiz 3:**")
en_qz_1 = en_qz_1.strip()
en_qz_2 = en_qz_2.strip()
en_qz_3 = en_qz_3.strip()
en_qz = [en_qz_1,en_qz_2,en_qz_3]


arabic = arabic_english[1]
ar_story , ar_quizs_value = arabic.split("**الاختبار 1:**")
_ , ar_story = ar_story.split("**القصة:**")

ar_quizs, ar_value = ar_quizs_value.split("**القيم:**")
ar_story = ar_story.strip()
ar_value = ar_value.strip() # removes stuff that is not usefull
ar_qz_1,ar_quizs = ar_quizs.split("**الاختبار 2:**")
ar_qz_2 , ar_qz_3 = ar_quizs.split("**الاختبار 3:**")
ar_qz_1 = ar_qz_1.strip()
ar_qz_2 = ar_qz_2.strip()
ar_qz_3 = ar_qz_3.strip()
ar_qz = [ar_qz_1,ar_qz_2,ar_qz_3]

