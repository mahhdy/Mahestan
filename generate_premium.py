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
    {"type": "vs-cards", "title": "طرح مجلس مهستان", "sub": "بیانیه‌ی چارچوب نهادی گذار ایران", "hl": "طراحی هوشمندانه برای عبور ایمن از استبداد", 
     "vs": [
         {"no": "نه به فرد‌محوری", "yes": "آری به نظم و قانون‌محوری"},
         {"no": "نه به ایده‌محوری", "yes": "آری به رای و اراده‌محوری"},
         {"no": "نه به قوم و قبیله‌محوری", "yes": "آری به حقوق بشر و ملی‌دوستی"},
         {"no": "نه به عقیده و گذشته‌محوری", "yes": "آری به هم‌سرنوشت‌محوری"}
     ]},
    {"type": "icon-text", "icon": "fa-map-signs text-cyan-400", "title": "ایران در تقاطع تاریخ", "text": "هیجان و عمل‌گرایی سریع باید با خرد جمعی همراه شود. تصمیمات امروز ما، سرنوشت نسل‌های آینده را رقم خواهد زد."},
    {"type": "cards", "title": "درس‌هایی از تجارب جهانی", "cards": [{"icon": "fa-check-circle text-emerald-400", "title": "الگوهای موفق", "text": "آفریقای جنوبی و اسپانیا؛ گذار با نهادسازی دقیق"}, {"icon": "fa-times-circle text-rose-400", "title": "ضدالگوها", "text": "عراق و لیبی؛ انحلال کامل نهادها و سال‌ها هرج‌ومرج"}]},
    {"type": "principles", "title": "۶ اصل راهنمای دوران گذار", "sub": "ستون‌های خیمه‌ی دموکراسی پایدار"},
    {"type": "split", "title": "اصل اول: تخصص در کنار اراده ملی", "left": "بُعد واقعیت\nتکنوکرات‌ها، داده‌ها و حقایق اقتصادی-اجتماعی", "right": "بُعد ارزش\nخواست مردم متبلور در صندوق رأی و رفراندوم"},
    {"type": "icon-text", "icon": "fa-users-viewfinder text-fuchsia-400", "title": "اصل دوم: نمایندگی نسبتی", "text": "در جامعه متکثر ایران، سیستم انتخاباتی لیستی-نسبی تضمین می‌کند ترکیب مجلس آینه‌ای از کل ملت باشد و هیچ صدایی مسکوت نماند."},
    {"type": "icon-text", "icon": "fa-file-signature text-amber-400", "title": "اصل سوم: قانون موقت", "text": "خلأ قانونی مادر جنگ‌های داخلی است! با تصویب دوماهه قانون اساسی موقت، فرصت کافی و آرام برای تبیین قانون نهایی فراهم می‌گردد."},
    {"type": "icon-text", "icon": "fa-building-columns text-slate-300", "title": "اصل چهارم: حفظ ساختارها", "text": "فروپاشی دستگاه‌های زیربنایی فاجعه‌بار است. امور درمانی، اداری و خدماتی با رهبری نوین حفظ شده، تنها بازوهای سرکوب منحل می‌شوند."},
    {"type": "icon-text", "icon": "fa-eye text-cyan-400", "title": "اصل پنجم: پایان تاریک‌خانه‌ها", "text": "تمامی جلسات مجلس علنی، آرا شفاف و مقامات ملزم به افشای دارایی خواهند بود. قدرت بی‌حصار، زاینده‌ی فساد است."},
    {"type": "icon-text", "icon": "fa-scale-balanced text-emerald-400", "title": "اصل ششم: حقوق بشر قطعی", "text": "حقوق بنیادین، برابری حقوقی زن و مرد، و حقوق اقلیت‌ها فوق هر قانونی است؛ حتی مجلس هم توان تعلیق آن‌ها را نخواهد داشت."},
    {"type": "icon-text", "icon": "fa-person-booth text-yellow-400", "title": "انتخابات توزیع‌شده محلی-ملی", "text": "به محض پیروزی، بلافاصله در تمام شهرها انتخابات آزاد ساختاریافته برگزار می‌گردد. هر جریان و حزب مردمی، از امروز باید آماده تشکیل ائتلاف باشد!"},
    {"type": "vs-cards", "title": "مبانی همبستگی ملی", "sub": "چشم‌انداز گذار دموکراتیک", "hl": "گذار از فردیت‌گرایی به قانون‌گرایی جمعی", 
     "vs": [
         {"no": "نه به فرد‌محوری", "yes": "آری به نظم و قانون‌محوری"},
         {"no": "نه به ایده‌محوری", "yes": "آری به رای و اراده‌محوری"},
         {"no": "نه به قوم و قبیله‌محوری", "yes": "آری به حقوق بشر و ملی‌دوستی"},
         {"no": "نه به عقیده و گذشته‌محوری", "yes": "آری به هم‌سرنوشت‌محوری"}
     ]},
    {"type": "org-chart", "title": "ساختار یکپارچه نهادی", "sub": "نمای کلی ارکان خیمه‌ی دوران گذار"},
    {"type": "icon-text", "icon": "fa-landmark-dome text-yellow-400", "title": "نهاد محوری: مجلس مهستان", "text": "یک مجلس مردم‌محور که بلافاصله پس از فروپاشی نظام پیشین، با انتخاباتی همگانی زیر نظر جامعه جهانی تشکیل می‌گردد."},
    {"type": "stats", "title": "ترکیب ۳۰۰ نفره مجلس", "stats": [{"val": "۲۴۰", "label": "کرسی استانی (محلی)"}, {"val": "۴۰", "label": "کرسی فهرست‌های ملی"}, {"val": "۲۰", "label": "سهمیه اقلیت‌ها"}]},
    {"type": "stats", "title": "توسعه‌ی همه‌جانبه‌ی مشارکت", "stats": [{"val": "۳۰٪", "label": "حداقل الزام حضور زنان در تمامی لیست‌ها"}, {"val": "دیاسپورا", "label": "حق کاندیداتوری و رأی برای تمام ایرانیان خارج از کشور"}]},
    {"type": "icon-text", "icon": "fa-globe text-cyan-400", "title": "تبعیدیان، بازوهای توسعه", "text": "میلیون‌ها ایرانی دیاسپورا سرمایه‌ی ایران هستند و حق انتخاب مستقیم و واریز رأی به حوزه‌ی داخلی منتخب خود را خواهند داشت."},
    {"type": "cards", "title": "کابینه اجرایی موقت", "cards": [{"icon": "fa-briefcase text-cyan-400", "title": "مدیریت کارآمد", "text": "کابینه‌ای از وزرای متخصص برای جلوگیری از اقتصاد رو به زوال."}, {"icon": "fa-handshake text-yellow-400", "title": "ائتلاف الزام‌آور", "text": "پایان دادن کامل به تک‌صدایی و بن‌بست‌های سیاسی."}]},
    {"type": "cards", "title": "اولین مأموریت بنیادین", "cards": [{"icon": "fa-gavel text-amber-400", "title": "قانون اساسی موقت در ۶۰ روز!", "text": "مجلس مهستان تنها ۲ ماه فرصت دارد پیش‌نویس قانون موقت را آماده و مستقیما به نظرسنجی و رفراندوم ملی بگذارد."}]},
    {"type": "cards", "title": "تصفیه قضایی", "cards": [{"icon": "fa-scale-unbalanced text-rose-400", "title": "شورای قضایی انتقالی", "text": "قاضیان و حقوق‌دانان شریف، مأمور برکناری فوری عناصر فاسد، تعلیق قوانین ظالمانه و محاکمات عادلانه."}]},
    {"type": "icon-text", "icon": "fa-shield-halved text-emerald-400", "title": "اصلاح بخش امنیتی", "text": "سریعاً نهادهایی نظیر گشت ارشاد، سازمان‌های عقیدتی و بازوهای سرکوب منحل و نیروهای مردمی در یک ارتش واحد ملی ادغام خواهند شد."},
    {"type": "tj-chart", "title": "عدالت انتقالی", "sub": "پنج ستون اساسی برای پایان چرخه‌ی خشونت"},
    {"type": "icon-text", "icon": "fa-tower-broadcast text-fuchsia-400", "title": "آزادی بی‌حصر رسانه", "text": "پایان انحصار! دستگاه عریض صداوسیما به شبکه‌ای مردمی و بی‌طرف بدل گشته و آزادی تأسیس شبکه‌های خصوصی تضمین می‌گردد."},
    {"type": "icon-text", "icon": "fa-chart-line text-emerald-400", "title": "شورای اقتصادی دوران گذار", "text": "اقتصاددانان خوش‌نام ایران و جهان، مشاور کابینه برای مقابله با ابرتورم، مدیریت یارانه‌ها و شفافیت اموال ملی خواهند بود."},
    {"type": "split", "title": "دو بازوی قانون‌گذاری", "left": "مرکز تحقیقات\nتأمین مستندات تخصصی، پیش‌بینی‌های اقتصادی و مدل-سازی‌های علمی (واقعیت)", "right": "ارتباط مردمی\nکشف خواست جامع از طریق نظرسنجی‌های ملی و پلتفرم‌های دموکراتیک (ارزش)"},
    {"type": "gantt-overview", "title": "نقشه‌ی راه ۱۰۰ روز نخست", "sub": "چشم‌انداز زمان‌بندی فازبندی شده (طیف کلی)"},
    {"type": "gantt-tall", "title": "جزئیات ۱۰۰ روز (فاز ۱)", "sub": "اقدامات اضطراری و فوری", "phase": 1},
    {"type": "gantt-tall", "title": "جزئیات ۱۰۰ روز (فاز ۲)", "sub": "تثبیت و نهادسازی", "phase": 2},
    {"type": "icon-text", "icon": "fa-calendar-check text-yellow-400", "title": "صد روزِ سرنوشت‌ساز", "text": "فرامین ۱۰۰ روز نخست، تعیین‌کننده است؛ روزهایی که بنیان‌های استبداد ۴۵ ساله با دستورات اضطراری الغا و درهم‌شکسته می‌شوند."},
    {"type": "cards", "title": "فرامین آزادی (هفته اول)", "cards": [{"icon": "fa-dove text-cyan-400", "title": "زندانیان", "text": "آزادی فوری و بی‌قید تمامی زندانیان سیاسی، عقیدتی و مدنی."}, {"icon": "fa-ban text-rose-400", "title": "حجاب اختیاری", "text": "لغو کامل حجاب اجباری و گشت‌های کنترل پوشش."}]},
    {"type": "cards", "title": "فرامین حقوق جانی", "cards": [{"icon": "fa-hand-paper text-rose-400", "title": "لغو اعدام", "text": "تعلیق کامل هرگونه مجازات غیرانسانی و اعدام در سراسر کشور."}, {"icon": "fa-person-walking-arrow-loop-left text-emerald-400", "title": "حق بازگشت", "text": "پایان دادن به کابوس تبعید سیاسی و صدور حق بازگشت."}]},
    {"type": "cards", "title": "فرامین شفافیت", "cards": [{"icon": "fa-wifi text-cyan-400", "title": "پایان فیلترینگ", "text": "رفع کلیه محدودیت‌های اینترنت و دسترسی آزاد جهانی."}, {"icon": "fa-lock text-yellow-400", "title": "حفاظت اسناد", "text": "دستور فوری برای محاصره و مراقبت از پرونده‌های امنیتی جهت دادخواهی قضایی."}]},
    {"type": "cards", "title": "اولویت‌های هفته‌های نخستین", "cards": [{"icon": "fa-newspaper text-emerald-400", "title": "آزادی تشکل", "text": "توسعه احزاب، سندیکاها و رسانه‌ها بدون اخذ مجوزهای حکومتی."}, {"icon": "fa-mars-stroke text-fuchsia-400", "title": "حقوق زنان", "text": "لغو کامل تمامی قوانین تبعیض‌آمیز سیستماتیک علیه زنان در طلاق، خروج و حضانت."}]},
    {"type": "cards", "title": "زیربناهای توسعه", "cards": [{"icon": "fa-language text-cyan-400", "title": "زبان مادری", "text": "آزادی آموزش و تضمین حقوق تنوع اقوامی."}, {"icon": "fa-building-columns text-yellow-400", "title": "اقتصاد", "text": "استقلال بانک مرکزی و حسابرسی سریع بنیادهای فرادولتی از جمله سپاه و آستان‌ها."}]},
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
    <script>
      tailwind.config = {
        theme: {
          extend: {
            fontFamily: { sans: ['Vazirmatn', 'sans-serif'] }
          }
        }
      }
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
        .chart-connector path { stroke: #cbd5e1; stroke-width: 4px; stroke-dasharray: 8 8; fill: none; opacity: 0.6; }
        .vs-card-no { background: linear-gradient(135deg, #450a0a, #7f1d1d); border: 2px solid #ef4444; }
        .vs-card-yes { background: linear-gradient(135deg, #064e3b, #065f46); border: 2px solid #10b981; }
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
    html_body += f'<div class="absolute top-[0rem] right-0 text-slate-500 font-bold text-2xl z-50 bg-slate-900/50 px-6 py-2 rounded-full border border-slate-700">طرح مهستان • {slide_num}/{total_slides}</div>\n'
    
    if sl["type"] == "title":
        html_body += f'''
            <h2 class="text-yellow-400 text-5xl font-bold mb-8 tracking-widest">{sl["sub"]}</h2>
            <h1 class="text-[6.5rem] font-black text-transparent bg-clip-text bg-gradient-to-r from-cyan-300 to-indigo-300 mb-12 drop-shadow-xl leading-tight glow-text text-center px-4" style="line-height:1.3;">{sl["title"]}</h1>
            <div class="glass-card p-12 mt-8 w-11/12 max-w-4xl text-center border-b-4 border-b-emerald-400">
                <p class="text-[2.6rem] text-slate-200 font-bold leading-relaxed">{sl["hl"]}</p>
            </div>
        '''
    elif sl["type"] == "vs-cards":
         html_body += f'''
            <h2 class="text-yellow-400 text-4xl font-bold mb-6">{sl["sub"]}</h2>
            <h1 class="text-7xl font-black text-white mb-12 glow-text">{sl["title"]}</h1>
            <div class="grid grid-cols-1 gap-6 w-full max-w-5xl px-8">
        '''
         for item in sl["vs"]:
             html_body += f'''
                <div class="flex items-center gap-6 w-full">
                    <div class="vs-card-no p-8 rounded-3xl w-1/2 flex items-center justify-center text-center shadow-lg border-2 border-rose-500">
                        <span class="text-3xl font-black text-white">{item["no"]}</span>
                    </div>
                    <div class="text-4xl text-slate-400 font-black"><i class="fa-solid fa-arrow-left-right"></i></div>
                    <div class="vs-card-yes p-8 rounded-3xl w-1/2 flex items-center justify-center text-center shadow-lg border-2 border-emerald-500">
                        <span class="text-3xl font-black text-white">{item["yes"]}</span>
                    </div>
                </div>
             '''
         html_body += '</div>'
         if "hl" in sl:
             html_body += f'<div class="mt-12 text-3xl font-bold text-cyan-400 bg-slate-900/80 px-8 py-4 rounded-full border border-cyan-500/30">{sl["hl"]}</div>'
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
            <div class="mt-16 text-3xl text-yellow-400 font-bold bg-slate-900/80 px-10 py-4 rounded-3xl border border-yellow-400/30">این تلفیق، رمز عبور از بحران‌های گذار است</div>
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
                        <h4 class="text-3xl font-black text-white">دموکراسی و علم</h4>
                    </div>
                    <p class="text-2xl text-slate-300 pr-[72px]">تفکیک بُعد کارشناسی از اراده ملی، سپس ترکیب آن‌ها در صحن علنی مجلس.</p>
                </div>
                <div class="glass-card p-8 border-r-8 border-fuchsia-400 text-right h-full flex flex-col justify-center">
                    <div class="flex items-center gap-4 mb-4">
                        <span class="bg-fuchsia-400 text-slate-900 font-bold text-3xl w-14 h-14 flex items-center justify-center rounded-2xl shadow-lg shrink-0">۲</span>
                        <h4 class="text-3xl font-black text-white">نمایندگی نسبتی</h4>
                    </div>
                    <p class="text-2xl text-slate-300 pr-[72px]">آرایش مجلس آینه‌ی تمام‌نمای ملت؛ هیچ اقلیت و جریانی مسکوت نمی‌ماند.</p>
                </div>
                <div class="glass-card p-8 border-r-8 border-amber-400 text-right h-full flex flex-col justify-center">
                    <div class="flex items-center gap-4 mb-4">
                        <span class="bg-amber-400 text-slate-900 font-bold text-3xl w-14 h-14 flex items-center justify-center rounded-2xl shadow-lg shrink-0">۳</span>
                        <h4 class="text-3xl font-black text-white">دو مرحله قانون‌گرایی</h4>
                    </div>
                    <p class="text-2xl text-slate-300 pr-[72px]">جلوگیری از خلأ قوانین از طریق تصویب فوری یک قانون اساسی موقت.</p>
                </div>
                <div class="glass-card p-8 border-r-8 border-rose-400 text-right h-full flex flex-col justify-center">
                    <div class="flex items-center gap-4 mb-4">
                        <span class="bg-rose-400 text-slate-900 font-bold text-3xl w-14 h-14 flex items-center justify-center rounded-2xl shadow-lg shrink-0">۴</span>
                        <h4 class="text-3xl font-black text-white">اصلاح نه تخریب</h4>
                    </div>
                    <p class="text-2xl text-slate-300 pr-[72px]">محافظت از ساختارهای خدمت‌رسان اداری و برکناری نقطه‌ای جنایتکاران سطح بالا.</p>
                </div>
                <div class="glass-card p-8 border-r-8 border-cyan-400 text-right h-full flex flex-col justify-center">
                    <div class="flex items-center gap-4 mb-4">
                        <span class="bg-cyan-400 text-slate-900 font-bold text-3xl w-14 h-14 flex items-center justify-center rounded-2xl shadow-lg shrink-0">۵</span>
                        <h4 class="text-3xl font-black text-white">حداکثر شفافیت</h4>
                    </div>
                    <p class="text-2xl text-slate-300 pr-[72px]">الزام تمامی نمایندگان و مقامات اجرایی به افشای دارایی و درآمد.</p>
                </div>
                <div class="glass-card p-8 border-r-8 border-blue-400 text-right h-full flex flex-col justify-center">
                    <div class="flex items-center gap-4 mb-4">
                        <span class="bg-blue-400 text-slate-900 font-bold text-3xl w-14 h-14 flex items-center justify-center rounded-2xl shadow-lg shrink-0">۶</span>
                        <h4 class="text-3xl font-black text-white">حقوق بشر بنیادین</h4>
                    </div>
                    <p class="text-2xl text-slate-300 pr-[72px]">برابری قطعی جنسیتی و حقوق اقلیت‌ها خط قرمز غیرقابل نقض است.</p>
                </div>
            </div>
        '''
    elif sl["type"] == "org-chart":
        html_body += f'''
            <h2 class="text-6xl font-black text-white mb-4 z-50 text-center">{sl["title"]}</h2>
            <h3 class="text-3xl text-yellow-400 mb-8 z-50 text-center">{sl["sub"]}</h3>
            <div class="relative w-[950px] h-[950px] mx-auto z-10">
                <div class="absolute top-2 left-1/2 -translate-x-1/2 glass-card p-8 border-[3px] border-indigo-400 bg-indigo-950/80 w-[600px] text-center rounded-[2.5rem] z-20">
                    <h3 class="text-5xl font-black text-white mb-2">مجلس مهستان</h3>
                    <p class="text-2xl text-indigo-200">نهاد عالی دوران گذار</p>
                </div>
                <div class="absolute top-[210px] right-[60px] glass-card p-5 border-r-[6px] border-cyan-400 w-[380px] z-20"><h4 class="text-2xl font-black text-cyan-400">بازوی دموکراتیک</h4></div>
                <div class="absolute top-[210px] left-[60px] glass-card p-5 border-l-[6px] border-amber-400 w-[380px] z-20"><h4 class="text-2xl font-black text-amber-400">بازوی تکنوکراتیک</h4></div>
                <div class="absolute top-[400px] left-1/2 -translate-x-1/2 flex justify-between w-full px-4 z-20">
                    <div class="glass-card p-6 border-t-[6px] border-emerald-400 text-center w-[280px]">شورای قضایی</div>
                    <div class="glass-card p-6 border-t-[6px] border-blue-400 text-center w-[300px] relative top-4">کابینه اجرایی</div>
                    <div class="glass-card p-6 border-t-[6px] border-rose-400 text-center w-[280px]">فرماندهی نظامی</div>
                </div>
                <div class="absolute bottom-4 left-1/2 -translate-x-1/2 w-full glass-card p-8 border border-slate-700 z-20 rounded-[2.5rem]">
                    <div class="grid grid-cols-3 gap-4 text-center">
                        <div class="py-3 bg-slate-800 rounded-xl">عدالت انتقالی</div>
                        <div class="py-3 bg-slate-800 rounded-xl">اصلاح امنیتی</div>
                        <div class="py-3 bg-slate-800 rounded-xl">ناظر انتخابات</div>
                    </div>
                </div>
                <svg class="absolute inset-0 w-[950px] h-[950px] chart-connector z-0"><path d="M 475 160 L 475 420" /><path d="M 475 180 L 250 180 L 250 210" /><path d="M 475 180 L 700 180 L 700 210" /></svg>
            </div>
        '''
    elif sl["type"] == "tj-chart":
        html_body += f'''
            <h2 class="text-6xl font-black text-white mb-4 z-50 text-center">{sl["title"]}</h2>
            <h3 class="text-3xl text-yellow-400 mb-10 z-50 text-center">{sl["sub"]}</h3>
            <div class="relative w-[1000px] h-[950px] flex items-center justify-center">
                <div class="absolute z-20 glass-card p-8 bg-indigo-950 border-[4px] border-indigo-400 rounded-full flex flex-col items-center justify-center w-[240px] h-[240px] text-center shadow-2xl">
                    <h3 class="text-3xl font-black text-white">عدالت انتقالی</h3>
                </div>
                <div class="absolute z-10 top-0 left-0 glass-card p-7 border-l-8 border-emerald-400 w-[420px] text-right rounded-3xl">
                    <h4 class="text-2xl font-bold text-emerald-400 mb-2">۱. حقیقت‌یابی</h4>
                    <p class="text-xl text-slate-300">مستندسازی جنایات و ثبت شهادت قربانیان بدون سانسور.</p>
                </div>
                <div class="absolute z-10 top-0 right-0 glass-card p-7 border-r-8 border-rose-400 w-[420px] text-right rounded-3xl">
                    <h4 class="text-2xl font-bold text-rose-400 mb-2">۲. عدالت کیفری</h4>
                    <p class="text-xl text-slate-300">محاکمات عادلانه، دادرسی شفاف و تفکیک مسئولیت آمران.</p>
                </div>
                <div class="absolute z-10 top-[400px] left-[-20px] glass-card p-7 border-l-8 border-amber-400 w-[420px] text-right rounded-3xl">
                    <h4 class="text-2xl font-bold text-amber-400 mb-2">۳. جبران خسارت</h4>
                    <p class="text-xl text-slate-300">تعهد ملی به پرداخت غرامت و اعاده حیثیت قربانیان.</p>
                </div>
                <div class="absolute z-10 top-[400px] right-[-20px] glass-card p-7 border-r-8 border-fuchsia-400 w-[420px] text-right rounded-3xl">
                    <h4 class="text-2xl font-bold text-fuchsia-400 mb-2">۴. آشتی ملی</h4>
                    <p class="text-xl text-slate-300">بسترسازی گفتگوهای اجتماعی فراگیر و رفع کینه‌ها.</p>
                </div>
                <!-- BOX 5 LOWERED -->
                <div class="absolute z-10 bottom-[-60px] glass-card p-10 border-b-8 border-cyan-400 w-[800px] text-center rounded-[2.5rem] shadow-2xl">
                    <h4 class="text-4xl font-bold text-cyan-400 mb-2">۵. تضمین عدم تکرار</h4>
                    <p class="text-2xl text-slate-200">اصلاح ساختار امنیتی و آموزش حقوق بشر در بطن نهادها.</p>
                </div>
                <svg class="absolute inset-0 w-full h-full chart-connector z-0"><path d="M 500 475 L 210 210" /><path d="M 500 475 L 790 210" /><path d="M 500 475 L 210 610" /><path d="M 500 475 L 790 610" /><path d="M 500 475 L 500 850" /></svg>
            </div>
        '''
    elif sl["type"] == "gantt-overview":
        html_body += f'''
            <h2 class="text-yellow-400 text-6xl font-black mb-16">{sl["title"]}</h2>
            <div class="glass-card w-full max-w-5xl p-16 flex flex-col gap-12 text-right">
                <div class="relative h-24 bg-slate-800 rounded-full flex items-center px-4 overflow-hidden border border-slate-700">
                    <div class="absolute top-0 right-0 h-full w-[30%] bg-rose-500 flex items-center justify-center text-3xl font-black text-white">فاز ۱</div>
                    <div class="absolute top-0 right-[30%] h-full w-[70%] bg-cyan-600 flex items-center justify-center text-3xl font-black text-white border-r-4 border-white">فاز ۲</div>
                </div>
                <div class="flex justify-between w-full px-4 text-3xl font-bold text-slate-400"><span>هفته ۱۴</span><span>هفته ۴</span><span>روز صفر</span></div>
                <div class="mt-12 p-10 bg-slate-900/50 rounded-3xl border border-slate-700"><p class="text-4xl text-slate-200 italic leading-relaxed text-center">{sl["sub"]}</p></div>
            </div>
        '''
    elif sl["type"] == "gantt-tall":
        phase = sl.get("phase", 1)
        html_body += f'''
            <h2 class="text-6xl font-black text-white mb-2 z-50">{sl["title"]}</h2>
            <h3 class="text-3xl text-yellow-400 mb-12 z-50">{sl["sub"]}</h3>
            <div class="relative w-full max-w-4xl rtl">
                <div class="absolute left-[30px] top-6 bottom-6 w-5 bg-slate-800 rounded-full border border-slate-700"></div>
                <div class="flex flex-col gap-[5rem] text-right">
        '''
        milestones = [
            {"title": "هفته اول: فرامین اضطراری", "text": "آزادی زندانیان سیاسی، لغو حجاب اجباری، پایان فیلترینگ و تعلیق اعدام.", "color": "rose"},
            {"title": "هفته ۱ تا ۴: مصوبات فوری", "text": "قانون آزادی مطبوعات، توسعه احزاب و لغو قوانین تبعیض‌آمیز خانواده.", "color": "amber"}
        ] if phase == 1 else [
            {"title": "هفته ۴ تا ۸: زیرساخت قانونی", "text": "قانون اساسی موقت، تشکیل کمیسیون حقیقت‌یابی و استقلال بانک مرکزی.", "color": "blue"},
            {"title": "هفته ۸ تا ۱۴: تثبیت جامعه", "text": "اصلاح نظام آموزشی، اقدامات محیط‌زیستی و زمینه‌سازی مجلس مؤسسان.", "color": "emerald"}
        ]
        for m in milestones:
            c = m["color"]
            html_body += f'''
                    <div class="relative pl-[100px] flex">
                        <div class="absolute w-10 h-10 rounded-full bg-{c}-400 border-[6px] border-slate-900 z-10 shadow-lg" style="left: 21px; top: 2.5rem;"></div>
                        <div class="glass-card p-12 border-r-[12px] border-{c}-400 w-full ml-auto">
                             <h3 class="text-4xl font-black text-white mb-6">{m["title"]}</h3>
                             <p class="text-3xl text-slate-300 leading-relaxed font-light">{m["text"]}</p>
                        </div>
                    </div>
            '''
        html_body += '</div></div>'
    elif sl["type"] == "flowchart":
        html_body += f'''
            <h2 class="text-6xl font-black text-white mb-16">{sl["title"]}</h2>
            <div class="glass-card p-12 w-full max-w-5xl flex flex-col items-center gap-12">
                <div class="p-8 bg-indigo-500 rounded-2xl w-96 text-center font-bold text-3xl">۱. ارائه طرح/لایحه</div>
                <div class="flex gap-16 w-full">
                    <div class="p-8 bg-amber-500 rounded-2xl flex-1 text-center font-bold text-2xl">بازوی تکنوکرات (علم)</div>
                    <div class="p-8 bg-cyan-500 rounded-2xl flex-1 text-center font-bold text-2xl">بازوی دموکرات (مردم)</div>
                </div>
                <div class="p-10 bg-slate-800 border-4 border-indigo-400 rounded-2xl w-[500px] text-center font-bold text-3xl">کمیسیون مشترک</div>
                <div class="p-12 bg-emerald-600 rounded-2xl w-full text-center font-bold text-4xl shadow-2xl">تصویب در صحن مجلس مهستان</div>
            </div>
        '''
    html_body += '</div></div>\n'

html_foot = '''</body></html>'''
with open(HTML_FILE, "w", encoding="utf-8") as f:
    f.write(html_head + html_body + html_foot)

def export_assets():
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page(viewport={"width": 1080, "height": 1350}, device_scale_factor=2)
        page.goto(f"file:///{os.path.abspath(HTML_FILE).replace(chr(92), '/')}", wait_until="networkidle")
        page.wait_for_timeout(3000)
        for i in range(len(slides)):
            page.evaluate(f"window.scrollTo(0, {i * 1350})")
            page.screenshot(path=os.path.join(PNG_DIR, f"slide_{i+1:02d}.png"))
        page.pdf(path=PDF_FILE, width="10.8in", height="13.5in", print_background=True)
        browser.close()

export_assets()
print("Success!")
