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
    {"type": "split", "title": "اصل اول: تخصص در کنار اراده ملی", "left": "بُعد واقعیت\nتکنوکرات‌ها، داده‌ها و حقایق اقتصادی-اجتماعی", "right": "بُعد ارزش\nخواست مردم متبلور در صندوق رأی و رفراندوم"},
    {"type": "icon-text", "icon": "fa-users-viewfinder text-fuchsia-400", "title": "اصل دوم: نمایندگی نسبتی", "text": "در جامعه متکثر ایران، سیستم انتخاباتی لیستی-نسبی تضمین می‌کند ترکیب مجلس آینه‌ای از کل ملت باشد و هیچ صدایی مسکوت نماند."},
    {"type": "icon-text", "icon": "fa-file-signature text-amber-400", "title": "اصل سوم: قانون موقت", "text": "خلأ قانونی مادر جنگ‌های داخلی است! با تصویب دوماهه قانون اساسی موقت، فرصت کافی و آرام برای تبیین قانون نهایی فراهم می‌گردد."},
    {"type": "icon-text", "icon": "fa-building-columns text-slate-300", "title": "اصل چهارم: حفظ ساختارها", "text": "فروپاشی دستگاه‌های زیربنایی فاجعه‌بار است. امور درمانی، اداری و خدماتی با رهبری نوین حفظ شده، تنها بازوهای سرکوب منحل می‌شوند."},
    {"type": "icon-text", "icon": "fa-eye text-cyan-400", "title": "اصل پنجم: پایان تاریک‌خانه‌ها", "text": "تمامی جلسات مجلس علنی، آرا شفاف و مقامات ملزم به افشای دارایی خواهند بود. قدرت بی‌حصار، زاینده‌ی فساد است."},
    {"type": "icon-text", "icon": "fa-scale-balanced text-emerald-400", "title": "اصل ششم: حقوق بشر قطعی", "text": "حقوق بنیادین، برابری حقوقی زن و مرد، و حقوق اقلیت‌ها فوق هر قانونی است؛ حتی مجلس هم توان تعلیق آن‌ها را نخواهد داشت."},
    {"type": "icon-text", "icon": "fa-landmark-dome text-yellow-400", "title": "نهاد محوری: مجلس مهستان", "text": "یک مجلس مردم‌محور که بلافاصله پس از فروپاشی نظام پیشین، با انتخاباتی همگانی زیر نظر جامعه جهانی تشکیل می‌گردد."},
    {"type": "stats", "title": "ترکیب ۳۰۰ نفره مجلس", "stats": [{"val": "۲۴۰", "label": "کرسی استانی (محلی)"}, {"val": "۴۰", "label": "کرسی فهرست‌های ملی"}, {"val": "۲۰", "label": "سهمیه اقلیت‌ها"}]},
    {"type": "stats", "title": "توسعه‌ی همه‌جانبه‌ی مشارکت", "stats": [{"val": "۳۰٪", "label": "حداقل الزام حضور زنان در تمامی لیست‌ها"}, {"val": "دیاسپورا", "label": "حق کاندیداتوری و رأی برای تمام ایرانیان خارج از کشور"}]},
    {"type": "icon-text", "icon": "fa-globe text-cyan-400", "title": "تبعیدیان، بازوهای توسعه", "text": "میلیون‌ها ایرانی دیاسپورا سرمایه‌ی ایران هستند و حق انتخاب مستقیم و واریز رأی به حوزه‌ی داخلی منتخب خود را خواهند داشت."},
    {"type": "cards", "title": "کابینه اجرایی موقت", "cards": [{"icon": "fa-briefcase text-cyan-400", "title": "مدیریت کارآمد", "text": "کابینه‌ای از وزرای متخصص برای جلوگیری از اقتصاد رو به زوال."}, {"icon": "fa-handshake text-yellow-400", "title": "ائتلاف الزام‌آور", "text": "پایان دادن کامل به تک‌صدایی و بن‌بست‌های سیاسی."}]},
    {"type": "cards", "title": "اولین مأموریت بنیادین", "cards": [{"icon": "fa-gavel text-amber-400", "title": "قانون اساسی موقت در ۶۰ روز!", "text": "مجلس مهستان تنها ۲ ماه فرصت دارد پیش‌نویس قانون موقت را آماده و مستقیما به نظرسنجی و رفراندوم ملی بگذارد."}]},
    {"type": "cards", "title": "تصفیه قضایی", "cards": [{"icon": "fa-scale-unbalanced text-rose-400", "title": "شورای قضایی انتقالی", "text": "قاضیان و حقوق‌دانان شریف، مأمور برکناری فوری عناصر فاسد، تعلیق قوانین ظالمانه و محاکمات عادلانه."}]},
    {"type": "icon-text", "icon": "fa-shield-halved text-emerald-400", "title": "اصلاح بخش امنیتی", "text": "سریعاً نهادهایی نظیر گشت ارشاد، سازمان‌های عقیدتی و بازوهای سرکوب منحل و نیروهای مردمی در یک ارتش واحد ملی ادغام خواهند شد."},
    {"type": "mermaid", "title": "عدالت انتقالی", "chart": "graph TD;\nTJ[عدالت انتقالی] --> TR[حقیقت یابی بی‌طرفانه];\nTJ --> CR[محاکمات عادلانه بدون انتقام];\nTJ --> CO[جبران خسارت قربانیان];\nTJ --> NP[تضمین عدم تکرار تاریخ];"},
    {"type": "icon-text", "icon": "fa-tower-broadcast text-fuchsia-400", "title": "آزادی بی‌حصر رسانه", "text": "پایان انحصار! دستگاه عریض صداوسیما به شبکه‌ای مردمی و بی‌طرف بدل گشته و آزادی تأسیس شبکه‌های خصوصی تضمین می‌گردد."},
    {"type": "icon-text", "icon": "fa-chart-line text-emerald-400", "title": "شورای اقتصادی دوران گذار", "text": "اقتصاددانان خوش‌نام ایران و جهان، مشاور کابینه برای مقابله با ابرتورم، مدیریت یارانه‌ها و شفافیت اموال ملی خواهند بود."},
    {"type": "split", "title": "دو بازوی قانون‌گذاری", "left": "مرکز تحقیقات\nتأمین مستندات تخصصی، پیش‌بینی‌های اقتصادی و مدل‌سازی‌های علمی (واقعیت)", "right": "ارتباط مردمی\nکشف خواست جامع از طریق نظرسنجی‌های ملی و پلتفرم‌های دموکراتیک (ارزش)"},
    {"type": "icon-text", "icon": "fa-calendar-check text-yellow-400", "title": "صد روزِ سرنوشت‌ساز", "text": "فرامین ۱۰۰ روز نخست، تعیین‌کننده است؛ روزهایی که بنیان‌های استبداد ۴۵ ساله با دستورات اضطراری الغا و درهم‌شکسته می‌شوند."},
    {"type": "cards", "title": "فرامین آزادی (هفته اول)", "cards": [{"icon": "fa-dove text-cyan-400", "title": "زندانیان", "text": "آزادی فوری و بی‌قید تمامی زندانیان سیاسی، عقیدتی و مدنی."}, {"icon": "fa-ban text-rose-400", "title": "حجاب اختیاری", "text": "لغو کامل حجاب اجباری و گشت‌های کنترل پوشش."}]},
    {"type": "cards", "title": "فرامین حقوق جانی", "cards": [{"icon": "fa-hand-paper text-rose-400", "title": "لغو اعدام", "text": "تعلیق کامل هرگونه مجازات غیرانسانی و اعدام در سراسر کشور."}, {"icon": "fa-person-walking-arrow-loop-left text-emerald-400", "title": "حق بازگشت", "text": "پایان دادن به کابوس تبعید سیاسی و صدور حق بازگشت."}]},
    {"type": "cards", "title": "فرامین شفافیت", "cards": [{"icon": "fa-wifi text-cyan-400", "title": "پایان فیلترینگ", "text": "رفع کلیه محدودیت‌های اینترنت و دسترسی آزاد جهانی."}, {"icon": "fa-lock text-yellow-400", "title": "حفاظت اسناد", "text": "دستور فوری برای محاصره و مراقبت از پرونده‌های امنیتی جهت دادخواهی قضایی."}]},
    {"type": "cards", "title": "اولویت‌های هفته‌های نخستین", "cards": [{"icon": "fa-newspaper text-emerald-400", "title": "آزادی تشکل", "text": "توسعه احزاب، سندیکاها و رسانه‌ها بدون اخذ مجوزهای حکومتی."}, {"icon": "fa-mars-stroke text-fuchsia-400", "title": "حقوق زنان", "text": "لغو کامل تمامی قوانین تبعیض‌آمیز سیستماتیک علیه زنان در طلاق، خروج و حضانت."}]},
    {"type": "cards", "title": "زیربناهای توسعه", "cards": [{"icon": "fa-language text-cyan-400", "title": "زبان مادری", "text": "آزادی آموزش و تضمین حقوق تنوع اقوامی."}, {"icon": "fa-building-columns text-yellow-400", "title": "اقتصاد", "text": "استقلال بانک مرکزی و حسابرسی سریع بنیادهای فرادولتی از جمله سپاه و آستان‌ها."}]},
    {"type": "mermaid", "title": "قانون‌گذاری خردمندانه", "chart": "graph TD;\nR[پیشنهاد لوایح] --> T1[گزارش فنی تکنوکرات ها];\nR --> T2[نظرسنجی واحد مردمی];\nT1 --> C[تصمیم‌گیری آگاهانه در مجلس];\nT2 --> C;\nC --> V[تصویب بر مبنای عقلانیت و آرای عمومی];"},
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
            padding: 4rem;
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
        .node rect { fill: rgba(255,255,255,0.1) !important; stroke: #38bdf8 !important; stroke-width: 2px; rx: 10px; ry: 10px; }
        .node text { fill: #fff !important; font-size: 24px !important; font-weight: bold; }
        .edgeLabel { background-color: transparent !important; }
        .edgePath path { stroke: #cbd5e1 !important; stroke-width: 3px !important; }
    </style>
</head>
<body>
'''

html_body = ""
for i, sl in enumerate(slides):
    slide_num = i + 1
    html_body += f'<!-- Slide {slide_num} -->\n<div class="slide" id="slide-{slide_num}">\n'
    html_body += '<div class="bg-blob-1"></div><div class="bg-blob-2"></div><div class="bg-grid"></div>\n'
    html_body += '<div class="relative z-10 w-full flex flex-col items-center">\n'
    
    html_body += f'<div class="absolute top-[-2rem] right-0 text-slate-500 font-bold text-xl">طرح مهستان • {slide_num:02d}/33</div>\n'
    
    if sl["type"] == "title":
        html_body += f'''
            <h2 class="text-yellow-400 text-4xl font-bold mb-8 tracking-widest">{sl["sub"]}</h2>
            <h1 class="text-8xl font-black text-transparent bg-clip-text bg-gradient-to-r from-cyan-300 to-indigo-300 mb-12 drop-shadow-xl leading-tight glow-text" style="line-height:1.2;">{sl["title"]}</h1>
            <div class="glass-card p-10 mt-8 w-11/12 max-w-4xl text-center border-b-4 border-b-emerald-400">
                <p class="text-4xl text-slate-200 font-bold leading-relaxed">{sl["hl"]}</p>
            </div>
        '''
    elif sl["type"] == "icon-text":
        html_body += f'''
            <i class="fa-solid {sl["icon"]} text-[9rem] mb-12 drop-shadow-[0_0_30px_rgba(255,255,255,0.3)]"></i>
            <h2 class="text-6xl font-black text-white mb-16">{sl["title"]}</h2>
            <div class="glass-card p-16 w-full max-w-4xl text-right">
                <p class="text-4xl text-slate-200 leading-[2.2]">{sl["text"]}</p>
            </div>
        '''
    elif sl["type"] == "cards":
        html_body += f'''
            <h2 class="text-6xl font-black text-white mb-20">{sl["title"]}</h2>
            <div class="flex flex-col gap-10 w-full max-w-4xl">
        '''
        for c in sl["cards"]:
            html_body += f'''
                <div class="glass-card p-12 flex items-center gap-10 text-right">
                    <div class="flex-shrink-0"><i class="fa-solid {c["icon"]} text-7xl"></i></div>
                    <div>
                        <h3 class="text-4xl font-bold text-white mb-4">{c["title"]}</h3>
                        <p class="text-3xl text-slate-300 leading-relaxed">{c["text"]}</p>
                    </div>
                </div>
            '''
        html_body += '</div>'
    elif sl["type"] == "split":
        html_body += f'''
            <h2 class="text-6xl font-black text-white mb-20">{sl["title"]}</h2>
            <div class="flex flex-row gap-8 w-full max-w-5xl">
                <div class="glass-card w-1/2 p-12 text-center border-b-4 border-b-rose-400 flex flex-col items-center justify-center">
                    <i class="fa-solid fa-chart-pie text-cyan-400 text-7xl mb-8"></i>
                    <p class="text-3xl text-slate-200 leading-[2.2] whitespace-pre-line">{sl["left"]}</p>
                </div>
                <div class="flex items-center text-4xl text-slate-400"><i class="fa-solid fa-plus"></i></div>
                <div class="glass-card w-1/2 p-12 text-center border-b-4 border-b-cyan-400 flex flex-col items-center justify-center">
                    <i class="fa-solid fa-users text-emerald-400 text-7xl mb-8"></i>
                    <p class="text-3xl text-slate-200 leading-[2.2] whitespace-pre-line">{sl["right"]}</p>
                </div>
            </div>
            <div class="mt-16 text-3xl text-yellow-400 font-bold">حکمرانی هوشمند نیازمند تلفیق حقایق علمی و دموکراسی است</div>
        '''
    elif sl["type"] == "stats":
        html_body += f'''
            <h2 class="text-7xl font-black text-white mb-24">{sl["title"]}</h2>
            <div class="flex flex-wrap gap-10 justify-center w-full max-w-5xl">
        '''
        for s in sl["stats"]:
            html_body += f'''
                <div class="glass-card p-12 flex flex-col items-center justify-center min-w-[300px] flex-1 border-t-4 border-t-yellow-400">
                    <div class="text-[7rem] font-black text-yellow-400 mb-6 drop-shadow-[0_0_20px_rgba(250,204,21,0.5)] leading-none" dir="ltr">{s["val"]}</div>
                    <div class="text-3xl font-bold text-slate-200 text-center leading-[1.8]">{s["label"]}</div>
                </div>
            '''
        html_body += '</div>'
    elif sl["type"] == "mermaid":
        html_body += f'''
            <h2 class="text-7xl font-black text-white mb-12">{sl["title"]}</h2>
            <div class="glass-card p-12 w-full max-w-5xl bg-slate-900/80">
                <div class="mermaid text-2xl font-bold flex justify-center w-full">
                    {sl["chart"]}
                </div>
            </div>
        '''
        
    html_body += '</div></div>\n'

html_foot = '''
</body>
</html>
'''

with open(HTML_FILE, "w", encoding="utf-8") as f:
    f.write(html_head + html_body + html_foot)

print("Beautiful HTML created.")

print("Generating screenshots & PDF via Playwright...")
def export_assets():
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page(viewport={"width": 1080, "height": 1350}, device_scale_factor=2)
        
        file_url = f"file:///{os.path.abspath(HTML_FILE).replace(chr(92), '/')}"
        page.goto(file_url, wait_until="networkidle")
        
        page.wait_for_timeout(4000)
        
        for i in range(len(slides)):
            slide_no = i + 1
            png_path = os.path.join(PNG_DIR, f"slide_{slide_no:02d}.png")
            page.evaluate("document.body.style.overflow = 'hidden'")
            page.evaluate(f"window.scrollTo(0, {i * 1350})")
            page.screenshot(path=png_path)
            print(f"Saved PNG {slide_no}/{len(slides)}")
        
        page.pdf(
            path=PDF_FILE, 
            width="10.8in", 
            height="13.5in", 
            print_background=True,
            page_ranges=f"1-{len(slides)}"
        )
        print("Saved High-Res Vector PDF.")

        browser.close()

export_assets()
print("All tasks elegantly completed!")
