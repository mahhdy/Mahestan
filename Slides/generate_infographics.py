import os
import svgwrite
import arabic_reshaper
from bidi.algorithm import get_display
from playwright.sync_api import sync_playwright

output_dir = "Infographics"
svg_dir = os.path.join(output_dir, "SVG")
png_dir = os.path.join(output_dir, "PNG")

os.makedirs(svg_dir, exist_ok=True)
os.makedirs(png_dir, exist_ok=True)

slides = [
    {"title": "ایران در تقاطع تاریخ", "sub": "تصمیمات امروز، سرنوشت فردا", "text": "ایران در مقطعی تاریخی قرار دارد. نه تعلل و بی‌عملی کارساز است، نه شتاب و احساساتی شدن. ما به یک گذار مهندسی شده نیاز داریم."},
    {"title": "طرح مجلس مهستان", "sub": "نقشه راه دوران گذار", "text": "مهستان یک ساختار بازنگری‌شده برای رسیدن به ایرانی آزاد، آباد و متکثر است. الگویی برای عبور از استبداد با کمترین هزینه."},
    {"title": "چرا نهادسازی؟", "sub": "درس‌هایی از تجارب جهانی", "text": "تجربه‌ی جهانی نشان می‌دهد کیفیت طراحی نهادی دوران گذار تعیین‌کننده‌ی اصلی موفقیت دموکراسی است. خلأ قانونی خطرناک‌ترین تهدید است."},
    {"title": "اصل اول: اراده ملی و تخصص", "sub": "تلفیق واقعیت و ارزش", "text": "هنر حکمرانی گذار، ترکیب دو بُعد است: بُعد واقعیت (داده‌های تخصصی) و بُعد ارزش (خواست مردم از طریق رفراندوم و نظرسنجی)."},
    {"title": "اصل دوم: جایگاه همه صداها", "sub": "نمایندگی نسبتی", "text": "در جامعه‌ای متکثر چون ایران، از طریق نمایندگی نسبی-فهرستی، هیچ اقلیت و گروهی از فرآیند قدرت و تصمیم‌گیری حذف نخواهد شد."},
    {"title": "اصل سوم: قانون موقت", "sub": "پیشگیری از هرج‌ومرج", "text": "با تصویب یک قانون اساسی موقت در ماه اول، کشور از فروپاشی حفظ شده و فرصت کافی برای بحث عمومی و قانون نهایی فراهم می‌شود."},
    {"title": "اصل چهارم: اصلاح نه تخریب", "sub": "حفظ نهادهای اجرایی", "text": "تجربه عراق نشان داد انحلال کامل ادارات، فاجعه می‌آفریند. ساختارهای خدماتی با رهبری جدید و پاکسازی جنایتکاران حفظ می‌شوند."},
    {"title": "اصل پنجم: نظارت و پاسخگویی", "sub": "پایان تاریکخانه‌ها", "text": "تمام جلسات مجلس مهستان علنی خواهد بود و مسئولین موظف به شفافیت مالی هستند. قدرت بدون نظارت، ناگزیر فاسد خواهد شد."},
    {"title": "اصل ششم: ایران برای همه", "sub": "حقوق بشر خط قرمز است", "text": "اصول بنیادین حقوق بشر، برابری جنسیتی، و حقوق اقلیت‌ها در طرح مهستان غیرقابل نقض است و حقوق هیچکس پایمال نمی‌شود."},
    {"title": "مجلس مهستان چیست؟", "sub": "نهاد محوری و منتخب گذار", "text": "یک مجلس مردم‌محور از ۳۰۰ نماینده‌ی منتخب، که بلافاصله پس از فروپاشی نظام فعلی تشکیل شده و اداره کشور را به دست می‌گیرد."},
    {"title": "توزیع عادلانه کرسی‌ها", "sub": "عدالت در نمایندگی ملی", "text": "۲۴۰ کرسی استانی، ۴۰ کرسی برای لیست‌های ملی و ۲۰ کرسی تضمینی ویژه‌ی اقلیت‌ها تا تمامی آحاد ملت در صحن حاضر باشند."},
    {"title": "سهمیه زنان: قاعده بی‌بازگشت", "sub": "حداقل ۳۰٪ حضور قطعی", "text": "هر سه نفر اول فهرست‌های انتخاباتی باید شامل حداقل یک زن باشد. پیروزی هر لیست، به معنای حضور واقعی زنان در مجلس است."},
    {"title": "حق رأی ایرانیان دیاسپورا", "sub": "خارج از مرز، داخل در قلب", "text": "میلیون‌ها ایرانی خارج از کشور می‌توانند در یک حوزه داخلی، هم‌پای داخل کشور رأی دهند. دیاسپورا بخش جدایی‌ناپذیر آینده است."},
    {"title": "کابینه‌ اجرایی موقت", "sub": "پیشگیری از توقف امور", "text": "بدون وقفه، ائتلاف اکثریت در مجلس، تیمی از وزرای متخصص را برای اداره روزمره کشور و بازگرداندن ثبات اقتصادی انتخاب می‌کند."},
    {"title": "ماموریت: قانون اساسی موقت", "sub": "فقط در ۶۰ روز!", "text": "کمیسیونی ویژه شامل حقوقدانان مستقل، پیش‌نویس قانون اساسی موقت را برای تصویب نمایندگان و سپس رفراندوم مردمی تدوین می‌کند."},
    {"title": "شورای قضایی انتقالی", "sub": "آغاز عدالت، پایان ظلم", "text": "جمعی از قاضیان مستقل و اساتید حقوق مأمور تصفیه دستگاه قضایی از فاسدان، تعلیق قوانین ظالمانه و محاکمات عادلانه می‌شوند."},
    {"title": "اصلاح بخش امنیتی (SSR)", "sub": "خداحافظی با سرکوبگران", "text": "کمیسیون تخصصی بی‌درنگ نهادهای سرکوب، گشت ارشاد و ساختارهای ایدئولوژیک را منحل کرده و یک ارتش نوین و ملی می‌سازد."},
    {"title": "دادخواهی و عدالت انتقالی", "sub": "حقیقت‌یابی و آشتی ملی", "text": "مستندسازی جنایات ۴۵ ساله، ثبت شهادت قربانیان، پرداخت غرامت و برگزاری محاکمات عادلانه برای تضمین عدم تکرار تاریخ."},
    {"title": "رسانه عمومی مستقل", "sub": "پایان بوق‌های حکومتی", "text": "رسانه ملی به یک شبکه خدمات عمومی (الگوی بی‌بی‌سی) تبدیل شده و آزادی بی‌تزلزل مطبوعات و لغو فیلترینگ تضمین می‌شود."},
    {"title": "مرکز تحقیقات مهستان", "sub": "بازوی تخصصی و تکنوکرات", "text": "فرار از عوام‌گرایی! تیمی از نخبگان برای هر لایحه، تحلیل اقتصادی و اجتماعی تهیه کرده و گزینه‌های کارشناسی به مجلس ارائه می‌دهند."},
    {"title": "واحد ارتباط مردمی", "sub": "بازوی دموکراتیک و مردمی", "text": "پلتفرمی دیجیتال برای دریافت لحظه‌ای صدای شهروندان، نظرسنجی علمی، و برگزاری رفراندوم‌ها. مجلس همواره زیر ذره‌بین مردم است."},
    {"title": "صد روز نخستین گذار", "sub": "فرمان‌های اضطراری فوری", "text": "صدور سریع فرامین ضروری در نخستین هفته: آزادی تمام زندانیان سیاسی و عقیدتی و اعلام ممنوعیت دائم بازداشت بدون حکم قضایی."},
    {"title": "پایان آپارتاید جنسیتی", "sub": "لغو فوری حجاب اجباری", "text": "در هفته اول تشکیل مجلس مهستان، لغو کامل حجاب اجباری و پاک‌سازی هرگونه قانون ناعادلانه و تبعیض‌آمیز علیه زنان صادر می‌شود."},
    {"title": "توقف ماشین سلاخی", "sub": "تعلیق مجازات اعدام", "text": "مجازات غیرانسانی اعدام تا بررسی نهایی بلافاصله معلق، و فعالیت دادگاه‌های غیرقانونی چون محاکم انقلاب در هفته اول متوقف می‌شود."},
    {"title": "نجات اقتصاد در حال احتضار", "sub": "شفافیت و حسابرسی ملی", "text": "اموال بنیادها فریز، دارایی‌های مشکوک مسدود و ثروت‌های آزاد شده صرف صندوق ملی بازسازی اقتصادی و مهار تورم خواهد شد."},
    {"title": "حق تحصیل به زبان مادری", "sub": "آموزش و حقوق اقلیت‌ها", "text": "حمایت از حقوق تمامی اقوام ایرانی و مصوبه آموزش به زبان مادری، از شعار عبور کرده و به تعهدی قانونی و پایدار تبدیل می‌گردد."},
    {"title": "نجات سرزمین و بوم‌سازگان", "sub": "وضع قانون محیط زیست", "text": "با تدوین اقدامات اضطراری برای مقابله با بحران بی‌آبی و فرونشست زمین، حفظ تنوع زیستی در صدر اولویت‌های ملی قرار می‌گیرد."},
    {"title": "فرایند تصویب یک قانون", "sub": "استدلال در کنار دموکراسی", "text": "قانون‌گذاری بر دو پایه استوار است: یک، گزارش فنی نخبگان و مرکز تحقیقات. دو، نظرسنجی و آرای آنلاین مردمی برای کشف خواست عمومی."},
    {"title": "خطوط قرمز رفراندوم", "sub": "موارد کلیدی و سرنوشت‌ساز", "text": "قوانین سرنوشت‌ساز چون تغییرات اساسی ساختار حکومت، فقط و فقط با اراده مستقیم مردم در صندوق‌های شفاف رفراندوم تعیین تکلیف می‌شوند."},
    {"title": "حق عزل نماینده بدعهد", "sub": "نظارت مداوم و همیشگی", "text": "اگر ۴۰ درصد از رأی‌دهندگان محلی تشخیص دهند نماینده‌شان شایسته نیست، او بدون معطلی برکنار شده و نفر بعدی لیست جایگزین می‌گردد."},
    {"title": "پایان ماموریت مهستان", "sub": "موقتی اما سرنوشت‌ساز", "text": "این مجلس ابدی نیست! حداکثر پس از ۲ سال، قانون اساسی دائمی تصویب شده، انتخابات آزاد برگزار و قدرت به نهاد ثابت واگذار می‌گردد."},
    {"title": "فردای آزادی در دستان توست", "sub": "نقش ما در این نقشه راه", "text": "طرح مهستان بدون حمایت و ترویج شما یک تئوری می‌ماند. این اینفوگرافیک‌ها را نشر دهید، فایل کامل را بخوانید و نقد کنید."},
    {"title": "ایرانِ متحد، ایرانِ آباد", "sub": "بسوی یک آینده درخشان", "text": "با اراده، همبستگی، و مهندسی دقیق نهادهای دوران گذار، از تاریک‌ترین شب تاریخمان عبور کرده و دموکراسی پایدار را خواهیم ساخت."}
]

