import os

import json

import time

from playwright.sync_api import sync_playwright



OUT_DIR = r"d:\Code\Books\Mahestan\Premium_Infographics"

PNG_DIR = os.path.join(OUT_DIR, "PNG")

os.makedirs(PNG_DIR, exist_ok=True)

PDF_FILE = os.path.join(OUT_DIR, "Mahestan_Infographics.pdf")

HTML_FILE = os.path.join(OUT_DIR, "deck.html")



slides = [

    {"type": "title", "title": "طرح مجلس مهستان", "sub": "بیانیه‌ی چارچوب نهادی گذار ایران", "hl": "طراحی هوشمندانه برای عبور ایمن از استبداد"},

    {"type": "icon-text", "icon": "fa-map-signs text-cyan-400", "title": "ایران در تقاطع تاریخ", "text": "هیجان و عمل‌گرایی سریع باید با خرد جمعی همراه شود. تصمیمات امروز ما، سرنوشت نسل‌های آینده را رقم خواهد زد."},

    {"type": "cards", "title": "درس‌هایی از تجارب جهانی", "cards": [{"icon": "fa-check-circle text-emerald-400", "title": "الگوهای موفق", "text": "آفریقای جنوبی و اسپانیا؛ گذار با نهادسازی دقیق"}, {"icon": "fa-times-circle text-rose-400", "title": "ضدالگوها", "text": "عراق و لیبی؛ انحلال کامل نهادها و سال‌ها هرج‌ومرج"}]},

    

    # NEW: 6 principles

    {"type": "principles", "title": "۶ اصل راهنمای دوران گذار", "sub": "ستون‌های خیمه‌ی دموکراسی پایدار"},



    {"type": "split", "title": "اصل اول: تخصص در کنار اراده ملی", "left": "بُعد واقعیت\nتکنوکرات‌ها، داده‌ها و حقایق اقتصادی-اجتماعی", "right": "بُعد ارزش\nخواست مردم متبلور در صندوق رأی و رفراندوم"},

    {"type": "icon-text", "icon": "fa-users-viewfinder text-fuchsia-400", "title": "اصل دوم: نمایندگی نسبتی", "text": "در جامعه متکثر ایران، سیستم انتخاباتی لیستی-نسبی تضمین می‌کند ترکیب مجلس آینه‌ای از کل ملت باشد و هیچ صدایی مسکوت نماند."},

    {"type": "icon-text", "icon": "fa-file-signature text-amber-400", "title": "اصل سوم: قانون موقت", "text": "خلأ قانونی مادر جنگ‌های داخلی است! با تصویب دوماهه قانون اساسی موقت، فرصت کافی و آرام برای تبیین قانون نهایی فراهم می‌گردد."},

    {"type": "icon-text", "icon": "fa-building-columns text-slate-300", "title": "اصل چهارم: حفظ ساختارها", "text": "فروپاشی دستگاه‌های زیربنایی فاجعه‌بار است. امور درمانی، اداری و خدماتی با رهبری نوین حفظ شده، تنها بازوهای سرکوب منحل می‌شوند."},

    {"type": "icon-text", "icon": "fa-eye text-cyan-400", "title": "اصل پنجم: پایان تاریک‌خانه‌ها", "text": "تمامی جلسات مجلس علنی، آرا شفاف و مقامات ملزم به افشای دارایی خواهند بود. قدرت بی‌حصار، زاینده‌ی فساد است."},

    {"type": "icon-text", "icon": "fa-scale-balanced text-emerald-400", "title": "اصل ششم: حقوق بشر قطعی", "text": "حقوق بنیادین، برابری حقوقی زن و مرد، و حقوق اقلیت‌ها فوق هر قانونی است؛ حتی مجلس هم توان تعلیق آن‌ها را نخواهد داشت."},

    

    # NEW: Distributed Election Prep

    {"type": "icon-text", "icon": "fa-person-booth text-yellow-400", "title": "انتخابات توزیع‌شده محلی-ملی", "text": "به محض پیروزی، بلافاصله در تمام شهرها انتخابات آزاد ساختاریافته برگزار می‌گردد. هر جریان و حزب مردمی، از امروز باید آماده تشکیل ائتلاف باشد!"},



    # NEW: Org Chart

    {"type": "org-chart", "title": "ساختار یکپارچه نهادی", "sub": "نمای کلی ارکان خیمه‌ی دوران گذار"},



    {"type": "icon-text", "icon": "fa-landmark-dome text-yellow-400", "title": "نهاد محوری: مجلس مهستان", "text": "یک مجلس مردم‌محور که بلافاصله پس از فروپاشی نظام پیشین، با انتخاباتی همگانی زیر نظر جامعه جهانی تشکیل می‌گردد."},

    {"type": "stats", "title": "ترکیب ۳۰۰ نفره مجلس", "stats": [{"val": "۲۴۰", "label": "کرسی استانی (محلی)"}, {"val": "۴۰", "label": "کرسی فهرست‌های ملی"}, {"val": "۲۰", "label": "سهمیه اقلیت‌ها"}]},

    {"type": "stats", "title": "توسعه‌ی همه‌جانبه‌ی مشارکت", "stats": [{"val": "۳۰٪", "label": "حداقل الزام حضور زنان در تمامی لیست‌ها"}, {"val": "دیاسپورا", "label": "حق کاندیداتوری و رأی برای تمام ایرانیان خارج از کشور"}]},

    {"type": "icon-text", "icon": "fa-globe text-cyan-400", "title": "تبعیدیان، بازوهای توسعه", "text": "میلیون‌ها ایرانی دیاسپورا سرمایه‌ی ایران هستند و حق انتخاب مستقیم و واریز رأی به حوزه‌ی داخلی منتخب خود را خواهند داشت."},

    

    {"type": "cards", "title": "کابینه اجرایی موقت", "cards": [{"icon": "fa-briefcase text-cyan-400", "title": "مدیریت کارآمد", "text": "کابینه‌ای از وزرای متخصص برای جلوگیری از اقتصاد رو به زوال."}, {"icon": "fa-handshake text-yellow-400", "title": "ائتلاف الزام‌آور", "text": "پایان دادن کامل به تک‌صدایی و بن‌بست‌های سیاسی."}]},

    {"type": "cards", "title": "اولین مأموریت بنیادین", "cards": [{"icon": "fa-gavel text-amber-400", "title": "قانون اساسی موقت در ۶۰ روز!", "text": "مجلس مهستان تنها ۲ ماه فرصت دارد پیش‌نویس قانون موقت را آماده و مستقیما به نظرسنجی و رفراندوم ملی بگذارد."}]},

    {"type": "cards", "title": "تصفیه قضایی", "cards": [{"icon": "fa-scale-unbalanced text-rose-400", "title": "شورای قضایی انتقالی", "text": "قاضیان و حقوق‌دانان شریف، مأمور برکناری فوری عناصر فاسد، تعلیق قوانین ظالمانه و محاکمات عادلانه."}]},

    {"type": "icon-text", "icon": "fa-shield-halved text-emerald-400", "title": "اصلاح بخش امنیتی", "text": "سریعاً نهادهایی نظیر گشت ارشاد، سازمان‌های عقیدتی و بازوهای سرکوب منحل و نیروهای مردمی در یک ارتش واحد ملی ادغام خواهند شد."},

    

    # UPGRADED TJ CHART!

    {"type": "tj-chart", "title": "عدالت انتقالی", "sub": "پنج ستون اساسی برای پایان چرخه‌ی خشونت"},



    {"type": "icon-text", "icon": "fa-tower-broadcast text-fuchsia-400", "title": "آزادی بی‌حصر رسانه", "text": "پایان انحصار! دستگاه عریض صداوسیما به شبکه‌ای مردمی و بی‌طرف بدل گشته و آزادی تأسیس شبکه‌های خصوصی تضمین می‌گردد."},

    {"type": "icon-text", "icon": "fa-chart-line text-emerald-400", "title": "شورای اقتصادی دوران گذار", "text": "اقتصاددانان خوش‌نام ایران و جهان، مشاور کابینه برای مقابله با ابرتورم، مدیریت یارانه‌ها و شفافیت اموال ملی خواهند بود."},

    {"type": "split", "title": "دو بازوی قانون‌گذاری", "left": "مرکز تحقیقات\nتأمین مستندات تخصصی، پیش‌بینی‌های اقتصادی و مدل‌سازی‌های علمی (واقعیت)", "right": "ارتباط مردمی\nکشف خواست جامع از طریق نظرسنجی‌های ملی و پلتفرم‌های دموکراتیک (ارزش)"},

    

    # NEW: Gantt

    {"type": "gantt", "title": "نقشه‌ی ۱۰۰ روز نخست", "sub": "زمان‌بندی تقنینی اقدامات حیاتی آغازین"},



    {"type": "icon-text", "icon": "fa-calendar-check text-yellow-400", "title": "صد روزِ سرنوشت‌ساز", "text": "فرامین ۱۰۰ روز نخست، تعیین‌کننده است؛ روزهایی که بنیان‌های استبداد ۴۵ ساله با دستورات اضطراری الغا و درهم‌شکسته می‌شوند."},

    {"type": "cards", "title": "فرامین آزادی (هفته اول)", "cards": [{"icon": "fa-dove text-cyan-400", "title": "زندانیان", "text": "آزادی فوری و بی‌قید تمامی زندانیان سیاسی، عقیدتی و مدنی."}, {"icon": "fa-ban text-rose-400", "title": "حجاب اختیاری", "text": "لغو کامل حجاب اجباری و گشت‌های کنترل پوشش."}]},

    {"type": "cards", "title": "فرامین حقوق جانی", "cards": [{"icon": "fa-hand-paper text-rose-400", "title": "لغو اعدام", "text": "تعلیق کامل هرگونه مجازات غیرانسانی و اعدام در سراسر کشور."}, {"icon": "fa-person-walking-arrow-loop-left text-emerald-400", "title": "حق بازگشت", "text": "پایان دادن به کابوس تبعید سیاسی و صدور حق بازگشت."}]},

    {"type": "cards", "title": "فرامین شفافیت", "cards": [{"icon": "fa-wifi text-cyan-400", "title": "پایان فیلترینگ", "text": "رفع کلیه محدودیت‌های اینترنت و دسترسی آزاد جهانی."}, {"icon": "fa-lock text-yellow-400", "title": "حفاظت اسناد", "text": "دستور فوری برای محاصره و مراقبت از پرونده‌های امنیتی جهت دادخواهی قضایی."}]},

    {"type": "cards", "title": "اولویت‌های هفته‌های نخستین", "cards": [{"icon": "fa-newspaper text-emerald-400", "title": "آزادی تشکل", "text": "توسعه احزاب، سندیکاها و رسانه‌ها بدون اخذ مجوزهای حکومتی."}, {"icon": "fa-mars-stroke text-fuchsia-400", "title": "حقوق زنان", "text": "لغو کامل تمامی قوانین تبعیض‌آمیز سیستماتیک علیه زنان در طلاق، خروج و حضانت."}]},

    {"type": "cards", "title": "زیربناهای توسعه", "cards": [{"icon": "fa-language text-cyan-400", "title": "زبان مادری", "text": "آزادی آموزش و تضمین حقوق تنوع اقوامی."}, {"icon": "fa-building-columns text-yellow-400", "title": "اقتصاد", "text": "استقلال بانک مرکزی و حسابرسی سریع بنیادهای فرادولتی از جمله سپاه و آستان‌ها."}]},

    

    # UPGRADED FLOWCHART!

    {"type": "flowchart", "title": "فرایند تقنینی؛ علم و دموکراسی", "sub": "یک قانون در مهستان چگونه تصویب می‌شود؟"},



    {"type": "icon-text", "icon": "fa-check-to-slot text-emerald-400", "title": "رفراندوم، خط قرمز نهایی", "text": "تعیین نوع حکومت، قراردادهای حیاتی ملی و قانون اساسی، فقط و فقط با رأی مستقیم مردم در رفراندوم آزاد و شفاف اعمال می‌شود."},

    {"type": "icon-text", "icon": "fa-user-times text-rose-400", "title": "حق عزل نماینده بدعهد!", "text": "اگر ۴۰ درصد از شهروندانِ رأی‌دهنده‌ی یک حوزه از نماینده ناراضی باشند، او بدون معطلی عزل شده و نفر بعدی لیست جایگزین می‌گردد."},

    {"type": "icon-text", "icon": "fa-hourglass-end text-yellow-400", "title": "پایان مأموریت مهستان", "text": "مجلس مهستان موقتی است! این مجلس حداکثر پس از ۲ سال منحل شده و امور کشور را به نهادهای تثبیت شده قانون اساسی نهایی می‌سپارد."},

    {"type": "title", "title": "آینده در دستان ماست", "sub": "با انتشار این طرح، مسیر گذار را بسازید", "hl": "تعهد جامعه‌ی آگاه امروز، ضامن آزادی فردای ایران است."},

    {"type": "title", "title": "ایرانِ متکثر و متحد", "sub": "پایان استبداد، آغاز سازندگی", "hl": "طرح مجلس مهستان؛ گامی اساسی به سوی طلوعی پرامید."}

]



