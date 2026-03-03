import os,re

from pathlib import Path
import cairosvg  # pip install cairosvg

# 1) Put your SVG strings here (any number of items)
svg_snippets = {
    "c_1_": r"""<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1080 1080" width="1080" height="1080">
  <defs>
    <linearGradient id="bg1" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%" stop-color="#4A148C"/>
      <stop offset="50%" stop-color="#6A1B9A"/>
      <stop offset="100%" stop-color="#311B92"/>
    </linearGradient>
  </defs>
  <rect width="1080" height="1080" fill="url(#bg1)"/>
  <circle cx="100" cy="100" r="200" fill="#7B1FA2" opacity="0.15"/>
  <circle cx="980" cy="980" r="250" fill="#CE93D8" opacity="0.1"/>
  <rect x="80" y="320" width="920" height="440" rx="30" fill="none" stroke="#CE93D8" stroke-width="1.5" opacity="0.3"/>
  <rect x="0" y="0" width="1080" height="6" fill="#2E7D32"/>
  <rect x="0" y="1074" width="1080" height="6" fill="#C62828"/>

  <text x="540" y="230" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="22" fill="#CE93D8" letter-spacing="3">بیانیه‌ی چارچوب نهادی</text>

  <text x="540" y="440" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="68" font-weight="bold" fill="#ffffff">گذار ایران</text>
  <text x="540" y="530" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="68" font-weight="bold" fill="#ffffff">طرح مهستان</text>

  <rect x="390" y="570" width="300" height="3" rx="1.5" fill="#CE93D8"/>

  <text x="540" y="640" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="22" fill="#E1BEE7">ترکیب دموکراسی مستقیم · تخصص‌گرایی · نمایندگی نسبتی</text>
  <text x="540" y="680" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="16" fill="#E1BEE7" opacity="0.7">مبتنی بر تجربه‌ی تطبیقی جهانی</text>

  <rect x="300" y="850" width="480" height="60" rx="30" fill="rgba(255,255,255,0.1)" stroke="#CE93D8" stroke-width="1"/>
  <text x="540" y="890" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="24" font-weight="bold" fill="#ffffff">🇮🇷 ایران برای همه‌ی ایرانیان</text>

  <text x="540" y="970" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#CE93D8" opacity="0.6">⬅ برای مشاهده‌ی کامل طرح، اسلایدها را ورق بزنید</text>
</svg>""",
 "c_2_": r"""<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1080 1080" width="1080" height="1080">
  <defs>
    <linearGradient id="bg2" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0%" stop-color="#1a1a2e"/>
      <stop offset="100%" stop-color="#16213e"/>
    </linearGradient>
  </defs>
  <rect width="1080" height="1080" fill="url(#bg2)"/>
  <rect x="0" y="0" width="8" height="1080" fill="#C62828"/>

  <text x="540" y="80" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="18" fill="#EF9A9A" letter-spacing="2">چرا گذار ضروری است؟</text>
  <text x="540" y="150" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="44" font-weight="bold" fill="#ffffff">۴۵ سال سرکوب نظام‌مند</text>

  <!-- Stat boxes -->
  <rect x="60" y="200" width="460" height="140" rx="16" fill="rgba(198,40,40,0.15)" stroke="#EF5350" stroke-width="1"/>
  <text x="290" y="270" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="48" font-weight="bold" fill="#EF5350">هزاران</text>
  <text x="290" y="310" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="17" fill="#FFCDD2">اعدام سیاسی و عقیدتی</text>
  <text x="290" y="335" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#EF9A9A">از کشتار ۶۷ تا سرکوب ژینا</text>

  <rect x="560" y="200" width="460" height="140" rx="16" fill="rgba(198,40,40,0.15)" stroke="#EF5350" stroke-width="1"/>
  <text x="790" y="270" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="48" font-weight="bold" fill="#EF5350">میلیون‌ها</text>
  <text x="790" y="310" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="17" fill="#FFCDD2">ایرانی آواره و تبعیدی</text>
  <text x="790" y="335" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#EF9A9A">بزرگ‌ترین فرار مغزها در منطقه</text>

  <!-- Problem cards -->
  <rect x="60" y="380" width="480" height="90" rx="12" fill="rgba(255,255,255,0.05)"/>
  <rect x="60" y="380" width="4" height="90" rx="2" fill="#EF5350"/>
  <text x="510" y="415" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="20" font-weight="bold" fill="#ffffff">⛓️ سرکوب سیاسی</text>
  <text x="510" y="445" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#BDBDBD">زندانیان سیاسی · شکنجه · محاکم انقلاب</text>

  <rect x="560" y="380" width="480" height="90" rx="12" fill="rgba(255,255,255,0.05)"/>
  <rect x="560" y="380" width="4" height="90" rx="2" fill="#EF5350"/>
  <text x="1010" y="415" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="20" font-weight="bold" fill="#ffffff">🧕 تبعیض علیه زنان</text>
  <text x="1010" y="445" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#BDBDBD">حجاب اجباری · نابرابری حقوقی</text>

  <rect x="60" y="490" width="480" height="90" rx="12" fill="rgba(255,255,255,0.05)"/>
  <rect x="60" y="490" width="4" height="90" rx="2" fill="#EF5350"/>
  <text x="510" y="525" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="20" font-weight="bold" fill="#ffffff">💸 فساد اقتصادی</text>
  <text x="510" y="555" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#BDBDBD">صدها میلیارد دلار غارت · بنیادها · سپاه</text>

  <rect x="560" y="490" width="480" height="90" rx="12" fill="rgba(255,255,255,0.05)"/>
  <rect x="560" y="490" width="4" height="90" rx="2" fill="#EF5350"/>
  <text x="1010" y="525" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="20" font-weight="bold" fill="#ffffff">🌐 سانسور و فیلترینگ</text>
  <text x="1010" y="555" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#BDBDBD">بدترین رتبه‌ی آزادی اینترنت</text>

  <rect x="60" y="600" width="480" height="90" rx="12" fill="rgba(255,255,255,0.05)"/>
  <rect x="60" y="600" width="4" height="90" rx="2" fill="#EF5350"/>
  <text x="510" y="635" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="20" font-weight="bold" fill="#ffffff">🏳️ سرکوب اقلیت‌ها</text>
  <text x="510" y="665" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#BDBDBD">کُرد · بلوچ · عرب · بهایی · سنی</text>

  <rect x="560" y="600" width="480" height="90" rx="12" fill="rgba(255,255,255,0.05)"/>
  <rect x="560" y="600" width="4" height="90" rx="2" fill="#EF5350"/>
  <text x="1010" y="635" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="20" font-weight="bold" fill="#ffffff">🌍 انزوای بین‌المللی</text>
  <text x="1010" y="665" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#BDBDBD">تحریم · تروریسم · بحران هسته‌ای</text>

  <text x="540" y="1000" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="18" fill="#EF9A9A">وقت تغییر رسیده است · اما چگونه؟ ➡️</text>
</svg>""",
 "c_3_": r"""<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1080 1080" width="1080" height="1080">
  <defs>
    <linearGradient id="bg3" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0%" stop-color="#1B5E20"/>
      <stop offset="100%" stop-color="#0D3B0E"/>
    </linearGradient>
  </defs>
  <rect width="1080" height="1080" fill="url(#bg3)"/>
  <circle cx="540" cy="540" r="400" fill="none" stroke="#A5D6A7" stroke-width="0.5" opacity="0.2"/>
  <circle cx="540" cy="540" r="300" fill="none" stroke="#A5D6A7" stroke-width="0.5" opacity="0.15"/>
  <rect x="0" y="0" width="1080" height="6" fill="#A5D6A7"/>

  <text x="540" y="75" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="18" fill="#A5D6A7" letter-spacing="2">راه‌حل پیشنهادی</text>
  <text x="540" y="150" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="50" font-weight="bold" fill="#ffffff">🏛️ مجلس مهستان</text>
  <text x="540" y="210" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="20" fill="#C8E6C9">یک مجلس مردم‌محور منتخب · نهاد عالی حاکمیت دوران گذار</text>
  <rect x="340" y="235" width="400" height="3" rx="1.5" fill="#A5D6A7" opacity="0.5"/>

  <!-- 3 Features -->
  <rect x="60" y="280" width="300" height="260" rx="20" fill="rgba(255,255,255,0.08)" stroke="#A5D6A7" stroke-width="1"/>
  <text x="210" y="340" text-anchor="middle" font-size="50">🗳️</text>
  <text x="210" y="390" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="22" font-weight="bold" fill="#ffffff">دموکراسی مستقیم</text>
  <text x="210" y="425" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#C8E6C9">ارزش‌ها و خواست مردم</text>
  <text x="210" y="450" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#C8E6C9">از طریق رفراندوم و مشارکت مستقیم</text>

  <rect x="390" y="280" width="300" height="260" rx="20" fill="rgba(255,255,255,0.08)" stroke="#A5D6A7" stroke-width="1"/>
  <text x="540" y="340" text-anchor="middle" font-size="50">🔬</text>
  <text x="540" y="390" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="22" font-weight="bold" fill="#ffffff">تخصص‌گرایی</text>
  <text x="540" y="425" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#C8E6C9">داده‌ها و حقایق علمی</text>
  <text x="540" y="450" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#C8E6C9">از تکنوکرات‌ها و متخصصان برتر</text>

  <rect x="720" y="280" width="300" height="260" rx="20" fill="rgba(255,255,255,0.08)" stroke="#A5D6A7" stroke-width="1"/>
  <text x="870" y="340" text-anchor="middle" font-size="50">⚖️</text>
  <text x="870" y="390" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="22" font-weight="bold" fill="#ffffff">نمایندگی نسبتی</text>
  <text x="870" y="425" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#C8E6C9">هر صدایی شنیده شود</text>
  <text x="870" y="450" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#C8E6C9">سیستم نسبی-فهرستی عادلانه</text>

  <!-- Key Numbers -->
  <rect x="60" y="590" width="220" height="110" rx="16" fill="rgba(165,214,167,0.15)"/>
  <text x="170" y="645" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="44" font-weight="bold" fill="#A5D6A7">۳۰۰</text>
  <text x="170" y="680" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="14" fill="#C8E6C9">نماینده‌ی منتخب</text>

  <rect x="310" y="590" width="220" height="110" rx="16" fill="rgba(165,214,167,0.15)"/>
  <text x="420" y="645" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="44" font-weight="bold" fill="#A5D6A7">۲</text>
  <text x="420" y="680" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="14" fill="#C8E6C9">قانون اساسی</text>

  <rect x="560" y="590" width="220" height="110" rx="16" fill="rgba(165,214,167,0.15)"/>
  <text x="670" y="645" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="44" font-weight="bold" fill="#A5D6A7">۲۴</text>
  <text x="670" y="680" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="14" fill="#C8E6C9">ماه دوره‌ی گذار</text>

  <rect x="810" y="590" width="220" height="110" rx="16" fill="rgba(165,214,167,0.15)"/>
  <text x="920" y="645" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="44" font-weight="bold" fill="#A5D6A7">۵</text>
  <text x="920" y="680" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="14" fill="#C8E6C9">ستون عدالت انتقالی</text>

  <!-- Quote -->
  <rect x="80" y="750" width="920" height="100" rx="16" fill="rgba(255,255,255,0.05)" stroke="#A5D6A7" stroke-width="1"/>
  <text x="540" y="800" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="16" fill="#E8F5E9" font-style="italic">«کیفیت طراحی نهادی دوران گذار، بیش از هر عامل دیگری،</text>
  <text x="540" y="830" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="16" fill="#E8F5E9" font-style="italic">تعیین‌کننده‌ی سرنوشت نظام سیاسی آینده است»</text>

  <text x="540" y="950" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#A5D6A7" opacity="0.6">۳ از ۲۵ · طرح مهستان</text>
</svg>""",
 "c_4_": r"""<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1080 1080" width="1080" height="1080">
  <defs>
    <linearGradient id="bg4" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0%" stop-color="#0D47A1"/>
      <stop offset="100%" stop-color="#1A237E"/>
    </linearGradient>
  </defs>
  <rect width="1080" height="1080" fill="url(#bg4)"/>
  <rect x="0" y="0" width="1080" height="5" fill="#64B5F6"/>

  <text x="540" y="70" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="18" fill="#90CAF9" letter-spacing="2">ترکیب مجلس مهستان</text>
  <text x="540" y="140" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="48" font-weight="bold" fill="#ffffff">۳۰۰ نماینده‌ی منتخب مردم</text>

  <!-- Donut chart -->
  <circle cx="540" cy="400" r="160" fill="none" stroke="#1E88E5" stroke-width="55" stroke-dasharray="804 200" stroke-dashoffset="0"/>
  <circle cx="540" cy="400" r="160" fill="none" stroke="#FFA726" stroke-width="55" stroke-dasharray="200 804" stroke-dashoffset="-804"/>
  <circle cx="540" cy="400" r="160" fill="none" stroke="#EF5350" stroke-width="55" stroke-dasharray="100 904" stroke-dashoffset="-1004"/>
  <circle cx="540" cy="400" r="115" fill="#0D47A1"/>
  <text x="540" y="390" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="44" font-weight="bold" fill="#ffffff">۳۰۰</text>
  <text x="540" y="425" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="16" fill="#90CAF9">کرسی</text>

  <!-- Legend boxes -->
  <rect x="80" y="620" width="280" height="90" rx="12" fill="rgba(30,136,229,0.2)" stroke="#1E88E5" stroke-width="1.5"/>
  <text x="220" y="660" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="34" font-weight="bold" fill="#64B5F6">۲۴۰</text>
  <text x="220" y="695" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="14" fill="#BBDEFB">🔵 کرسی استانی (نسبی)</text>

  <rect x="400" y="620" width="280" height="90" rx="12" fill="rgba(255,167,38,0.2)" stroke="#FFA726" stroke-width="1.5"/>
  <text x="540" y="660" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="34" font-weight="bold" fill="#FFB74D">۴۰</text>
  <text x="540" y="695" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="14" fill="#FFE0B2">🟠 فهرست ملی (سراسری)</text>

  <rect x="720" y="620" width="280" height="90" rx="12" fill="rgba(239,83,80,0.2)" stroke="#EF5350" stroke-width="1.5"/>
  <text x="860" y="660" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="34" font-weight="bold" fill="#EF9A9A">۲۰</text>
  <text x="860" y="695" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="14" fill="#FFCDD2">🔴 تضمینی اقلیت‌ها</text>

  <!-- Gender quota -->
  <rect x="180" y="760" width="720" height="60" rx="14" fill="rgba(206,147,216,0.15)" stroke="#CE93D8" stroke-width="1"/>
  <text x="540" y="800" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="20" fill="#E1BEE7">👩‍💼 حداقل ۳۰٪ تنوع جنسیتی الزامی در فهرست‌ها</text>

  <text x="540" y="900" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="16" fill="#90CAF9">انتخابات مستقیم · سیستم نسبی-فهرستی · عزل با ۴۰٪ آرا · حداکثر ۲ سال</text>
  <text x="540" y="1010" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#64B5F6" opacity="0.5">۴ از ۲۵ · طرح مهستان</text>
</svg>""",
 "c_5_": r"""<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1080 1080" width="1080" height="1080">
  <defs>
    <linearGradient id="bg5" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0%" stop-color="#B71C1C"/>
      <stop offset="100%" stop-color="#880E4F"/>
    </linearGradient>
  </defs>
  <rect width="1080" height="1080" fill="url(#bg5)"/>
  <rect x="0" y="0" width="1080" height="5" fill="#FF8A80"/>

  <text x="540" y="60" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="18" fill="#FF8A80" letter-spacing="2">فرمان‌های اضطراری — هفته‌ی اول</text>
  <text x="540" y="120" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="42" font-weight="bold" fill="#ffffff">⚡ ۱۰ اقدام فوری روز اول</text>

  <!-- 10 action items -->
  <rect x="60" y="170" width="960" height="72" rx="14" fill="rgba(255,255,255,0.1)"/>
  <text x="980" y="215" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="19" font-weight="bold" fill="#ffffff">🔓 آزادی فوری تمام زندانیان سیاسی و عقیدتی</text>

  <rect x="60" y="254" width="960" height="72" rx="14" fill="rgba(255,255,255,0.1)"/>
  <text x="980" y="299" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="19" font-weight="bold" fill="#ffffff">🧕 لغو حجاب اجباری و قوانین کنترل پوشش</text>

  <rect x="60" y="338" width="960" height="72" rx="14" fill="rgba(255,255,255,0.1)"/>
  <text x="980" y="383" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="19" font-weight="bold" fill="#ffffff">🌐 رفع کامل فیلترینگ و سانسور اینترنت</text>

  <rect x="60" y="422" width="960" height="72" rx="14" fill="rgba(255,255,255,0.1)"/>
  <text x="980" y="467" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="19" font-weight="bold" fill="#ffffff">⛔ تعلیق مجازات اعدام</text>

  <rect x="60" y="506" width="960" height="72" rx="14" fill="rgba(255,255,255,0.1)"/>
  <text x="980" y="551" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="19" font-weight="bold" fill="#ffffff">🏛️ آزادی فعالیت احزاب، اتحادیه‌ها و تشکل‌ها</text>

  <rect x="60" y="590" width="960" height="72" rx="14" fill="rgba(255,255,255,0.1)"/>
  <text x="980" y="635" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="19" font-weight="bold" fill="#ffffff">⚖️ ممنوعیت بازداشت بدون حکم قضایی</text>

  <rect x="60" y="674" width="960" height="72" rx="14" fill="rgba(255,255,255,0.1)"/>
  <text x="980" y="719" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="19" font-weight="bold" fill="#ffffff">❌ لغو فوری محاکم انقلاب</text>

  <rect x="60" y="758" width="960" height="72" rx="14" fill="rgba(255,255,255,0.1)"/>
  <text x="980" y="803" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="19" font-weight="bold" fill="#ffffff">✈️ حق بازگشت آزادانه‌ی تبعیدیان</text>

  <rect x="60" y="842" width="960" height="72" rx="14" fill="rgba(255,255,255,0.1)"/>
  <text x="980" y="887" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="19" font-weight="bold" fill="#ffffff">💰 مسدودسازی دارایی‌های مشکوک نهادهای حکومتی</text>

  <rect x="60" y="926" width="960" height="72" rx="14" fill="rgba(255,255,255,0.1)"/>
  <text x="980" y="971" text-anchor="end" font-family="Tahoma,Arial,sans-serif" font-size="19" font-weight="bold" fill="#ffffff">📁 حفاظت از اسناد نهادهای امنیتی</text>

  <text x="540" y="1050" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="15" fill="#FF8A80">بدون نیاز به فرایند قانون‌گذاری عادی · فرمان اضطراری مجلس</text>
</svg>""",
 "c_6_": r"""<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1080 1080" width="1080" height="1080">
  <defs>
    <linearGradient id="bg6" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0%" stop-color="#263238"/>
      <stop offset="100%" stop-color="#1a1a2e"/>
    </linearGradient>
  </defs>
  <rect width="1080" height="1080" fill="url(#bg6)"/>
  <rect x="0" y="0" width="1080" height="5" fill="#FFD54F"/>

  <text x="540" y="65" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="18" fill="#FFD54F" letter-spacing="2">عدالت انتقالی</text>
  <text x="540" y="130" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="42" font-weight="bold" fill="#ffffff">⚖️ مدل ۵ ستونی</text>

  <!-- 5 Pillars -->
  <rect x="30" y="180" width="192" height="360" rx="14" fill="rgba(66,165,245,0.15)" stroke="#42A5F5" stroke-width="1.5"/>
  <text x="126" y="235" text-anchor="middle" font-size="40">🔍</text>
  <text x="126" y="280" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="17" font-weight="bold" fill="#64B5F6">حقیقت‌یابی</text>
  <text x="126" y="310" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">کمیسیون حقیقت و آشتی</text>
  <text x="126" y="330" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">مستندسازی · شهادت</text>
  <text x="126" y="350" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">جلسات علنی</text>
  <text x="126" y="370" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">گزارش نهایی</text>

  <rect x="234" y="180" width="192" height="360" rx="14" fill="rgba(239,83,80,0.15)" stroke="#EF5350" stroke-width="1.5"/>
  <text x="330" y="235" text-anchor="middle" font-size="40">⚔️</text>
  <text x="330" y="280" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="17" font-weight="bold" fill="#EF9A9A">عدالت کیفری</text>
  <text x="330" y="310" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">محاکمات عادلانه</text>
  <text x="330" y="330" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">تفکیک سطوح مسئولیت</text>
  <text x="330" y="350" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">عفو مشروط</text>
  <text x="330" y="370" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">رده‌پایین‌ها</text>

  <rect x="438" y="180" width="192" height="360" rx="14" fill="rgba(255,167,38,0.15)" stroke="#FFA726" stroke-width="1.5"/>
  <text x="534" y="235" text-anchor="middle" font-size="40">💰</text>
  <text x="534" y="280" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="17" font-weight="bold" fill="#FFB74D">جبران خسارت</text>
  <text x="534" y="310" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">غرامت مالی</text>
  <text x="534" y="330" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">اعاده‌ی حیثیت</text>
  <text x="534" y="350" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">درمان روانشناختی</text>
  <text x="534" y="370" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">بازگرداندن اموال</text>

  <rect x="642" y="180" width="192" height="360" rx="14" fill="rgba(255,213,79,0.15)" stroke="#FFD54F" stroke-width="1.5"/>
  <text x="738" y="235" text-anchor="middle" font-size="40">🕊️</text>
  <text x="738" y="280" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="17" font-weight="bold" fill="#FFD54F">آشتی ملی</text>
  <text x="738" y="310" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">گفتگوهای ملی</text>
  <text x="738" y="330" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">موزه‌ها و یادبودها</text>
  <text x="738" y="350" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">اصلاح تاریخ‌نگاری</text>
  <text x="738" y="370" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">روز ملی یادبود</text>

  <rect x="846" y="180" width="192" height="360" rx="14" fill="rgba(102,187,106,0.15)" stroke="#66BB6A" stroke-width="1.5"/>
  <text x="942" y="235" text-anchor="middle" font-size="40">🛡️</text>
  <text x="942" y="280" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="17" font-weight="bold" fill="#81C784">عدم تکرار</text>
  <text x="942" y="310" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">اصلاح امنیتی</text>
  <text x="942" y="330" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">اصلاح قضایی</text>
  <text x="942" y="350" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">آموزش حقوق بشر</text>
  <text x="942" y="370" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#B0BEC5">نهادهای نظارتی</text>

  <!-- Bottom formula -->
  <rect x="100" y="580" width="880" height="90" rx="16" fill="rgba(255,255,255,0.05)" stroke="rgba(255,255,255,0.1)" stroke-width="1"/>
  <text x="540" y="620" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="17" fill="#EF5350">⚖️ عدالت بدون آشتی = انتقام</text>
  <text x="540" y="650" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="17" fill="#FFD54F">🕊️ آشتی بدون عدالت = فراموشی</text>
  <text x="540" y="680" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="19" font-weight="bold" fill="#66BB6A">✅ عدالت + آشتی = صلح پایدار</text>

  <!-- Global examples -->
  <text x="540" y="740" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="15" fill="#78909C">الگوهای جهانی عدالت انتقالی</text>

  <rect x="60" y="770" width="220" height="100" rx="10" fill="rgba(255,255,255,0.05)"/>
  <text x="170" y="810" text-anchor="middle" font-size="28">🇿🇦</text>
  <text x="170" y="840" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="14" font-weight="bold" fill="#ffffff">آفریقای جنوبی</text>
  <text x="170" y="860" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#90A4AE">TRC · عفو مشروط</text>

  <rect x="310" y="770" width="220" height="100" rx="10" fill="rgba(255,255,255,0.05)"/>
  <text x="420" y="810" text-anchor="middle" font-size="28">🇨🇴</text>
  <text x="420" y="840" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="14" font-weight="bold" fill="#ffffff">کلمبیا</text>
  <text x="420" y="860" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#90A4AE">مدل ۵ ستونی · مرکز حافظه</text>

  <rect x="560" y="770" width="220" height="100" rx="10" fill="rgba(255,255,255,0.05)"/>
  <text x="670" y="810" text-anchor="middle" font-size="28">🇨🇱</text>
  <text x="670" y="840" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="14" font-weight="bold" fill="#ffffff">شیلی</text>
  <text x="670" y="860" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#90A4AE">گزارش رتیگ · محاکمات تدریجی</text>

  <rect x="810" y="770" width="220" height="100" rx="10" fill="rgba(255,255,255,0.05)"/>
  <text x="920" y="810" text-anchor="middle" font-size="28">🇩🇪</text>
  <text x="920" y="840" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="14" font-weight="bold" fill="#ffffff">آلمان</text>
  <text x="920" y="860" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="11" fill="#90A4AE">بایگانی اشتازی · یادبودها</text>

  <text x="540" y="1030" text-anchor="middle" font-family="Tahoma,Arial,sans-serif" font-size="13" fill="#78909C" opacity="0.5">۶ از ۲۵ · طرح مهستان</text>
</svg>""",
}

# 2) Output directory
BASE_DIR = Path.cwd()#Path("output_svgs")
BASE_DIR.mkdir(parents=True, exist_ok=True)

# 3) Loop over all snippets, write SVG + PNG
for name, svg_text in svg_snippets.items():
    svg_path = BASE_DIR / f"{name}.svg"
    png_path = BASE_DIR / f"{name}.png"

    # write SVG file
    svg_path.write_text(svg_text, encoding="utf-8")

    # convert SVG -> PNG
    cairosvg.svg2png(
        bytestring=svg_text.encode("utf-8"),
        write_to=str(png_path),
        # output_width=1080,
        # output_height=1080,
    )

    print(f"Created {svg_path} and {png_path}")