def make_bidi(text):
    reshaped_text = arabic_reshaper.reshape(text)
    bidi_text = get_display(reshaped_text)
    return bidi_text

def wrap_text(text, max_chars_per_line=45):
    words = text.split(" ")
    lines = []
    current_line = ""
    for word in words:
        if len(current_line) + len(word) <= max_chars_per_line:
            current_line += word + " "
        else:
            lines.append(current_line.strip())
            current_line = word + " "
    if current_line:
        lines.append(current_line.strip())
    return lines

WIDTH = 1080
HEIGHT = 1350

# We use Vazirmatn locally via webfonts or standard fallback
# Actually, SVG will be rendered by Playwright so web fonts work perfectly.
css = """
@import url('https://fonts.googleapis.com/css2?family=Vazirmatn:wght@400;700;900&display=swap');
text { font-family: 'Vazirmatn', sans-serif; }
"""

def generate_svg(slide, slide_no, total_slides, output_path):
    dwg = svgwrite.Drawing(output_path, size=(WIDTH, HEIGHT), profile='full')
    dwg.add(dwg.style(content=css))
    
    # Background (Deep dark blue/grey gradient + some aesthetic elements)
    defs = dwg.defs
    bg_grad = svgwrite.gradients.LinearGradient(start=("0%", "0%"), end=("100%", "100%"), id="bgGrad")
    bg_grad.add_stop_color(offset="0%", color="#0f172a") # dark slate
    bg_grad.add_stop_color(offset="100%", color="#1e3a8a") # deep blue
    defs.add(bg_grad)
    
    dwg.add(dwg.rect(insert=(0, 0), size=("100%", "100%"), fill="url(#bgGrad)"))
    
    # Add some abstract geometry for that "engineered/structured" vibe
    dwg.add(dwg.polygon(points=[(WIDTH, 0), (WIDTH - 400, 0), (WIDTH, 300)], fill="#1e1b4b", opacity=0.4))
    dwg.add(dwg.circle(center=(150, HEIGHT - 150), r=300, fill="#2dd4bf", opacity=0.05))
    dwg.add(dwg.circle(center=(WIDTH - 100, HEIGHT - 500), r=150, fill="#fbbf24", opacity=0.08))
    
    # Grid lines to show 'structure'
    for i in range(0, WIDTH, 100):
        dwg.add(dwg.line(start=(i, 0), end=(i, HEIGHT), stroke="#ffffff", opacity=0.02, stroke_width=1))
    for i in range(0, HEIGHT, 100):
        dwg.add(dwg.line(start=(0, i), end=(WIDTH, i), stroke="#ffffff", opacity=0.02, stroke_width=1))

    # Header section
    brand_text = "طرح مجلس مهستان | دوران گذار پایدار"
    dwg.add(dwg.text(make_bidi(brand_text), insert=(WIDTH - 80, 80), fill="#94a3b8", font_size="22px", font_weight="400", text_anchor="end"))
    
    # Slide Number
    page_str = f"اسلاید {make_bidi(str(slide_no))} از {make_bidi(str(total_slides))}"
    dwg.add(dwg.text(page_str, insert=(80, 80), fill="#94a3b8", font_size="22px", font_weight="400", text_anchor="start"))

    # Content Coordinates
    RIGHT_ALIGN_X = WIDTH - 80
    CURRENT_Y = 350

    # Subtitle (Gold)
    dwg.add(dwg.text(make_bidi(slide['sub']), insert=(RIGHT_ALIGN_X, CURRENT_Y), fill="#fbbf24", font_size="40px", font_weight="700", text_anchor="end"))
    CURRENT_Y += 100

    # Title (White)
    dwg.add(dwg.text(make_bidi(slide['title']), insert=(RIGHT_ALIGN_X, CURRENT_Y), fill="#ffffff", font_size="75px", font_weight="900", text_anchor="end"))
    CURRENT_Y += 160

    # Decorative Line
    dwg.add(dwg.line(start=(RIGHT_ALIGN_X, CURRENT_Y), end=(RIGHT_ALIGN_X - 150, CURRENT_Y), stroke="#2dd4bf", stroke_width=6))
    CURRENT_Y += 120

    # Main Text (Wrapped)
    lines = wrap_text(slide['text'], max_chars_per_line=38)
    for line in lines:
        dwg.add(dwg.text(make_bidi(line), insert=(RIGHT_ALIGN_X, CURRENT_Y), fill="#e2e8f0", font_size="45px", font_weight="400", text_anchor="end", style="line-height: 1.8;"))
        CURRENT_Y += 85

    # Footer CTA
    footer_text = "متن کامل را مطالعه کنید و برای فردای ایران به اشتراک بگذارید."
    dwg.add(dwg.text(make_bidi(footer_text), insert=(WIDTH/2, HEIGHT - 80), fill="#38bdf8", font_size="26px", font_weight="700", text_anchor="middle"))

    dwg.save()

print("Generating SVGs...")
for i, slide in enumerate(slides):
    no = i + 1
    svg_path = os.path.join(svg_dir, f"slide_{no:02d}.svg")
    generate_svg(slide, no, len(slides), svg_path)
print("Finished SVGs.")

print("Starting PNG generation via Playwright...")
def convert_to_png():
    with sync_playwright() as p:
        # We need a browser to render the local SVGs containing web fonts!
        browser = p.chromium.launch(headless=True)
        page = browser.new_page(viewport={"width": WIDTH, "height": HEIGHT})
        for i in range(len(slides)):
            no = i + 1
            svg_file = f"slide_{no:02d}.svg"
            svg_path = os.path.join(svg_dir, svg_file)
            png_path = os.path.join(png_dir, f"slide_{no:02d}.png")
            
            # Using absolute file URI
            abs_path = os.path.abspath(svg_path).replace("\\", "/")
            file_url = f"file:///{abs_path}"
            
            page.goto(file_url)
            # wait a bit for fonts to load
            page.wait_for_timeout(500)
            page.screenshot(path=png_path)
            print(f"Saved {png_path}")
        browser.close()

convert_to_png()
print("All tasks complete!")