html_head = '''<!DOCTYPE html>

<html lang="fa" dir="rtl">

<head>

    <meta charset="UTF-8">

    <script src="https://cdn.tailwindcss.com"></script>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <link href="https://fonts.googleapis.com/css2?family=Vazirmatn:wght@400;700;900&display=swap" rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>

    <script>

      tailwind.config = {

        theme: {

          extend: {

            fontFamily: { sans: ['Vazirmatn', 'sans-serif'] }

          }

        }

      }

      mermaid.initialize({ startOnLoad: true, theme: 'dark', fontFamily: 'Vazirmatn' });

    </script>

    <style>

        body { margin: 0; background: #09090b; color: #f8fafc; overflow-x: hidden; font-family: 'Vazirmatn', sans-serif;}

        .slide { 

            width: 1080px; height: 1350px; 

            position: relative; overflow: hidden; 

            background: linear-gradient(to bottom right, #020617, #0f172a, #1e1b4b);

            display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center;

            padding: 4rem; box-sizing: border-box;

        }

        @media print {

            .slide { page-break-after: always; height: 1350px; width: 1080px; margin: 0; padding: 4rem; -webkit-print-color-adjust: exact; }

            @page { size: 10.8in 13.5in; margin: 0; }

            body { -webkit-print-color-adjust: exact; }

        }

        .bg-blob-1 { position: absolute; top: -10%; left: -10%; width: 600px; height: 600px; background-color: rgba(6, 182, 212, 0.3); border-radius: 50%; filter: blur(120px); mix-blend-mode: screen; }

        .bg-blob-2 { position: absolute; bottom: -10%; right: -10%; width: 700px; height: 700px; background-color: rgba(79, 70, 229, 0.3); border-radius: 50%; filter: blur(150px); mix-blend-mode: screen; }

        .bg-grid { position: absolute; inset: 0; background-image: radial-gradient(rgba(255,255,255,0.1) 2px, transparent 2px); background-size: 40px 40px; opacity: 0.5; }

        .glass-card { background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 1.5rem; box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5); }

        .glow-text { text-shadow: 0 0 25px rgba(56, 189, 248, 0.6); }

        /* Custom Chart Connections */

        .chart-connector path { stroke: #cbd5e1; stroke-width: 4px; stroke-dasharray: 8 8; fill: none; opacity: 0.6; }

    </style>

</head>

<body>

'''



