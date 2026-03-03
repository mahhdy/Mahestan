

## ۲. اسلایدهای اینستاگرام (SVG)

### اسلاید ۱ — معرفی

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1080 1080" dir="rtl">
  <defs>
    <linearGradient id="bgGrad1" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#1A237E"/>
      <stop offset="100%" style="stop-color:#283593"/>
    </linearGradient>
    <filter id="shadow1" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="4" stdDeviation="8" flood-opacity="0.3"/>
    </filter>
    <style>
      @font-face {
        font-family: 'Vazirmatn';
        src: url('fonts/Vazirmatn-Regular.ttf');
      }
      .title { font-family: 'Vazirmatn', sans-serif; font-size: 72px; font-weight: bold; fill: white; }
      .subtitle { font-family: 'Vazirmatn', sans-serif; font-size: 36px; fill: #F9A825; }
      .body { font-family: 'Vazirmatn', sans-serif; font-size: 32px; fill: white; }
      .highlight { font-family: 'Vazirmatn', sans-serif; font-size: 120px; font-weight: bold; fill: #F9A825; }
      .label { font-family: 'Vazirmatn', sans-serif; font-size: 28px; fill: white; }
    </style>
  </defs>
  
  <!-- پس‌زمینه -->
  <rect width="1080" height="1080" fill="url(#bgGrad1)"/>
  
  <!-- نوار طلایی بالا -->
  <rect x="0" y="0" width="1080" height="12" fill="#F9A825"/>
  
  <!-- نوار طلایی پایین -->
  <rect x="0" y="1068" width="1080" height="12" fill="#F9A825"/>
  
  <!-- عنوان -->
  <text x="540" y="180" text-anchor="middle" class="title">طرح مجلس مهستان</text>
  
  <!-- زیرعنوان -->
  <text x="540" y="260" text-anchor="middle" class="subtitle">چارچوب نهادی گذار دموکراتیک ایران</text>
  
  <!-- خط جداکننده -->
  <line x1="340" y1="320" x2="740" y2="320" stroke="#F9A825" stroke-width="4"/>
  
  <!-- دایره‌ی مرکزی -->
  <circle cx="540" cy="540" r="180" fill="#1565C0" filter="url(#shadow1)"/>
  <circle cx="540" cy="540" r="150" fill="#1A237E" stroke="#F9A825" stroke-width="4"/>
  
  <!-- عدد بزرگ -->
  <text x="540" y="520" text-anchor="middle" class="highlight">۳۰۰</text>
  <text x="540" y="590" text-anchor="middle" class="body">نماینده‌ی منتخب مردم</text>
  
  <!-- باکس‌های اطراف -->
  <g filter="url(#shadow1)">
    <!-- استانی -->
    <rect x="80" y="420" width="200" height="100" rx="12" fill="#BBDEFB"/>
    <text x="180" y="465" text-anchor="middle" font-family="Vazirmatn" font-size="40" font-weight="bold" fill="#1565C0">۲۴۰</text>
    <text x="180" y="500" text-anchor="middle" font-family="Vazirmatn" font-size="22" fill="#1565C0">کرسی استانی</text>
    
    <!-- ملی -->
    <rect x="80" y="560" width="200" height="100" rx="12" fill="#FFF9C4"/>
    <text x="180" y="605" text-anchor="middle" font-family="Vazirmatn" font-size="40" font-weight="bold" fill="#F9A825">۴۰</text>
    <text x="180" y="640" text-anchor="middle" font-family="Vazirmatn" font-size="22" fill="#F9A825">کرسی ملی</text>
    
    <!-- اقلیت‌ها -->
    <rect x="800" y="490" width="200" height="100" rx="12" fill="#F3E5F5"/>
    <text x="900" y="535" text-anchor="middle" font-family="Vazirmatn" font-size="40" font-weight="bold" fill="#6A1B9A">۲۰</text>
    <text x="900" y="570" text-anchor="middle" font-family="Vazirmatn" font-size="22" fill="#6A1B9A">کرسی اقلیت‌ها</text>
  </g>
  
  <!-- خطوط اتصال -->
  <line x1="280" y1="470" x2="390" y2="500" stroke="#BBDEFB" stroke-width="3"/>
  <line x1="280" y1="610" x2="390" y2="580" stroke="#FFF9C4" stroke-width="3"/>
  <line x1="800" y1="540" x2="690" y2="540" stroke="#F3E5F5" stroke-width="3"/>
  
  <!-- پیام پایین -->
  <rect x="140" y="800" width="800" height="120" rx="16" fill="rgba(255,255,255,0.1)"/>
  <text x="540" y="855" text-anchor="middle" class="body">نهاد عالی حاکمیت دوران گذار</text>
  <text x="540" y="900" text-anchor="middle" class="label">حداکثر ۲ سال — منتخب مستقیم مردم</text>
  
  <!-- شماره اسلاید -->
  <text x="540" y="1020" text-anchor="middle" font-family="Vazirmatn" font-size="24" fill="rgba(255,255,255,0.5)">۱ / ۶</text>
</svg>
```

### اسلاید ۲ — ۶ اصل راهنما

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1080 1080" dir="rtl">
  <defs>
    <linearGradient id="bgGrad2" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#1A237E"/>
      <stop offset="100%" style="stop-color:#283593"/>
    </linearGradient>
    <filter id="shadow2" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="3" stdDeviation="6" flood-opacity="0.25"/>
    </filter>
  </defs>
  
  <!-- پس‌زمینه -->
  <rect width="1080" height="1080" fill="url(#bgGrad2)"/>
  <rect x="0" y="0" width="1080" height="10" fill="#F9A825"/>
  <rect x="0" y="1070" width="1080" height="10" fill="#F9A825"/>
  
  <!-- عنوان -->
  <text x="540" y="100" text-anchor="middle" font-family="Vazirmatn" font-size="56" font-weight="bold" fill="white">۶ اصل راهنما</text>
  <line x1="380" y1="140" x2="700" y2="140" stroke="#F9A825" stroke-width="3"/>
  
  <!-- اصل ۱ -->
  <g filter="url(#shadow2)">
    <rect x="60" y="200" width="460" height="220" rx="16" fill="#BBDEFB"/>
    <circle cx="140" cy="280" r="40" fill="#1565C0"/>
    <text x="140" y="295" text-anchor="middle" font-family="Vazirmatn" font-size="36" font-weight="bold" fill="white">۱</text>
    <text x="300" y="270" text-anchor="middle" font-family="Vazirmatn" font-size="28" font-weight="bold" fill="#1565C0">دموکراسی + تخصص</text>
    <text x="290" y="320" text-anchor="middle" font-family="Vazirmatn" font-size="20" fill="#1565C0">ترکیب رأی مردم با</text>
    <text x="290" y="350" text-anchor="middle" font-family="Vazirmatn" font-size="20" fill="#1565C0">تحلیل متخصصان</text>
  </g>
  
  <!-- اصل ۲ -->
  <g filter="url(#shadow2)">
    <rect x="560" y="200" width="460" height="220" rx="16" fill="#C8E6C9"/>
    <circle cx="640" cy="280" r="40" fill="#2E7D32"/>
    <text x="640" y="295" text-anchor="middle" font-family="Vazirmatn" font-size="36" font-weight="bold" fill="white">۲</text>
    <text x="800" y="270" text-anchor="middle" font-family="Vazirmatn" font-size="28" font-weight="bold" fill="#2E7D32">نمایندگی نسبی</text>
    <text x="790" y="320" text-anchor="middle" font-family="Vazirmatn" font-size="20" fill="#2E7D32">هیچ صدایی</text>
    <text x="790" y="350" text-anchor="middle" font-family="Vazirmatn" font-size="20" fill="#2E7D32">نشنیده نمی‌ماند</text>
  </g>
  
  <!-- اصل ۳ -->
  <g filter="url(#shadow2)">
    <rect x="60" y="450" width="460" height="220" rx="16" fill="#F3E5F5"/>
    <circle cx="140" cy="530" r="40" fill="#6A1B9A"/>
    <text x="140" y="545" text-anchor="middle" font-family="Vazirmatn" font-size="36" font-weight="bold" fill="white">۳</text>
    <text x="300" y="520" text-anchor="middle" font-family="Vazirmatn" font-size="28" font-weight="bold" fill="#6A1B9A">دو قانون اساسی</text>
    <text x="290" y="570" text-anchor="middle" font-family="Vazirmatn" font-size="20" fill="#6A1B9A">موقت (۲ ماه)</text>
    <text x="290" y="600" text-anchor="middle" font-family="Vazirmatn" font-size="20" fill="#6A1B9A">+ نهایی (۱۸ ماه)</text>
  </g>
  
  <!-- اصل ۴ -->
  <g filter="url(#shadow2)">
    <rect x="560" y="450" width="460" height="220" rx="16" fill="#FFF3E0"/>
    <circle cx="640" cy="530" r="40" fill="#E65100"/>
    <text x="640" y="545" text-anchor="middle" font-family="Vazirmatn" font-size="36" font-weight="bold" fill="white">۴</text>
    <text x="800" y="520" text-anchor="middle" font-family="Vazirmatn" font-size="28" font-weight="bold" fill="#E65100">اصلاح نه تخریب</text>
    <text x="790" y="570" text-anchor="middle" font-family="Vazirmatn" font-size="20" fill="#E65100">درس عراق:</text>
    <text x="790" y="600" text-anchor="middle" font-family="Vazirmatn" font-size="20" fill="#E65100">انحلال کامل = فاجعه</text>
  </g>
  
  <!-- اصل ۵ -->
  <g filter="url(#shadow2)">
    <rect x="60" y="700" width="460" height="220" rx="16" fill="#E0F2F1"/>
    <circle cx="140" cy="780" r="40" fill="#00695C"/>
    <text x="140" y="795" text-anchor="middle" font-family="Vazirmatn" font-size="36" font-weight="bold" fill="white">۵</text>
    <text x="300" y="770" text-anchor="middle" font-family="Vazirmatn" font-size="28" font-weight="bold" fill="#00695C">شفافیت حداکثری</text>
    <text x="290" y="820" text-anchor="middle" font-family="Vazirmatn" font-size="20" fill="#00695C">جلسات علنی</text>
    <text x="290" y="850" text-anchor="middle" font-family="Vazirmatn" font-size="20" fill="#00695C">شفافیت مالی</text>
  </g>
  
  <!-- اصل ۶ -->
  <g filter="url(#shadow2)">
    <rect x="560" y="700" width="460" height="220" rx="16" fill="#FFCDD2"/>
    <circle cx="640" cy="780" r="40" fill="#C62828"/>
    <text x="640" y="795" text-anchor="middle" font-family="Vazirmatn" font-size="36" font-weight="bold" fill="white">۶</text>
    <text x="800" y="770" text-anchor="middle" font-family="Vazirmatn" font-size="28" font-weight="bold" fill="#C62828">فراگیری</text>
    <text x="790" y="820" text-anchor="middle" font-family="Vazirmatn" font-size="20" fill="#C62828">ایران برای</text>
    <text x="790" y="850" text-anchor="middle" font-family="Vazirmatn" font-size="20" fill="#C62828">همه‌ی ایرانیان</text>
  </g>
  
  <!-- شماره -->
  <text x="540" y="1020" text-anchor="middle" font-family="Vazirmatn" font-size="24" fill="rgba(255,255,255,0.5)">۲ / ۶</text>
</svg>
```

### اسلاید ۳ — ۱۰ اقدام فوری

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1080 1080" dir="rtl">
  <defs>
    <linearGradient id="bgGrad3" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#1A237E"/>
      <stop offset="100%" style="stop-color:#283593"/>
    </linearGradient>
  </defs>
  
  <rect width="1080" height="1080" fill="url(#bgGrad3)"/>
  <rect x="0" y="0" width="1080" height="10" fill="#C62828"/>
  <rect x="0" y="1070" width="1080" height="10" fill="#C62828"/>
  
  <!-- عنوان -->
  <text x="540" y="90" text-anchor="middle" font-family="Vazirmatn" font-size="48" font-weight="bold" fill="white">۱۰ اقدام فوری — هفته‌ی اول</text>
  <line x1="300" y1="120" x2="780" y2="120" stroke="#C62828" stroke-width="3"/>
  
  <!-- آیتم‌ها -->
  <g>
    <!-- ستون راست -->
    <g transform="translate(100, 180)">
      <circle cx="40" cy="30" r="28" fill="#2E7D32"/>
      <text x="40" y="40" text-anchor="middle" font-family="Vazirmatn" font-size="24" font-weight="bold" fill="white">۱</text>
      <text x="85" y="38" font-family="Vazirmatn" font-size="24" fill="white">آزادی زندانیان سیاسی</text>
    </g>
    
    <g transform="translate(100, 260)">
      <circle cx="40" cy="30" r="28" fill="#2E7D32"/>
      <text x="40" y="40" text-anchor="middle" font-family="Vazirmatn" font-size="24" font-weight="bold" fill="white">۲</text>
      <text x="85" y="38" font-family="Vazirmatn" font-size="24" fill="white">لغو حجاب اجباری</text>
    </g>
    
    <g transform="translate(100, 340)">
      <circle cx="40" cy="30" r="28" fill="#2E7D32"/>
      <text x="40" y="40" text-anchor="middle" font-family="Vazirmatn" font-size="24" font-weight="bold" fill="white">۳</text>
      <text x="85" y="38" font-family="Vazirmatn" font-size="24" fill="white">رفع فیلترینگ اینترنت</text>
    </g>
    
    <g transform="translate(100, 420)">
      <circle cx="40" cy="30" r="28" fill="#2E7D32"/>
      <text x="40" y="40" text-anchor="middle" font-family="Vazirmatn" font-size="24" font-weight="bold" fill="white">۴</text>
      <text x="85" y="38" font-family="Vazirmatn" font-size="24" fill="white">تعلیق مجازات اعدام</text>
    </g>
    
    <g transform="translate(100, 500)">
      <circle cx="40" cy="30" r="28" fill="#2E7D32"/>
      <text x="40" y="40" text-anchor="middle" font-family="Vazirmatn" font-size="24" font-weight="bold" fill="white">۵</text>
      <text x="85" y="38" font-family="Vazirmatn" font-size="24" fill="white">آزادی فعالیت احزاب</text>
    </g>
    
    <!-- ستون چپ -->
    <g transform="translate(560, 180)">
      <circle cx="40" cy="30" r="28" fill="#2E7D32"/>
      <text x="40" y="40" text-anchor="middle" font-family="Vazirmatn" font-size="24" font-weight="bold" fill="white">۶</text>
      <text x="85" y="38" font-family="Vazirmatn" font-size="24" fill="white">ممنوعیت بازداشت خودسرانه</text>
    </g>
    
    <g transform="translate(560, 260)">
      <circle cx="40" cy="30" r="28" fill="#2E7D32"/>
      <text x="40" y="40" text-anchor="middle" font-family="Vazirmatn" font-size="24" font-weight="bold" fill="white">۷</text>
      <text x="85" y="38" font-family="Vazirmatn" font-size="24" fill="white">لغو محاکم انقلاب</text>
    </g>
    
    <g transform="translate(560, 340)">
      <circle cx="40" cy="30" r="28" fill="#2E7D32"/>
      <text x="40" y="40" text-anchor="middle" font-family="Vazirmatn" font-size="24" font-weight="bold" fill="white">۸</text>
      <text x="85" y="38" font-family="Vazirmatn" font-size="24" fill="white">حق بازگشت تبعیدیان</text>
    </g>
    
    <g transform="translate(560, 420)">
      <circle cx="40" cy="30" r="28" fill="#2E7D32"/>
      <text x="40" y="40" text-anchor="middle" font-family="Vazirmatn" font-size="24" font-weight="bold" fill="white">۹</text>
      <text x="85" y="38" font-family="Vazirmatn" font-size="24" fill="white">مسدودسازی حساب‌های مشکوک</text>
    </g>
    
    <g transform="translate(560, 500)">
      <circle cx="40" cy="30" r="28" fill="#2E7D32"/>
      <text x="40" y="40" text-anchor="middle" font-family="Vazirmatn" font-size="24" font-weight="bold" fill="white">۱۰</text>
      <text x="85" y="38" font-family="Vazirmatn" font-size="24" fill="white">حفاظت از اسناد امنیتی</text>
    </g>
  </g>
  
  <!-- خط جداکننده -->
  <line x1="100" y1="600" x2="980" y2="600" stroke="rgba(255,255,255,0.2)" stroke-width="2"/>
  
  <!-- باکس پایین -->
  <rect x="100" y="650" width="880" height="300" rx="20" fill="rgba(255,255,255,0.1)"/>
  
  <text x="540" y="720" text-anchor="middle" font-family="Vazirmatn" font-size="32" font-weight="bold" fill="#F9A825">بدون نیاز به قانون‌گذاری عادی</text>
  
  <text x="540" y="790" text-anchor="middle" font-family="Vazirmatn" font-size="26" fill="white">این اقدامات با فرمان اضطراری مجلس مهستان</text>
  <text x="540" y="840" text-anchor="middle" font-family="Vazirmatn" font-size="26" fill="white">(رأی اکثریت ساده) صادر می‌شوند</text>
  
  <text x="540" y="910" text-anchor="middle" font-family="Vazirmatn" font-size="22" fill="rgba(255,255,255,0.7)">حقوق بنیادین انسان منتظر هیچ فرایندی نمی‌ماند</text>
  
  <text x="540" y="1020" text-anchor="middle" font-family="Vazirmatn" font-size="24" fill="rgba(255,255,255,0.5)">۳ / ۶</text>
</svg>
```

### اسلاید ۴ — عدالت انتقالی

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1080 1080" dir="rtl">
  <defs>
    <linearGradient id="bgGrad4" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#1A237E"/>
      <stop offset="100%" style="stop-color:#283593"/>
    </linearGradient>
    <filter id="glow">
      <feGaussianBlur stdDeviation="3" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
  
  <rect width="1080" height="1080" fill="url(#bgGrad4)"/>
  <rect x="0" y="0" width="1080" height="10" fill="#6A1B9A"/>
  <rect x="0" y="1070" width="1080" height="10" fill="#6A1B9A"/>
  
  <!-- عنوان -->
  <text x="540" y="90" text-anchor="middle" font-family="Vazirmatn" font-size="52" font-weight="bold" fill="white">۵ ستون عدالت انتقالی</text>
  <line x1="320" y1="130" x2="760" y2="130" stroke="#6A1B9A" stroke-width="3"/>
  
  <!-- ستون مرکزی (بالا) -->
  <g filter="url(#glow)">
    <polygon points="540,180 620,280 460,280" fill="#6A1B9A"/>
  </g>
  <circle cx="540" cy="260" r="50" fill="#F3E5F5" stroke="#6A1B9A" stroke-width="3"/>
  <text x="540" y="250" text-anchor="middle" font-family="Vazirmatn" font-size="18" font-weight="bold" fill="#6A1B9A">عدالت</text>
  <text x="540" y="275" text-anchor="middle" font-family="Vazirmatn" font-size="18" font-weight="bold" fill="#6A1B9A">انتقالی</text>
  
  <!-- ۵ ستون -->
  <!-- ستون ۱: حقیقت‌یابی -->
  <rect x="60" y="340" width="180" height="500" rx="12" fill="#BBDEFB" stroke="#1565C0" stroke-width="2"/>
  <circle cx="150" cy="400" r="35" fill="#1565C0"/>
  <text x="150" y="410" text-anchor="middle" font-family="Vazirmatn" font-size="28" font-weight="bold" fill="white">۱</text>
  <text x="150" y="470" text-anchor="middle" font-family="Vazirmatn" font-size="22" font-weight="bold" fill="#1565C0">حقیقت‌یابی</text>
  <line x1="90" y1="495" x2="210" y2="495" stroke="#1565C0" stroke-width="1"/>
  <text x="150" y="530" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#1565C0">کمیسیون حقیقت</text>
  <text x="150" y="560" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#1565C0">مستندسازی جنایات</text>
  <text x="150" y="590" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#1565C0">ثبت شهادت‌ها</text>
  <text x="150" y="620" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#1565C0">جلسات علنی</text>
  
  <!-- ستون ۲: عدالت کیفری -->
  <rect x="260" y="340" width="180" height="500" rx="12" fill="#FFCDD2" stroke="#C62828" stroke-width="2"/>
  <circle cx="350" cy="400" r="35" fill="#C62828"/>
  <text x="350" y="410" text-anchor="middle" font-family="Vazirmatn" font-size="28" font-weight="bold" fill="white">۲</text>
  <text x="350" y="470" text-anchor="middle" font-family="Vazirmatn" font-size="22" font-weight="bold" fill="#C62828">عدالت کیفری</text>
  <line x1="290" y1="495" x2="410" y2="495" stroke="#C62828" stroke-width="1"/>
  <text x="350" y="530" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#C62828">محاکمات عادلانه</text>
  <text x="350" y="560" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#C62828">تفکیک مسئولیت</text>
  <text x="350" y="590" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#C62828">عفو مشروط</text>
  <text x="350" y="620" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#C62828">دادرسی عادلانه</text>
  
  <!-- ستون ۳: جبران خسارت -->
  <rect x="460" y="340" width="180" height="500" rx="12" fill="#FFF3E0" stroke="#E65100" stroke-width="2"/>
  <circle cx="550" cy="400" r="35" fill="#E65100"/>
  <text x="550" y="410" text-anchor="middle" font-family="Vazirmatn" font-size="28" font-weight="bold" fill="white">۳</text>
  <text x="550" y="470" text-anchor="middle" font-family="Vazirmatn" font-size="22" font-weight="bold" fill="#E65100">جبران خسارت</text>
  <line x1="490" y1="495" x2="610" y2="495" stroke="#E65100" stroke-width="1"/>
  <text x="550" y="530" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#E65100">غرامت مالی</text>
  <text x="550" y="560" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#E65100">اعاده‌ی حیثیت</text>
  <text x="550" y="590" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#E65100">خدمات درمانی</text>
  <text x="550" y="620" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#E65100">بازگرداندن اموال</text>
  
  <!-- ستون ۴: آشتی ملی -->
  <rect x="660" y="340" width="180" height="500" rx="12" fill="#FFF9C4" stroke="#F9A825" stroke-width="2"/>
  <circle cx="750" cy="400" r="35" fill="#F9A825"/>
  <text x="750" y="410" text-anchor="middle" font-family="Vazirmatn" font-size="28" font-weight="bold" fill="white">۴</text>
  <text x="750" y="470" text-anchor="middle" font-family="Vazirmatn" font-size="22" font-weight="bold" fill="#F9A825">آشتی ملی</text>
  <line x1="690" y1="495" x2="810" y2="495" stroke="#F9A825" stroke-width="1"/>
  <text x="750" y="530" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#F9A825">گفتگوهای ملی</text>
  <text x="750" y="560" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#F9A825">موزه‌ها و یادبود</text>
  <text x="750" y="590" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#F9A825">اصلاح تاریخ‌نگاری</text>
  <text x="750" y="620" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#F9A825">روز ملی یادبود</text>
  
  <!-- ستون ۵: عدم تکرار -->
  <rect x="860" y="340" width="180" height="500" rx="12" fill="#C8E6C9" stroke="#2E7D32" stroke-width="2"/>
  <circle cx="950" cy="400" r="35" fill="#2E7D32"/>
  <text x="950" y="410" text-anchor="middle" font-family="Vazirmatn" font-size="28" font-weight="bold" fill="white">۵</text>
  <text x="950" y="470" text-anchor="middle" font-family="Vazirmatn" font-size="22" font-weight="bold" fill="#2E7D32">عدم تکرار</text>
  <line x1="890" y1="495" x2="1010" y2="495" stroke="#2E7D32" stroke-width="1"/>
  <text x="950" y="530" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#2E7D32">اصلاح نهادی</text>
  <text x="950" y="560" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#2E7D32">آموزش حقوق بشر</text>
  <text x="950" y="590" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#2E7D32">نهادهای نظارتی</text>
  <text x="950" y="620" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="#2E7D32">قانون اساسی نوین</text>
  
  <!-- پیام پایین -->
  <rect x="150" y="880" width="780" height="80" rx="15" fill="rgba(255,255,255,0.1)"/>
  <text x="540" y="930" text-anchor="middle" font-family="Vazirmatn" font-size="26" fill="white">عدالت + آشتی = صلح پایدار</text>
  
  <text x="540" y="1020" text-anchor="middle" font-family="Vazirmatn" font-size="24" fill="rgba(255,255,255,0.5)">۴ / ۶</text>
</svg>
```

### اسلاید ۵ — خط زمانی

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1080 1080" dir="rtl">
  <defs>
    <linearGradient id="bgGrad5" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#1A237E"/>
      <stop offset="100%" style="stop-color:#283593"/>
    </linearGradient>
    <linearGradient id="timelineGrad" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" style="stop-color:#C62828"/>
      <stop offset="50%" style="stop-color:#F9A825"/>
      <stop offset="100%" style="stop-color:#2E7D32"/>
    </linearGradient>
  </defs>
  
  <rect width="1080" height="1080" fill="url(#bgGrad5)"/>
  <rect x="0" y="0" width="1080" height="10" fill="#F9A825"/>
  <rect x="0" y="1070" width="1080" height="10" fill="#F9A825"/>
  
  <!-- عنوان -->
  <text x="540" y="80" text-anchor="middle" font-family="Vazirmatn" font-size="52" font-weight="bold" fill="white">خط زمانی گذار</text>
  <text x="540" y="130" text-anchor="middle" font-family="Vazirmatn" font-size="28" fill="#F9A825">حداکثر ۲۴ ماه</text>
  
  <!-- محور زمانی اصلی -->
  <rect x="100" y="200" width="880" height="8" rx="4" fill="url(#timelineGrad)"/>
  
  <!-- نقاط زمانی و فازها -->
  
  <!-- فاز ۱ -->
  <circle cx="150" cy="204" r="20" fill="#E65100" stroke="white" stroke-width="3"/>
  <text x="150" y="212" text-anchor="middle" font-family="Vazirmatn" font-size="18" font-weight="bold" fill="white">۱</text>
  <rect x="70" y="260" width="160" height="180" rx="12" fill="#FFF3E0" stroke="#E65100" stroke-width="2"/>
  <text x="150" y="295" text-anchor="middle" font-family="Vazirmatn" font-size="20" font-weight="bold" fill="#E65100">انتخابات</text>
  <line x1="90" y1="315" x2="210" y2="315" stroke="#E65100" stroke-width="1"/>
  <text x="150" y="345" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#E65100">هفته‌ی ۱-۵</text>
  <text x="150" y="375" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#E65100">ثبت‌نام و تبلیغات</text>
  <text x="150" y="400" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#E65100">رأی‌گیری</text>
  <text x="150" y="425" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#E65100">تشکیل مجلس</text>
  
  <!-- فاز ۲ -->
  <circle cx="300" cy="204" r="20" fill="#C62828" stroke="white" stroke-width="3"/>
  <text x="300" y="212" text-anchor="middle" font-family="Vazirmatn" font-size="18" font-weight="bold" fill="white">۲</text>
  <rect x="220" y="260" width="160" height="180" rx="12" fill="#FFCDD2" stroke="#C62828" stroke-width="2"/>
  <text x="300" y="295" text-anchor="middle" font-family="Vazirmatn" font-size="20" font-weight="bold" fill="#C62828">اقدامات فوری</text>
  <line x1="240" y1="315" x2="360" y2="315" stroke="#C62828" stroke-width="1"/>
  <text x="300" y="345" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#C62828">هفته‌ی ۱-۸</text>
  <text x="300" y="375" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#C62828">فرمان‌های اضطراری</text>
  <text x="300" y="400" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#C62828">تشکیل کابینه</text>
  <text x="300" y="425" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#C62828">مصوبات فوری</text>
  
  <!-- فاز ۳ -->
  <circle cx="450" cy="204" r="20" fill="#6A1B9A" stroke="white" stroke-width="3"/>
  <text x="450" y="212" text-anchor="middle" font-family="Vazirmatn" font-size="18" font-weight="bold" fill="white">۳</text>
  <rect x="370" y="260" width="160" height="180" rx="12" fill="#F3E5F5" stroke="#6A1B9A" stroke-width="2"/>
  <text x="450" y="295" text-anchor="middle" font-family="Vazirmatn" font-size="20" font-weight="bold" fill="#6A1B9A">ق.ا. موقت</text>
  <line x1="390" y1="315" x2="510" y2="315" stroke="#6A1B9A" stroke-width="1"/>
  <text x="450" y="345" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#6A1B9A">هفته‌ی ۱-۱۰</text>
  <text x="450" y="375" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#6A1B9A">تدوین پیش‌نویس</text>
  <text x="450" y="400" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#6A1B9A">بازخوردگیری</text>
  <text x="450" y="425" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#6A1B9A">رفراندوم</text>
  
  <!-- فاز ۴ -->
  <circle cx="600" cy="204" r="20" fill="#1565C0" stroke="white" stroke-width="3"/>
  <text x="600" y="212" text-anchor="middle" font-family="Vazirmatn" font-size="18" font-weight="bold" fill="white">۴</text>
  <rect x="520" y="260" width="160" height="180" rx="12" fill="#BBDEFB" stroke="#1565C0" stroke-width="2"/>
  <text x="600" y="295" text-anchor="middle" font-family="Vazirmatn" font-size="20" font-weight="bold" fill="#1565C0">نهادسازی</text>
  <line x1="540" y1="315" x2="660" y2="315" stroke="#1565C0" stroke-width="1"/>
  <text x="600" y="345" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#1565C0">ماه ۳-۱۸</text>
  <text x="600" y="375" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#1565C0">عدالت انتقالی</text>
  <text x="600" y="400" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#1565C0">اصلاح امنیتی</text>
  <text x="600" y="425" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#1565C0">اصلاح قضایی</text>
  
  <!-- فاز ۵ -->
  <circle cx="780" cy="204" r="20" fill="#00695C" stroke="white" stroke-width="3"/>
  <text x="780" y="212" text-anchor="middle" font-family="Vazirmatn" font-size="18" font-weight="bold" fill="white">۵</text>
  <rect x="700" y="260" width="160" height="180" rx="12" fill="#E0F2F1" stroke="#00695C" stroke-width="2"/>
  <text x="780" y="295" text-anchor="middle" font-family="Vazirmatn" font-size="20" font-weight="bold" fill="#00695C">ق.ا. نهایی</text>
  <line x1="720" y1="315" x2="840" y2="315" stroke="#00695C" stroke-width="1"/>
  <text x="780" y="345" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#00695C">ماه ۶-۱۸</text>
  <text x="780" y="375" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#00695C">مجلس مؤسسان</text>
  <text x="780" y="400" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#00695C">مشاوره‌ی عمومی</text>
  <text x="780" y="425" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#00695C">رفراندوم</text>
  
  <!-- فاز ۶ -->
  <circle cx="930" cy="204" r="20" fill="#2E7D32" stroke="white" stroke-width="3"/>
  <text x="930" y="212" text-anchor="middle" font-family="Vazirmatn" font-size="18" font-weight="bold" fill="white">۶</text>
  <rect x="850" y="260" width="160" height="180" rx="12" fill="#C8E6C9" stroke="#2E7D32" stroke-width="2"/>
  <text x="930" y="295" text-anchor="middle" font-family="Vazirmatn" font-size="20" font-weight="bold" fill="#2E7D32">انتقال قدرت</text>
  <line x1="870" y1="315" x2="990" y2="315" stroke="#2E7D32" stroke-width="1"/>
  <text x="930" y="345" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#2E7D32">ماه ۱۸-۲۴</text>
  <text x="930" y="375" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#2E7D32">انتخابات نهایی</text>
  <text x="930" y="400" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#2E7D32">تشکیل دولت</text>
  <text x="930" y="425" text-anchor="middle" font-family="Vazirmatn" font-size="14" fill="#2E7D32">پایان گذار</text>
  
  <!-- نمودار گذشته ← گذار ← آینده -->
  <g transform="translate(0, 480)">
    <!-- گذشته -->
    <rect x="100" y="0" width="250" height="220" rx="15" fill="#FFCDD2" stroke="#C62828" stroke-width="2"/>
    <text x="225" y="45" text-anchor="middle" font-family="Vazirmatn" font-size="28" font-weight="bold" fill="#C62828">گذشته</text>
    <line x1="140" y1="65" x2="310" y2="65" stroke="#C62828" stroke-width="1"/>
    <text x="225" y="100" text-anchor="middle" font-family="Vazirmatn" font-size="18" fill="#C62828">استبداد دینی</text>
    <text x="225" y="130" text-anchor="middle" font-family="Vazirmatn" font-size="18" fill="#C62828">سرکوب و تبعیض</text>
    <text x="225" y="160" text-anchor="middle" font-family="Vazirmatn" font-size="18" fill="#C62828">فساد سازمان‌یافته</text>
    <text x="225" y="190" text-anchor="middle" font-family="Vazirmatn" font-size="18" fill="#C62828">انزوای بین‌المللی</text>
    
    <!-- فلش ۱ -->
    <polygon points="370,110 400,90 400,130" fill="#F9A825"/>
    
    <!-- گذار -->
    <rect x="415" y="0" width="250" height="220" rx="15" fill="#FFF9C4" stroke="#F9A825" stroke-width="2"/>
    <text x="540" y="45" text-anchor="middle" font-family="Vazirmatn" font-size="28" font-weight="bold" fill="#F9A825">گذار</text>
    <line x1="455" y1="65" x2="625" y2="65" stroke="#F9A825" stroke-width="1"/>
    <text x="540" y="100" text-anchor="middle" font-family="Vazirmatn" font-size="18" fill="#F9A825">مجلس مهستان</text>
    <text x="540" y="130" text-anchor="middle" font-family="Vazirmatn" font-size="18" fill="#F9A825">قانون اساسی موقت</text>
    <text x="540" y="160" text-anchor="middle" font-family="Vazirmatn" font-size="18" fill="#F9A825">عدالت انتقالی</text>
    <text x="540" y="190" text-anchor="middle" font-family="Vazirmatn" font-size="18" fill="#F9A825">اصلاحات نهادی</text>
    
    <!-- فلش ۲ -->
    <polygon points="685,110 715,90 715,130" fill="#2E7D32"/>
    
    <!-- آینده -->
    <rect x="730" y="0" width="250" height="220" rx="15" fill="#C8E6C9" stroke="#2E7D32" stroke-width="2"/>
    <text x="855" y="45" text-anchor="middle" font-family="Vazirmatn" font-size="28" font-weight="bold" fill="#2E7D32">آینده</text>
    <line x1="770" y1="65" x2="940" y2="65" stroke="#2E7D32" stroke-width="1"/>
    <text x="855" y="100" text-anchor="middle" font-family="Vazirmatn" font-size="18" fill="#2E7D32">دموکراسی پایدار</text>
    <text x="855" y="130" text-anchor="middle" font-family="Vazirmatn" font-size="18" fill="#2E7D32">حقوق بشر</text>
    <text x="855" y="160" text-anchor="middle" font-family="Vazirmatn" font-size="18" fill="#2E7D32">رفاه اقتصادی</text>
    <text x="855" y="190" text-anchor="middle" font-family="Vazirmatn" font-size="18" fill="#2E7D32">صلح و همکاری</text>
  </g>
  
  <!-- پیام -->
  <rect x="250" y="750" width="580" height="60" rx="30" fill="rgba(255,255,255,0.15)"/>
  <text x="540" y="790" text-anchor="middle" font-family="Vazirmatn" font-size="26" fill="white">گذار باید پایان داشته باشد</text>
  
  <text x="540" y="1020" text-anchor="middle" font-family="Vazirmatn" font-size="24" fill="rgba(255,255,255,0.5)">۵ / ۶</text>
</svg>
```

### اسلاید ۶ — فراخوان (پایانی)

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1080 1080" dir="rtl">
  <defs>
    <linearGradient id="bgGrad6" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#1A237E"/>
      <stop offset="100%" style="stop-color:#0D47A1"/>
    </linearGradient>
    <filter id="glow2">
      <feGaussianBlur stdDeviation="4" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>
  
  <rect width="1080" height="1080" fill="url(#bgGrad6)"/>
  
  <!-- نوارهای تزئینی -->
  <rect x="0" y="0" width="1080" height="15" fill="#F9A825"/>
  <rect x="0" y="15" width="1080" height="8" fill="#2E7D32"/>
  <rect x="0" y="1057" width="1080" height="8" fill="#2E7D32"/>
  <rect x="0" y="1065" width="1080" height="15" fill="#F9A825"/>
  
  <!-- عنوان با افکت -->
  <g filter="url(#glow2)">
    <text x="540" y="130" text-anchor="middle" font-family="Vazirmatn" font-size="64" font-weight="bold" fill="white">فراخوان</text>
  </g>
  <text x="540" y="190" text-anchor="middle" font-family="Vazirmatn" font-size="32" fill="#F9A825">به همه‌ی ایرانیان آزادیخواه</text>
  
  <!-- خط تزئینی -->
  <line x1="340" y1="230" x2="740" y2="230" stroke="#F9A825" stroke-width="3"/>
  
  <!-- ۴ باکس فراخوان -->
  <!-- جریان‌ها -->
  <rect x="100" y="280" width="420" height="150" rx="15" fill="rgba(255,255,255,0.1)" stroke="#1565C0" stroke-width="2"/>
  <circle cx="180" cy="355" r="45" fill="#1565C0"/>
  <text x="180" y="345" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="white">هر</text>
  <text x="180" y="370" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="white">جریان</text>
  <text x="350" y="340" text-anchor="middle" font-family="Vazirmatn" font-size="22" font-weight="bold" fill="white">قانون اساسی موقت</text>
  <text x="350" y="380" text-anchor="middle" font-family="Vazirmatn" font-size="22" font-weight="bold" fill="white">خود را بنویسید</text>
  
  <!-- شهروندان -->
  <rect x="560" y="280" width="420" height="150" rx="15" fill="rgba(255,255,255,0.1)" stroke="#2E7D32" stroke-width="2"/>
  <circle cx="640" cy="355" r="45" fill="#2E7D32"/>
  <text x="640" y="345" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="white">هر</text>
  <text x="640" y="370" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="white">شهروند</text>
  <text x="810" y="340" text-anchor="middle" font-family="Vazirmatn" font-size="22" font-weight="bold" fill="white">مطالعه کنید</text>
  <text x="810" y="380" text-anchor="middle" font-family="Vazirmatn" font-size="22" font-weight="bold" fill="white">مشارکت کنید</text>
  
  <!-- متخصصان -->
  <rect x="100" y="460" width="420" height="150" rx="15" fill="rgba(255,255,255,0.1)" stroke="#6A1B9A" stroke-width="2"/>
  <circle cx="180" cy="535" r="45" fill="#6A1B9A"/>
  <text x="180" y="525" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="white">هر</text>
  <text x="180" y="550" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="white">متخصص</text>
  <text x="350" y="520" text-anchor="middle" font-family="Vazirmatn" font-size="22" font-weight="bold" fill="white">دانش خود را در خدمت</text>
  <text x="350" y="560" text-anchor="middle" font-family="Vazirmatn" font-size="22" font-weight="bold" fill="white">طراحی گذار بگذارید</text>
  
  <!-- فعالان -->
  <rect x="560" y="460" width="420" height="150" rx="15" fill="rgba(255,255,255,0.1)" stroke="#E65100" stroke-width="2"/>
  <circle cx="640" cy="535" r="45" fill="#E65100"/>
  <text x="640" y="525" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="white">هر</text>
  <text x="640" y="550" text-anchor="middle" font-family="Vazirmatn" font-size="16" fill="white">فعال</text>
  <text x="810" y="520" text-anchor="middle" font-family="Vazirmatn" font-size="22" font-weight="bold" fill="white">مستندسازی را</text>
  <text x="810" y="560" text-anchor="middle" font-family="Vazirmatn" font-size="22" font-weight="bold" fill="white">ادامه دهید</text>
  
  <!-- باکس مرکزی - پیام اصلی -->
  <rect x="150" y="660" width="780" height="140" rx="20" fill="#C8E6C9" stroke="#2E7D32" stroke-width="3"/>
  <text x="540" y="720" text-anchor="middle" font-family="Vazirmatn" font-size="32" font-weight="bold" fill="#1B5E20">تصمیم نهایی درباره‌ی آینده‌ی ایران</text>
  <text x="540" y="770" text-anchor="middle" font-family="Vazirmatn" font-size="32" font-weight="bold" fill="#1B5E20">فقط و فقط با مردم ایران است</text>
  
  <!-- شعار نهایی -->
  <g filter="url(#glow2)">
    <text x="540" y="880" text-anchor="middle" font-family="Vazirmatn" font-size="52" font-weight="bold" fill="#F9A825">«ایران برای همه‌ی ایرانیان»</text>
  </g>
  
  <!-- اطلاعات -->
  <text x="540" y="950" text-anchor="middle" font-family="Vazirmatn" font-size="22" fill="rgba(255,255,255,0.7)">طرح مجلس مهستان — نسخه‌ی ۲.۰</text>
  <text x="540" y="990" text-anchor="middle" font-family="Vazirmatn" font-size="18" fill="rgba(255,255,255,0.5)">اسفند ۱۴۰۴ / فوریه‌ی ۲۰۲۶</text>
  
  <text x="540" y="1030" text-anchor="middle" font-family="Vazirmatn" font-size="24" fill="rgba(255,255,255,0.5)">۶ / ۶</text>
</svg>
```

---

## ۳. SVG متحرک برای ارائه

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 800" dir="rtl">
  <defs>
    <linearGradient id="bgGradAnim" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#1A237E"/>
      <stop offset="100%" style="stop-color:#283593"/>
    </linearGradient>
    
    <!-- فیلتر درخشش -->
    <filter id="glowAnim" x="-50%" y="-50%" width="200%" height="200%">
      <feGaussianBlur stdDeviation="6" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
    
    <!-- انیمیشن پالس -->
    <style>
      @keyframes pulse {
        0%, 100% { transform: scale(1); opacity: 1; }
        50% { transform: scale(1.05); opacity: 0.9; }
      }
      @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
      }
      @keyframes slideIn {
        from { transform: translateX(-50px); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
      }
      @keyframes drawLine {
        from { stroke-dashoffset: 1000; }
        to { stroke-dashoffset: 0; }
      }
      @keyframes countUp {
        from { opacity: 0; }
        to { opacity: 1; }
      }
      @keyframes rotate {
        from { transform: rotate(0deg); }
        to { transform: rotate(360deg); }
      }
      @keyframes blink {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.3; }
      }
      @keyframes flowArrow {
        0% { transform: translateX(0); }
        50% { transform: translateX(10px); }
        100% { transform: translateX(0); }
      }
      
      .pulse { animation: pulse 2s ease-in-out infinite; }
      .fadeIn { animation: fadeIn 1s ease-out forwards; }
      .slideIn { animation: slideIn 0.8s ease-out forwards; }
      .drawLine { 
        stroke-dasharray: 1000;
        animation: drawLine 2s ease-out forwards;
      }
      .countUp { animation: countUp 0.5s ease-out forwards; }
      .blink { animation: blink 1.5s ease-in-out infinite; }
      .flowArrow { animation: flowArrow 1s ease-in-out infinite; }
      
      .delay1 { animation-delay: 0.2s; opacity: 0; }
      .delay2 { animation-delay: 0.4s; opacity: 0; }
      .delay3 { animation-delay: 0.6s; opacity: 0; }
      .delay4 { animation-delay: 0.8s; opacity: 0; }
      .delay5 { animation-delay: 1s; opacity: 0; }
      .delay6 { animation-delay: 1.2s; opacity: 0; }
    </style>
  </defs>
  
  <!-- پس‌زمینه -->
  <rect width="1200" height="800" fill="url(#bgGradAnim)"/>
  
  <!-- خطوط تزئینی متحرک -->
  <line x1="0" y1="0" x2="1200" y2="0" stroke="#F9A825" stroke-width="6" class="drawLine"/>
  <line x1="0" y1="794" x2="1200" y2="794" stroke="#F9A825" stroke-width="6" class="drawLine" style="animation-delay: 0.3s"/>
  
  <!-- عنوان با انیمیشن -->
  <g class="fadeIn">
    <text x="600" y="80" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="48" font-weight="bold" fill="white" filter="url(#glowAnim)">
      طرح مجلس مهستان
    </text>
    <text x="600" y="130" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="24" fill="#F9A825">
      چارچوب نهادی گذار دموکراتیک ایران
    </text>
  </g>
  
  <!-- دایره‌ی مرکزی با پالس -->
  <g transform="translate(600, 320)" class="pulse">
    <circle cx="0" cy="0" r="100" fill="#1565C0" filter="url(#glowAnim)"/>
    <circle cx="0" cy="0" r="85" fill="#1A237E" stroke="#F9A825" stroke-width="3"/>
    <text x="0" y="-10" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="56" font-weight="bold" fill="#F9A825">۳۰۰</text>
    <text x="0" y="30" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="18" fill="white">نماینده</text>
  </g>
  
  <!-- سه باکس اطراف با انیمیشن ورود -->
  <!-- باکس استانی -->
  <g class="slideIn delay1">
    <rect x="150" y="260" width="180" height="120" rx="12" fill="#BBDEFB" stroke="#1565C0" stroke-width="2"/>
    <text x="240" y="310" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="36" font-weight="bold" fill="#1565C0">۲۴۰</text>
    <text x="240" y="350" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="18" fill="#1565C0">کرسی استانی</text>
    <!-- فلش متحرک -->
    <g class="flowArrow">
      <polygon points="340,320 370,310 370,330" fill="#1565C0"/>
    </g>
  </g>
  
  <!-- باکس ملی -->
  <g class="slideIn delay2">
    <rect x="150" y="400" width="180" height="120" rx="12" fill="#FFF9C4" stroke="#F9A825" stroke-width="2"/>
    <text x="240" y="450" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="36" font-weight="bold" fill="#F9A825">۴۰</text>
    <text x="240" y="490" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="18" fill="#F9A825">کرسی ملی</text>
    <g class="flowArrow">
      <polygon points="340,460 370,450 370,470" fill="#F9A825"/>
    </g>
  </g>
  
  <!-- باکس اقلیت‌ها -->
  <g class="slideIn delay3" style="transform-origin: right center;">
    <rect x="870" y="330" width="180" height="120" rx="12" fill="#F3E5F5" stroke="#6A1B9A" stroke-width="2"/>
    <text x="960" y="380" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="36" font-weight="bold" fill="#6A1B9A">۲۰</text>
    <text x="960" y="420" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="18" fill="#6A1B9A">کرسی اقلیت‌ها</text>
    <g class="flowArrow" style="animation-direction: reverse;">
      <polygon points="860,390 830,380 830,400" fill="#6A1B9A"/>
    </g>
  </g>
  
  <!-- خط زمانی متحرک -->
  <g transform="translate(100, 550)">
    <!-- محور -->
    <line x1="0" y1="0" x2="1000" y2="0" stroke="white" stroke-width="4" stroke-linecap="round" class="drawLine" style="animation-delay: 1.5s;"/>
    
    <!-- نقاط با انیمیشن -->
    <g class="fadeIn delay4">
      <circle cx="100" cy="0" r="20" fill="#E65100"/>
      <text x="100" y="6" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="16" font-weight="bold" fill="white">۱</text>
      <text x="100" y="45" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="14" fill="white">انتخابات</text>
    </g>
    
    <g class="fadeIn delay5">
      <circle cx="300" cy="0" r="20" fill="#C62828"/>
      <text x="300" y="6" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="16" font-weight="bold" fill="white">۲</text>
      <text x="300" y="45" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="14" fill="white">اقدامات فوری</text>
    </g>
    
    <g class="fadeIn delay5" style="animation-delay: 1.4s;">
      <circle cx="500" cy="0" r="20" fill="#6A1B9A"/>
      <text x="500" y="6" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="16" font-weight="bold" fill="white">۳</text>
      <text x="500" y="45" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="14" fill="white">ق.ا. موقت</text>
    </g>
    
    <g class="fadeIn" style="animation-delay: 1.6s; opacity: 0;">
      <circle cx="700" cy="0" r="20" fill="#1565C0"/>
      <text x="700" y="6" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="16" font-weight="bold" fill="white">۴</text>
      <text x="700" y="45" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="14" fill="white">نهادسازی</text>
    </g>
    
    <g class="fadeIn" style="animation-delay: 1.8s; opacity: 0;">
      <circle cx="900" cy="0" r="20" fill="#2E7D32"/>
      <text x="900" y="6" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="16" font-weight="bold" fill="white">۶</text>
      <text x="900" y="45" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="14" fill="white">پایان گذار</text>
    </g>
  </g>
  
  <!-- باکس فراخوان با چشمک -->
  <g class="fadeIn" style="animation-delay: 2s; opacity: 0;">
    <rect x="300" y="680" width="600" height="70" rx="35" fill="#C8E6C9" stroke="#2E7D32" stroke-width="3"/>
    <g class="blink">
      <text x="600" y="725" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="28" font-weight="bold" fill="#1B5E20">
        ایران برای همه‌ی ایرانیان
      </text>
    </g>
  </g>
  
  <!-- اطلاعات پایین -->
  <text x="600" y="780" text-anchor="middle" font-family="Vazirmatn, sans-serif" font-size="14" fill="rgba(255,255,255,0.5)">
    طرح مهستان — نسخه‌ی ۲.۰ — اسفند ۱۴۰۴
  </text>
  
</svg>
```

---

## ۴. نسخه‌ی متحرک پیشرفته‌تر (با JavaScript)

```html
<!DOCTYPE html>
<html lang="fa" dir="rtl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>طرح مجلس مهستان — ارائه‌ی متحرک</title>
  <style>
    @font-face {
      font-family: 'Vazirmatn';
      src: url('fonts/Vazirmatn-Regular.ttf') format('truetype');
    }
    
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    
    body {
      font-family: 'Vazirmatn', sans-serif;
      background: linear-gradient(135deg, #1A237E 0%, #283593 100%);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      overflow: hidden;
    }
    
    .container {
      width: 100%;
      max-width: 1200px;
      padding: 20px;
    }
    
    .slide {
      display: none;
      opacity: 0;
      transform: translateY(30px);
      transition: all 0.8s ease;
    }
    
    .slide.active {
      display: block;
      opacity: 1;
      transform: translateY(0);
    }
    
    .title {
      text-align: center;
      color: white;
      margin-bottom: 40px;
    }
    
    .title h1 {
      font-size: 3rem;
      margin-bottom: 10px;
      text-shadow: 0 4px 20px rgba(0,0,0,0.3);
    }
    
    .title h2 {
      font-size: 1.5rem;
      color: #F9A825;
      font-weight: normal;
    }
    
    .center-circle {
      width: 200px;
      height: 200px;
      background: linear-gradient(135deg, #1565C0, #0D47A1);
      border-radius: 50%;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      margin: 0 auto 40px;
      box-shadow: 0 0 60px rgba(21, 101, 192, 0.5);
      animation: pulse 2s ease-in-out infinite;
      border: 4px solid #F9A825;
    }
    
    @keyframes pulse {
      0%, 100% { transform: scale(1); box-shadow: 0 0 60px rgba(21, 101, 192, 0.5); }
      50% { transform: scale(1.05); box-shadow: 0 0 80px rgba(21, 101, 192, 0.7); }
    }
    
    .center-circle .number {
      font-size: 4rem;
      font-weight: bold;
      color: #F9A825;
    }
    
    .center-circle .label {
      font-size: 1.2rem;
      color: white;
    }
    
    .boxes {
      display: flex;
      justify-content: center;
      gap: 30px;
      flex-wrap: wrap;
    }
    
    .box {
      background: rgba(255,255,255,0.1);
      border-radius: 15px;
      padding: 25px;
      text-align: center;
      min-width: 200px;
      backdrop-filter: blur(10px);
      border: 2px solid;
      opacity: 0;
      transform: translateY(30px);
      transition: all 0.6s ease;
    }
    
    .box.visible {
      opacity: 1;
      transform: translateY(0);
    }
    
    .box.blue { border-color: #64B5F6; background: rgba(187, 222, 251, 0.2); }
    .box.yellow { border-color: #FFD54F; background: rgba(255, 249, 196, 0.2); }
    .box.purple { border-color: #BA68C8; background: rgba(243, 229, 245, 0.2); }
    .box.green { border-color: #81C784; background: rgba(200, 230, 201, 0.2); }
    .box.red { border-color: #E57373; background: rgba(255, 205, 210, 0.2); }
    .box.orange { border-color: #FFB74D; background: rgba(255, 243, 224, 0.2); }
    
    .box .number {
      font-size: 2.5rem;
      font-weight: bold;
      margin-bottom: 5px;
    }
    
    .box.blue .number { color: #64B5F6; }
    .box.yellow .number { color: #FFD54F; }
    .box.purple .number { color: #BA68C8; }
    .box.green .number { color: #81C784; }
    .box.red .number { color: #E57373; }
    .box.orange .number { color: #FFB74D; }
    
    .box .label {
      color: white;
      font-size: 1.1rem;
    }
    
    .timeline {
      position: relative;
      margin: 50px 0;
      padding: 20px 0;
    }
    
    .timeline-line {
      position: absolute;
      top: 50%;
      left: 5%;
      right: 5%;
      height: 4px;
      background: linear-gradient(to left, #C62828, #F9A825, #2E7D32);
      border-radius: 2px;
      transform: scaleX(0);
      transform-origin: right;
      transition: transform 1.5s ease;
    }
    
    .timeline-line.animate {
      transform: scaleX(1);
    }
    
    .timeline-points {
      display: flex;
      justify-content: space-around;
      position: relative;
      z-index: 1;
    }
    
    .timeline-point {
      text-align: center;
      opacity: 0;
      transform: translateY(20px);
      transition: all 0.5s ease;
    }
    
    .timeline-point.visible {
      opacity: 1;
      transform: translateY(0);
    }
    
    .timeline-point .dot {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      display: flex;
      justify-content: center;
      align-items: center;
      color: white;
      font-weight: bold;
      margin: 0 auto 10px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.3);
    }
    
    .timeline-point .text {
      color: white;
      font-size: 0.9rem;
    }
    
    .cta-box {
      background: linear-gradient(135deg, #C8E6C9, #A5D6A7);
      border-radius: 20px;
      padding: 30px 50px;
      text-align: center;
      max-width: 800px;
      margin: 40px auto;
      box-shadow: 0 10px 40px rgba(0,0,0,0.2);
      opacity: 0;
      transform: scale(0.9);
      transition: all 0.8s ease;
    }
    
    .cta-box.visible {
      opacity: 1;
      transform: scale(1);
    }
    
    .cta-box h3 {
      color: #1B5E20;
      font-size: 2rem;
      margin-bottom: 10px;
    }
    
    .cta-box p {
      color: #2E7D32;
      font-size: 1.2rem;
    }
    
    .navigation {
      position: fixed;
      bottom: 30px;
      left: 50%;
      transform: translateX(-50%);
      display: flex;
      gap: 15px;
    }
    
    .nav-btn {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      border: 2px solid #F9A825;
      background: rgba(0,0,0,0.3);
      color: #F9A825;
      font-size: 1.5rem;
      cursor: pointer;
      transition: all 0.3s ease;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    
    .nav-btn:hover {
      background: #F9A825;
      color: #1A237E;
    }
    
    .dots {
      display: flex;
      gap: 10px;
      align-items: center;
    }
    
    .dot-indicator {
      width: 12px;
      height: 12px;
      border-radius: 50%;
      background: rgba(255,255,255,0.3);
      cursor: pointer;
      transition: all 0.3s ease;
    }
    
    .dot-indicator.active {
      background: #F9A825;
      transform: scale(1.3);
    }
  </style>
</head>
<body>
  <div class="container">
    <!-- اسلاید ۱ -->
    <div class="slide active" id="slide1">
      <div class="title">
        <h1>طرح مجلس مهستان</h1>
        <h2>چارچوب نهادی گذار دموکراتیک ایران</h2>
      </div>
      
      <div class="center-circle">
        <span class="number">۳۰۰</span>
        <span class="label">نماینده</span>
      </div>
      
      <div class="boxes">
        <div class="box blue">
          <div class="number">۲۴۰</div>
          <div class="label">کرسی استانی</div>
        </div>
        <div class="box yellow">
          <div class="number">۴۰</div>
          <div class="label">کرسی ملی</div>
        </div>
        <div class="box purple">
          <div class="number">۲۰</div>
          <div class="label">کرسی اقلیت‌ها</div>
        </div>
      </div>
    </div>
    
    <!-- اسلاید ۲ -->
    <div class="slide" id="slide2">
      <div class="title">
        <h1>خط زمانی گذار</h1>
        <h2>حداکثر ۲۴ ماه</h2>
      </div>
      
      <div class="timeline">
        <div class="timeline-line"></div>
        <div class="timeline-points">
          <div class="timeline-point">
            <div class="dot" style="background: #E65100;">۱</div>
            <div class="text">انتخابات<br><small>هفته ۵</small></div>
          </div>
          <div class="timeline-point">
            <div class="dot" style="background: #C62828;">۲</div>
            <div class="text">اقدامات فوری<br><small>هفته ۸</small></div>
          </div>
          <div class="timeline-point">
            <div class="dot" style="background: #6A1B9A;">۳</div>
            <div class="text">ق.ا. موقت<br><small>هفته ۱۰</small></div>
          </div>
          <div class="timeline-point">
            <div class="dot" style="background: #1565C0;">۴</div>
            <div class="text">نهادسازی<br><small>ماه ۱۸</small></div>
          </div>
          <div class="timeline-point">
            <div class="dot" style="background: #2E7D32;">۶</div>
            <div class="text">پایان گذار<br><small>ماه ۲۴</small></div>
          </div>
        </div>
      </div>
      
      <div class="cta-box">
        <h3>ایران برای همه‌ی ایرانیان</h3>
        <p>تصمیم نهایی فقط با مردم ایران است</p>
      </div>
    </div>
  </div>
  
  <div class="navigation">
    <button class="nav-btn" onclick="prevSlide()">→</button>
    <div class="dots">
      <div class="dot-indicator active" onclick="goToSlide(0)"></div>
      <div class="dot-indicator" onclick="goToSlide(1)"></div>
    </div>
    <button class="nav-btn" onclick="nextSlide()">←</button>
  </div>
  
  <script>
    let currentSlide = 0;
    const totalSlides = 2;
    
    function showSlide(index) {
      const slides = document.querySelectorAll('.slide');
      const dots = document.querySelectorAll('.dot-indicator');
      
      slides.forEach((slide, i) => {
        slide.classList.remove('active');
        dots[i].classList.remove('active');
      });
      
      slides[index].classList.add('active');
      dots[index].classList.add('active');
      
      // انیمیشن‌های داخل اسلاید
      setTimeout(() => {
        const boxes = slides[index].querySelectorAll('.box');
        boxes.forEach((box, i) => {
          setTimeout(() => box.classList.add('visible'), i * 200);
        });
        
        const timelineLine = slides[index].querySelector('.timeline-line');
        if (timelineLine) {
          setTimeout(() => timelineLine.classList.add('animate'), 300);
        }
        
        const timelinePoints = slides[index].querySelectorAll('.timeline-point');
        timelinePoints.forEach((point, i) => {
          setTimeout(() => point.classList.add('visible'), 800 + i * 200);
        });
        
        const ctaBox = slides[index].querySelector('.cta-box');
        if (ctaBox) {
          setTimeout(() => ctaBox.classList.add('visible'), 1500);
        }
      }, 100);
      
      currentSlide = index;
    }
    
    function nextSlide() {
      showSlide((currentSlide + 1) % totalSlides);
    }
    
    function prevSlide() {
      showSlide((currentSlide - 1 + totalSlides) % totalSlides);
    }
    
    function goToSlide(index) {
      showSlide(index);
    }
    
    // کلیدهای جهت‌نما
    document.addEventListener('keydown', (e) => {
      if (e.key === 'ArrowLeft') nextSlide();
      if (e.key === 'ArrowRight') prevSlide();
    });
    
    // اجرای انیمیشن اولیه
    showSlide(0);
  </script>
</body>
</html>
```

---

## خلاصه‌ی فایل‌های تولیدشده

| فایل | فرمت | کاربرد |
|------|------|--------|
| `infographic-2page.tex` | LaTeX/TikZ | چاپ و PDF با کیفیت بالا |
| `slide-1.svg` تا `slide-6.svg` | SVG استاتیک | اینستاگرام، تلگرام |
| `animated-presentation.svg` | SVG متحرک | وب و ارائه |
| `interactive-presentation.html` | HTML/CSS/JS | ارائه‌ی تعاملی |

برای هرکدام، فونت **Vazirmatn** را در پوشه‌ی `fonts/` قرار دهید.

آیا می‌خواهید نسخه‌های بیشتری (مثلاً ویدیوی متحرک، پوستر A3، یا نسخه‌ی انگلیسی) تهیه کنم؟