html_body = ""

total_slides = len(slides)

for i, sl in enumerate(slides):

    slide_num = i + 1

    html_body += f'<!-- Slide {slide_num} -->\n<div class="slide" id="slide-{slide_num}">\n'

    html_body += '<div class="bg-blob-1"></div><div class="bg-blob-2"></div><div class="bg-grid"></div>\n'

    html_body += '<div class="relative z-10 w-full h-full flex flex-col items-center justify-center">\n'

    

    # Display indicator at top absolute (moved completely away from main box)

    html_body += f'<div class="absolute top-[0rem] right-0 text-slate-500 font-bold text-2xl z-50 bg-slate-900/50 px-6 py-2 rounded-full border border-slate-700">طرح مهستان • اسلاید {slide_num} از {total_slides}</div>\n'

    

    if sl["type"] == "title":

        html_body += f'''

            <h2 class="text-yellow-400 text-5xl font-bold mb-8 tracking-widest">{sl["sub"]}</h2>

            <h1 class="text-[6.5rem] font-black text-transparent bg-clip-text bg-gradient-to-r from-cyan-300 to-indigo-300 mb-12 drop-shadow-xl leading-tight glow-text text-center px-4" style="line-height:1.3;">{sl["title"]}</h1>

            <div class="glass-card p-12 mt-8 w-11/12 max-w-4xl text-center border-b-4 border-b-emerald-400">

                <p class="text-[2.6rem] text-slate-200 font-bold leading-relaxed">{sl["hl"]}</p>

            </div>

        '''

    elif sl["type"] == "icon-text":

        html_body += f'''

            <i class="fa-solid {sl["icon"]} text-[10rem] mb-14 drop-shadow-[0_0_30px_rgba(255,255,255,0.3)]"></i>

            <h2 class="text-7xl font-black text-white mb-16">{sl["title"]}</h2>

            <div class="glass-card p-16 w-full max-w-4xl text-right">

                <p class="text-4xl text-slate-200 leading-[2.4]">{sl["text"]}</p>

            </div>

        '''

    elif sl["type"] == "cards":

        html_body += f'''

            <h2 class="text-[4rem] font-black text-white mb-20">{sl["title"]}</h2>

            <div class="flex flex-col gap-10 w-full max-w-4xl">

        '''

        for c in sl["cards"]:

            html_body += f'''

                <div class="glass-card p-12 flex items-center gap-12 text-right">

                    <div class="flex-shrink-0"><i class="fa-solid {c["icon"]} text-[5.5rem]"></i></div>

                    <div>

                        <h3 class="text-[2.6rem] font-bold text-white mb-6">{c["title"]}</h3>

                        <p class="text-4xl text-slate-300 leading-relaxed">{c["text"]}</p>

                    </div>

                </div>

            '''

        html_body += '</div>'

    elif sl["type"] == "split":

        html_body += f'''

            <h2 class="text-[4rem] font-black text-white mb-16 px-4">{sl["title"]}</h2>

            <div class="flex flex-row gap-8 w-full max-w-5xl h-[600px]">

                <div class="glass-card w-1/2 p-12 text-center border-b-8 border-b-rose-400 flex flex-col items-center justify-center relative overflow-hidden">

                    <div class="absolute inset-0 bg-rose-500/10 mix-blend-overlay"></div>

                    <i class="fa-solid fa-chart-pie text-rose-400 text-[6rem] mb-10 z-10"></i>

                    <p class="text-3xl text-slate-200 leading-[2.4] whitespace-pre-line z-10">{sl["left"]}</p>

                </div>

                <div class="flex items-center text-5xl text-slate-400"><i class="fa-solid fa-plus"></i></div>

                <div class="glass-card w-1/2 p-12 text-center border-b-8 border-b-cyan-400 flex flex-col items-center justify-center relative overflow-hidden">

                    <div class="absolute inset-0 bg-cyan-500/10 mix-blend-overlay"></div>

                    <i class="fa-solid fa-users-viewfinder text-cyan-400 text-[6rem] mb-10 z-10"></i>

                    <p class="text-3xl text-slate-200 leading-[2.4] whitespace-pre-line z-10">{sl["right"]}</p>

                </div>

            </div>

            <div class="mt-16 text-3xl text-yellow-400 font-bold bg-slate-900/80 px-10 py-4 rounded-3xl border border-yellow-400/30 shadow-[0_0_30px_rgba(250,204,21,0.2)]">این تلفیق، رمز عبور از بحران‌های گذار است</div>

        '''

    elif sl["type"] == "stats":

        html_body += f'''

            <h2 class="text-[4.5rem] font-black text-white mb-24">{sl["title"]}</h2>

            <div class="flex flex-wrap gap-12 justify-center w-full max-w-[95%]">

        '''

        for s in sl["stats"]:

            html_body += f'''

                <div class="glass-card p-12 flex flex-col items-center justify-center min-w-[300px] flex-1 border-t-8 border-t-yellow-400 hover:scale-105 transition-transform duration-500">

                    <div class="text-[8rem] font-black text-yellow-400 mb-8 drop-shadow-[0_0_25px_rgba(250,204,21,0.7)] leading-none text-center min-h-[140px] flex items-center justify-center">{s["val"]}</div>

                    <div class="text-4xl font-bold text-slate-200 text-center leading-[1.8] min-h-[100px]">{s["label"]}</div>

                </div>

            '''

        html_body += '</div>'

    elif sl["type"] == "principles":

        html_body += f'''

            <h2 class="text-[4rem] font-black text-white mb-6 uppercase tracking-wider">{sl["title"]}</h2>

            <h3 class="text-3xl text-cyan-400 font-bold mb-12">{sl["sub"]}</h3>

            

            <div class="grid grid-cols-2 gap-8 w-full max-w-[920px]">

                <div class="glass-card p-8 border-r-8 border-emerald-400 text-right h-full flex flex-col justify-center">

                    <div class="flex items-center gap-4 mb-4">

                        <span class="bg-emerald-400 text-slate-900 font-bold text-3xl w-14 h-14 flex items-center justify-center rounded-2xl shadow-lg shrink-0">۱</span>

                        <h4 class="text-3xl font-black text-white line-clamp-1">دموکراسی و علم</h4>

                    </div>

                    <p class="text-2xl text-slate-300 leading-relaxed pr-[72px]">تفکیک بُعد کارشناسی از اراده ملی، سپس ترکیب آن‌ها در صحن علنی مجلس.</p>

                </div>

                

                <div class="glass-card p-8 border-r-8 border-fuchsia-400 text-right h-full flex flex-col justify-center">

                    <div class="flex items-center gap-4 mb-4">

                        <span class="bg-fuchsia-400 text-slate-900 font-bold text-3xl w-14 h-14 flex items-center justify-center rounded-2xl shadow-lg shrink-0">۲</span>

                        <h4 class="text-3xl font-black text-white line-clamp-1">نمایندگی نسبتی</h4>

                    </div>

                    <p class="text-2xl text-slate-300 leading-relaxed pr-[72px]">آرایش مجلس آینه‌ی تمام‌نمای ملت؛ هیچ اقلیت و جریانی مسکوت نمی‌ماند.</p>

                </div>



                <div class="glass-card p-8 border-r-8 border-amber-400 text-right h-full flex flex-col justify-center">

                    <div class="flex items-center gap-4 mb-4">

                        <span class="bg-amber-400 text-slate-900 font-bold text-3xl w-14 h-14 flex items-center justify-center rounded-2xl shadow-lg shrink-0">۳</span>

                        <h4 class="text-3xl font-black text-white line-clamp-1">دو مرحله قانون‌گرایی</h4>

                    </div>

                    <p class="text-2xl text-slate-300 leading-relaxed pr-[72px]">جلوگیری از خلأ قوانین از طریق تصویب فوری یک قانون اساسی موقت.</p>

                </div>



                <div class="glass-card p-8 border-r-8 border-rose-400 text-right h-full flex flex-col justify-center">

                    <div class="flex items-center gap-4 mb-4">

                        <span class="bg-rose-400 text-slate-900 font-bold text-3xl w-14 h-14 flex items-center justify-center rounded-2xl shadow-lg shrink-0">۴</span>

                        <h4 class="text-3xl font-black text-white line-clamp-1">اصلاح نه تخریب</h4>

                    </div>

                    <p class="text-2xl text-slate-300 leading-relaxed pr-[72px]">محافظت از ساختارهای خدمت‌رسان اداری و برکناری نقطه‌ای جنایتکاران سطح بالا.</p>

                </div>



                <div class="glass-card p-8 border-r-8 border-cyan-400 text-right h-full flex flex-col justify-center">

                    <div class="flex items-center gap-4 mb-4">

                        <span class="bg-cyan-400 text-slate-900 font-bold text-3xl w-14 h-14 flex items-center justify-center rounded-2xl shadow-lg shrink-0">۵</span>

                        <h4 class="text-3xl font-black text-white line-clamp-1">حداکثر شفافیت</h4>

                    </div>

                    <p class="text-2xl text-slate-300 leading-relaxed pr-[72px]">الزام تمامی نمایندگان و مقامات اجرایی به افشای دارایی و درآمد.</p>

                </div>



                <div class="glass-card p-8 border-r-8 border-blue-400 text-right h-full flex flex-col justify-center">

                    <div class="flex items-center gap-4 mb-4">

                        <span class="bg-blue-400 text-slate-900 font-bold text-3xl w-14 h-14 flex items-center justify-center rounded-2xl shadow-lg shrink-0">۶</span>

                        <h4 class="text-3xl font-black text-white line-clamp-1">حقوق بشر بنیادین</h4>

                    </div>

                    <p class="text-2xl text-slate-300 leading-relaxed pr-[72px]">برابری قطعی جنسیتی و حقوق اقلیت‌ها خط قرمز غیرقابل نقض برای همه است.</p>

                </div>

            </div>

        '''

    elif sl["type"] == "org-chart":

        html_body += f'''

            <h2 class="text-[4.5rem] font-black text-white mb-4 z-50 text-center">{sl["title"]}</h2>

            <h3 class="text-3xl text-yellow-400 mb-6 z-50 text-center">{sl["sub"]}</h3>

            

            <div class="relative w-[950px] h-[950px] mx-auto z-10">

                <!-- Main Council -->

                <div class="absolute top-2 left-1/2 -translate-x-1/2 glass-card p-8 border-[3px] border-indigo-400 bg-indigo-950/80 shadow-[0_0_50px_rgba(99,102,241,0.5)] z-20 w-[600px] text-center rounded-[2.5rem]">

                    <h3 class="text-5xl font-black text-white mb-2 pb-2 border-b border-indigo-500/50">مجلس مهستان (۳۰۰ نماینده)</h3>

                    <p class="text-2xl text-indigo-200 uppercase tracking-widest pt-2">نهاد عالی و حاکمیتی دوران گذار</p>

                </div>



                <!-- Wings -->

                <div class="absolute top-[210px] right-[60px] glass-card p-5 border-r-[6px] border-cyan-400 bg-slate-900/90 text-right w-[380px] z-20">

                    <h4 class="text-2xl font-black text-cyan-400 mb-2">بازوی دموکراتیک</h4>

                    <p class="text-xl text-slate-300">واحد ارتباط مردمی، نظرسنجی و دریافت اولویت‌ها</p>

                </div>

                

                <div class="absolute top-[210px] left-[60px] glass-card p-5 border-l-[6px] border-amber-400 bg-slate-900/90 text-right w-[380px] z-20">

                    <h4 class="text-2xl font-black text-amber-400 mb-2">بازوی تکنوکراتیک</h4>

                    <p class="text-xl text-slate-300">مرکز تحقیقات استراتژیک و بررسی فنی تخصصی پیامدها</p>

                </div>



                <!-- Executive Level -->

                <div class="absolute top-[400px] left-1/2 -translate-x-1/2 flex justify-between w-full z-20">

                    <div class="glass-card p-6 bg-slate-800/95 border-t-[6px] border-emerald-400 text-center w-[300px] -ml-2 rounded-3xl shadow-xl hover:-translate-y-2 transition-transform">

                        <i class="fa-solid fa-scale-unbalanced text-[3.5rem] text-emerald-400 mb-4"></i>

                        <h4 class="text-2xl font-black text-white">شورای قضایی انتقالی</h4>

                        <p class="text-lg text-slate-300 mt-2 border-t border-slate-700 pt-2">تصفیه قضات فاسد، تعلیق قوانین ظالمانه</p>

                    </div>

                    

                    <div class="glass-card p-6 bg-slate-800/95 border-t-[6px] border-blue-400 text-center w-[330px] rounded-3xl shadow-xl hover:-translate-y-2 transition-transform relative top-4">

                        <i class="fa-solid fa-briefcase text-[3.5rem] text-blue-400 mb-4"></i>

                        <h4 class="text-3xl font-black text-white">کابینه اجرایی موقت</h4>

                        <p class="text-lg text-slate-300 mt-2 border-t border-slate-700 pt-2">وزارتخانه‌ها، بهداشت و خدمات اداری روزمره</p>

                    </div>

                    

                    <div class="glass-card p-6 bg-slate-800/95 border-t-[6px] border-rose-400 text-center w-[300px] -mr-2 rounded-3xl shadow-xl hover:-translate-y-2 transition-transform">

                        <i class="fa-solid fa-shield-halved text-[3.5rem] text-rose-400 mb-4"></i>

                        <h4 class="text-2xl font-black text-white">فرماندهی نظامی</h4>

                        <p class="text-lg text-slate-300 mt-2 border-t border-slate-700 pt-2">تامین امنیت، کنترل مرزها و ارتش واحد ملی</p>

                    </div>

                </div>



                <!-- Bottom Subordinate Commissions -->

                <div class="absolute bottom-4 left-1/2 -translate-x-1/2 w-full glass-card p-8 border-[2px] border-slate-700 bg-slate-900/60 z-20 rounded-[2.5rem]">

                    <h4 class="text-center font-black text-yellow-400 text-3xl mb-8 tracking-wide">نهادهای کمیسیونی مهم</h4>

                    <div class="grid grid-cols-3 gap-6 text-center">

                        <div class="py-4 px-2 bg-slate-800/80 rounded-2xl border border-slate-700 hover:bg-slate-700 transition"><span class="block text-xl font-bold text-slate-100">عدالت انتقالی</span></div>

                        <div class="py-4 px-2 bg-slate-800/80 rounded-2xl border border-slate-700 hover:bg-slate-700 transition"><span class="block text-xl font-bold text-slate-100">اصلاح بخش امنیتی</span></div>

                        <div class="py-4 px-2 bg-slate-800/80 rounded-2xl border border-slate-700 hover:bg-slate-700 transition"><span class="block text-xl font-bold text-slate-100">هیأت ناظر انتخابات</span></div>

                        <div class="py-4 px-2 bg-slate-800/80 rounded-2xl border border-slate-700 hover:bg-slate-700 transition"><span class="block text-xl font-bold text-slate-100">رسانه مستقل ملی</span></div>

                        <div class="py-4 px-2 bg-slate-800/80 rounded-2xl border border-slate-700 hover:bg-slate-700 transition"><span class="block text-xl font-bold text-slate-100">شورای اقتصادی موقت</span></div>

                        <div class="py-4 px-2 bg-slate-800/80 rounded-2xl border border-slate-700 hover:bg-slate-700 transition"><span class="block text-xl font-bold text-slate-100">آمبودزمان شهروندی</span></div>

                    </div>

                </div>



                <!-- Connectors SVG -->

                <!-- width is 950, center X is 475 -->

                <svg class="absolute inset-0 w-[950px] h-[950px] z-0 chart-connector" xmlns="http://www.w3.org/2000/svg">

                    <path d="M 475 160 L 475 420" />

                    <!-- wings -->

                    <path d="M 475 180 L 250 180 L 250 210" />

                    <path d="M 475 180 L 700 180 L 700 210" />

                    <!-- exe branches -->

                    <path d="M 475 320 L 150 320 L 150 400" />

                    <path d="M 475 320 L 800 320 L 800 400" />

                    <!-- bottom link -->

                    <path d="M 475 620 L 475 670" />

                </svg>

            </div>

        '''

    elif sl["type"] == "gantt":

        html_body += f'''

            <h2 class="text-[4.5rem] font-black text-white mb-2 z-50">{sl["title"]}</h2>

            <h3 class="text-3xl text-yellow-400 tracking-wider mb-12 z-50">{sl["sub"]}</h3>



            <div class="relative w-full max-w-4xl rtl">

                <!-- Vertical Track -->

                <div class="absolute left-[30px] top-6 bottom-6 w-5 bg-slate-800 rounded-full shadow-inner border border-slate-700"></div>

                <!-- Segments (Simulated) -->

                <div class="absolute left-[30px] top-6 h-[22%] w-5 bg-rose-500 rounded-t-full shadow-[0_0_20px_#f43f5e]"></div>

                <div class="absolute left-[30px] top-[25%] h-[22%] w-5 bg-amber-500 shadow-[0_0_20px_#f59e0b]"></div>

                <div class="absolute left-[30px] top-[50%] h-[22%] w-5 bg-blue-500 shadow-[0_0_20px_#3b82f6]"></div>

                <div class="absolute left-[30px] top-[75%] h-[22%] w-5 bg-emerald-500 rounded-b-full shadow-[0_0_20px_#10b981]"></div>



                <div class="flex flex-col gap-[3rem] text-right">

                    <!-- Milestone 1 -->

                    <div class="relative pl-[100px] flex">

                        <div class="absolute w-8 h-8 rounded-full bg-rose-400 border-[6px] border-slate-900 z-10 shadow-[0_0_15px_#f43f5e]" style="left: 23px; top: 2rem;"></div>

                        <div class="glass-card p-10 border-r-8 border-rose-400 w-full ml-auto relative group">

                            <div class="flex justify-between items-center mb-6 border-b border-rose-500/20 pb-4">

                                <h3 class="text-4xl font-black text-white">هفته اول: فرامین اضطراری</h3>

                                <span class="bg-rose-500/20 text-rose-300 border border-rose-500/40 px-5 py-2 rounded-xl text-xl font-bold">بدون درنگ</span>

                            </div>

                            <p class="text-[1.8rem] text-slate-300 leading-relaxed font-light">آزادی بی‌قید زندانیان سیاسی و عقیدتی، تعلیق و لغو حجاب اجباری، پایان ۱۰۰٪ فیلترینگ اینترنت و تعلیق سراسری مجازات اعدام.</p>

                        </div>

                    </div>



                    <!-- Milestone 2 -->

                    <div class="relative pl-[100px] flex">

                        <div class="absolute w-8 h-8 rounded-full bg-amber-400 border-[6px] border-slate-900 z-10 shadow-[0_0_15px_#f59e0b]" style="left: 23px; top: 2rem;"></div>

                        <div class="glass-card p-10 border-r-8 border-amber-400 w-full ml-auto relative">

                            <div class="flex justify-between items-center mb-6 border-b border-amber-500/20 pb-4">

                                <h3 class="text-4xl font-black text-white">هفته ۱ تا ۴: مصوبات فوری</h3>

                                <span class="bg-amber-500/20 text-amber-300 border border-amber-500/40 px-5 py-2 rounded-xl text-xl font-bold">اولویت بالا</span>

                            </div>

                            <p class="text-[1.8rem] text-slate-300 leading-relaxed font-light">قانون آزادی انتشار مطبوعات، توسعه بی‌مجوز احزاب، لغو کلیه قوانین تبعیض‌آمیز سیستماتیک خانواده، و مسدودسازی دارایی‌های مشکوک.</p>

                        </div>

                    </div>



                    <!-- Milestone 3 -->

                    <div class="relative pl-[100px] flex">

                        <div class="absolute w-8 h-8 rounded-full bg-blue-400 border-[6px] border-slate-900 z-10 shadow-[0_0_15px_#3b82f6]" style="left: 23px; top: 2rem;"></div>

                        <div class="glass-card p-10 border-r-8 border-blue-400 w-full ml-auto relative">

                            <div class="flex justify-between items-center mb-6 border-b border-blue-500/20 pb-4">

                                <h3 class="text-4xl font-black text-white">هفته ۴ تا ۸: زیرساخت قانونی</h3>

                                <span class="bg-blue-500/20 text-blue-300 border border-blue-500/40 px-5 py-2 rounded-xl text-xl font-bold">اولویت متوسط</span>

                            </div>

                            <p class="text-[1.8rem] text-slate-300 leading-relaxed font-light">تهیه و تصویب قانون اساسی موقت (فراهم بودن بستر رفراندوم)، تشکیل کمیسیون جامع حقیقت‌یابی عدالت انتقالی و استقلال کامل بانک مرکزی.</p>

                        </div>

                    </div>



                    <!-- Milestone 4 -->

                    <div class="relative pl-[100px] flex">

                        <div class="absolute w-8 h-8 rounded-full bg-emerald-400 border-[6px] border-slate-900 z-10 shadow-[0_0_15px_#10b981]" style="left: 23px; top: 2rem;"></div>

                        <div class="glass-card p-10 border-r-8 border-emerald-400 w-full ml-auto relative">

                            <div class="flex justify-between items-center mb-6 border-b border-emerald-500/20 pb-4">

                                <h3 class="text-4xl font-black text-white">هفته ۸ تا ۱۴: تثبیت جامعه</h3>

                                <span class="bg-emerald-500/20 text-emerald-300 border border-emerald-500/40 px-5 py-2 rounded-xl text-xl font-bold">اولویت نرمال</span>

                            </div>

                            <p class="text-[1.8rem] text-slate-300 leading-relaxed font-light">اصلاح ساختار نظام آموزشی (حذف محتوای ایدئولوژیک آموزش و پرورش)، اقدامات اضطراری محیط زیست و زمینه‌سازی مجلس مؤسسان نهایی.</p>

                        </div>

                    </div>

                </div>

            </div>

        '''

    elif sl["type"] == "tj-chart":

        html_body += f'''

            <h2 class="text-[4.5rem] font-black text-white mt-10 mb-4 z-50 text-center">{sl["title"]}</h2>

            <h3 class="text-3xl text-yellow-400 mb-10 z-50 text-center">{sl["sub"]}</h3>

            

            <div class="relative w-[950px] h-[850px] flex items-center justify-center -mt-6">

                <!-- MAIN BOX -->

                <div class="absolute z-20 glass-card p-8 bg-indigo-950 border-[4px] border-indigo-400 rounded-full flex flex-col items-center justify-center w-[250px] h-[250px] text-center shadow-[0_0_80px_rgba(99,102,241,0.7)]">

                    <i class="fa-solid fa-scale-balanced text-[5rem] text-white mb-4 drop-shadow-md"></i>

                    <h3 class="text-3xl font-black text-white">عدالت انتقالی</h3>

                </div>

                

                <!-- 1 -->

                <div class="absolute z-10 top-[20px] left-[20px] glass-card p-8 bg-slate-900/95 border-l-[6px] border-emerald-400 w-[420px] text-right rounded-3xl hover:bg-slate-800 transition">

                    <div class="flex items-center gap-4 border-b border-emerald-400/30 pb-3 mb-4">

                        <span class="w-12 h-12 bg-emerald-400 flex items-center justify-center rounded-xl text-3xl font-black text-slate-900">۱</span>

                        <h4 class="text-3xl font-bold text-emerald-400">حقیقت‌یابی</h4>

                    </div>

                    <p class="text-[1.6rem] text-slate-300 leading-relaxed">توصیف جامع و مستندسازی جنایات، ثبت شهادت قربانیان بدون هیچ‌گونه سانسور.</p>

                </div>



                <!-- 2 -->

                <div class="absolute z-10 top-[20px] right-[20px] glass-card p-8 bg-slate-900/95 border-r-[6px] border-rose-400 w-[420px] text-right rounded-3xl hover:bg-slate-800 transition">

                    <div class="flex items-center gap-4 border-b border-rose-400/30 pb-3 mb-4">

                        <span class="w-12 h-12 bg-rose-400 flex items-center justify-center rounded-xl text-3xl font-black text-slate-900">۲</span>

                        <h4 class="text-3xl font-bold text-rose-400">عدالت کیفری</h4>

                    </div>

                    <p class="text-[1.6rem] text-slate-300 leading-relaxed">محاکمات بین‌المللی کاملا عادلانه، دادرسی شفاف و تفکیک کردن دقیق سطوح مسئولیت.</p>

                </div>



                <!-- 3 -->

                <div class="absolute z-10 bottom-[180px] left-[20px] glass-card p-8 bg-slate-900/95 border-l-[6px] border-amber-400 w-[420px] text-right rounded-3xl hover:bg-slate-800 transition">

                    <div class="flex items-center gap-4 border-b border-amber-400/30 pb-3 mb-4">

                        <span class="w-12 h-12 bg-amber-400 flex items-center justify-center rounded-xl text-3xl font-black text-slate-900">۳</span>

                        <h4 class="text-3xl font-bold text-amber-400">جبران خسارت</h4>

                    </div>

                    <p class="text-[1.6rem] text-slate-300 leading-relaxed">تعهد ملی به پرداخت غرامت‌های قطعی، اعاده حیثیت و احیای خدمات حمایتی قربانیان.</p>

                </div>



                <!-- 4 -->

                <div class="absolute z-10 bottom-[180px] right-[20px] glass-card p-8 bg-slate-900/95 border-r-[6px] border-fuchsia-400 w-[420px] text-right rounded-3xl hover:bg-slate-800 transition">

                    <div class="flex items-center gap-4 border-b border-fuchsia-400/30 pb-3 mb-4">

                        <span class="w-12 h-12 bg-fuchsia-400 flex items-center justify-center rounded-xl text-3xl font-black text-slate-900">۴</span>

                        <h4 class="text-3xl font-bold text-fuchsia-400">آشتی ملی</h4>

                    </div>

                    <p class="text-[1.6rem] text-slate-300 leading-relaxed">بسترسازی گفتگوهای اجتماعی فراگیر، رفع کینه‌ها، احداث موزه‌ها و اصلاح تاریخ‌نگاری.</p>

                </div>



                <!-- 5 -->

                <div class="absolute z-10 bottom-[-40px] glass-card p-8 bg-slate-900/95 border-[6px] border-cyan-400 w-[600px] text-center rounded-[2rem] hover:bg-slate-800 transition">

                    <div class="flex items-center justify-center gap-4 border-b border-cyan-400/30 pb-3 mb-4">

                        <span class="w-12 h-12 bg-cyan-400 flex items-center justify-center rounded-xl text-3xl font-black text-slate-900">۵</span>

                        <h4 class="text-3xl font-bold text-cyan-400">تضمین عدم تکرار</h4>

                    </div>

                    <p class="text-[1.6rem] text-slate-300 leading-relaxed">استحکام پایدار، تصفیه امنیتی ادارات، اصلاح ساختاری و قانون اساسی مدرن و نوین.</p>

                </div>



                <!-- Connecting Lines SVG -->

                <!-- Center 475, 425 -->

                <svg class="absolute inset-0 w-[950px] h-[850px] z-0 chart-connector" xmlns="http://www.w3.org/2000/svg">

                    <path d="M 475 425 L 230 150" />

                    <path d="M 475 425 L 720 150" />

                    <path d="M 475 425 L 230 600" />

                    <path d="M 475 425 L 720 600" />

                    <path d="M 475 425 L 475 720" />

                </svg>

            </div>

        '''

    elif sl["type"] == "flowchart":

        html_body += f'''

            <h2 class="text-[4.5rem] font-black text-white mt-8 mb-4 z-50 text-center">{sl["title"]}</h2>

            <h3 class="text-3xl text-yellow-400 mb-8 z-50 text-center">{sl["sub"]}</h3>



            <div class="relative w-[950px] h-[950px] mx-auto z-10">

                <!-- 1 -->

                <div class="absolute top-2 left-1/2 -translate-x-1/2 glass-card p-6 bg-slate-900/90 border-t-[6px] border-indigo-500 text-center w-[600px] z-20 rounded-[2rem]">

                    <h4 class="text-4xl font-black text-white mb-2">۱. معرفی طرح یا لایحه</h4>

                    <p class="text-[1.6rem] text-slate-300">ارائه از سوی نمایندگان مجلس، وزرا، یا طومارهای معتبر</p>

                </div>

                

                <!-- L W -->

                <div class="absolute top-[210px] left-[20px] glass-card p-8 bg-slate-900/90 border-l-[6px] border-amber-400 text-right w-[420px] z-20 rounded-3xl">

                    <h4 class="text-3xl font-bold text-amber-400 mb-4 border-b border-amber-400/20 pb-3 flex items-center justify-between">گزارش تکنوکرات <i class="fa-solid fa-microscope"></i></h4>

                    <p class="text-2xl text-slate-300 leading-relaxed">تیم تخصصی، پیامدهای قانونی، اقتصادی و آماری را استخراج می‌کند. (کشف حقایق قطعی)</p>

                </div>



                <!-- R W -->

                <div class="absolute top-[210px] right-[20px] glass-card p-8 bg-slate-900/90 border-r-[6px] border-cyan-400 text-right w-[420px] z-20 rounded-3xl">

                    <h4 class="text-3xl font-bold text-cyan-400 mb-4 border-b border-cyan-400/20 pb-3 flex items-center justify-between">گزارش دموکراتیک <i class="fa-solid fa-people-group"></i></h4>

                    <p class="text-2xl text-slate-300 leading-relaxed">ثبت نظرسنجی و ارزیابی عمیق خواست مردم توسط پلتفرم‌های تعاملی. (کشف مراد ملت)</p>

                </div>



                <!-- Middle Merge -->

                <div class="absolute top-[480px] left-1/2 -translate-x-1/2 glass-card p-8 bg-indigo-950/90 border-2 border-indigo-400 text-center w-[550px] z-20 shadow-[0_0_50px_rgba(99,102,241,0.5)] rounded-[2rem]">

                    <h4 class="text-[2.6rem] font-black text-white mb-3">کمیسیون تخصصی مشترک</h4>

                    <p class="text-[1.6rem] text-indigo-200">تبادل و بررسی همزمان حقیقت محض علمی + اراده و حقوق شهروندی</p>

                </div>



                <!-- Bottom vote -->

                <div class="absolute bottom-[30px] left-1/2 -translate-x-1/2 glass-card p-8 bg-emerald-950/90 border-b-[8px] border-emerald-500 text-center w-[750px] z-20 rounded-[2.5rem] shadow-[0_0_50px_rgba(16,185,129,0.3)]">

                    <h4 class="text-[3rem] font-black text-white mb-5">رأی‌گیری در صحن جامع مهستان</h4>

                    <p class="text-[1.6rem] text-emerald-100 flex items-center justify-center gap-6 font-bold">

                        <span class="bg-emerald-800/80 px-4 py-2 rounded-xl">قانون عادی: ۵۰٪+۱</span>

                        <span class="bg-emerald-800/80 px-4 py-2 rounded-xl">قانون خاص: دو سوم مجلس</span>

                        <span class="bg-rose-800/50 text-rose-200 border border-rose-500/30 px-4 py-2 rounded-xl">نهایی: رفراندوم ملی</span>

                    </p>

                </div>



                <!-- Connections -->

                <!-- Center 475 -->

                <svg class="absolute inset-0 w-[950px] h-[950px] z-0 chart-connector" xmlns="http://www.w3.org/2000/svg">

                    <path d="M 475 140 L 475 180" stroke-width="6"/>

                    <path d="M 475 180 L 230 180 L 230 210" />

                    <path d="M 475 180 L 720 180 L 720 210" />

                    <path d="M 230 380 L 230 430 L 475 430 L 475 480" />

                    <path d="M 720 380 L 720 430 L 475 430 L 475 480" />

                    <path d="M 475 620 L 475 750" stroke-width="6"/>

                </svg>

            </div>

        '''

        

    html_body += '</div></div>\n'



html_foot = '''

</body>

</html>

'''



with open(HTML_FILE, "w", encoding="utf-8") as f:

    f.write(html_head + html_body + html_foot)



print("Expanded HTML layout with new slides successfully created.")



def export_assets():

    with sync_playwright() as p:

        browser = p.chromium.launch(headless=True)

        page = browser.new_page(viewport={"width": 1080, "height": 1350}, device_scale_factor=2)

        

        file_url = f"file:///{os.path.abspath(HTML_FILE).replace(chr(92), '/')}"

        page.goto(file_url, wait_until="networkidle")

        

        # Adding a bit of timeout for all fonts/css variables to load

        page.wait_for_timeout(3000)

        

        total = len(slides)

        for i in range(total):

            slide_no = i + 1

            png_path = os.path.join(PNG_DIR, f"slide_{slide_no:02d}.png")

            page.evaluate("document.body.style.overflow = 'hidden'")

            page.evaluate(f"window.scrollTo(0, {i * 1350})")

            page.screenshot(path=png_path)

            print(f"Saved PNG {slide_no}/{total}")

        

        # Print to PDF using Playwright

        page.pdf(

            path=PDF_FILE, 

            width="10.8in", 

            height="13.5in", 

            print_background=True,

            page_ranges=f"1-{total}"

        )

        print("Saved High-Res Vector PDF with all custom layouts/charts.")



        browser.close()



export_assets()

print("All extra large charts and new slides rendered successfully!")
