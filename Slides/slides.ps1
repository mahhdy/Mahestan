



# === BATCH 1: Slides 01-05 === Save as UTF-8 BOM ===
Add-Type -AssemblyName System.Drawing
$dir = "D:\Code\Books\Mahestan\Slides"
if(!(Test-Path $dir)){New-Item -ItemType Directory -Path $dir -Force}

function MakeSlide($fname, [scriptblock]$draw){
    $bmp = New-Object System.Drawing.Bitmap(1920,1080)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = 'AntiAlias'
    $g.TextRenderingHint = 'ClearTypeGridFit'
    & $draw $g
    $bmp.Save((Join-Path $dir $fname),[System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose(); $bmp.Dispose()
    Write-Host "Saved $fname" -ForegroundColor Green
}

function GradBG($g,$c1,$c2){
    $b = New-Object System.Drawing.Drawing2D.LinearGradientBrush([System.Drawing.Rectangle]::new(0,0,1920,1080),$c1,$c2,45)
    $g.FillRectangle($b,0,0,1920,1080); $b.Dispose()
}

function RRect($g,$brush,$x,$y,$w,$h,$r){
    $p = New-Object System.Drawing.Drawing2D.GraphicsPath
    $p.AddArc($x,$y,$r,$r,180,90); $p.AddArc($x+$w-$r,$y,$r,$r,270,90)
    $p.AddArc($x+$w-$r,$y+$h-$r,$r,$r,0,90); $p.AddArc($x,$y+$h-$r,$r,$r,90,90)
    $p.CloseFigure(); $g.FillPath($brush,$p); $p.Dispose()
}

function RTL($g,$txt,$font,$brush,$x,$y,$w,$h,$al='Near'){
    $sf = New-Object System.Drawing.StringFormat
    $sf.FormatFlags = [System.Drawing.StringFormatFlags]::DirectionRightToLeft
    $sf.Alignment = [System.Drawing.StringAlignment]::$al
    $sf.LineAlignment = 'Near'
    $g.DrawString($txt,$font,$brush,[System.Drawing.RectangleF]::new($x,$y,$w,$h),$sf)
    $sf.Dispose()
}

function Footer($g,$n){
    $b=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180,0,0,0))
    $g.FillRectangle($b,0,1035,1920,45)
    $f=New-Object System.Drawing.Font("Tahoma",13)
    $w=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    $g.DrawString("$n / 25",$f,$w,40,1043)
    RTL $g "طرح مهستان  —  چارچوب نهادی گذار ایران" $f $w 700 1043 1170 30 'Near'
    $f.Dispose();$w.Dispose();$b.Dispose()
}

$Indigo=[System.Drawing.Color]::FromArgb(255,26,35,126)
$Royal=[System.Drawing.Color]::FromArgb(255,63,81,181)
$Gold=[System.Drawing.Color]::FromArgb(255,255,193,7)
$Teal=[System.Drawing.Color]::FromArgb(255,0,150,136)
$Navy=[System.Drawing.Color]::FromArgb(255,13,71,161)
$Purple=[System.Drawing.Color]::FromArgb(255,103,58,183)
$Green=[System.Drawing.Color]::FromArgb(255,46,125,50)
$Orange=[System.Drawing.Color]::FromArgb(255,230,81,0)
$Pink=[System.Drawing.Color]::FromArgb(255,233,30,99)
$Dk=[System.Drawing.Color]::FromArgb(255,33,33,33)
$Wh=[System.Drawing.Color]::White

# ===================== SLIDE 01 - COVER =====================
MakeSlide "Slide_01_Cover.png" {
    param($g)
    GradBG $g $Indigo $Royal

    # decorative circles
    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(20,255,255,255))
    $g.FillEllipse($tb,-80,600,400,400)
    $g.FillEllipse($tb,1600,-100,350,350)
    $g.FillEllipse($tb,800,700,250,250)
    $tb.Dispose()

    # center card
    $cb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(240,255,255,255))
    RRect $g $cb 260 160 1400 740 40; $cb.Dispose()

    # gold top bar
    $gb=New-Object System.Drawing.SolidBrush($Gold)
    $g.FillRectangle($gb,260,160,1400,14); $gb.Dispose()

    # emoji row
    $ef=New-Object System.Drawing.Font("Segoe UI Emoji",44)
    $db=New-Object System.Drawing.SolidBrush($Dk)
    $icons = @("🏛️","⚖️","🗳️","📜","🕊️")
    for($i=0;$i -lt 5;$i++){
        $ix = 400 + $i * 230
        $ib=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(25,63,81,181))
        RRect $g $ib $ix 210 180 120 20; $ib.Dispose()
        $g.DrawString($icons[$i],$ef,$db,($ix+45),230)
    }
    $ef.Dispose()

    # title
    $tf=New-Object System.Drawing.Font("Tahoma",50,[System.Drawing.FontStyle]::Bold)
    RTL $g "بیانیه‌ی چارچوب نهادی گذار ایران" $tf $db 300 380 1320 80 'Center'
    $tf.Dispose()

    # gold line
    $gp=New-Object System.Drawing.Pen($Gold,4)
    $g.DrawLine($gp,560,480,1360,480); $gp.Dispose()

    # subtitle
    $sf=New-Object System.Drawing.Font("Tahoma",34)
    RTL $g "طرح مجلس مهستان" $sf $db 300 510 1320 55 'Center'
    $sf.Dispose()

    $vf=New-Object System.Drawing.Font("Tahoma",22)
    RTL $g "نسخه‌ی بازنگری‌شده" $vf $db 300 580 1320 40 'Center'
    $vf.Dispose()

    # labels
    $lf=New-Object System.Drawing.Font("Tahoma",15)
    $labels = @("نهادسازی","عدالت","دموکراسی","قانون‌اساسی","صلح و آشتی")
    for($i=0;$i -lt 5;$i++){
        RTL $g $labels[$i] $lf $db (400+$i*230) 670 180 30 'Center'
    }
    $lf.Dispose()

    # website
    $wf=New-Object System.Drawing.Font("Consolas",18)
    $rb=New-Object System.Drawing.SolidBrush($Royal)
    $g.DrawString("MahdiSalem.com",$wf,$rb,830,810); $wf.Dispose();$rb.Dispose()

    $db.Dispose()
    Footer $g 1
}

# ===================== SLIDE 02 - INTRODUCTION =====================
MakeSlide "Slide_02_Introduction.png" {
    param($g)
    GradBG $g $Navy ([System.Drawing.Color]::FromArgb(255,21,101,192))

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,255,255))
    $g.FillEllipse($tb,1500,500,400,400); $g.FillEllipse($tb,-50,100,300,300); $tb.Dispose()

    # header bar
    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(230,255,255,255))
    $g.FillRectangle($hb,0,0,1920,110); $hb.Dispose()

    $hf=New-Object System.Drawing.Font("Tahoma",34,[System.Drawing.FontStyle]::Bold)
    $nb=New-Object System.Drawing.SolidBrush($Navy)
    RTL $g "۱. مقدمه — ایران در مقطعی تاریخی" $hf $nb 80 30 1760 55 'Near'
    $hf.Dispose(); $nb.Dispose()

    # main card
    $mc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(245,255,255,255))
    RRect $g $mc 60 130 1800 880 30; $mc.Dispose()

    # top quote
    $qb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(35,0,150,136))
    RRect $g $qb 100 150 1720 90 18; $qb.Dispose()

    $qf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Italic)
    $tc=New-Object System.Drawing.SolidBrush($Teal)
    RTL $g "تصمیمات امروز، سرنوشت نسل‌های آینده را رقم خواهد زد" $qf $tc 120 175 1680 40 'Center'
    $qf.Dispose(); $tc.Dispose()

    # points
    $bf=New-Object System.Drawing.Font("Tahoma",20)
    $db=New-Object System.Drawing.SolidBrush($Dk)
    $points = @(
        "⚠️  نه تعلل و بی‌عملی کارساز است، نه شتاب و تمامیت‌خواهی",
        "🎯  برای ایرانی آزاد، آباد و چندصدایی باید فرایند گذار را مهندسی کرد",
        "📚  مهندسی گذار بر اساس دروس آموخته‌ی ملی و بین‌المللی",
        "⚖️  خشونت هدفمند تا عبور از ج.ا. قابل درک — فراتر از آن مانع همکاری",
        "💔  همه‌ی اقشار و گروه‌ها هزینه‌های گزاف پرداخت کرده‌اند",
        "🏗️  کیفیت طراحی نهادی = تعیین‌کننده‌ی سرنوشت نظام سیاسی آینده"
    )
    $y = 280
    foreach($p in $points){
        RTL $g $p $bf $db 120 $y 1680 40 'Near'
        $y += 65
    }
    $bf.Dispose()

    # highlight box
    $hlb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,232,245,253))
    RRect $g $hlb 100 700 1720 270 22; $hlb.Dispose()
    $cb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,0,188,212))
    $g.FillRectangle($cb,1770,700,50,270); $cb.Dispose()

    $htf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    $hc=New-Object System.Drawing.SolidBrush($Teal)
    RTL $g "درس اصلی تجربه‌ی جهانی:" $htf $hc 140 720 1600 40 'Near'
    $htf.Dispose(); $hc.Dispose()

    $sf=New-Object System.Drawing.Font("Tahoma",18)
    $lines = @(
        "✅ کشورهای موفق: تونس، آفریقای جنوبی، اسپانیا، لهستان، شیلی",
        "❌ ضدالگوها: لیبی، مصر، عراق — هرج‌ومرج، بازگشت استبداد، جنگ داخلی",
        "💡 تفاوت: آگاهی، فراگیری و اجماع در طراحی نهادی دوران گذار"
    )
    $y = 785
    foreach($l in $lines){
        RTL $g $l $sf $db 140 $y 1590 35 'Near'
        $y += 55
    }
    $sf.Dispose(); $db.Dispose()
    Footer $g 2
}

# ===================== SLIDE 03 - GLOBAL LESSONS =====================
MakeSlide "Slide_03_Global_Lessons.png" {
    param($g)
    GradBG $g $Teal ([System.Drawing.Color]::FromArgb(255,0,121,107))

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,255,255))
    $g.FillEllipse($tb,100,700,300,300); $g.FillEllipse($tb,1500,100,280,280); $tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(230,255,255,255))
    $g.FillRectangle($hb,0,0,1920,105); $hb.Dispose()

    $hf=New-Object System.Drawing.Font("Tahoma",32,[System.Drawing.FontStyle]::Bold)
    $tc=New-Object System.Drawing.SolidBrush($Teal)
    RTL $g "تجربه‌ی جهانی: الگوها و ضدالگوهای گذار" $hf $tc 80 28 1760 50 'Near'
    $hf.Dispose(); $tc.Dispose()

    # SUCCESS card (right)
    $sc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(242,232,245,233))
    RRect $g $sc 980 130 880 430 25; $sc.Dispose()
    $gb=New-Object System.Drawing.SolidBrush($Green)
    $g.FillRectangle($gb,980,130,880,10); $gb.Dispose()

    $tf=New-Object System.Drawing.Font("Tahoma",24,[System.Drawing.FontStyle]::Bold)
    $gn=New-Object System.Drawing.SolidBrush($Green)
    RTL $g "✅ الگوهای موفق" $tf $gn 1000 155 830 40 'Near'
    $tf.Dispose()

    $bf=New-Object System.Drawing.Font("Tahoma",17)
    $db=New-Object System.Drawing.SolidBrush($Dk)
    $success = @(
        "🇿🇦  آفریقای جنوبی — مدل دو قانون اساسی",
        "🇪🇸  اسپانیا — گذار مسالمت‌آمیز از دیکتاتوری",
        "🇵🇱  لهستان — میز گرد ملی و مذاکره",
        "🇨🇱  شیلی — کمیسیون حقیقت‌یابی مؤثر",
        "🇮🇪  ایرلند — مجمع شهروندان نوآورانه",
        "🇹🇳  تونس — گفتگوی ملی چهارجانبه"
    )
    $y=210
    foreach($s in $success){ RTL $g $s $bf $db 1000 $y 830 32 'Near'; $y+=42 }

    # FAILURE card (left)
    $fc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(242,255,235,238))
    RRect $g $fc 60 130 880 430 25; $fc.Dispose()
    $pb=New-Object System.Drawing.SolidBrush($Pink)
    $g.FillRectangle($pb,60,130,880,10); $pb.Dispose()

    $tf2=New-Object System.Drawing.Font("Tahoma",24,[System.Drawing.FontStyle]::Bold)
    $pk=New-Object System.Drawing.SolidBrush($Pink)
    RTL $g "❌ ضدالگوها" $tf2 $pk 80 155 830 40 'Near'
    $tf2.Dispose()

    $fails = @(
        "🇱🇾  لیبی — انحلال کامل = هرج‌ومرج مداوم",
        "🇪🇬  مصر — بازگشت استبداد نظامی",
        "🇮🇶  عراق — اجتثاث فاجعه‌بار، جنگ داخلی",
        "🇸🇾  سوریه — تجزیه و ویرانی",
        "🇾🇪  یمن — فروپاشی کامل دولت"
    )
    $y=210
    foreach($f in $fails){ RTL $g $f $bf $db 80 $y 830 32 'Near'; $y+=48 }

    # LESSONS card (bottom)
    $lc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(250,255,255,255))
    RRect $g $lc 60 590 1800 400 25; $lc.Dispose()

    $ab=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,255,160,0))
    $g.FillRectangle($ab,60,590,14,400); $ab.Dispose()

    $ltf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    $ob=New-Object System.Drawing.SolidBrush($Orange)
    RTL $g "💡 پنج درس کلیدی:" $ltf $ob 100 610 1720 40 'Near'
    $ltf.Dispose(); $ob.Dispose()

    $lbf=New-Object System.Drawing.Font("Tahoma",19)
    $lessons = @(
        "۱.  طراحی نهادی آگاهانه و فراگیر = ضرورت مطلق",
        "۲.  عجله در تصمیمات سرنوشت‌ساز = خطرناک",
        "۳.  حفظ ساختارهای کارآمد موجود با رهبری اصلاح‌شده",
        "۴.  مشارکت واقعی همه‌ی گروه‌ها = کلید موفقیت",
        "۵.  اصول بنیادین حقوق بشر = غیرقابل‌مذاکره"
    )
    $y=670
    foreach($l in $lessons){ RTL $g $l $lbf $db 100 $y 1720 35 'Near'; $y+=55 }
    $bf.Dispose();$lbf.Dispose();$db.Dispose();$gn.Dispose();$pk.Dispose()
    Footer $g 3
}

# ===================== SLIDE 04 - PRINCIPLE 1 =====================
MakeSlide "Slide_04_Principle1_Democracy_Technocracy.png" {
    param($g)
    GradBG $g $Purple ([System.Drawing.Color]::FromArgb(255,74,20,140))

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(20,255,193,7))
    $g.FillEllipse($tb,1550,600,350,350); $g.FillEllipse($tb,-80,300,280,280); $tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100); $hb.Dispose()

    $hf=New-Object System.Drawing.Font("Tahoma",28,[System.Drawing.FontStyle]::Bold)
    $pp=New-Object System.Drawing.SolidBrush($Purple)
    RTL $g "اصل اول: ترکیب دموکراسی مستقیم و تخصص‌گرایی" $hf $pp 80 28 1760 50 'Near'
    $hf.Dispose()

    # quote bar
    $qb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(35,255,255,255))
    RRect $g $qb 60 120 1800 75 18; $qb.Dispose()
    $qf=New-Object System.Drawing.Font("Tahoma",19,[System.Drawing.FontStyle]::Italic)
    $wb=New-Object System.Drawing.SolidBrush($Wh)
    RTL $g "هر تصمیم دو بُعد دارد: بُعد واقعیت و بُعد ارزش — هنر حکمرانی در ترکیب درست این دو است" $qf $wb 80 140 1720 40 'Center'
    $qf.Dispose(); $wb.Dispose()

    # FACT card (right)
    $fc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(245,255,243,224))
    RRect $g $fc 980 220 880 370 22; $fc.Dispose()
    $ob2=New-Object System.Drawing.SolidBrush($Orange)
    $g.FillRectangle($ob2,980,220,880,10); $ob2.Dispose()

    $tf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    $ob3=New-Object System.Drawing.SolidBrush($Orange)
    RTL $g "🔬 بُعد واقعیت — What is" $tf $ob3 1000 245 830 35 'Near'
    $tf.Dispose(); $ob3.Dispose()

    $bf=New-Object System.Drawing.Font("Tahoma",17)
    $db=New-Object System.Drawing.SolidBrush($Dk)
    $facts=@("• داده‌ها و حقایق علمی-تجربی","• تحلیل‌های فنی و تخصصی","• پیامدهای اقتصادی/حقوقی/اجتماعی","• گزینه‌های سیاستی و مزایا/معایب","• منبع: متخصصان و مراکز پژوهشی")
    $y=300
    foreach($f in $facts){ RTL $g $f $bf $db 1000 $y 830 28 'Near'; $y+=40 }

    # VALUE card (left)
    $vc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(245,227,242,253))
    RRect $g $vc 60 220 880 370 22; $vc.Dispose()
    $bl=New-Object System.Drawing.SolidBrush($Royal)
    $g.FillRectangle($bl,60,220,880,10); $bl.Dispose()

    $tf2=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    $bl2=New-Object System.Drawing.SolidBrush($Royal)
    RTL $g "🗳️ بُعد ارزش — What ought to be" $tf2 $bl2 80 245 830 35 'Near'
    $tf2.Dispose(); $bl2.Dispose()

    $vals=@("• تمایلات و ارزش‌های مردم","• آرزوها و ترجیحات ملی","• حق تعیین سرنوشت","• رفراندوم و نظرسنجی مستقیم","• منبع: فقط مراجعه به آرای مردم")
    $y=300
    foreach($v in $vals){ RTL $g $v $bf $db 80 $y 830 28 'Near'; $y+=40 }

    # examples card
    $ec=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $ec 60 620 1800 370 22; $ec.Dispose()

    $etf=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    RTL $g "📌 نمونه‌های موفق جهانی:" $etf $pp 100 640 1680 35 'Near'
    $etf.Dispose()

    $ef=New-Object System.Drawing.Font("Tahoma",17)
    $exs=@(
        "🇮🇪  ایرلند: مجمع شهروندان (انتخاب تصادفی) + متخصصان ← اصلاح قانون اساسی از طریق رفراندوم",
        "🇫🇷  فرانسه: کنوانسیون شهروندی اقلیم — ۱۵۰ شهروند تصادفی + کارشناسان اقلیمی",
        "🇿🇦  آفریقای جنوبی: ۲+ میلیون نظر مردمی + کمیته‌های فنی تخصصی ← قانون اساسی ۱۹۹۶"
    )
    $y=695
    foreach($e in $exs){ RTL $g $e $ef $db 100 $y 1720 32 'Near'; $y+=55 }

    $thf=New-Object System.Drawing.Font("Tahoma",14,[System.Drawing.FontStyle]::Italic)
    $gr=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,120,120,120))
    RTL $g "مبانی نظری: هیوم (هست/باید) • هابرماس (دموکراسی مشورتی) • پتیت (آزادی = عدم سلطه) • لیپهارت (الگوهای دموکراسی)" $thf $gr 100 910 1720 25 'Near'
    $thf.Dispose();$gr.Dispose();$bf.Dispose();$ef.Dispose();$db.Dispose();$pp.Dispose()
    Footer $g 4
}

# ===================== SLIDE 05 - PRINCIPLES 2 & 3 =====================
MakeSlide "Slide_05_Principles2_3.png" {
    param($g)
    GradBG $g $Royal ([System.Drawing.Color]::FromArgb(255,48,63,159))

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,193,7))
    $g.FillEllipse($tb,1500,700,300,300); $g.FillEllipse($tb,50,50,250,250); $tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100); $hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",30,[System.Drawing.FontStyle]::Bold)
    $ib=New-Object System.Drawing.SolidBrush($Indigo)
    RTL $g "اصل دوم و سوم: نمایندگی نسبتی و قانون‌اساسی‌گرایی دو مرحله‌ای" $hf $ib 60 25 1800 55 'Near'
    $hf.Dispose();$ib.Dispose()

    # Principle 2 card (right)
    $c1=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $c1 980 125 880 450 22; $c1.Dispose()
    $bl=New-Object System.Drawing.SolidBrush($Royal)
    $g.FillRectangle($bl,980,125,880,10); $bl.Dispose()

    $tf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    $bl2=New-Object System.Drawing.SolidBrush($Royal)
    RTL $g "🗳️ اصل دوم: نمایندگی نسبتی" $tf $bl2 1000 150 830 35 'Near'
    $tf.Dispose(); $bl2.Dispose()

    $qf=New-Object System.Drawing.Font("Tahoma",16,[System.Drawing.FontStyle]::Italic)
    $gr=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,100,100,100))
    RTL $g "«هیچ صدایی نباید نشنیده بماند»" $qf $gr 1000 195 830 25 'Near'
    $qf.Dispose();$gr.Dispose()

    $bf=New-Object System.Drawing.Font("Tahoma",16)
    $db=New-Object System.Drawing.SolidBrush($Dk)
    $p2=@("✅ نمایندگی عادلانه‌تر همه گروه‌ها","✅ تشویق ائتلاف‌سازی و مذاکره","✅ کاهش ریسک انحصار قدرت","✅ افزایش مشارکت سیاسی","✅ آینه‌ی واقعی جامعه متکثر ایران")
    $y=240
    foreach($p in $p2){ RTL $g $p $bf $db 1000 $y 830 28 'Near'; $y+=38 }

    # thresholds
    $thb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(30,63,81,181))
    RRect $g $thb 1000 440 840 110 15; $thb.Dispose()
    $sf=New-Object System.Drawing.Font("Tahoma",15)
    RTL $g "📊 آستانه استانی: ۳٪  |  فهرست ملی: ۵٪  |  اقلیت‌ها: بدون آستانه" $sf $db 1010 460 820 70 'Near'
    $sf.Dispose()

    # Principle 3 card (left)
    $c2=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $c2 60 125 880 450 22; $c2.Dispose()
    $pp=New-Object System.Drawing.SolidBrush($Purple)
    $g.FillRectangle($pp,60,125,880,10)

    $tf2=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    RTL $g "📜 اصل سوم: دو قانون اساسی" $tf2 $pp 80 150 830 35 'Near'
    $tf2.Dispose()

    $qf2=New-Object System.Drawing.Font("Tahoma",16,[System.Drawing.FontStyle]::Italic)
    $gr2=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,100,100,100))
    RTL $g "«خلأ قانونی خطرناک‌ترین تهدید دوران گذار»" $qf2 $gr2 80 195 830 25 'Near'
    $qf2.Dispose();$gr2.Dispose()

    $p3=@("✅ چارچوب حقوقی از روز اول (قانون اساسی موقت)","✅ حذف فشار زمانی تصمیمات سرنوشت‌ساز","✅ تثبیت اصول غیرقابل‌نقض از ابتدا","✅ فرصت کافی برای بحث عمومی","✅ الگو: آفریقای جنوبی")
    $y=240
    foreach($p in $p3){ RTL $g $p $bf $db 80 $y 830 28 'Near'; $y+=38 }

    # flow visual
    $arb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(30,103,58,183))
    RRect $g $arb 80 440 840 110 15; $arb.Dispose()
    $arf=New-Object System.Drawing.Font("Tahoma",16,[System.Drawing.FontStyle]::Bold)
    RTL $g "قانون اساسی موقت ← مجلس مؤسسان ← قانون اساسی نهایی ← رفراندوم" $arf $pp 95 470 810 60 'Near'
    $arf.Dispose(); $pp.Dispose()

    # bottom principles 4,5,6
    $bc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $bc 60 600 580 390 22; $bc.Dispose()
    $ob=New-Object System.Drawing.SolidBrush($Orange)
    $g.FillRectangle($ob,60,600,580,10); $ob.Dispose()
    $tf3=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    $ob2=New-Object System.Drawing.SolidBrush($Orange)
    RTL $g "🔧 اصل چهارم: اصلاح نه تخریب" $tf3 $ob2 80 625 530 32 'Near'
    $pf=New-Object System.Drawing.Font("Tahoma",15)
    $p4=@("• حفظ ساختارهای کارآمد با رهبری جدید","• جذب نیروهای حرفه‌ای غیرمتخلف","• انحلال فقط ساختارهای ایدئولوژیک","• ضدالگو: اشتباه عراق")
    $y=675
    foreach($p in $p4){ RTL $g $p $pf $db 80 $y 530 25 'Near'; $y+=38 }

    $bc2=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $bc2 670 600 580 390 22; $bc2.Dispose()
    $tl=New-Object System.Drawing.SolidBrush($Teal)
    $g.FillRectangle($tl,670,600,580,10)
    RTL $g "🔍 اصل پنجم: شفافیت حداکثری" $tf3 $tl 690 625 530 32 'Near'
    $p5=@("• جلسات علنی مجلس مهستان","• اسناد و تصمیمات عمومی","• شفافیت مالی همه مقامات","• نهادهای نظارتی مستقل از روز اول")
    $y=675
    foreach($p in $p5){ RTL $g $p $pf $db 690 $y 530 25 'Near'; $y+=38 }

    $bc3=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $bc3 1280 600 580 390 22; $bc3.Dispose()
    $gn=New-Object System.Drawing.SolidBrush($Green)
    $g.FillRectangle($gn,1280,600,580,10)
    RTL $g "🌈 اصل ششم: فراگیری" $tf3 $gn 1300 625 530 32 'Near'
    $p6=@("• ایران برای همه‌ی ایرانیان","• هیچ گروهی حذف نمی‌شود","• برابری جنسیتی کامل","• حقوق بنیادین بشر غیرقابل‌نقض")
    $y=675
    foreach($p in $p6){ RTL $g $p $pf $db 1300 $y 530 25 'Near'; $y+=38 }

    $tf3.Dispose();$pf.Dispose();$bf.Dispose();$db.Dispose();$ob2.Dispose();$tl.Dispose();$gn.Dispose()
    Footer $g 5
}

Write-Host "`n=== BATCH 1 DONE: Slides 01-05 ===" -ForegroundColor Cyan
# === BATCH 2: Slides 06-10 - Assembly Structure ===
Add-Type -AssemblyName System.Drawing
$dir = "D:\Code\Books\Mahestan\Slides"
if(!(Test-Path $dir)){New-Item -ItemType Directory -Path $dir -Force}

$Indigo=[System.Drawing.Color]::FromArgb(255,26,35,126)
$Royal=[System.Drawing.Color]::FromArgb(255,63,81,181)
$Gold=[System.Drawing.Color]::FromArgb(255,255,193,7)
$Amber=[System.Drawing.Color]::FromArgb(255,255,160,0)
$Teal=[System.Drawing.Color]::FromArgb(255,0,150,136)
$Cyan=[System.Drawing.Color]::FromArgb(255,0,188,212)
$Purple=[System.Drawing.Color]::FromArgb(255,103,58,183)
$Pink=[System.Drawing.Color]::FromArgb(255,233,30,99)
$Wh=[System.Drawing.Color]::White
$Dk=[System.Drawing.Color]::FromArgb(255,33,33,33)
$Navy=[System.Drawing.Color]::FromArgb(255,13,71,161)
$Green=[System.Drawing.Color]::FromArgb(255,46,125,50)
$Orange=[System.Drawing.Color]::FromArgb(255,230,81,0)

function MakeSlide($fname,[scriptblock]$draw){
    $bmp=New-Object System.Drawing.Bitmap(1920,1080)
    $g=[System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode='AntiAlias';$g.TextRenderingHint='ClearTypeGridFit'
    & $draw $g
    $bmp.Save((Join-Path $dir $fname),[System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose();$bmp.Dispose()
    Write-Host "Saved $fname" -ForegroundColor Green
}
function GradBG($g,$c1,$c2){$b=New-Object System.Drawing.Drawing2D.LinearGradientBrush([System.Drawing.Rectangle]::new(0,0,1920,1080),$c1,$c2,45);$g.FillRectangle($b,0,0,1920,1080);$b.Dispose()}
function RRect($g,$brush,$x,$y,$w,$h,$r){$p=New-Object System.Drawing.Drawing2D.GraphicsPath;$p.AddArc($x,$y,$r,$r,180,90);$p.AddArc($x+$w-$r,$y,$r,$r,270,90);$p.AddArc($x+$w-$r,$y+$h-$r,$r,$r,0,90);$p.AddArc($x,$y+$h-$r,$r,$r,90,90);$p.CloseFigure();$g.FillPath($brush,$p);$p.Dispose()}
function RTL($g,$txt,$font,$brush,$x,$y,$w,$h,$al='Near'){$sf=New-Object System.Drawing.StringFormat;$sf.FormatFlags=[System.Drawing.StringFormatFlags]::DirectionRightToLeft;$sf.Alignment=[System.Drawing.StringAlignment]::$al;$sf.LineAlignment='Near';$g.DrawString($txt,$font,$brush,[System.Drawing.RectangleF]::new($x,$y,$w,$h),$sf);$sf.Dispose()}
function Footer($g,$n){$b=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180,0,0,0));$g.FillRectangle($b,0,1035,1920,45);$f=New-Object System.Drawing.Font("Tahoma",13);$w=New-Object System.Drawing.SolidBrush($Wh);$g.DrawString("$n / 25",$f,$w,40,1043);RTL $g "طرح مهستان — چارچوب نهادی گذار ایران" $f $w 700 1043 1170 30 'Near';$f.Dispose();$w.Dispose();$b.Dispose()}

# ===================== SLIDE 06 - MAHESTAN OVERVIEW =====================
MakeSlide "Slide_06_Mahestan_Overview.png" {
    param($g)
    GradBG $g ([System.Drawing.Color]::FromArgb(255,0,77,64)) $Teal

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(20,255,255,255))
    $g.FillEllipse($tb,1500,-80,400,400);$g.FillEllipse($tb,-100,600,350,350);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,105);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",32,[System.Drawing.FontStyle]::Bold)
    $tc=New-Object System.Drawing.SolidBrush($Teal)
    RTL $g "🏛️ مجلس مهستان — نهاد محوری گذار" $hf $tc 80 28 1760 55 'Near'
    $hf.Dispose();$tc.Dispose()

    # main card
    $mc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $mc 60 125 1800 880 30;$mc.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # center icon
    $ef=New-Object System.Drawing.Font("Segoe UI Emoji",70)
    $g.DrawString("🏛️",$ef,$db,860,150);$ef.Dispose()

    $tf=New-Object System.Drawing.Font("Tahoma",26,[System.Drawing.FontStyle]::Bold)
    RTL $g "مجلس مردم‌محور منتخب — ۳۰۰ نماینده" $tf $db 200 270 1520 45 'Center'
    $tf.Dispose()

    # 3 info boxes
    $bf=New-Object System.Drawing.Font("Tahoma",17)

    # box 1
    $b1=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40,63,81,181))
    RRect $g $b1 1280 350 540 280 20;$b1.Dispose()
    $bl=New-Object System.Drawing.SolidBrush($Royal)
    $tf2=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    RTL $g "🗳️ انتخابات" $tf2 $bl 1300 365 500 35 'Near'
    $items1=@("• سیستم نسبی-فهرستی","• غیرمتمرکز توسط فرمانداری‌ها","• ناظران داخلی و بین‌المللی","• تشکیل ظرف ۱ هفته پس از رأی‌گیری")
    $y=410
    foreach($i in $items1){RTL $g $i $bf $db 1300 $y 500 28 'Near';$y+=38}

    # box 2
    $b2=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40,0,150,136))
    RRect $g $b2 690 350 540 280 20;$b2.Dispose()
    $tl=New-Object System.Drawing.SolidBrush($Teal)
    RTL $g "⚙️ ساختار" $tf2 $tl 710 365 500 35 'Near'
    $items2=@("• هیأت رئیسه منتخب","• ۱۱ کمیسیون تخصصی دائمی","• مرکز تحقیقات (بازوی تکنوکراتیک)","• واحد مردمی (بازوی دموکراتیک)")
    $y=410
    foreach($i in $items2){RTL $g $i $bf $db 710 $y 500 28 'Near';$y+=38}

    # box 3
    $b3=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40,103,58,183))
    RRect $g $b3 100 350 540 280 20;$b3.Dispose()
    $pp=New-Object System.Drawing.SolidBrush($Purple)
    RTL $g "📋 مأموریت‌ها" $tf2 $pp 120 365 500 35 'Near'
    $items3=@("• تصویب قانون اساسی موقت","• تشکیل کابینه اجرایی","• نهادسازی عدالت انتقالی","• آماده‌سازی قانون اساسی نهایی")
    $y=410
    foreach($i in $items3){RTL $g $i $bf $db 120 $y 500 28 'Near';$y+=38}

    # timeline bar
    $ab=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,255,243,224))
    RRect $g $ab 100 670 1720 130 20;$ab.Dispose()
    $ob=New-Object System.Drawing.SolidBrush($Orange)
    $g.FillRectangle($ob,100,670,1720,8);$ob.Dispose()

    $tf3=New-Object System.Drawing.Font("Tahoma",19,[System.Drawing.FontStyle]::Bold)
    $ob2=New-Object System.Drawing.SolidBrush($Orange)
    RTL $g "⏱️ حداکثر مدت: ۲ سال  |  انتخابات مجدد ۲ ماه قبل از پایان" $tf3 $ob2 120 695 1680 35 'Near'
    $tf3.Dispose();$ob2.Dispose()

    $sf=New-Object System.Drawing.Font("Tahoma",16)
    RTL $g "رأی‌گیری مجدد ← قانون اساسی نهایی ← انتخابات نظام جدید ← انتقال رسمی قدرت" $sf $db 120 740 1680 30 'Near'
    $sf.Dispose()

    # bottom key points
    $kb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(30,46,125,50))
    RRect $g $kb 100 830 1720 140 18;$kb.Dispose()
    $gn=New-Object System.Drawing.SolidBrush($Green)
    $kf=New-Object System.Drawing.Font("Tahoma",17,[System.Drawing.FontStyle]::Bold)
    RTL $g "نکات کلیدی:" $kf $gn 120 845 300 30 'Near';$kf.Dispose()
    $items_k=@("✅ هر جریان باید پیش‌نویس قانون اساسی موقت خود را منتشر کند","✅ حداقل ۳۰٪ تنوع جنسیتی در فهرست‌ها الزامی  |  ✅ ۲۰ کرسی تضمینی اقلیت‌ها")
    $y=880
    foreach($k in $items_k){RTL $g $k $bf $db 120 $y 1680 28 'Near';$y+=38}

    $tf2.Dispose();$bf.Dispose();$db.Dispose();$bl.Dispose();$tl.Dispose();$pp.Dispose();$gn.Dispose()
    Footer $g 6
}

# === SLIDE 07 COMPLETE - 300 Seats Composition ===
Add-Type -AssemblyName System.Drawing
$dir = "D:\Code\Books\Mahestan\Slides"
if(!(Test-Path $dir)){New-Item -ItemType Directory -Path $dir -Force}

$Indigo=[System.Drawing.Color]::FromArgb(255,26,35,126);$Royal=[System.Drawing.Color]::FromArgb(255,63,81,181);$Gold=[System.Drawing.Color]::FromArgb(255,255,193,7);$Teal=[System.Drawing.Color]::FromArgb(255,0,150,136);$Purple=[System.Drawing.Color]::FromArgb(255,103,58,183);$Pink=[System.Drawing.Color]::FromArgb(255,233,30,99);$Wh=[System.Drawing.Color]::White;$Dk=[System.Drawing.Color]::FromArgb(255,33,33,33);$Navy=[System.Drawing.Color]::FromArgb(255,13,71,161);$Green=[System.Drawing.Color]::FromArgb(255,46,125,50);$Orange=[System.Drawing.Color]::FromArgb(255,230,81,0)

function GradBG($g,$c1,$c2){$b=New-Object System.Drawing.Drawing2D.LinearGradientBrush([System.Drawing.Rectangle]::new(0,0,1920,1080),$c1,$c2,45);$g.FillRectangle($b,0,0,1920,1080);$b.Dispose()}
function RRect($g,$brush,$x,$y,$w,$h,$r){$p=New-Object System.Drawing.Drawing2D.GraphicsPath;$p.AddArc($x,$y,$r,$r,180,90);$p.AddArc($x+$w-$r,$y,$r,$r,270,90);$p.AddArc($x+$w-$r,$y+$h-$r,$r,$r,0,90);$p.AddArc($x,$y+$h-$r,$r,$r,90,90);$p.CloseFigure();$g.FillPath($brush,$p);$p.Dispose()}
function RTL($g,$txt,$font,$brush,$x,$y,$w,$h,$al='Near'){$sf=New-Object System.Drawing.StringFormat;$sf.FormatFlags=[System.Drawing.StringFormatFlags]::DirectionRightToLeft;$sf.Alignment=[System.Drawing.StringAlignment]::$al;$sf.LineAlignment='Near';$g.DrawString($txt,$font,$brush,[System.Drawing.RectangleF]::new($x,$y,$w,$h),$sf);$sf.Dispose()}
function Footer($g,$n){$b=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180,0,0,0));$g.FillRectangle($b,0,1035,1920,45);$f=New-Object System.Drawing.Font("Tahoma",13);$w=New-Object System.Drawing.SolidBrush($Wh);$g.DrawString("$n / 25",$f,$w,40,1043);RTL $g "طرح مهستان — چارچوب نهادی گذار ایران" $f $w 700 1043 1170 30 'Near';$f.Dispose();$w.Dispose();$b.Dispose()}

# Create slide
$bmp = New-Object System.Drawing.Bitmap(1920,1080)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = 'AntiAlias'
$g.TextRenderingHint = 'ClearTypeGridFit'

# Background
GradBG $g $Royal $Indigo

# Decorative circles
$tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(22,255,255,255))
$g.FillEllipse($tb,1400,500,400,400)
$g.FillEllipse($tb,100,700,300,300)
$tb.Dispose()

# Header bar
$hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
$g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
$hf=New-Object System.Drawing.Font("Tahoma",30,[System.Drawing.FontStyle]::Bold)
$ib=New-Object System.Drawing.SolidBrush($Indigo)
RTL $g "ترکیب مجلس مهستان: ۳۰۰ نماینده" $hf $ib 80 26 1760 50 'Near'
$hf.Dispose();$ib.Dispose()

$db=New-Object System.Drawing.SolidBrush($Dk)

# ============================
# Card 1 - 240 Provincial (right side in RTL)
# ============================
$c1=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
RRect $g $c1 60 125 580 550 25;$c1.Dispose()
$bl=New-Object System.Drawing.SolidBrush($Royal)
$g.FillRectangle($bl,60,125,580,12);$bl.Dispose()

$nf=New-Object System.Drawing.Font("Tahoma",56,[System.Drawing.FontStyle]::Bold)
$bl2=New-Object System.Drawing.SolidBrush($Royal)
RTL $g "۲۴۰" $nf $bl2 80 160 540 80 'Center'
$nf.Dispose()

$tf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
RTL $g "کرسی استانی" $tf $bl2 80 255 540 35 'Center'
$tf.Dispose();$bl2.Dispose()

$bf=New-Object System.Drawing.Font("Tahoma",16)
$items1=@(
    "• بر اساس جمعیت هر استان",
    "• سیستم نسبی-فهرستی",
    "• حداقل ۳ کرسی برای هر استان",
    "• آستانه‌ی ورود: ۳٪",
    "• تضمین صدای همه‌ی مناطق",
    "• نمایندگی عادلانه‌ی جغرافیایی"
)
$y=320
foreach($i in $items1){RTL $g $i $bf $db 80 $y 530 26 'Near';$y+=40}

# ============================
# Card 2 - 40 National (center)
# ============================
$c2=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
RRect $g $c2 670 125 580 550 25;$c2.Dispose()
$tl=New-Object System.Drawing.SolidBrush($Teal)
$g.FillRectangle($tl,670,125,580,12)

$nf2=New-Object System.Drawing.Font("Tahoma",56,[System.Drawing.FontStyle]::Bold)
RTL $g "۴۰" $nf2 $tl 690 160 540 80 'Center'
$nf2.Dispose()

$tf2=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
RTL $g "فهرست ملی" $tf2 $tl 690 255 540 35 'Center'
$tf2.Dispose();$tl.Dispose()

$items2=@(
    "• برای جریان‌های سراسری",
    "• سیستم نسبی",
    "• آستانه‌ی ورود: ۵٪",
    "• تشویق تشکیل جریان‌های فراگیر",
    "• ترکیب دیدگاه ملی و محلی"
)
$y=320
foreach($i in $items2){RTL $g $i $bf $db 690 $y 530 26 'Near';$y+=40}

# ============================
# Card 3 - 20 Minority (left side in RTL)
# ============================
$c3=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
RRect $g $c3 1280 125 580 550 25;$c3.Dispose()
$gn=New-Object System.Drawing.SolidBrush($Green)
$g.FillRectangle($gn,1280,125,580,12)

$nf3=New-Object System.Drawing.Font("Tahoma",56,[System.Drawing.FontStyle]::Bold)
RTL $g "۲۰" $nf3 $gn 1300 160 540 80 'Center'
$nf3.Dispose()

$tf3=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
RTL $g "کرسی تضمینی اقلیت‌ها" $tf3 $gn 1300 255 540 35 'Center'
$tf3.Dispose();$gn.Dispose()

$items3=@(
    "• اقلیت‌های قومی و زبانی",
    "• اقلیت‌های مذهبی",
    "• انتخاب توسط خود اقلیت‌ها",
    "• تضمین حضور هر صدای متفاوت",
    "• بدون آستانه‌ی ورود"
)
$y=320
foreach($i in $items3){RTL $g $i $bf $db 1300 $y 530 26 'Near';$y+=40}

# ============================
# Visual proportional bar chart
# ============================
$barY=710
$barH=55
$totalW=1620
$startX=190

# Bar background
$barBg=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(30,0,0,0))
RRect $g $barBg $startX $barY $totalW $barH 10;$barBg.Dispose()

# 240/300 = 80% of totalW = 1296
$w240 = [int]($totalW * 240 / 300)
# 40/300 = 13.3% = 216
$w40 = [int]($totalW * 40 / 300)
# 20/300 = 6.7% = 108
$w20 = $totalW - $w240 - $w40

# Draw from right to left (RTL)
$xPos = $startX

# Green - 20
$barBrush3=New-Object System.Drawing.SolidBrush($Green)
RRect $g $barBrush3 $xPos $barY $w20 $barH 10
$barBrush3.Dispose()

# Teal - 40
$barBrush2=New-Object System.Drawing.SolidBrush($Teal)
RRect $g $barBrush2 ($xPos+$w20) $barY $w40 $barH 0
$barBrush2.Dispose()

# Royal Blue - 240
$barBrush1=New-Object System.Drawing.SolidBrush($Royal)
RRect $g $barBrush1 ($xPos+$w20+$w40) $barY $w240 $barH 10
$barBrush1.Dispose()

# Labels on the bars
$lf=New-Object System.Drawing.Font("Tahoma",15,[System.Drawing.FontStyle]::Bold)
$wb=New-Object System.Drawing.SolidBrush($Wh)

# Label for 240
$label240X = $xPos + $w20 + $w40 + ($w240/2) - 60
$g.DrawString("240 (80%)",$lf,$wb,[float]$label240X,[float]($barY+16))

# Label for 40
$label40X = $xPos + $w20 + ($w40/2) - 30
$g.DrawString("40 (13%)",$lf,$wb,[float]$label40X,[float]($barY+16))

# Label for 20
$label20X = $xPos + ($w20/2) - 25
$smallF=New-Object System.Drawing.Font("Tahoma",12,[System.Drawing.FontStyle]::Bold)
$g.DrawString("20 (7%)",$smallF,$wb,[float]$label20X,[float]($barY+18))
$smallF.Dispose()

$lf.Dispose();$wb.Dispose()

# ============================
# Legend under bar
# ============================
$legendY = $barY + 65
$legendFont=New-Object System.Drawing.Font("Tahoma",14)

# Blue legend
$lb1=New-Object System.Drawing.SolidBrush($Royal)
$g.FillRectangle($lb1,1560,$legendY,22,22);$lb1.Dispose()
RTL $g "کرسی استانی" $legendFont $db 1400 $legendY 150 22 'Near'

# Teal legend
$lb2=New-Object System.Drawing.SolidBrush($Teal)
$g.FillRectangle($lb2,1160,$legendY,22,22);$lb2.Dispose()
RTL $g "فهرست ملی" $legendFont $db 1000 $legendY 150 22 'Near'

# Green legend
$lb3=New-Object System.Drawing.SolidBrush($Green)
$g.FillRectangle($lb3,760,$legendY,22,22);$lb3.Dispose()
RTL $g "اقلیت‌ها" $legendFont $db 620 $legendY 130 22 'Near'

$legendFont.Dispose()

# ============================
# Gender quota card
# ============================
$gqb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
RRect $g $gqb 60 830 1800 170 22;$gqb.Dispose()

# Pink top bar
$pkb=New-Object System.Drawing.SolidBrush($Pink)
$g.FillRectangle($pkb,60,830,1800,10);$pkb.Dispose()

# Gender icon area
$pinkCircle=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40,233,30,99))
$g.FillEllipse($pinkCircle,1740,855,80,80);$pinkCircle.Dispose()
$ef=New-Object System.Drawing.Font("Segoe UI Emoji",32)
$g.DrawString("👩‍💼",$ef,$db,1750,870);$ef.Dispose()

# Title
$gtf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
$pk2=New-Object System.Drawing.SolidBrush($Pink)
RTL $g "الزام حداقل ۳۰٪ تنوع جنسیتی در فهرست‌های انتخاباتی" $gtf $pk2 100 858 1620 35 'Near'
$gtf.Dispose();$pk2.Dispose()

# Description line 1
$gdf=New-Object System.Drawing.Font("Tahoma",17)
RTL $g "هر فهرست انتخاباتی باید حداقل ۳۰٪ زنان یا مردان را شامل شود — تضمین مشارکت برابر جنسیتی" $gdf $db 100 905 1620 30 'Near'

# Description line 2
$grayBr=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,100,100,100))
$goalFont=New-Object System.Drawing.Font("Tahoma",15,[System.Drawing.FontStyle]::Italic)
RTL $g "هدف بلندمدت: رسیدن به ۵۰٪ نمایندگی زنان در نهادهای تصمیم‌گیری — برابری واقعی" $goalFont $grayBr 100 945 1620 28 'Near'
$goalFont.Dispose();$grayBr.Dispose()

# Visual: 30% indicator bar
$indBarX = 100
$indBarY = 980
$indBarW = 600
$indBarH = 12

$indBg=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40,233,30,99))
RRect $g $indBg $indBarX $indBarY $indBarW $indBarH 6;$indBg.Dispose()

$indFill=New-Object System.Drawing.SolidBrush($Pink)
$fillW = [int]($indBarW * 0.3)
RRect $g $indFill $indBarX $indBarY $fillW $indBarH 6;$indFill.Dispose()

$indLabel=New-Object System.Drawing.Font("Tahoma",11,[System.Drawing.FontStyle]::Bold)
$pkLabel=New-Object System.Drawing.SolidBrush($Pink)
$g.DrawString("30%",$indLabel,$pkLabel,($indBarX+$fillW+5),($indBarY-3))

# Target marker at 50%
$targetX = $indBarX + [int]($indBarW * 0.5)
$targetPen=New-Object System.Drawing.Pen($Pink,2)
$targetPen.DashStyle = [System.Drawing.Drawing2D.DashStyle]::Dash
$g.DrawLine($targetPen,$targetX,$indBarY,$targetX,($indBarY+$indBarH))
$targetPen.Dispose()
$g.DrawString("50%",$indLabel,$pkLabel,($targetX+3),($indBarY-3))

$indLabel.Dispose();$pkLabel.Dispose()

# Cleanup remaining
$gdf.Dispose()
$bf.Dispose()
$db.Dispose()

# Footer
Footer $g 7

# Save
$fullPath = Join-Path $dir "Slide_07_Composition_300.png"
$bmp.Save($fullPath, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
Write-Host "Saved Slide_07_Composition_300.png" -ForegroundColor Green










# === BATCH 2 CONTINUED + BATCH 3: Slides 08-12 ===
Add-Type -AssemblyName System.Drawing
$dir = "D:\Code\Books\Mahestan\Slides"
if(!(Test-Path $dir)){New-Item -ItemType Directory -Path $dir -Force}

$Indigo=[System.Drawing.Color]::FromArgb(255,26,35,126)
$Royal=[System.Drawing.Color]::FromArgb(255,63,81,181)
$Gold=[System.Drawing.Color]::FromArgb(255,255,193,7)
$Teal=[System.Drawing.Color]::FromArgb(255,0,150,136)
$Purple=[System.Drawing.Color]::FromArgb(255,103,58,183)
$Pink=[System.Drawing.Color]::FromArgb(255,233,30,99)
$Wh=[System.Drawing.Color]::White
$Dk=[System.Drawing.Color]::FromArgb(255,33,33,33)
$Navy=[System.Drawing.Color]::FromArgb(255,13,71,161)
$Green=[System.Drawing.Color]::FromArgb(255,46,125,50)
$Orange=[System.Drawing.Color]::FromArgb(255,230,81,0)
$Red=[System.Drawing.Color]::FromArgb(255,198,40,40)

function MakeSlide($fname,[scriptblock]$draw){$bmp=New-Object System.Drawing.Bitmap(1920,1080);$g=[System.Drawing.Graphics]::FromImage($bmp);$g.SmoothingMode='AntiAlias';$g.TextRenderingHint='ClearTypeGridFit';& $draw $g;$bmp.Save((Join-Path $dir $fname),[System.Drawing.Imaging.ImageFormat]::Png);$g.Dispose();$bmp.Dispose();Write-Host "Saved $fname" -ForegroundColor Green}
function GradBG($g,$c1,$c2){$b=New-Object System.Drawing.Drawing2D.LinearGradientBrush([System.Drawing.Rectangle]::new(0,0,1920,1080),$c1,$c2,45);$g.FillRectangle($b,0,0,1920,1080);$b.Dispose()}
function RRect($g,$brush,$x,$y,$w,$h,$r){$p=New-Object System.Drawing.Drawing2D.GraphicsPath;$p.AddArc($x,$y,$r,$r,180,90);$p.AddArc($x+$w-$r,$y,$r,$r,270,90);$p.AddArc($x+$w-$r,$y+$h-$r,$r,$r,0,90);$p.AddArc($x,$y+$h-$r,$r,$r,90,90);$p.CloseFigure();$g.FillPath($brush,$p);$p.Dispose()}
function RTL($g,$txt,$font,$brush,$x,$y,$w,$h,$al='Near'){$sf=New-Object System.Drawing.StringFormat;$sf.FormatFlags=[System.Drawing.StringFormatFlags]::DirectionRightToLeft;$sf.Alignment=[System.Drawing.StringAlignment]::$al;$sf.LineAlignment='Near';$g.DrawString($txt,$font,$brush,[System.Drawing.RectangleF]::new($x,$y,$w,$h),$sf);$sf.Dispose()}
function Footer($g,$n){$b=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180,0,0,0));$g.FillRectangle($b,0,1035,1920,45);$f=New-Object System.Drawing.Font("Tahoma",13);$w=New-Object System.Drawing.SolidBrush($Wh);$g.DrawString("$n / 25",$f,$w,40,1043);RTL $g "طرح مهستان — چارچوب نهادی گذار ایران" $f $w 700 1043 1170 30 'Near';$f.Dispose();$w.Dispose();$b.Dispose()}

# ===================== SLIDE 08 - 11 COMMISSIONS =====================
MakeSlide "Slide_08_Commissions.png" {
    param($g)
    GradBG $g $Purple ([System.Drawing.Color]::FromArgb(255,74,20,140))

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,255,255))
    $g.FillEllipse($tb,1550,-50,350,350);$g.FillEllipse($tb,-80,700,300,300);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",30,[System.Drawing.FontStyle]::Bold)
    $pp=New-Object System.Drawing.SolidBrush($Purple)
    RTL $g "۱۱ کمیسیون تخصصی دائمی مجلس مهستان" $hf $pp 80 26 1760 50 'Near'
    $hf.Dispose();$pp.Dispose()

    $mc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(245,255,255,255))
    RRect $g $mc 40 115 1840 890 28;$mc.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)
    $bf=New-Object System.Drawing.Font("Tahoma",17)

    $commissions = @(
        @{Icon="📜";Name="کمیسیون قانون اساسی موقت";Color=$Royal},
        @{Icon="⚖️";Name="کمیسیون عدالت انتقالی و حقوق بشر";Color=$Red},
        @{Icon="🛡️";Name="کمیسیون اصلاح بخش امنیتی و نظامی";Color=$Navy},
        @{Icon="⚔️";Name="کمیسیون اصلاح قضایی و حقوقی";Color=$Purple},
        @{Icon="💰";Name="کمیسیون اقتصاد و بودجه";Color=$Orange},
        @{Icon="📚";Name="کمیسیون آموزش، علم و فرهنگ";Color=$Teal},
        @{Icon="🌐";Name="کمیسیون سیاست خارجی و روابط بین‌الملل";Color=$Indigo},
        @{Icon="🌈";Name="کمیسیون حقوق اقلیت‌ها و تنوع قومی-زبانی";Color=$Green},
        @{Icon="🌿";Name="کمیسیون محیط زیست و منابع طبیعی";Color=[System.Drawing.Color]::FromArgb(255,27,94,32)},
        @{Icon="👩";Name="کمیسیون حقوق زنان و برابری جنسیتی";Color=$Pink},
        @{Icon="📺";Name="کمیسیون رسانه و حقوق دیجیتال";Color=[System.Drawing.Color]::FromArgb(255,0,131,143)}
    )

    $cols = 2
    $cardW = 850
    $cardH = 65
    $startX_right = 950
    $startX_left = 70
    $startY = 135

    for($i=0; $i -lt $commissions.Count; $i++){
        $c = $commissions[$i]
        $col = $i % $cols
        $row = [math]::Floor($i / $cols)
        $x = if($col -eq 0){$startX_right}else{$startX_left}
        $y = $startY + ($row * 78)

        $cb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(20,$c.Color.R,$c.Color.G,$c.Color.B))
        RRect $g $cb $x $y $cardW $cardH 14;$cb.Dispose()

        $bar=New-Object System.Drawing.SolidBrush($c.Color)
        $g.FillRectangle($bar,($x+$cardW-8),$y,8,$cardH);$bar.Dispose()

        $ef=New-Object System.Drawing.Font("Segoe UI Emoji",22)
        $g.DrawString($c.Icon,$ef,$db,($x+$cardW-50),($y+15));$ef.Dispose()

        $nf=New-Object System.Drawing.Font("Tahoma",17,[System.Drawing.FontStyle]::Bold)
        $cb2=New-Object System.Drawing.SolidBrush($c.Color)
        RTL $g $c.Name $nf $cb2 ($x+10) ($y+18) ($cardW-80) 30 'Near'
        $nf.Dispose();$cb2.Dispose()
    }

    # bottom note
    $nb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,243,229,245))
    RRect $g $nb 70 610 1780 370 20;$nb.Dispose()

    $ntf=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    $pp2=New-Object System.Drawing.SolidBrush($Purple)
    RTL $g "💡 ساختار تصمیم‌گیری در هر کمیسیون:" $ntf $pp2 100 630 1720 35 'Near'
    $ntf.Dispose();$pp2.Dispose()

    $sf=New-Object System.Drawing.Font("Tahoma",17)
    $steps=@(
        "۱. دریافت گزارش فنی از مرکز تحقیقات (بازوی تکنوکراتیک — بُعد واقعیت)",
        "۲. دریافت گزارش مردمی از واحد ارتباط مردمی (بازوی دموکراتیک — بُعد ارزش)",
        "۳. جلسات استماع با متخصصان و ذی‌نفعان",
        "۴. بحث، بررسی و تدوین متن نهایی",
        "۵. ارائه به صحن مجلس برای رأی‌گیری",
        "۶. نظارت بر اجرای مصوبات توسط کابینه"
    )
    $y=680
    foreach($s in $steps){RTL $g $s $sf $db 100 $y 1720 30 'Near';$y+=42}

    $bf.Dispose();$sf.Dispose();$db.Dispose()
    Footer $g 8
}

# ===================== SLIDE 09 - CABINET =====================
MakeSlide "Slide_09_Cabinet.png" {
    param($g)
    GradBG $g $Navy ([System.Drawing.Color]::FromArgb(255,21,101,192))

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,255,255))
    $g.FillEllipse($tb,1500,500,400,400);$g.FillEllipse($tb,-50,100,280,280);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",32,[System.Drawing.FontStyle]::Bold)
    $nb=New-Object System.Drawing.SolidBrush($Navy)
    RTL $g "⚙️ کابینه‌ی اجرایی موقت" $hf $nb 80 26 1760 50 'Near'
    $hf.Dispose();$nb.Dispose()

    $mc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $mc 60 120 1800 885 28;$mc.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # 3 scenarios
    $tf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    $bf=New-Object System.Drawing.Font("Tahoma",16)

    # Scenario 1
    $s1=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(35,46,125,50))
    RRect $g $s1 1240 140 580 280 20;$s1.Dispose()
    $gn=New-Object System.Drawing.SolidBrush($Green)
    $g.FillRectangle($gn,1240,140,580,10)
    RTL $g "سناریو ۱: اکثریت مطلق" $tf $gn 1260 165 540 35 'Near'
    $items1=@("• جریان اکثریت (۵۰٪+۱)","  کابینه را تشکیل می‌دهد","• ریاست جلسه اول با اکثریت","• سریع‌ترین مسیر تشکیل کابینه")
    $y=210
    foreach($i in $items1){RTL $g $i $bf $db 1260 $y 540 26 'Near';$y+=35}

    # Scenario 2
    $s2=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(35,63,81,181))
    RRect $g $s2 630 140 580 280 20;$s2.Dispose()
    $bl=New-Object System.Drawing.SolidBrush($Royal)
    $g.FillRectangle($bl,630,140,580,10)
    RTL $g "سناریو ۲: ائتلاف" $tf $bl 650 165 540 35 'Near'
    $items2=@("• بدون اکثریت مطلق","• ائتلاف جریان‌ها + مستقلان","• نیاز به اکثریت قاطع","• مذاکره و توافق ائتلافی")
    $y=210
    foreach($i in $items2){RTL $g $i $bf $db 650 $y 540 26 'Near';$y+=35}

    # Scenario 3
    $s3=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(35,230,81,0))
    RRect $g $s3 100 140 500 280 20;$s3.Dispose()
    $ob=New-Object System.Drawing.SolidBrush($Orange)
    $g.FillRectangle($ob,100,140,500,10)
    RTL $g "سناریو ۳: رأی‌گیری" $tf $ob 120 165 460 35 'Near'
    $items3=@("• بدون ائتلاف موفق","• رأی‌گیری برای ریاست کابینه","• مهلت ۱ هفته برای تشکیل","• افراد با بیشترین رأی = کابینه")
    $y=210
    foreach($i in $items3){RTL $g $i $bf $db 120 $y 460 26 'Near';$y+=35}

    # Accountability section
    $ac=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,232,245,253))
    RRect $g $ac 100 450 1720 260 22;$ac.Dispose()
    $bl2=New-Object System.Drawing.SolidBrush($Navy)
    $g.FillRectangle($bl2,100,450,10,260)

    $atf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    RTL $g "📊 سازوکار پاسخ‌گویی کابینه به مجلس:" $atf $bl2 140 470 1640 35 'Near'
    $atf.Dispose()

    $af=New-Object System.Drawing.Font("Tahoma",18)
    $accountability=@(
        "✅  رأی اعتماد اولیه:  ۵۰٪ + ۱  نمایندگان",
        "⚠️  استیضاح و برکناری:  ۷۵٪  آرای نمایندگان",
        "🔄  تعویض فردی وزرا:  ⅔  آرا",
        "📋  تفویض اختیارات تقنینی مشخص به کابینه با تصویب مجلس"
    )
    $y=520
    foreach($a in $accountability){RTL $g $a $af $db 140 $y 1640 32 'Near';$y+=45}

    # Scope
    $sc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,255,243,224))
    RRect $g $sc 100 740 1720 240 22;$sc.Dispose()
    $ob2=New-Object System.Drawing.SolidBrush($Orange)
    $g.FillRectangle($ob2,100,740,1720,10);$ob2.Dispose()

    $stf=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    $ob3=New-Object System.Drawing.SolidBrush($Orange)
    RTL $g "📌 وظایف کابینه:" $stf $ob3 130 770 1660 35 'Near'
    $stf.Dispose();$ob3.Dispose()

    $sf=New-Object System.Drawing.Font("Tahoma",17)
    $duties=@(
        "• اجرای دستورات و تصمیم‌های مجلس مهستان",
        "• تهیه و تدوین طرح‌ها و لوایح مورد نیاز",
        "• مدیریت روزمره‌ی امور کشور در چارچوب مصوبات مجلس",
        "• محدوده‌ی کاری و اجرایی با نظر مجلس تعیین و نظارت می‌شود"
    )
    $y=815
    foreach($d in $duties){RTL $g $d $sf $db 130 $y 1660 28 'Near';$y+=40}

    $tf.Dispose();$bf.Dispose();$af.Dispose();$sf.Dispose();$db.Dispose()
    $gn.Dispose();$bl.Dispose();$ob.Dispose();$bl2.Dispose()
    Footer $g 9
}

# ===================== SLIDE 10 - INTERIM CONSTITUTION =====================
MakeSlide "Slide_10_Interim_Constitution.png" {
    param($g)
    GradBG $g ([System.Drawing.Color]::FromArgb(255,74,20,140)) $Purple

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(22,255,193,7))
    $g.FillEllipse($tb,1400,-80,400,400);$g.FillEllipse($tb,50,700,300,300);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",30,[System.Drawing.FontStyle]::Bold)
    $pp=New-Object System.Drawing.SolidBrush($Purple)
    RTL $g "📜 قانون اساسی موقت — مأموریت فوری" $hf $pp 80 26 1760 50 'Near'
    $hf.Dispose();$pp.Dispose()

    $mc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $mc 60 120 1800 885 28;$mc.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # Timeline visual - 4 steps
    $stepColors = @($Red, $Orange, $Teal, $Green)
    $stepLabels = @("تشکیل کمیسیون ویژه","بررسی و ترکیب پیش‌نویس‌ها","تصویب ⅔ مجلس","رفراندوم عمومی")
    $stepDetails = @(
        "۲۱ عضو مجلس + ۷ حقوقدان + ۳ ناظر بین‌المللی",
        "جمع‌آوری پیش‌نویس‌های جریان‌ها و تدوین متن واحد",
        "نیاز به ⅔ آرای نمایندگان مجلس مهستان",
        "۵۰٪+۱ آرا با حداقل ۴۰٪ مشارکت"
    )

    $tf=New-Object System.Drawing.Font("Tahoma",18,[System.Drawing.FontStyle]::Bold)
    $sf=New-Object System.Drawing.Font("Tahoma",14)

    for($i=0;$i -lt 4;$i++){
        $x = 100 + ($i * 440)
        $cb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(30,$stepColors[$i].R,$stepColors[$i].G,$stepColors[$i].B))
        RRect $g $cb $x 145 410 160 18;$cb.Dispose()

        $bar=New-Object System.Drawing.SolidBrush($stepColors[$i])
        $g.FillRectangle($bar,$x,145,410,8);$bar.Dispose()

        # Step number circle
        $nc=New-Object System.Drawing.SolidBrush($stepColors[$i])
        $g.FillEllipse($nc,($x+350),160,45,45);$nc.Dispose()
        $nf=New-Object System.Drawing.Font("Tahoma",18,[System.Drawing.FontStyle]::Bold)
        $wb=New-Object System.Drawing.SolidBrush($Wh)
        $num = ($i+1).ToString()
        $g.DrawString($num,$nf,$wb,($x+365),168);$nf.Dispose();$wb.Dispose()

        $scb=New-Object System.Drawing.SolidBrush($stepColors[$i])
        RTL $g $stepLabels[$i] $tf $scb ($x+10) 165 330 30 'Near';$scb.Dispose()
        RTL $g $stepDetails[$i] $sf $db ($x+10) 210 380 60 'Near'

        # Arrow
        if($i -lt 3){
            $ap=New-Object System.Drawing.Pen($Gold,3)
            $g.DrawLine($ap,($x+410),200,($x+440),200);$ap.Dispose()
        }
    }

    # Deadline box
    $dlb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,255,235,238))
    RRect $g $dlb 100 330 1720 70 18;$dlb.Dispose()
    $rb=New-Object System.Drawing.SolidBrush($Red)
    $dtf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    RTL $g "⏰ مهلت: حداکثر ۲ ماه پس از تشکیل مجلس مهستان" $dtf $rb 120 348 1680 35 'Near'
    $dtf.Dispose();$rb.Dispose()

    # Required content
    $ccb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,243,229,245))
    RRect $g $ccb 100 430 1720 560 22;$ccb.Dispose()
    $pp2=New-Object System.Drawing.SolidBrush($Purple)
    $g.FillRectangle($pp2,100,430,10,560)

    $ctf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    RTL $g "📋 محتوای الزامی قانون اساسی موقت:" $ctf $pp2 140 450 1640 35 'Near'
    $ctf.Dispose();$pp2.Dispose()

    $bf=New-Object System.Drawing.Font("Tahoma",18)
    $contents=@(
        @{Icon="🏛️";Text="اصول بنیادین غیرقابل‌تغییر — حقوق بشر، برابری، جدایی دین از دولت"},
        @{Icon="⚙️";Text="ساختار نهادهای گذار — مجلس، کابینه، شورای قضایی، نظامی"},
        @{Icon="📜";Text="منشور حقوق شهروندی — آزادی بیان، تجمع، عقیده، مطبوعات"},
        @{Icon="⚖️";Text="چارچوب عدالت انتقالی — حقیقت‌یابی، محاکمه، جبران خسارت"},
        @{Icon="🗳️";Text="مسیر رسیدن به قانون اساسی نهایی — مجلس مؤسسان + رفراندوم"},
        @{Icon="🛡️";Text="تضمین‌های امنیتی — حفاظت از حقوق در دوران انتقال"},
        @{Icon="💰";Text="چارچوب اقتصادی — حفاظت از اموال عمومی، استقلال بانک مرکزی"},
        @{Icon="🌐";Text="روابط بین‌الملل — تعهدات و الحاق به کنوانسیون‌ها"}
    )

    $ef=New-Object System.Drawing.Font("Segoe UI Emoji",20)
    $y=500
    foreach($c in $contents){
        $g.DrawString($c.Icon,$ef,$db,1740,$y)
        RTL $g $c.Text $bf $db 140 ($y+3) 1580 32 'Near'
        $y+=52
    }

    $tf.Dispose();$sf.Dispose();$bf.Dispose();$ef.Dispose();$db.Dispose()
    Footer $g 10
}

# ===================== SLIDE 11 - JUDICIAL & MILITARY =====================
MakeSlide "Slide_11_Judicial_Military.png" {
    param($g)
    GradBG $g ([System.Drawing.Color]::FromArgb(255,27,94,32)) $Green

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,255,255))
    $g.FillEllipse($tb,1500,-50,350,350);$g.FillEllipse($tb,-80,600,300,300);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",28,[System.Drawing.FontStyle]::Bold)
    $gn=New-Object System.Drawing.SolidBrush($Green)
    RTL $g "شورای قضایی انتقالی و فرماندهی نظامی-انتظامی" $hf $gn 80 28 1760 50 'Near'
    $hf.Dispose();$gn.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # Judicial card (right)
    $jc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $jc 980 125 880 860 25;$jc.Dispose()
    $pp=New-Object System.Drawing.SolidBrush($Purple)
    $g.FillRectangle($pp,980,125,880,12)

    $ef=New-Object System.Drawing.Font("Segoe UI Emoji",40)
    $g.DrawString("⚖️",$ef,$db,1370,150);$ef.Dispose()

    $tf=New-Object System.Drawing.Font("Tahoma",24,[System.Drawing.FontStyle]::Bold)
    RTL $g "شورای قضایی انتقالی" $tf $pp 1000 210 830 40 'Near'
    $tf.Dispose()

    $sf=New-Object System.Drawing.Font("Tahoma",15,[System.Drawing.FontStyle]::Italic)
    $gr=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,100,100,100))
    RTL $g "اعضا: اساتید حقوق + اعضای کانون وکلا + قاضیان مستقل" $sf $gr 1000 255 830 25 'Near'
    $sf.Dispose();$gr.Dispose()

    $bf=New-Object System.Drawing.Font("Tahoma",17)
    $judicial=@(
        "✅ تصفیه دستگاه قضایی از عناصر فاسد",
        "✅ بازبینی و تعلیق قوانین ناعادلانه",
        "✅ تنظیم قوانین حقوقی جدید فوری",
        "✅ سازمان‌دهی مجدد دادگاه‌ها",
        "✅ تشکیل دادگاه‌های عدالت انتقالی",
        "✅ تضمین استقلال قوه قضاییه",
        "✅ حق دادرسی عادلانه برای همه"
    )
    $y=300
    foreach($j in $judicial){RTL $g $j $bf $db 1000 $y 830 28 'Near';$y+=42}

    $lqb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(30,103,58,183))
    RRect $g $lqb 1000 610 840 110 15;$lqb.Dispose()
    $ltf=New-Object System.Drawing.Font("Tahoma",16,[System.Drawing.FontStyle]::Bold)
    RTL $g "❌ لغو فوری:" $ltf $pp 1020 625 800 25 'Near'
    $lf=New-Object System.Drawing.Font("Tahoma",15)
    RTL $g "محاکم انقلاب • دادگاه ویژه روحانیت • بازداشت بدون حکم" $lf $db 1020 660 800 30 'Near'
    $ltf.Dispose();$lf.Dispose();$pp.Dispose()

    # Military card (left)
    $mlc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $mlc 60 125 880 860 25;$mlc.Dispose()
    $nv=New-Object System.Drawing.SolidBrush($Navy)
    $g.FillRectangle($nv,60,125,880,12)

    $ef2=New-Object System.Drawing.Font("Segoe UI Emoji",40)
    $g.DrawString("🛡️",$ef2,$db,460,150);$ef2.Dispose()

    $tf2=New-Object System.Drawing.Font("Tahoma",24,[System.Drawing.FontStyle]::Bold)
    RTL $g "فرماندهی نظامی-انتظامی موقت" $tf2 $nv 80 210 830 40 'Near'
    $tf2.Dispose()

    $military=@(
        "✅ تعیین شورای مدیریت نظامی توسط مجلس",
        "✅ فرمانده ستاد مشترک: منتخب مجلس",
        "✅ هماهنگی اجرایی با رئیس کابینه",
        "✅ برنامه‌های گسترده با تصویب مجلس"
    )
    $y=300
    foreach($m in $military){RTL $g $m $bf $db 80 $y 830 28 'Near';$y+=42}

    # SSR section
    $ssrb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,232,245,253))
    RRect $g $ssrb 80 490 840 480 20;$ssrb.Dispose()
    $nv2=New-Object System.Drawing.SolidBrush($Navy)
    $g.FillRectangle($nv2,80,490,840,8);$nv2.Dispose()

    $stf=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    $nv3=New-Object System.Drawing.SolidBrush($Navy)
    RTL $g "🔄 کمیسیون ملی اصلاح بخش امنیتی (SSR):" $stf $nv3 100 510 800 35 'Near'
    $stf.Dispose();$nv3.Dispose()

    $ssr=@(
        "• غربال‌گری (Vetting) فرماندهان امنیتی",
        "• انحلال نهادهای سرکوب:",
        "  — سازمان عقیدتی-سیاسی",
        "  — دفتر نمایندگی ولی فقیه",
        "  — گشت ارشاد",
        "• ادغام نیروهای واجد شرایط در ارتش ملی",
        "• واگذاری دارایی‌های اقتصادی نظامی",
        "  به صندوق ملی بازسازی",
        "• آموزش حقوق بشر و تبعیت از مقام مدنی"
    )
    $y=555
    foreach($s in $ssr){RTL $g $s $bf $db 100 $y 800 26 'Near';$y+=38}

    $bf.Dispose();$db.Dispose()
    Footer $g 11
}

# ===================== SLIDE 12 - TRANSITIONAL JUSTICE =====================
MakeSlide "Slide_12_Transitional_Justice.png" {
    param($g)
    GradBG $g $Indigo ([System.Drawing.Color]::FromArgb(255,69,39,160))

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(20,255,193,7))
    $g.FillEllipse($tb,1500,600,350,350);$g.FillEllipse($tb,-80,200,300,300);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",32,[System.Drawing.FontStyle]::Bold)
    $ib=New-Object System.Drawing.SolidBrush($Indigo)
    RTL $g "⚖️ عدالت انتقالی — پنج ستون" $hf $ib 80 26 1760 50 'Near'
    $hf.Dispose();$ib.Dispose()

    # deadline
    $dlb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40,255,255,255))
    RRect $g $dlb 60 115 1800 60 18;$dlb.Dispose()
    $wb=New-Object System.Drawing.SolidBrush($Wh)
    $df=New-Object System.Drawing.Font("Tahoma",18,[System.Drawing.FontStyle]::Bold)
    RTL $g "⏰ مهلت تدوین طرح جامع: حداکثر ۳ ماه پس از تشکیل مجلس" $df $wb 80 130 1740 35 'Center'
    $df.Dispose();$wb.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # 5 pillars as cards
    $pillars = @(
        @{Icon="🔍";Title="حقیقت‌یابی";Color=[System.Drawing.Color]::FromArgb(255,21,101,192);Items=@("کمیسیون حقیقت‌یابی و آشتی","مستندسازی جنایات ۴۵ ساله","ثبت شهادت قربانیان","جلسات علنی","گزارش نهایی جامع")},
        @{Icon="⚔️";Title="عدالت کیفری";Color=$Red;Items=@("محاکمات عادلانه و علنی","تفکیک سطوح مسئولیت","دادرسی عادلانه","عفو مشروط سطوح پایین","رعایت اصول بین‌المللی")},
        @{Icon="💰";Title="جبران خسارت";Color=$Orange;Items=@("غرامت مالی قربانیان","اعاده‌ی حیثیت","خدمات درمانی/روانشناختی","بازگرداندن اموال","حمایت بلندمدت")},
        @{Icon="🕊️";Title="آشتی ملی";Color=$Gold;Items=@("گفتگوهای ملی آشتی","موزه‌ها و یادبودها","اصلاح تاریخ‌نگاری","روز ملی یادبود","بازسازی اعتماد عمومی")},
        @{Icon="🛡️";Title="تضمین عدم تکرار";Color=$Green;Items=@("اصلاح نهادی ریشه‌ای","آموزش حقوق بشر","نهادهای نظارتی مستقل","قانون اساسی دموکراتیک","تغییر فرهنگ سیاسی")}
    )

    $cardW = 340
    $startX = 60
    $cardY = 200

    for($i=0;$i -lt 5;$i++){
        $p = $pillars[$i]
        $x = $startX + ($i * 370)

        $cb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
        RRect $g $cb $x $cardY $cardW 780 22;$cb.Dispose()

        $bar=New-Object System.Drawing.SolidBrush($p.Color)
        $g.FillRectangle($bar,$x,$cardY,$cardW,10);$bar.Dispose()

        # Icon
        $ef=New-Object System.Drawing.Font("Segoe UI Emoji",32)
        $g.DrawString($p.Icon,$ef,$db,($x+$cardW/2-20),($cardY+25));$ef.Dispose()

        # Title
        $tf=New-Object System.Drawing.Font("Tahoma",18,[System.Drawing.FontStyle]::Bold)
        $tcb=New-Object System.Drawing.SolidBrush($p.Color)
        RTL $g $p.Title $tf $tcb ($x+10) ($cardY+80) ($cardW-20) 30 'Center'
        $tf.Dispose();$tcb.Dispose()

        # Separator
        $sp=New-Object System.Drawing.Pen($p.Color,2)
        $g.DrawLine($sp,($x+40),($cardY+118),($x+$cardW-40),($cardY+118));$sp.Dispose()

        # Items
        $bf=New-Object System.Drawing.Font("Tahoma",14)
        $y=$cardY+135
        foreach($item in $p.Items){
            RTL $g "• $item" $bf $db ($x+10) $y ($cardW-20) 22 'Near'
            $y+=32
        }
        $bf.Dispose()

        # Pillar number
        $pnb=New-Object System.Drawing.SolidBrush($p.Color)
        $g.FillEllipse($pnb,($x+$cardW/2-18),($cardY+$cardW+340),36,36);$pnb.Dispose()
        $nf=New-Object System.Drawing.Font("Tahoma",16,[System.Drawing.FontStyle]::Bold)
        $wbb=New-Object System.Drawing.SolidBrush($Wh)
        $g.DrawString(($i+1).ToString(),$nf,$wbb,($x+$cardW/2-6),($cardY+$cardW+346));$nf.Dispose();$wbb.Dispose()
    }

    $db.Dispose()
    Footer $g 12
}

Write-Host "`n=== BATCH 2-3 DONE: Slides 08-12 ===" -ForegroundColor Cyan

# === BATCH 3: Slides 13-17 - Oversight & Arms ===
Add-Type -AssemblyName System.Drawing
$dir = "D:\Code\Books\Mahestan\Slides"
if(!(Test-Path $dir)){New-Item -ItemType Directory -Path $dir -Force}

$Indigo=[System.Drawing.Color]::FromArgb(255,26,35,126);$Royal=[System.Drawing.Color]::FromArgb(255,63,81,181);$Gold=[System.Drawing.Color]::FromArgb(255,255,193,7);$Teal=[System.Drawing.Color]::FromArgb(255,0,150,136);$Purple=[System.Drawing.Color]::FromArgb(255,103,58,183);$Pink=[System.Drawing.Color]::FromArgb(255,233,30,99);$Wh=[System.Drawing.Color]::White;$Dk=[System.Drawing.Color]::FromArgb(255,33,33,33);$Navy=[System.Drawing.Color]::FromArgb(255,13,71,161);$Green=[System.Drawing.Color]::FromArgb(255,46,125,50);$Orange=[System.Drawing.Color]::FromArgb(255,230,81,0);$Red=[System.Drawing.Color]::FromArgb(255,198,40,40);$Cyan=[System.Drawing.Color]::FromArgb(255,0,188,212)

function MakeSlide($fname,[scriptblock]$draw){$bmp=New-Object System.Drawing.Bitmap(1920,1080);$g=[System.Drawing.Graphics]::FromImage($bmp);$g.SmoothingMode='AntiAlias';$g.TextRenderingHint='ClearTypeGridFit';& $draw $g;$bmp.Save((Join-Path $dir $fname),[System.Drawing.Imaging.ImageFormat]::Png);$g.Dispose();$bmp.Dispose();Write-Host "Saved $fname" -ForegroundColor Green}
function GradBG($g,$c1,$c2){$b=New-Object System.Drawing.Drawing2D.LinearGradientBrush([System.Drawing.Rectangle]::new(0,0,1920,1080),$c1,$c2,45);$g.FillRectangle($b,0,0,1920,1080);$b.Dispose()}
function RRect($g,$brush,$x,$y,$w,$h,$r){$p=New-Object System.Drawing.Drawing2D.GraphicsPath;$p.AddArc($x,$y,$r,$r,180,90);$p.AddArc($x+$w-$r,$y,$r,$r,270,90);$p.AddArc($x+$w-$r,$y+$h-$r,$r,$r,0,90);$p.AddArc($x,$y+$h-$r,$r,$r,90,90);$p.CloseFigure();$g.FillPath($brush,$p);$p.Dispose()}
function RTL($g,$txt,$font,$brush,$x,$y,$w,$h,$al='Near'){$sf=New-Object System.Drawing.StringFormat;$sf.FormatFlags=[System.Drawing.StringFormatFlags]::DirectionRightToLeft;$sf.Alignment=[System.Drawing.StringAlignment]::$al;$sf.LineAlignment='Near';$g.DrawString($txt,$font,$brush,[System.Drawing.RectangleF]::new($x,$y,$w,$h),$sf);$sf.Dispose()}
function Footer($g,$n){$b=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180,0,0,0));$g.FillRectangle($b,0,1035,1920,45);$f=New-Object System.Drawing.Font("Tahoma",13);$w=New-Object System.Drawing.SolidBrush($Wh);$g.DrawString("$n / 25",$f,$w,40,1043);RTL $g "طرح مهستان — چارچوب نهادی گذار ایران" $f $w 700 1043 1170 30 'Near';$f.Dispose();$w.Dispose();$b.Dispose()}

# ===================== SLIDE 13 - OVERSIGHT BODIES =====================
MakeSlide "Slide_13_Oversight_Bodies.png" {
    param($g)
    GradBG $g $Teal ([System.Drawing.Color]::FromArgb(255,0,105,92))

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,255,255))
    $g.FillEllipse($tb,1550,500,350,350);$g.FillEllipse($tb,-50,-50,280,280);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",30,[System.Drawing.FontStyle]::Bold)
    $tc=New-Object System.Drawing.SolidBrush($Teal)
    RTL $g "نهادهای نظارتی و مشاوره‌ای مستقل" $hf $tc 80 26 1760 50 'Near'
    $hf.Dispose();$tc.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # 4 cards
    $bodies = @(
        @{Icon="🗳️";Title="هیأت ناظر مستقل انتخابات";Color=$Royal;
          Items=@("حقوقدانان مستقل","نمایندگان جامعه مدنی","ناظران بین‌المللی","نظارت بر تمام رأی‌گیری‌ها و رفراندوم‌ها")},
        @{Icon="👤";Title="آمبودزمان (حقوق شهروندی)";Color=$Purple;
          Items=@("نهاد مستقل رسیدگی به شکایات","منتخب مجلس مهستان","مستقل از کابینه","حمایت از حقوق شهروندان در برابر دولت")},
        @{Icon="📺";Title="کمیسیون ملی رسانه‌ها";Color=$Cyan;
          Items=@("تبدیل صداوسیما به رسانه عمومی مستقل","الگوی BBC / ARD","تضمین آزادی مطبوعات","رفع کامل فیلترینگ و سانسور")},
        @{Icon="📊";Title="شورای اقتصادی دوران گذار";Color=$Orange;
          Items=@("اقتصاددانان برجسته داخل و خارج","مشاوره و طراحی سیاست اقتصادی","گزارش به مجلس و کابینه","مدیریت بحران اقتصادی انتقال")}
    )

    $cardW = 870
    for($i=0;$i -lt 4;$i++){
        $b = $bodies[$i]
        $col = $i % 2
        $row = [math]::Floor($i / 2)
        $x = if($col -eq 0){990}else{80}
        $y = 125 + ($row * 460)

        $cb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
        RRect $g $cb $x $y $cardW 430 22;$cb.Dispose()

        $bar=New-Object System.Drawing.SolidBrush($b.Color)
        $g.FillRectangle($bar,$x,$y,$cardW,10);$bar.Dispose()

        $ef=New-Object System.Drawing.Font("Segoe UI Emoji",36)
        $g.DrawString($b.Icon,$ef,$db,($x+$cardW-70),($y+25));$ef.Dispose()

        $tf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
        $tcb=New-Object System.Drawing.SolidBrush($b.Color)
        RTL $g $b.Title $tf $tcb ($x+20) ($y+35) ($cardW-100) 35 'Near'
        $tf.Dispose();$tcb.Dispose()

        $sp=New-Object System.Drawing.Pen($b.Color,2)
        $g.DrawLine($sp,($x+20),($y+80),($x+$cardW-20),($y+80));$sp.Dispose()

        $bf=New-Object System.Drawing.Font("Tahoma",18)
        $iy=$y+100
        foreach($item in $b.Items){
            RTL $g "✅ $item" $bf $db ($x+20) $iy ($cardW-40) 30 'Near'
            $iy+=45
        }
        $bf.Dispose()

        # Additional details
        $df=New-Object System.Drawing.Font("Tahoma",15,[System.Drawing.FontStyle]::Italic)
        $gr=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,100,100,100))
        $detailText = switch($i){
            0 {"اعتبار دموکراتیک تمام فرایندها"}
            1 {"صدای شهروندان در برابر قدرت"}
            2 {"اطلاعات آزاد = پایه‌ی دموکراسی"}
            3 {"ثبات اقتصادی = ثبات سیاسی"}
        }
        RTL $g "💡 $detailText" $df $gr ($x+20) ($y+350) ($cardW-40) 25 'Near'
        $df.Dispose();$gr.Dispose()
    }

    $db.Dispose()
    Footer $g 13
}

# ===================== SLIDE 14 - TECHNOCRATIC ARM =====================
MakeSlide "Slide_14_Research_Center.png" {
    param($g)
    GradBG $g $Orange ([System.Drawing.Color]::FromArgb(255,191,54,12))

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,255,255))
    $g.FillEllipse($tb,1400,-80,400,400);$g.FillEllipse($tb,50,700,300,300);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",30,[System.Drawing.FontStyle]::Bold)
    $ob=New-Object System.Drawing.SolidBrush($Orange)
    RTL $g "🔬 مرکز تحقیقات مجلس — بازوی تکنوکراتیک" $hf $ob 80 26 1760 50 'Near'
    $hf.Dispose();$ob.Dispose()

    $mc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $mc 60 120 1800 885 28;$mc.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # Key question box
    $qb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,255,243,224))
    RRect $g $qb 100 140 1720 80 18;$qb.Dispose()
    $ob2=New-Object System.Drawing.SolidBrush($Orange)
    $qtf=New-Object System.Drawing.Font("Tahoma",24,[System.Drawing.FontStyle]::Bold)
    RTL $g "❓ سؤال کلیدی: واقعیت چیست؟  (What is?)" $qtf $ob2 120 160 1680 40 'Near'
    $qtf.Dispose();$ob2.Dispose()

    # Functions
    $tf=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    $ob3=New-Object System.Drawing.SolidBrush($Orange)
    RTL $g "وظایف اصلی:" $tf $ob3 100 245 1680 35 'Near'
    $tf.Dispose();$ob3.Dispose()

    $bf=New-Object System.Drawing.Font("Tahoma",18)
    $functions=@(
        "📊  هماهنگی با متخصصان و پژوهشگران حوزه‌های مختلف",
        "📋  تهیه‌ی گزارش‌های فنی-تخصصی (Fact Sheets) برای هر تصمیم",
        "📈  تحلیل پیامدهای اقتصادی، حقوقی و اجتماعی لوایح و طرح‌ها",
        "🔢  جمع‌آوری و تحلیل داده‌ها و آمارهای ملی",
        "🌐  بررسی تجربه‌ی جهانی و الگوهای موفق",
        "📝  ارائه‌ی گزینه‌های سیاستی (حداقل ۳ گزینه + مزایا و معایب هر کدام)"
    )
    $y=295
    foreach($f in $functions){RTL $g $f $bf $db 120 $y 1680 32 'Near';$y+=52}

    # Key principle
    $kpb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,255,235,238))
    RRect $g $kpb 100 630 1720 100 18;$kpb.Dispose()
    $rb=New-Object System.Drawing.SolidBrush($Red)
    $kf=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    RTL $g "⚠️ نکته کلیدی: مرکز تحقیقات بُعد واقعیت را تأمین می‌کند" $kf $rb 120 650 1680 30 'Near'
    $kf.Dispose()
    $sf=New-Object System.Drawing.Font("Tahoma",18)
    RTL $g "تصمیم نهایی (What ought to be) با نمایندگان منتخب و مردم است — نه توصیه‌ی یکجانبه!" $sf $db 120 690 1680 30 'Near'
    $sf.Dispose();$rb.Dispose()

    # Output example
    $exb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,232,245,253))
    RRect $g $exb 100 760 1720 210 18;$exb.Dispose()

    $etf=New-Object System.Drawing.Font("Tahoma",19,[System.Drawing.FontStyle]::Bold)
    $bl=New-Object System.Drawing.SolidBrush($Royal)
    RTL $g "📄 نمونه خروجی مرکز تحقیقات (برای هر موضوع):" $etf $bl 120 780 1680 32 'Near'
    $etf.Dispose();$bl.Dispose()

    $ef=New-Object System.Drawing.Font("Tahoma",16)
    $outputs=@(
        "• وضعیت موجود و داده‌ها ← تحلیل پیامدها ← تجربه جهانی ← حداقل ۳ گزینه سیاستی",
        "• مزایا و معایب هر گزینه ← هزینه‌ها و منابع مورد نیاز ← زمان‌بندی پیشنهادی",
        "• ⚡ مهم: گزارش بدون جهت‌گیری ارزشی — فقط واقعیت‌ها و تحلیل‌ها"
    )
    $y=825
    foreach($o in $outputs){RTL $g $o $ef $db 120 $y 1680 28 'Near';$y+=45}

    $bf.Dispose();$ef.Dispose();$db.Dispose()
    Footer $g 14
}

# === BATCH 3 CONTINUED: Slides 15-17 ===
Add-Type -AssemblyName System.Drawing
$dir = "D:\Code\Books\Mahestan\Slides"
if(!(Test-Path $dir)){New-Item -ItemType Directory -Path $dir -Force}

$Indigo=[System.Drawing.Color]::FromArgb(255,26,35,126);$Royal=[System.Drawing.Color]::FromArgb(255,63,81,181);$Gold=[System.Drawing.Color]::FromArgb(255,255,193,7);$Teal=[System.Drawing.Color]::FromArgb(255,0,150,136);$Purple=[System.Drawing.Color]::FromArgb(255,103,58,183);$Pink=[System.Drawing.Color]::FromArgb(255,233,30,99);$Wh=[System.Drawing.Color]::White;$Dk=[System.Drawing.Color]::FromArgb(255,33,33,33);$Navy=[System.Drawing.Color]::FromArgb(255,13,71,161);$Green=[System.Drawing.Color]::FromArgb(255,46,125,50);$Orange=[System.Drawing.Color]::FromArgb(255,230,81,0);$Red=[System.Drawing.Color]::FromArgb(255,198,40,40);$Cyan=[System.Drawing.Color]::FromArgb(255,0,188,212)

function MakeSlide($fname,[scriptblock]$draw){$bmp=New-Object System.Drawing.Bitmap(1920,1080);$g=[System.Drawing.Graphics]::FromImage($bmp);$g.SmoothingMode='AntiAlias';$g.TextRenderingHint='ClearTypeGridFit';& $draw $g;$bmp.Save((Join-Path $dir $fname),[System.Drawing.Imaging.ImageFormat]::Png);$g.Dispose();$bmp.Dispose();Write-Host "Saved $fname" -ForegroundColor Green}
function GradBG($g,$c1,$c2){$b=New-Object System.Drawing.Drawing2D.LinearGradientBrush([System.Drawing.Rectangle]::new(0,0,1920,1080),$c1,$c2,45);$g.FillRectangle($b,0,0,1920,1080);$b.Dispose()}
function RRect($g,$brush,$x,$y,$w,$h,$r){$p=New-Object System.Drawing.Drawing2D.GraphicsPath;$p.AddArc($x,$y,$r,$r,180,90);$p.AddArc($x+$w-$r,$y,$r,$r,270,90);$p.AddArc($x+$w-$r,$y+$h-$r,$r,$r,0,90);$p.AddArc($x,$y+$h-$r,$r,$r,90,90);$p.CloseFigure();$g.FillPath($brush,$p);$p.Dispose()}
function RTL($g,$txt,$font,$brush,$x,$y,$w,$h,$al='Near'){$sf=New-Object System.Drawing.StringFormat;$sf.FormatFlags=[System.Drawing.StringFormatFlags]::DirectionRightToLeft;$sf.Alignment=[System.Drawing.StringAlignment]::$al;$sf.LineAlignment='Near';$g.DrawString($txt,$font,$brush,[System.Drawing.RectangleF]::new($x,$y,$w,$h),$sf);$sf.Dispose()}
function Footer($g,$n){$b=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180,0,0,0));$g.FillRectangle($b,0,1035,1920,45);$f=New-Object System.Drawing.Font("Tahoma",13);$w=New-Object System.Drawing.SolidBrush($Wh);$g.DrawString("$n / 25",$f,$w,40,1043);RTL $g "طرح مهستان — چارچوب نهادی گذار ایران" $f $w 700 1043 1170 30 'Near';$f.Dispose();$w.Dispose();$b.Dispose()}

# ===================== SLIDE 15 - DEMOCRATIC ARM =====================
MakeSlide "Slide_15_Democratic_Arm.png" {
    param($g)
    GradBG $g $Royal ([System.Drawing.Color]::FromArgb(255,25,118,210))

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,255,255))
    $g.FillEllipse($tb,1500,-50,350,350);$g.FillEllipse($tb,-80,600,300,300);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",28,[System.Drawing.FontStyle]::Bold)
    $bl=New-Object System.Drawing.SolidBrush($Royal)
    RTL $g "📢 واحد ارتباط مردمی و دموکراسی مستقیم — بازوی دموکراتیک" $hf $bl 60 26 1800 50 'Near'
    $hf.Dispose();$bl.Dispose()

    $mc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $mc 40 115 1840 890 28;$mc.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # Key question
    $qb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,227,242,253))
    RRect $g $qb 80 130 1760 70 18;$qb.Dispose()
    $bl2=New-Object System.Drawing.SolidBrush($Royal)
    $qtf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    RTL $g "❓ سؤال کلیدی: مردم چه می‌خواهند؟  (What ought to be?)" $qtf $bl2 100 150 1700 35 'Near'
    $qtf.Dispose();$bl2.Dispose()

    # 7 functions as cards
    $funcs = @(
        @{Icon="🗳️";Title="بستر دموکراسی مستقیم";Desc="پلتفرم دیجیتال رأی‌گیری، نظرسنجی و رفراندوم";Color=$Royal},
        @{Icon="📨";Title="دریافت پیشنهادهای مردمی";Desc="سامانه آنلاین + خط تلفن رایگان + صندوق فیزیکی";Color=$Green},
        @{Icon="🏘️";Title="جلسات عمومی و مشاوره";Desc="جلسات محله‌ای، پنل شهروندی، گفتگوی تخصصی";Color=$Gold},
        @{Icon="📊";Title="نظرسنجی‌های علمی";Desc="نمونه‌گیری تصادفی، سنجش اولویت‌ها و رضایت";Color=$Pink},
        @{Icon="📢";Title="اطلاع‌رسانی و شفافیت";Desc="پخش زنده مجلس، ترجمه به زبان‌های محلی";Color=$Cyan},
        @{Icon="🔄";Title="بازخوردگیری قانون‌گذاری";Desc="انتشار پیش‌نویس + مهلت ۷ تا ۳۰ روز بازخورد";Color=$Purple},
        @{Icon="📋";Title="مدیریت طومارها";Desc="۱۰۰,۰۰۰+ امضا = بررسی رسمی الزامی مجلس";Color=$Orange}
    )

    $row1Y = 225
    $row2Y = 445
    $row3Y = 665
    $cardW = 550
    $cardH = 185

    $positions = @(
        @{X=1220;Y=$row1Y}, @{X=620;Y=$row1Y}, @{X=80;Y=$row1Y},
        @{X=1220;Y=$row2Y}, @{X=620;Y=$row2Y}, @{X=80;Y=$row2Y},
        @{X=650;Y=$row3Y}
    )

    for($i=0;$i -lt 7;$i++){
        $f = $funcs[$i]
        $pos = $positions[$i]

        $cb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(25,$f.Color.R,$f.Color.G,$f.Color.B))
        RRect $g $cb $pos.X $pos.Y $cardW $cardH 18;$cb.Dispose()

        $bar=New-Object System.Drawing.SolidBrush($f.Color)
        $g.FillRectangle($bar,($pos.X+$cardW-8),$pos.Y,8,$cardH);$bar.Dispose()

        $ef=New-Object System.Drawing.Font("Segoe UI Emoji",26)
        $g.DrawString($f.Icon,$ef,$db,($pos.X+$cardW-55),($pos.Y+15));$ef.Dispose()

        $tf=New-Object System.Drawing.Font("Tahoma",17,[System.Drawing.FontStyle]::Bold)
        $tcb=New-Object System.Drawing.SolidBrush($f.Color)
        RTL $g $f.Title $tf $tcb ($pos.X+15) ($pos.Y+20) ($cardW-80) 28 'Near'
        $tf.Dispose();$tcb.Dispose()

        $bf=New-Object System.Drawing.Font("Tahoma",15)
        RTL $g $f.Desc $bf $db ($pos.X+15) ($pos.Y+60) ($cardW-40) 100 'Near'
        $bf.Dispose()
    }

    # Languages box
    $lb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,232,245,253))
    RRect $g $lb 80 880 1760 100 18;$lb.Dispose()
    $lf=New-Object System.Drawing.Font("Tahoma",16,[System.Drawing.FontStyle]::Bold)
    $bl3=New-Object System.Drawing.SolidBrush($Royal)
    RTL $g "🌐 زبان‌های پشتیبانی: فارسی + آذری + کُردی + عربی + بلوچی + ترکمنی + زبان اشاره" $lf $bl3 100 895 1700 30 'Near'
    $lf2=New-Object System.Drawing.Font("Tahoma",15)
    RTL $g "پادکست، ویدئو، نسخه ساده‌شده برای عموم — دسترسی حداکثری به اطلاعات" $lf2 $db 100 930 1700 28 'Near'
    $lf.Dispose();$lf2.Dispose();$bl3.Dispose()

    $db.Dispose()
    Footer $g 15
}

# ===================== SLIDE 16 - TWO ARMS TOGETHER =====================
MakeSlide "Slide_16_Two_Arms.png" {
    param($g)
    GradBG $g ([System.Drawing.Color]::FromArgb(255,27,94,32)) $Green

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,255,255))
    $g.FillEllipse($tb,1500,500,350,350);$g.FillEllipse($tb,-80,100,300,300);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",30,[System.Drawing.FontStyle]::Bold)
    $gn=New-Object System.Drawing.SolidBrush($Green)
    RTL $g "ترکیب دو بازو: تکنوکراتیک + دموکراتیک = حکمرانی مطلوب" $hf $gn 60 26 1800 50 'Near'
    $hf.Dispose();$gn.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # Technocratic Arm (right card)
    $tc1=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,243,224))
    RRect $g $tc1 980 125 880 400 25;$tc1.Dispose()
    $ob=New-Object System.Drawing.SolidBrush($Orange)
    $g.FillRectangle($ob,980,125,880,12);$ob.Dispose()

    $ef=New-Object System.Drawing.Font("Segoe UI Emoji",40)
    $g.DrawString("🔬",$ef,$db,1370,150);$ef.Dispose()

    $tf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    $ob2=New-Object System.Drawing.SolidBrush($Orange)
    RTL $g "مرکز تحقیقات (بازوی تکنوکراتیک)" $tf $ob2 1000 200 830 35 'Near'
    $tf.Dispose();$ob2.Dispose()

    $bf=New-Object System.Drawing.Font("Tahoma",17)
    $tech=@("❓ واقعیت چیست؟","• داده‌ها و آمار","• تحلیل فنی پیامدها","• گزینه‌های سیاستی","• تجربه جهانی","• نظر متخصصان")
    $y=250
    foreach($t in $tech){RTL $g $t $bf $db 1000 $y 830 28 'Near';$y+=38}

    # Democratic Arm (left card)
    $dc1=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,227,242,253))
    RRect $g $dc1 60 125 880 400 25;$dc1.Dispose()
    $bl=New-Object System.Drawing.SolidBrush($Royal)
    $g.FillRectangle($bl,60,125,880,12);$bl.Dispose()

    $ef2=New-Object System.Drawing.Font("Segoe UI Emoji",40)
    $g.DrawString("📢",$ef2,$db,460,150);$ef2.Dispose()

    $tf2=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    $bl2=New-Object System.Drawing.SolidBrush($Royal)
    RTL $g "واحد ارتباط مردمی (بازوی دموکراتیک)" $tf2 $bl2 80 200 830 35 'Near'
    $tf2.Dispose();$bl2.Dispose()

    $demo=@("❓ مردم چه می‌خواهند؟","• اولویت‌ها و ارزش‌ها","• نظرسنجی‌ها","• پیشنهادها و بازخوردها","• جلسات عمومی","• رفراندوم‌ها")
    $y=250
    foreach($d in $demo){RTL $g $d $bf $db 80 $y 830 28 'Near';$y+=38}

    # Arrow down to Mahestan
    $arrowPen=New-Object System.Drawing.Pen($Gold,5)
    $g.DrawLine($arrowPen,960,525,960,575);$arrowPen.Dispose()
    $gb=New-Object System.Drawing.SolidBrush($Gold)
    # triangle
    $points = @(
        [System.Drawing.Point]::new(940,575),
        [System.Drawing.Point]::new(980,575),
        [System.Drawing.Point]::new(960,600)
    )
    $g.FillPolygon($gb,$points);$gb.Dispose()

    # Mahestan center card
    $mc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(250,255,255,255))
    RRect $g $mc 360 610 1200 380 30;$mc.Dispose()
    $gnBar=New-Object System.Drawing.SolidBrush($Green)
    $g.FillRectangle($gnBar,360,610,1200,14);$gnBar.Dispose()

    $ef3=New-Object System.Drawing.Font("Segoe UI Emoji",45)
    $g.DrawString("🏛️",$ef3,$db,910,640);$ef3.Dispose()

    $mtf=New-Object System.Drawing.Font("Tahoma",26,[System.Drawing.FontStyle]::Bold)
    $gn2=New-Object System.Drawing.SolidBrush($Green)
    RTL $g "مجلس مهستان" $mtf $gn2 400 710 1120 40 'Center'
    $mtf.Dispose();$gn2.Dispose()

    $mf=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    RTL $g "تصمیم‌گیری آگاهانه بر اساس هر دو بُعد:" $mf $db 400 760 1120 35 'Center'
    $mf.Dispose()

    $rf=New-Object System.Drawing.Font("Tahoma",22)
    $gn3=New-Object System.Drawing.SolidBrush($Green)
    RTL $g "واقعیت (Fact)  +  خواست مردم (Value)  =  حکمرانی مطلوب" $rf $gn3 400 810 1120 35 'Center'
    $rf.Dispose();$gn3.Dispose()

    # Key note
    $nb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(30,255,193,7))
    RRect $g $nb 400 870 1120 90 15;$nb.Dispose()
    $nf=New-Object System.Drawing.Font("Tahoma",16,[System.Drawing.FontStyle]::Italic)
    $gr=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,100,100,100))
    RTL $g "💡 دو بازو مستقل از هم عمل می‌کنند ولی گزارش‌هایشان مکمل است" $nf $gr 420 885 1080 25 'Near'
    RTL $g "برای هر تصمیم مهم، مجلس هر دو گزارش را دریافت و بررسی می‌کند" $nf $gr 420 915 1080 25 'Near'
    $nf.Dispose();$gr.Dispose()

    $bf.Dispose();$db.Dispose()
    Footer $g 16
}

# ===================== SLIDE 17 - EMERGENCY DECREES =====================
MakeSlide "Slide_17_Emergency_Decrees.png" {
    param($g)
    GradBG $g $Red ([System.Drawing.Color]::FromArgb(255,183,28,28))

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,255,255))
    $g.FillEllipse($tb,1500,-50,350,350);$g.FillEllipse($tb,-80,700,300,300);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",30,[System.Drawing.FontStyle]::Bold)
    $rb=New-Object System.Drawing.SolidBrush($Red)
    RTL $g "🔴 فرمان‌های اضطراری — هفته‌ی اول مجلس مهستان" $hf $rb 60 26 1800 50 'Near'
    $hf.Dispose();$rb.Dispose()

    $mc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $mc 40 115 1840 890 28;$mc.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # 10 emergency decrees
    $decrees = @(
        @{Num="۱";Text="آزادی فوری تمام زندانیان سیاسی و عقیدتی";Icon="🔓";Color=$Green},
        @{Num="۲";Text="لغو حجاب اجباری و قوانین کنترل پوشش";Icon="👗";Color=$Pink},
        @{Num="۳";Text="رفع کامل فیلترینگ و سانسور اینترنت";Icon="🌐";Color=$Cyan},
        @{Num="۴";Text="تعلیق مجازات اعدام تا بررسی نهایی";Icon="⛔";Color=$Red},
        @{Num="۵";Text="آزادی فعالیت احزاب، اتحادیه‌ها و تشکل‌ها";Icon="🏛️";Color=$Royal},
        @{Num="۶";Text="ممنوعیت بازداشت بدون حکم قضایی";Icon="⚖️";Color=$Purple},
        @{Num="۷";Text="لغو فوری محاکم انقلاب و دادگاه ویژه روحانیت";Icon="🔨";Color=$Navy},
        @{Num="۸";Text="اعلام حق بازگشت آزادانه‌ی تبعیدیان";Icon="✈️";Color=$Teal},
        @{Num="۹";Text="مسدودسازی حساب‌های مشکوک نهادهای حکومتی";Icon="🔒";Color=$Orange},
        @{Num="۱۰";Text="دستور حفاظت از اسناد و بایگانی‌های امنیتی";Icon="📁";Color=[System.Drawing.Color]::FromArgb(255,121,85,72)}
    )

    $col1X = 960; $col2X = 60
    $cardW = 880; $cardH = 72

    for($i=0;$i -lt 10;$i++){
        $d = $decrees[$i]
        $col = $i % 2
        $row = [math]::Floor($i / 2)
        $x = if($col -eq 0){$col1X}else{$col2X}
        $y = 130 + ($row * 82)

        $cb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(20,$d.Color.R,$d.Color.G,$d.Color.B))
        RRect $g $cb $x $y $cardW $cardH 14;$cb.Dispose()

        # colored left bar
        $bar=New-Object System.Drawing.SolidBrush($d.Color)
        $g.FillRectangle($bar,($x+$cardW-6),$y,6,$cardH);$bar.Dispose()

        # number circle
        $nc=New-Object System.Drawing.SolidBrush($d.Color)
        $g.FillEllipse($nc,($x+$cardW-55),($y+17),38,38);$nc.Dispose()
        $nf=New-Object System.Drawing.Font("Tahoma",14,[System.Drawing.FontStyle]::Bold)
        $wb=New-Object System.Drawing.SolidBrush($Wh)
        RTL $g $d.Num $nf $wb ($x+$cardW-52) ($y+25) 32 20 'Center'
        $nf.Dispose();$wb.Dispose()

        # icon & text
        $ef=New-Object System.Drawing.Font("Segoe UI Emoji",20)
        $g.DrawString($d.Icon,$ef,$db,($x+$cardW-95),($y+20));$ef.Dispose()

        $tf=New-Object System.Drawing.Font("Tahoma",16,[System.Drawing.FontStyle]::Bold)
        $tcb=New-Object System.Drawing.SolidBrush($d.Color)
        RTL $g $d.Text $tf $tcb ($x+15) ($y+22) ($cardW-120) 28 'Near'
        $tf.Dispose();$tcb.Dispose()
    }

    # Bottom note
    $noteBg=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,255,235,238))
    RRect $g $noteBg 60 560 1800 420 22;$noteBg.Dispose()
    $redBar=New-Object System.Drawing.SolidBrush($Red)
    $g.FillRectangle($redBar,60,560,1800,10);$redBar.Dispose()

    $ntf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    $rb2=New-Object System.Drawing.SolidBrush($Red)
    RTL $g "⚡ ویژگی فرمان‌های اضطراری:" $ntf $rb2 100 585 1720 35 'Near'
    $ntf.Dispose();$rb2.Dispose()

    $bf=New-Object System.Drawing.Font("Tahoma",18)
    $features=@(
        "✅  بلافاصله پس از تشکیل مجلس صادر می‌شوند",
        "✅  بدون نیاز به فرایند قانون‌گذاری عادی",
        "✅  با رأی اکثریت ساده (۵۰٪ + ۱) قابل تصویب",
        "✅  نمادین و سرنوشت‌ساز — پیام آزادی و تغییر واقعی"
    )
    $y=640
    foreach($f in $features){RTL $g $f $bf $db 100 $y 1720 30 'Near';$y+=48}

    # importance box
    $imb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(30,255,193,7))
    RRect $g $imb 100 840 1720 110 18;$imb.Dispose()
    $gld=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,230,140,0))
    $itf=New-Object System.Drawing.Font("Tahoma",18,[System.Drawing.FontStyle]::Bold)
    RTL $g "💡 چرا مهم است؟" $itf $gld 120 860 1680 30 'Near'
    $itf.Dispose();$gld.Dispose()
    $sf=New-Object System.Drawing.Font("Tahoma",17)
    RTL $g "این ۱۰ فرمان نشانه‌ی قاطع پایان سرکوب و آغاز دوران جدید است — پیامی روشن به مردم ایران و جهان" $sf $db 120 900 1680 30 'Near'
    $sf.Dispose()

    $bf.Dispose();$db.Dispose()
    Footer $g 17
}

Write-Host "`n=== BATCH 3 DONE: Slides 15-17 ===" -ForegroundColor Cyan

# === BATCH 4: Slides 18-21 - Legislative & Process ===
Add-Type -AssemblyName System.Drawing
$dir = "D:\Code\Books\Mahestan\Slides"
if(!(Test-Path $dir)){New-Item -ItemType Directory -Path $dir -Force}

$Indigo=[System.Drawing.Color]::FromArgb(255,26,35,126);$Royal=[System.Drawing.Color]::FromArgb(255,63,81,181);$Gold=[System.Drawing.Color]::FromArgb(255,255,193,7);$Teal=[System.Drawing.Color]::FromArgb(255,0,150,136);$Purple=[System.Drawing.Color]::FromArgb(255,103,58,183);$Pink=[System.Drawing.Color]::FromArgb(255,233,30,99);$Wh=[System.Drawing.Color]::White;$Dk=[System.Drawing.Color]::FromArgb(255,33,33,33);$Navy=[System.Drawing.Color]::FromArgb(255,13,71,161);$Green=[System.Drawing.Color]::FromArgb(255,46,125,50);$Orange=[System.Drawing.Color]::FromArgb(255,230,81,0);$Red=[System.Drawing.Color]::FromArgb(255,198,40,40);$Cyan=[System.Drawing.Color]::FromArgb(255,0,188,212)

function MakeSlide($fname,[scriptblock]$draw){$bmp=New-Object System.Drawing.Bitmap(1920,1080);$g=[System.Drawing.Graphics]::FromImage($bmp);$g.SmoothingMode='AntiAlias';$g.TextRenderingHint='ClearTypeGridFit';& $draw $g;$bmp.Save((Join-Path $dir $fname),[System.Drawing.Imaging.ImageFormat]::Png);$g.Dispose();$bmp.Dispose();Write-Host "Saved $fname" -ForegroundColor Green}
function GradBG($g,$c1,$c2){$b=New-Object System.Drawing.Drawing2D.LinearGradientBrush([System.Drawing.Rectangle]::new(0,0,1920,1080),$c1,$c2,45);$g.FillRectangle($b,0,0,1920,1080);$b.Dispose()}
function RRect($g,$brush,$x,$y,$w,$h,$r){$p=New-Object System.Drawing.Drawing2D.GraphicsPath;$p.AddArc($x,$y,$r,$r,180,90);$p.AddArc($x+$w-$r,$y,$r,$r,270,90);$p.AddArc($x+$w-$r,$y+$h-$r,$r,$r,0,90);$p.AddArc($x,$y+$h-$r,$r,$r,90,90);$p.CloseFigure();$g.FillPath($brush,$p);$p.Dispose()}
function RTL($g,$txt,$font,$brush,$x,$y,$w,$h,$al='Near'){$sf=New-Object System.Drawing.StringFormat;$sf.FormatFlags=[System.Drawing.StringFormatFlags]::DirectionRightToLeft;$sf.Alignment=[System.Drawing.StringAlignment]::$al;$sf.LineAlignment='Near';$g.DrawString($txt,$font,$brush,[System.Drawing.RectangleF]::new($x,$y,$w,$h),$sf);$sf.Dispose()}
function Footer($g,$n){$b=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180,0,0,0));$g.FillRectangle($b,0,1035,1920,45);$f=New-Object System.Drawing.Font("Tahoma",13);$w=New-Object System.Drawing.SolidBrush($Wh);$g.DrawString("$n / 25",$f,$w,40,1043);RTL $g "طرح مهستان — چارچوب نهادی گذار ایران" $f $w 700 1043 1170 30 'Near';$f.Dispose();$w.Dispose();$b.Dispose()}

# ===================== SLIDE 18 - LEGISLATIVE PRIORITIES =====================
MakeSlide "Slide_18_Legislative_Priorities.png" {
    param($g)
    GradBG $g $Orange ([System.Drawing.Color]::FromArgb(255,191,54,12))

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,255,255))
    $g.FillEllipse($tb,1500,-50,350,350);$g.FillEllipse($tb,-80,600,300,300);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",30,[System.Drawing.FontStyle]::Bold)
    $ob=New-Object System.Drawing.SolidBrush($Orange)
    RTL $g "📋 اولویت‌های تقنینی ۱۰۰ روز اول (هفته ۱ تا ۱۴)" $hf $ob 60 26 1800 50 'Near'
    $hf.Dispose();$ob.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # High Priority (Week 1-4)
    $c1=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,243,224))
    RRect $g $c1 980 115 880 440 22;$c1.Dispose()
    $ob2=New-Object System.Drawing.SolidBrush($Orange)
    $g.FillRectangle($ob2,980,115,880,10);$ob2.Dispose()

    $tf=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    $ob3=New-Object System.Drawing.SolidBrush($Orange)
    RTL $g "🟠 اولویت بالا — هفته ۱ تا ۴" $tf $ob3 1000 135 830 35 'Near'
    $tf.Dispose();$ob3.Dispose()

    $bf=New-Object System.Drawing.Font("Tahoma",15)
    $high=@(
        "📰  قانون آزادی مطبوعات و رسانه‌ها",
        "🏛️  قانون تشکیل احزاب و تشکل‌های مدنی",
        "📢  قانون اجتماعات و تظاهرات (آزادی بدون مجوز)",
        "💰  قانون موقت مدیریت بحران اقتصادی",
        "🔍  قانون شفافیت مالی مقامات",
        "👩  لغو قوانین تبعیض‌آمیز علیه زنان",
        "🌈  قانون حقوق اقلیت‌ها و آموزش به زبان مادری",
        "🔒  قانون موقت حفاظت از داده‌های شخصی"
    )
    $y=180
    foreach($h in $high){RTL $g $h $bf $db 1000 $y 830 26 'Near';$y+=37}

    # Medium Priority (Week 4-8)
    $c2=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,249,196))
    RRect $g $c2 60 115 880 440 22;$c2.Dispose()
    $gld=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,249,168,37))
    $g.FillRectangle($gld,60,115,880,10);$gld.Dispose()

    $tf2=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    $gld2=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,249,168,37))
    RTL $g "🟡 اولویت متوسط — هفته ۴ تا ۸" $tf2 $gld2 80 135 830 35 'Near'
    $tf2.Dispose();$gld2.Dispose()

    $medium=@(
        "⚖️  قانون عدالت انتقالی و جرم سیاسی",
        "🔍  قانون تشکیل کمیسیون حقیقت‌یابی و آشتی ملی",
        "🛡️  قانون اصلاح بخش امنیتی (SSR)",
        "⚔️  قانون موقت استقلال قوه قضاییه",
        "🏦  قانون استقلال بانک مرکزی",
        "📊  قانون حسابرسی ملی (بنیادها، سپاه، آستان‌ها)"
    )
    $y=180
    foreach($m in $medium){RTL $g $m $bf $db 80 $y 830 26 'Near';$y+=42}

    # Normal Priority (Week 8-14)
    $c3=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,200,230,201))
    RRect $g $c3 60 580 1800 395 22;$c3.Dispose()
    $gn=New-Object System.Drawing.SolidBrush($Green)
    $g.FillRectangle($gn,60,580,1800,10);$gn.Dispose()

    $tf3=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    $gn2=New-Object System.Drawing.SolidBrush($Green)
    RTL $g "🟢 اولویت عادی — هفته ۸ تا ۱۴ (پس از قانون اساسی موقت)" $tf3 $gn2 100 600 1720 35 'Near'
    $tf3.Dispose();$gn2.Dispose()

    $normal=@(
        @{T="🌿  قانون جامع محیط زیست (اقدامات اضطراری بحران آب)";X=990},
        @{T="📚  قانون اصلاح نظام آموزشی (حذف محتوای ایدئولوژیک)";X=990},
        @{T="🏭  قانون خصوصی‌سازی شفاف نهادهای حکومتی";X=990},
        @{T="💵  قانون سرمایه‌گذاری خارجی";X=100},
        @{T="🏛️  قانون تشکیل مجلس مؤسسان (قانون اساسی نهایی)";X=100},
        @{T="🌐  الحاق به کنوانسیون‌های بین‌المللی (CEDAW, CAT, CRC)";X=100}
    )
    $yLeft=650;$yRight=650
    foreach($n in $normal){
        if($n.X -eq 990){RTL $g $n.T $bf $db 990 $yRight 770 26 'Near';$yRight+=42}
        else{RTL $g $n.T $bf $db 100 $yLeft 770 26 'Near';$yLeft+=42}
    }

    $bf.Dispose();$db.Dispose()
    Footer $g 18
}

# ===================== SLIDE 19 - LEGISLATIVE PROCESS =====================
MakeSlide "Slide_19_Legislative_Process.png" {
    param($g)
    GradBG $g $Purple ([System.Drawing.Color]::FromArgb(255,69,39,160))

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,255,255))
    $g.FillEllipse($tb,1500,600,350,350);$g.FillEllipse($tb,-80,200,300,300);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",30,[System.Drawing.FontStyle]::Bold)
    $pp=New-Object System.Drawing.SolidBrush($Purple)
    RTL $g "فرایند تقنینی — از طرح تا اجرا" $hf $pp 80 26 1760 50 'Near'
    $hf.Dispose();$pp.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # 8 steps as flow
    $steps = @(
        @{Num="۱";Title="ارائه طرح/لایحه";Desc="نمایندگان (۱۰+ امضا) یا کابینه یا طومار ۱۰۰هزار+";Color=$Red},
        @{Num="۲";Title="ارجاع به کمیسیون";Desc="+ درخواست هم‌زمان از دو بازو";Color=$Orange},
        @{Num="۳";Title="گزارش تکنوکراتیک";Desc="داده، تحلیل، گزینه‌ها (مرکز تحقیقات)";Color=$Orange},
        @{Num="۴";Title="گزارش دموکراتیک";Desc="نظرسنجی، بازخورد، جلسات عمومی";Color=$Royal},
        @{Num="۵";Title="بررسی کمیسیون";Desc="با هر دو گزارش + استماع متخصصان";Color=$Purple},
        @{Num="۶";Title="صحن مجلس";Desc="بحث آزاد + اصلاحیه + رأی‌گیری";Color=$Teal},
        @{Num="۷";Title="رفراندوم (در صورت لزوم)";Desc="قانون اساسی، ساختار حکومت، موارد سرنوشت‌ساز";Color=$Pink},
        @{Num="۸";Title="اجرا و نظارت";Desc="ابلاغ + اجرا توسط کابینه + نظارت مجلس";Color=$Green}
    )

    $cardW = 420; $cardH = 195
    for($i=0;$i -lt 8;$i++){
        $s = $steps[$i]
        $col = $i % 4
        $row = [math]::Floor($i / 4)
        $x = 60 + (3 - $col) * 460   # RTL order
        $y = 120 + ($row * 225)

        $cb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
        RRect $g $cb $x $y $cardW $cardH 18;$cb.Dispose()

        $bar=New-Object System.Drawing.SolidBrush($s.Color)
        $g.FillRectangle($bar,$x,$y,$cardW,10);$bar.Dispose()

        # number circle
        $nc=New-Object System.Drawing.SolidBrush($s.Color)
        $g.FillEllipse($nc,($x+$cardW-50),($y+20),40,40);$nc.Dispose()
        $nf=New-Object System.Drawing.Font("Tahoma",16,[System.Drawing.FontStyle]::Bold)
        $wb=New-Object System.Drawing.SolidBrush($Wh)
        RTL $g $s.Num $nf $wb ($x+$cardW-47) ($y+28) 34 22 'Center'
        $nf.Dispose();$wb.Dispose()

        $tf=New-Object System.Drawing.Font("Tahoma",17,[System.Drawing.FontStyle]::Bold)
        $tcb=New-Object System.Drawing.SolidBrush($s.Color)
        RTL $g $s.Title $tf $tcb ($x+15) ($y+25) ($cardW-75) 28 'Near'
        $tf.Dispose();$tcb.Dispose()

        $sp=New-Object System.Drawing.Pen($s.Color,1)
        $g.DrawLine($sp,($x+15),($y+60),($x+$cardW-15),($y+60));$sp.Dispose()

        $df=New-Object System.Drawing.Font("Tahoma",14)
        RTL $g $s.Desc $df $db ($x+15) ($y+72) ($cardW-30) 100 'Near'
        $df.Dispose()
    }

    # Voting thresholds
    $vb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $vb 60 590 1800 400 22;$vb.Dispose()

    $vtf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    $pp2=New-Object System.Drawing.SolidBrush($Purple)
    RTL $g "📊 آستانه‌های رأی‌گیری:" $vtf $pp2 100 610 1720 35 'Near'
    $vtf.Dispose();$pp2.Dispose()

    $bf=New-Object System.Drawing.Font("Tahoma",18)
    $votes=@(
        "•  قوانین عادی:  اکثریت ساده (۵۰٪ + ۱)",
        "•  قوانین مهم:  ⅔ آرا (دو سوم)",
        "•  اصلاح قانون اساسی موقت:  ¾ آرا (سه چهارم)",
        "•  رفراندوم:  ۵۰٪+۱ با حداقل ۴۰٪ مشارکت"
    )
    $y=660
    foreach($v in $votes){RTL $g $v $bf $db 120 $y 1680 32 'Near';$y+=48}

    # Mandatory referendum
    $mrb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,252,228,236))
    RRect $g $mrb 100 860 1720 100 18;$mrb.Dispose()
    $pkb=New-Object System.Drawing.SolidBrush($Pink)
    $mrf=New-Object System.Drawing.Font("Tahoma",17,[System.Drawing.FontStyle]::Bold)
    RTL $g "🗳️ رفراندوم الزامی برای:" $mrf $pkb 120 875 1680 28 'Near'
    $mrf.Dispose();$pkb.Dispose()
    $sf=New-Object System.Drawing.Font("Tahoma",16)
    RTL $g "قانون اساسی موقت/نهایی • نوع حکومت • ساختار حکمرانی • موارد سرنوشت‌ساز (⅔ مجلس) • ۵۰۰هزار+ امضا" $sf $db 120 910 1680 28 'Near'
    $sf.Dispose()

    $bf.Dispose();$db.Dispose()
    Footer $g 19
}

# ===================== SLIDE 20 - FUNDAMENTAL PRINCIPLES =====================
MakeSlide "Slide_20_Fundamental_Principles.png" {
    param($g)
    GradBG $g $Indigo $Navy

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(22,255,193,7))
    $g.FillEllipse($tb,1500,-50,400,400);$g.FillEllipse($tb,-80,700,300,300);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",30,[System.Drawing.FontStyle]::Bold)
    $ib=New-Object System.Drawing.SolidBrush($Indigo)
    RTL $g "🛡️ اصول بنیادین غیرقابل‌نقض" $hf $ib 80 26 1760 50 'Near'
    $hf.Dispose();$ib.Dispose()

    # warning box
    $wb2=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40,255,255,255))
    RRect $g $wb2 60 115 1800 60 18;$wb2.Dispose()
    $wt=New-Object System.Drawing.SolidBrush($Wh)
    $wf=New-Object System.Drawing.Font("Tahoma",18,[System.Drawing.FontStyle]::Bold)
    RTL $g "⚠️ هیچ نهادی — حتی مجلس مهستان — حق تعلیق یا نقض این اصول را ندارد" $wf $wt 80 130 1760 35 'Center'
    $wf.Dispose();$wt.Dispose()

    $mc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $mc 40 195 1840 810 28;$mc.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    $principles = @(
        @{N="۱";T="حاکمیت مردم";D="تنها منبع مشروعیت = رأی آزاد مردم";C=$Royal},
        @{N="۲";T="جدایی دین از دولت";D="بی‌طرفی دولت، آزادی عبادت و عقیده";C=$Purple},
        @{N="۳";T="برابری";D="صرف‌نظر از جنسیت، قومیت، مذهب، گرایش";C=$Pink},
        @{N="۴";T="آزادی‌های بنیادین";D="بیان، مطبوعات، تجمع، تشکل، عقیده";C=$Teal},
        @{N="۵";T="ممنوعیت مطلق شکنجه";D="تحت هیچ شرایطی مجاز نیست";C=$Red},
        @{N="۶";T="حق دادرسی عادلانه";D="وکیل، محاکمه علنی، فرض بی‌گناهی";C=$Navy},
        @{N="۷";T="حقوق اقلیت‌ها";D="قومی، زبانی، مذهبی، آموزش به زبان مادری";C=$Green},
        @{N="۸";T="حقوق زنان";D="برابری کامل حقوقی، اجتماعی، اقتصادی";C=$Pink},
        @{N="۹";T="استقلال قضایی";D="مستقل از مجریه و مقننه";C=$Purple},
        @{N="۱۰";T="تمامیت ارضی";D="ساختار حکمرانی از طریق رفراندوم";C=$Indigo},
        @{N="۱۱";T="حاکمیت قانون";D="هیچ فرد یا نهادی بالاتر از قانون نیست";C=$Navy},
        @{N="۱۲";T="عدالت نه انتقام";D="عدالت از مسیرهای قانونی";C=$Orange},
        @{N="۱۳";T="آزادی اطلاعات";D="ممنوعیت سانسور و فیلترینگ";C=$Cyan},
        @{N="۱۴";T="تعهد به صلح";D="حل مسالمت‌آمیز اختلافات بین‌المللی";C=$Teal}
    )

    $cardW = 580; $cardH = 52
    for($i=0;$i -lt 14;$i++){
        $p = $principles[$i]
        $col = $i % 3
        $row = [math]::Floor($i / 3)
        $x = 60 + (2 - $col) * 610
        $y = 215 + ($row * 62)

        $cb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(20,$p.C.R,$p.C.G,$p.C.B))
        RRect $g $cb $x $y $cardW $cardH 12;$cb.Dispose()

        $bar=New-Object System.Drawing.SolidBrush($p.C)
        $g.FillRectangle($bar,($x+$cardW-6),$y,6,$cardH);$bar.Dispose()

        # number
        $nc=New-Object System.Drawing.SolidBrush($p.C)
        $g.FillEllipse($nc,($x+$cardW-42),($y+10),32,32);$nc.Dispose()
        $nf=New-Object System.Drawing.Font("Tahoma",12,[System.Drawing.FontStyle]::Bold)
        $wbb=New-Object System.Drawing.SolidBrush($Wh)
        RTL $g $p.N $nf $wbb ($x+$cardW-40) ($y+16) 28 18 'Center'
        $nf.Dispose();$wbb.Dispose()

        $tf=New-Object System.Drawing.Font("Tahoma",14,[System.Drawing.FontStyle]::Bold)
        $tcb=New-Object System.Drawing.SolidBrush($p.C)
        RTL $g $p.T $tf $tcb ($x+10) ($y+6) ($cardW-60) 20 'Near'
        $tf.Dispose();$tcb.Dispose()

        $df=New-Object System.Drawing.Font("Tahoma",12)
        RTL $g $p.D $df $db ($x+10) ($y+28) ($cardW-60) 18 'Near'
        $df.Dispose()
    }

    # Bottom emphasis
    $eb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,255,243,224))
    RRect $g $eb 60 540 1800 440 22;$eb.Dispose()
    $gldBar=New-Object System.Drawing.SolidBrush($Gold)
    $g.FillRectangle($gldBar,60,540,1800,12);$gldBar.Dispose()

    $etf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    $gld=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,230,140,0))
    RTL $g "💡 چرا غیرقابل‌نقض؟" $etf $gld 100 570 1720 35 'Near'
    $etf.Dispose();$gld.Dispose()

    $ef=New-Object System.Drawing.Font("Tahoma",18)
    $reasons=@(
        "✅  این اصول خطوط قرمز مطلق دوران گذار هستند",
        "✅  قانون اساسی نهایی نیز ملزم به رعایت آن‌هاست",
        "✅  هیچ اکثریتی حق محدود کردن حقوق بنیادین اقلیت‌ها را ندارد",
        "✅  مبتنی بر اعلامیه جهانی حقوق بشر و کنوانسیون‌های بین‌المللی",
        "✅  تضمین‌کننده‌ی بازگشت‌ناپذیری فرایند دموکراتیک‌سازی"
    )
    $y=620
    foreach($r in $reasons){RTL $g $r $ef $db 100 $y 1720 30 'Near';$y+=48}

    # Shield visual
    $shb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(30,26,35,126))
    $ef2=New-Object System.Drawing.Font("Segoe UI Emoji",60)
    $g.DrawString("🛡️",$ef2,$db,890,850);$ef2.Dispose()

    $stf=New-Object System.Drawing.Font("Tahoma",16,[System.Drawing.FontStyle]::Bold)
    $ib2=New-Object System.Drawing.SolidBrush($Indigo)
    RTL $g "حافظ حقوق همه‌ی ایرانیان — امروز و فردا" $stf $ib2 500 940 920 28 'Center'
    $stf.Dispose();$ib2.Dispose()

    $ef.Dispose();$db.Dispose()
    Footer $g 20
}

# === BATCH 4 CONTINUED + BATCH 5: Slides 21-25 ===
Add-Type -AssemblyName System.Drawing
$dir = "D:\Code\Books\Mahestan\Slides"
if(!(Test-Path $dir)){New-Item -ItemType Directory -Path $dir -Force}

$Indigo=[System.Drawing.Color]::FromArgb(255,26,35,126);$Royal=[System.Drawing.Color]::FromArgb(255,63,81,181);$Gold=[System.Drawing.Color]::FromArgb(255,255,193,7);$Teal=[System.Drawing.Color]::FromArgb(255,0,150,136);$Purple=[System.Drawing.Color]::FromArgb(255,103,58,183);$Pink=[System.Drawing.Color]::FromArgb(255,233,30,99);$Wh=[System.Drawing.Color]::White;$Dk=[System.Drawing.Color]::FromArgb(255,33,33,33);$Navy=[System.Drawing.Color]::FromArgb(255,13,71,161);$Green=[System.Drawing.Color]::FromArgb(255,46,125,50);$Orange=[System.Drawing.Color]::FromArgb(255,230,81,0);$Red=[System.Drawing.Color]::FromArgb(255,198,40,40);$Cyan=[System.Drawing.Color]::FromArgb(255,0,188,212)

function MakeSlide($fname,[scriptblock]$draw){$bmp=New-Object System.Drawing.Bitmap(1920,1080);$g=[System.Drawing.Graphics]::FromImage($bmp);$g.SmoothingMode='AntiAlias';$g.TextRenderingHint='ClearTypeGridFit';& $draw $g;$bmp.Save((Join-Path $dir $fname),[System.Drawing.Imaging.ImageFormat]::Png);$g.Dispose();$bmp.Dispose();Write-Host "Saved $fname" -ForegroundColor Green}
function GradBG($g,$c1,$c2){$b=New-Object System.Drawing.Drawing2D.LinearGradientBrush([System.Drawing.Rectangle]::new(0,0,1920,1080),$c1,$c2,45);$g.FillRectangle($b,0,0,1920,1080);$b.Dispose()}
function RRect($g,$brush,$x,$y,$w,$h,$r){$p=New-Object System.Drawing.Drawing2D.GraphicsPath;$p.AddArc($x,$y,$r,$r,180,90);$p.AddArc($x+$w-$r,$y,$r,$r,270,90);$p.AddArc($x+$w-$r,$y+$h-$r,$r,$r,0,90);$p.AddArc($x,$y+$h-$r,$r,$r,90,90);$p.CloseFigure();$g.FillPath($brush,$p);$p.Dispose()}
function RTL($g,$txt,$font,$brush,$x,$y,$w,$h,$al='Near'){$sf=New-Object System.Drawing.StringFormat;$sf.FormatFlags=[System.Drawing.StringFormatFlags]::DirectionRightToLeft;$sf.Alignment=[System.Drawing.StringAlignment]::$al;$sf.LineAlignment='Near';$g.DrawString($txt,$font,$brush,[System.Drawing.RectangleF]::new($x,$y,$w,$h),$sf);$sf.Dispose()}
function Footer($g,$n){$b=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180,0,0,0));$g.FillRectangle($b,0,1035,1920,45);$f=New-Object System.Drawing.Font("Tahoma",13);$w=New-Object System.Drawing.SolidBrush($Wh);$g.DrawString("$n / 25",$f,$w,40,1043);RTL $g "طرح مهستان — چارچوب نهادی گذار ایران" $f $w 700 1043 1170 30 'Near';$f.Dispose();$w.Dispose();$b.Dispose()}

# ===================== SLIDE 21 - FULL INSTITUTIONAL STRUCTURE =====================
MakeSlide "Slide_21_Full_Structure.png" {
    param($g)
    GradBG $g ([System.Drawing.Color]::FromArgb(255,27,94,32)) $Green

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,255,255))
    $g.FillEllipse($tb,1500,-50,350,350);$g.FillEllipse($tb,-80,700,280,280);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",30,[System.Drawing.FontStyle]::Bold)
    $gn=New-Object System.Drawing.SolidBrush($Green)
    RTL $g "🏛️ نمودار جامع ساختار نهادی گذار" $hf $gn 80 26 1760 50 'Near'
    $hf.Dispose();$gn.Dispose()

    $mc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $mc 40 115 1840 890 28;$mc.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # TOP: People
    $pb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(50,21,101,192))
    RRect $g $pb 660 130 600 70 18;$pb.Dispose()
    $tf=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    $bl=New-Object System.Drawing.SolidBrush($Royal)
    RTL $g "🗳️ مردم ایران — حاکمیت مطلق" $tf $bl 680 143 560 35 'Center'

    # Arrow down
    $ap=New-Object System.Drawing.Pen($Gold,4)
    $g.DrawLine($ap,960,200,960,240);$ap.Dispose()
    $gb=New-Object System.Drawing.SolidBrush($Gold)
    $pts=@([System.Drawing.Point]::new(945,240),[System.Drawing.Point]::new(975,240),[System.Drawing.Point]::new(960,260))
    $g.FillPolygon($gb,$pts);$gb.Dispose()

    # CENTER: Mahestan
    $mhb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(50,46,125,50))
    RRect $g $mhb 560 265 800 80 20;$mhb.Dispose()
    $gn2=New-Object System.Drawing.SolidBrush($Green)
    $mtf=New-Object System.Drawing.Font("Tahoma",24,[System.Drawing.FontStyle]::Bold)
    RTL $g "🏛️ مجلس مهستان — ۳۰۰ نماینده — حداکثر ۲ سال" $mtf $gn2 580 280 760 40 'Center'
    $mtf.Dispose()

    # Two arms - left and right of Mahestan
    # Technocratic arm (left side)
    $ta=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40,230,81,0))
    RRect $g $ta 60 270 460 75 15;$ta.Dispose()
    $ob=New-Object System.Drawing.SolidBrush($Orange)
    $af=New-Object System.Drawing.Font("Tahoma",15,[System.Drawing.FontStyle]::Bold)
    RTL $g "🔬 بازوی تکنوکراتیک — مرکز تحقیقات" $af $ob 70 287 440 30 'Near'
    $af.Dispose();$ob.Dispose()

    # Democratic arm (right side)
    $da=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40,63,81,181))
    RRect $g $da 1400 270 460 75 15;$da.Dispose()
    $bl2=New-Object System.Drawing.SolidBrush($Royal)
    $af2=New-Object System.Drawing.Font("Tahoma",15,[System.Drawing.FontStyle]::Bold)
    RTL $g "📢 بازوی دموکراتیک — واحد ارتباط مردمی" $af2 $bl2 1410 287 440 30 'Near'
    $af2.Dispose();$bl2.Dispose()

    # Connection lines
    $cp=New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(100,100,100,100),2)
    $g.DrawLine($cp,520,305,560,305) # tech arm to mahestan
    $g.DrawLine($cp,1360,305,1400,305) # demo arm to mahestan
    $cp.Dispose()

    # Arrows down from Mahestan
    $institutions = @(
        @{X=100;Title="⚙️ کابینه اجرایی";Color=$Gold;W=240},
        @{X=370;Title="⚖️ شورای قضایی";Color=$Purple;W=240},
        @{X=640;Title="🛡️ فرماندهی نظامی";Color=$Navy;W=240},
        @{X=910;Title="🔄 کمیسیون SSR";Color=$Teal;W=240},
        @{X=1180;Title="📋 حقیقت‌یابی";Color=$Red;W=220},
        @{X=1420;Title="🗳️ نظارت انتخابات";Color=$Royal;W=220},
        @{X=1660;Title="👤 آمبودزمان";Color=$Green;W=220}
    )

    foreach($inst in $institutions){
        # arrow
        $iap=New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(120,$inst.Color.R,$inst.Color.G,$inst.Color.B),2)
        $cx = $inst.X + $inst.W/2
        $g.DrawLine($iap,$cx,345,$cx,380)
        $iap.Dispose()

        # card
        $icb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(30,$inst.Color.R,$inst.Color.G,$inst.Color.B))
        RRect $g $icb $inst.X 385 $inst.W 55 12;$icb.Dispose()
        $bar=New-Object System.Drawing.SolidBrush($inst.Color)
        $g.FillRectangle($bar,$inst.X,385,$inst.W,5);$bar.Dispose()
        $itf=New-Object System.Drawing.Font("Tahoma",12,[System.Drawing.FontStyle]::Bold)
        $itb=New-Object System.Drawing.SolidBrush($inst.Color)
        RTL $g $inst.Title $itf $itb ($inst.X+5) 400 ($inst.W-10) 22 'Center'
        $itf.Dispose();$itb.Dispose()
    }

    # More institutions row 2
    $inst2 = @(
        @{X=100;Title="📺 کمیسیون رسانه‌ها";Color=$Cyan;W=280},
        @{X=410;Title="📊 شورای اقتصادی";Color=$Orange;W=280},
        @{X=720;Title="📜 قانون اساسی موقت";Color=$Purple;W=280},
        @{X=1030;Title="📜 قانون اساسی نهایی";Color=[System.Drawing.Color]::FromArgb(255,142,36,170);W=280},
        @{X=1340;Title="🤝 هیأت میانجی‌گری";Color=$Green;W=280}
    )

    foreach($inst in $inst2){
        $icb2=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(25,$inst.Color.R,$inst.Color.G,$inst.Color.B))
        RRect $g $icb2 $inst.X 465 $inst.W 50 12;$icb2.Dispose()
        $bar2=New-Object System.Drawing.SolidBrush($inst.Color)
        $g.FillRectangle($bar2,$inst.X,465,$inst.W,5);$bar2.Dispose()
        $itf2=New-Object System.Drawing.Font("Tahoma",12,[System.Drawing.FontStyle]::Bold)
        $itb2=New-Object System.Drawing.SolidBrush($inst.Color)
        RTL $g $inst.Title $itf2 $itb2 ($inst.X+5) 480 ($inst.W-10) 22 'Center'
        $itf2.Dispose();$itb2.Dispose()
    }

    # External oversight
    $civil=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(30,0,188,212))
    RRect $g $civil 60 545 880 200 20;$civil.Dispose()
    $cb=New-Object System.Drawing.SolidBrush($Cyan)
    $g.FillRectangle($cb,60,545,880,8);$cb.Dispose()

    $ctf=New-Object System.Drawing.Font("Tahoma",18,[System.Drawing.FontStyle]::Bold)
    $cc=New-Object System.Drawing.SolidBrush($Cyan)
    RTL $g "🏘️ جامعه‌ی مدنی — نظارت و مشاوره" $ctf $cc 80 565 830 30 'Near'
    $ctf.Dispose();$cc.Dispose()
    $cf=New-Object System.Drawing.Font("Tahoma",15)
    $civItems=@("• کانون وکلا • اتحادیه‌ها • انجمن‌ها • رسانه‌ها","• نظارت مستقل بر تمام نهادها","• گزارش‌دهی عمومی و مطالبه‌گری")
    $y=605
    foreach($c in $civItems){RTL $g $c $cf $db 80 $y 830 25 'Near';$y+=35}
    $cf.Dispose()

    $intl=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(30,46,125,50))
    RRect $g $intl 980 545 880 200 20;$intl.Dispose()
    $gn3=New-Object System.Drawing.SolidBrush($Green)
    $g.FillRectangle($gn3,980,545,880,8);$gn3.Dispose()

    $itf3=New-Object System.Drawing.Font("Tahoma",18,[System.Drawing.FontStyle]::Bold)
    $ig=New-Object System.Drawing.SolidBrush($Green)
    RTL $g "🌐 جامعه‌ی بین‌المللی — حمایت فنی" $itf3 $ig 1000 565 830 30 'Near'
    $itf3.Dispose();$ig.Dispose()
    $if2=New-Object System.Drawing.Font("Tahoma",15)
    $intItems=@("• سازمان ملل • کمیسیون ونیز • ICTJ / IDEA","• ناظران بین‌المللی انتخابات","• حمایت اقتصادی و فنی")
    $y=605
    foreach($i2 in $intItems){RTL $g $i2 $if2 $db 1000 $y 830 25 'Near';$y+=35}
    $if2.Dispose()

    # Flow summary
    $fb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,232,245,233))
    RRect $g $fb 60 775 1800 210 22;$fb.Dispose()
    $gnBar=New-Object System.Drawing.SolidBrush($Green)
    $g.FillRectangle($gnBar,60,775,1800,10);$gnBar.Dispose()

    $ftf=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    $gn4=New-Object System.Drawing.SolidBrush($Green)
    RTL $g "🔄 مسیر کلی گذار:" $ftf $gn4 100 800 1720 35 'Near'
    $ftf.Dispose();$gn4.Dispose()

    $ff=New-Object System.Drawing.Font("Tahoma",17)
    $flow=@(
        "مردم ← انتخابات ← مجلس مهستان (۳۰۰ نماینده) ← تشکیل کابینه + نهادها",
        "← قانون اساسی موقت (۲ ماه) + رفراندوم ← عدالت انتقالی + اصلاحات",
        "← مجلس مؤسسان ← قانون اساسی نهایی + رفراندوم ← انتخابات نظام جدید ← انتقال قدرت"
    )
    $y=845
    foreach($fl in $flow){RTL $g $fl $ff $db 100 $y 1720 28 'Near';$y+=40}
    $ff.Dispose()

    $tf.Dispose();$bl.Dispose();$gn2.Dispose();$db.Dispose()
    Footer $g 21
}

# ===================== SLIDE 22 - TIMELINE =====================
MakeSlide "Slide_22_Timeline.png" {
    param($g)
    GradBG $g $Navy ([System.Drawing.Color]::FromArgb(255,21,101,192))

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,255,255))
    $g.FillEllipse($tb,1500,600,350,350);$g.FillEllipse($tb,-80,100,300,300);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",32,[System.Drawing.FontStyle]::Bold)
    $nb=New-Object System.Drawing.SolidBrush($Navy)
    RTL $g "⏱️ خط زمانی جامع گذار ایران" $hf $nb 80 26 1760 50 'Near'
    $hf.Dispose();$nb.Dispose()

    $mc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $mc 40 115 1840 890 28;$mc.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # 6 phases
    $phases = @(
        @{Title="فاز صفر: آمادگی";Time="از هم‌اکنون";Color=$Purple;
          Items=@("نوشتن پیش‌نویس‌های قانون اساسی","تشکیل ائتلاف‌ها و فهرست‌ها","طراحی زیرساخت فنی رأی‌گیری")},
        @{Title="فاز ۱: انتخابات";Time="ماه ۱";Color=$Red;
          Items=@("ثبت‌نام و تبلیغات رسمی (۳ هفته)","برگزاری انتخابات مجلس مهستان","تشکیل مجلس ظرف ۱ هفته")},
        @{Title="فاز ۲: اقدامات فوری";Time="ماه ۱-۲";Color=$Orange;
          Items=@("۱۰ فرمان اضطراری هفته اول","تشکیل کابینه و رأی اعتماد","مصوبات فوری اولویت بالا")},
        @{Title="فاز ۳: قانون اساسی موقت";Time="ماه ۲-۴";Color=$Gold;
          Items=@("کمیسیون ویژه + تدوین متن","بازخوردگیری عمومی","رفراندوم و اجرا")},
        @{Title="فاز ۴: نهادسازی";Time="ماه ۴-۱۸";Color=$Teal;
          Items=@("شورای قضایی + حقیقت‌یابی","عدالت انتقالی + SSR","اصلاحات اقتصادی و اجتماعی")},
        @{Title="فاز ۵: قانون اساسی نهایی";Time="ماه ۱۲-۲۴";Color=$Green;
          Items=@("مجلس مؤسسان + تدوین","مشاوره عمومی گسترده","رفراندوم ← انتخابات ← انتقال قدرت")}
    )

    $cardW = 570; $cardH = 270
    for($i=0;$i -lt 6;$i++){
        $ph = $phases[$i]
        $col = $i % 3
        $row = [math]::Floor($i / 3)
        $x = 60 + (2 - $col) * 610
        $y = 135 + ($row * 310)

        $cb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(20,$ph.Color.R,$ph.Color.G,$ph.Color.B))
        RRect $g $cb $x $y $cardW $cardH 20;$cb.Dispose()

        $bar=New-Object System.Drawing.SolidBrush($ph.Color)
        $g.FillRectangle($bar,$x,$y,$cardW,10);$bar.Dispose()

        # Phase number circle
        $nc=New-Object System.Drawing.SolidBrush($ph.Color)
        $g.FillEllipse($nc,($x+$cardW-55),($y+18),42,42);$nc.Dispose()
        $nf=New-Object System.Drawing.Font("Tahoma",18,[System.Drawing.FontStyle]::Bold)
        $wb=New-Object System.Drawing.SolidBrush($Wh)
        $g.DrawString(($i).ToString(),$nf,$wb,($x+$cardW-42),($y+26));$nf.Dispose();$wb.Dispose()

        # Title
        $tf=New-Object System.Drawing.Font("Tahoma",18,[System.Drawing.FontStyle]::Bold)
        $tcb=New-Object System.Drawing.SolidBrush($ph.Color)
        RTL $g $ph.Title $tf $tcb ($x+15) ($y+22) ($cardW-80) 28 'Near'
        $tf.Dispose();$tcb.Dispose()

        # Time
        $tmf=New-Object System.Drawing.Font("Tahoma",14,[System.Drawing.FontStyle]::Italic)
        $gr=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,120,120,120))
        RTL $g "⏰ $($ph.Time)" $tmf $gr ($x+15) ($y+55) ($cardW-30) 22 'Near'
        $tmf.Dispose();$gr.Dispose()

        # Separator
        $sp=New-Object System.Drawing.Pen($ph.Color,1)
        $g.DrawLine($sp,($x+15),($y+85),($x+$cardW-15),($y+85));$sp.Dispose()

        # Items
        $bf=New-Object System.Drawing.Font("Tahoma",15)
        $iy=$y+100
        foreach($item in $ph.Items){
            RTL $g "✅ $item" $bf $db ($x+15) $iy ($cardW-30) 25 'Near'
            $iy+=38
        }
        $bf.Dispose()
    }

    # Timeline bar at bottom
    $tlb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(40,255,193,7))
    RRect $g $tlb 60 780 1800 200 20;$tlb.Dispose()

    # Progress bar
    $phaseColors = @($Purple,$Red,$Orange,$Gold,$Teal,$Green)
    $phaseWidths = @(200,100,150,200,500,450) # proportional
    $startX = 100
    $barY = 810
    $barH = 35

    for($i=0;$i -lt 6;$i++){
        $pcb=New-Object System.Drawing.SolidBrush($phaseColors[$i])
        RRect $g $pcb $startX $barY $phaseWidths[$i] $barH 8
        $plf=New-Object System.Drawing.Font("Tahoma",11,[System.Drawing.FontStyle]::Bold)
        $pwb=New-Object System.Drawing.SolidBrush($Wh)
        $g.DrawString("F$i",$plf,$pwb,($startX+$phaseWidths[$i]/2-8),($barY+8))
        $plf.Dispose();$pwb.Dispose();$pcb.Dispose()
        $startX += $phaseWidths[$i] + 5
    }

    # Key milestones
    $mf=New-Object System.Drawing.Font("Tahoma",15,[System.Drawing.FontStyle]::Bold)
    $gld=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,200,140,0))
    RTL $g "📌 نقاط عطف کلیدی:" $mf $gld 100 870 1720 28 'Near'
    $mf.Dispose();$gld.Dispose()

    $mlf=New-Object System.Drawing.Font("Tahoma",14)
    $milestones=@(
        "🔴 تشکیل مجلس مهستان → 🟠 تصویب قانون اساسی موقت → 🟡 رفراندوم → 🟢 قانون اساسی نهایی → ✅ انتقال قدرت",
        "⏰ کل فرایند: حداکثر ۲ سال — هدف: گذار مهندسی‌شده، فراگیر و بازگشت‌ناپذیر به دموکراسی"
    )
    $y=905
    foreach($m in $milestones){RTL $g $m $mlf $db 100 $y 1720 25 'Near';$y+=38}
    $mlf.Dispose()

    $db.Dispose()
    Footer $g 22
}

# ===================== SLIDE 23 - ACCOUNTABILITY & SAFEGUARDS =====================
MakeSlide "Slide_23_Accountability.png" {
    param($g)
    GradBG $g $Teal ([System.Drawing.Color]::FromArgb(255,0,105,92))

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,255,255))
    $g.FillEllipse($tb,1500,-50,350,350);$g.FillEllipse($tb,-80,600,300,300);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",30,[System.Drawing.FontStyle]::Bold)
    $tc=New-Object System.Drawing.SolidBrush($Teal)
    RTL $g "🔍 سازوکارهای نظارت، پاسخ‌گویی و حل اختلاف" $hf $tc 60 26 1800 50 'Near'
    $hf.Dispose();$tc.Dispose()

    $mc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $mc 40 115 1840 890 28;$mc.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # Recall mechanism
    $r1=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(35,233,30,99))
    RRect $g $r1 980 135 860 200 22;$r1.Dispose()
    $pkBar=New-Object System.Drawing.SolidBrush($Pink)
    $g.FillRectangle($pkBar,980,135,860,10);$pkBar.Dispose()

    $tf=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    $pk=New-Object System.Drawing.SolidBrush($Pink)
    RTL $g "🗳️ عزل نمایندگان" $tf $pk 1000 160 820 32 'Near'
    $tf.Dispose();$pk.Dispose()

    $bf=New-Object System.Drawing.Font("Tahoma",16)
    $recall=@("• جمع‌آوری ۴۰٪ آرای مأخوذه منطقه","• نماینده عزل می‌شود","• فرد بعدی در فهرست جایگزین","• حق مردم برای بازخواست مستمر")
    $y=205
    foreach($r in $recall){RTL $g $r $bf $db 1000 $y 820 26 'Near';$y+=32}

    # Term limit
    $t1=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(35,230,81,0))
    RRect $g $t1 80 135 860 200 22;$t1.Dispose()
    $obBar=New-Object System.Drawing.SolidBrush($Orange)
    $g.FillRectangle($obBar,80,135,860,10);$obBar.Dispose()

    $tf2=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    $ob=New-Object System.Drawing.SolidBrush($Orange)
    RTL $g "⏰ محدودیت زمانی" $tf2 $ob 100 160 820 32 'Near'
    $tf2.Dispose();$ob.Dispose()

    $term=@("• مجلس مهستان حداکثر ۲ سال","• رأی‌گیری مجدد ۲ ماه قبل از پایان","• جایگزینی اعضا: فرد بعدی در فهرست","• هدف: جلوگیری از تمرکز و ماندگاری قدرت")
    $y=205
    foreach($t in $term){RTL $g $t $bf $db 100 $y 820 26 'Near';$y+=32}

    # Conflict resolution
    $cr=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(35,46,125,50))
    RRect $g $cr 80 365 1760 210 22;$cr.Dispose()
    $gnBar=New-Object System.Drawing.SolidBrush($Green)
    $g.FillRectangle($gnBar,80,365,1760,10);$gnBar.Dispose()

    $tf3=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    $gn=New-Object System.Drawing.SolidBrush($Green)
    RTL $g "🤝 حل اختلاف بین‌نهادی" $tf3 $gn 100 390 1720 35 'Near'
    $tf3.Dispose();$gn.Dispose()

    $conflict=@(
        "✅  هیأت میانجی‌گری: ۵ شخصیت مورد احترام ملی (پیشنهاد جامعه مدنی، مصوب مجلس)",
        "✅  در صورت اختلاف جدی بین مجلس، کابینه یا شورای قضایی وارد عمل می‌شود",
        "✅  در صورت عدم حل اختلاف: موضوع به رفراندوم عمومی گذاشته می‌شود",
        "✅  اصل نهایی: اراده‌ی مستقیم مردم بالاتر از هر نهادی است"
    )
    $y=440
    foreach($c in $conflict){RTL $g $c $bf $db 100 $y 1720 28 'Near';$y+=38}

    # Final constitution path
    $fc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(35,103,58,183))
    RRect $g $fc 80 605 1760 380 22;$fc.Dispose()
    $ppBar=New-Object System.Drawing.SolidBrush($Purple)
    $g.FillRectangle($ppBar,80,605,1760,10);$ppBar.Dispose()

    $tf4=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    $pp=New-Object System.Drawing.SolidBrush($Purple)
    RTL $g "📜 مسیر قانون اساسی نهایی" $tf4 $pp 100 630 1720 35 'Near'
    $tf4.Dispose();$pp.Dispose()

    $bf2=New-Object System.Drawing.Font("Tahoma",17)
    $const=@(
        "✅  پس از تصویب قانون اساسی موقت، مجلس گروهی را مأمور تدوین نهایی می‌کند",
        "",
        "📌  گزینه الف: تشکیل مجلس مؤسسان مستقل (انتخابات جداگانه)",
        "📌  گزینه ب: کمیسیون ویژه درون مجلس مهستان + مشاوره عمومی گسترده",
        "",
        "⚠️  الزامات: رعایت اصول غیرقابل‌نقض + تصویب نهایی از طریق رفراندوم عمومی",
        "🗳️  مسیر: تدوین ← مشاوره عمومی ← نهایی‌سازی ← رفراندوم ← انتخابات نظام جدید"
    )
    $y=680
    foreach($c2 in $const){
        if($c2 -ne ""){RTL $g $c2 $bf2 $db 100 $y 1720 30 'Near'}
        $y+=38
    }
    $bf2.Dispose()

    $bf.Dispose();$db.Dispose()
    Footer $g 23
}

# ===================== SLIDE 24 - DIRECT DEMOCRACY =====================
MakeSlide "Slide_24_Direct_Democracy.png" {
    param($g)
    GradBG $g $Royal ([System.Drawing.Color]::FromArgb(255,25,118,210))

    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(18,255,255,255))
    $g.FillEllipse($tb,1500,-50,350,350);$g.FillEllipse($tb,-80,600,300,300);$tb.Dispose()

    $hb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(235,255,255,255))
    $g.FillRectangle($hb,0,0,1920,100);$hb.Dispose()
    $hf=New-Object System.Drawing.Font("Tahoma",30,[System.Drawing.FontStyle]::Bold)
    $bl=New-Object System.Drawing.SolidBrush($Royal)
    RTL $g "🗳️ رفراندوم و دموکراسی مستقیم" $hf $bl 80 26 1760 50 'Near'
    $hf.Dispose();$bl.Dispose()

    $mc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(248,255,255,255))
    RRect $g $mc 40 115 1840 890 28;$mc.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # Quote
    $qb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(30,63,81,181))
    RRect $g $qb 80 135 1760 70 18;$qb.Dispose()
    $bl2=New-Object System.Drawing.SolidBrush($Royal)
    $qf=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Italic)
    RTL $g "اراده‌ی مستقیم مردم در هر لحظه بالاتر از نمایندگان آن‌هاست" $qf $bl2 100 155 1720 35 'Center'
    $qf.Dispose();$bl2.Dispose()

    # Mandatory referendums
    $m1=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(35,198,40,40))
    RRect $g $m1 980 230 860 360 22;$m1.Dispose()
    $rBar=New-Object System.Drawing.SolidBrush($Red)
    $g.FillRectangle($rBar,980,230,860,10);$rBar.Dispose()

    $tf=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    $rb=New-Object System.Drawing.SolidBrush($Red)
    RTL $g "🔴 رفراندوم‌های الزامی:" $tf $rb 1000 255 820 32 'Near'
    $tf.Dispose();$rb.Dispose()

    $bf=New-Object System.Drawing.Font("Tahoma",16)
    $mandatory=@(
        "✅  تصویب قانون اساسی موقت",
        "✅  تصویب قانون اساسی نهایی",
        "✅  تعیین نوع حکومت (جمهوری/مشروطه)",
        "✅  تعیین ساختار (متمرکز/فدرال/خودمختار)",
        "✅  الحاق یا واگذاری سرزمینی",
        "✅  هر موضوع «سرنوشت‌ساز» (⅔ مجلس)",
        "✅  درخواست ۵۰۰,۰۰۰+ امضای مردمی"
    )
    $y=300
    foreach($m in $mandatory){RTL $g $m $bf $db 1000 $y 820 26 'Near';$y+=35}

    # Tools of direct democracy
    $t1=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(35,63,81,181))
    RRect $g $t1 80 230 860 360 22;$t1.Dispose()
    $blBar=New-Object System.Drawing.SolidBrush($Royal)
    $g.FillRectangle($blBar,80,230,860,10);$blBar.Dispose()

    $tf2=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    $bl3=New-Object System.Drawing.SolidBrush($Royal)
    RTL $g "🗳️ ابزارهای دموکراسی مستقیم:" $tf2 $bl3 100 255 820 32 'Near'
    $tf2.Dispose();$bl3.Dispose()

    $tools=@(
        "📊  نظرسنجی‌های موضوعی (مشورتی، غیرالزامی)",
        "🗳️  رفراندوم‌های الزام‌آور (⅔ مجلس)",
        "📋  اولویت‌بندی مردمی دستور کار مجلس",
        "📨  بازخورد مستقیم درباره عملکرد نهادها",
        "📝  طومار ۱۰۰,۰۰۰+ = بررسی الزامی مجلس",
        "📝  طومار ۵۰۰,۰۰۰+ = رفراندوم الزامی",
        "🏘️  جلسات عمومی و پنل‌های شهروندی"
    )
    $y=300
    foreach($t in $tools){RTL $g $t $bf $db 100 $y 820 26 'Near';$y+=35}

    # Digital platform
    $dp=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(35,0,150,136))
    RRect $g $dp 80 620 1760 360 22;$dp.Dispose()
    $tBar=New-Object System.Drawing.SolidBrush($Teal)
    $g.FillRectangle($tBar,80,620,1760,10);$tBar.Dispose()

    $tf3=New-Object System.Drawing.Font("Tahoma",22,[System.Drawing.FontStyle]::Bold)
    $tc=New-Object System.Drawing.SolidBrush($Teal)
    RTL $g "💻 بستر دیجیتال دموکراسی مستقیم:" $tf3 $tc 100 645 1720 35 'Near'
    $tf3.Dispose();$tc.Dispose()

    $bf2=New-Object System.Drawing.Font("Tahoma",17)
    $digital=@(
        "🔐  احراز هویت امن (کد ملی + پاسپورت) — یک نفر، یک رأی",
        "📱  دسترسی از طریق موبایل، کامپیوتر و کیوسک‌های عمومی",
        "🌐  زبان‌های متعدد: فارسی + آذری + کُردی + عربی + بلوچی + ترکمنی",
        "📊  نتایج شفاف و قابل‌بررسی عمومی",
        "🛡️  نظارت هیأت مستقل انتخابات + ناظران بین‌المللی",
        "📋  ثبت و پیگیری پیشنهادها و شکایات شهروندان"
    )
    $y=700
    foreach($d in $digital){RTL $g $d $bf2 $db 100 $y 1720 30 'Near';$y+=42}

    $bf.Dispose();$bf2.Dispose();$db.Dispose()
    Footer $g 24
}

# ===================== SLIDE 25 - CALL TO ACTION & CLOSING =====================
MakeSlide "Slide_25_Call_To_Action.png" {
    param($g)
    GradBG $g $Indigo $Royal

    # Larger decorative elements
    $tb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(25,255,193,7))
    $g.FillEllipse($tb,-100,500,500,500)
    $g.FillEllipse($tb,1550,-100,450,450)
    $g.FillEllipse($tb,700,800,300,300)
    $tb.Dispose()

    # Central white card
    $cc=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(242,255,255,255))
    RRect $g $cc 200 80 1520 900 40;$cc.Dispose()

    # Gold top bar
    $gb=New-Object System.Drawing.SolidBrush($Gold)
    $g.FillRectangle($gb,200,80,1520,14);$gb.Dispose()

    $db=New-Object System.Drawing.SolidBrush($Dk)

    # Title
    $tf=New-Object System.Drawing.Font("Tahoma",38,[System.Drawing.FontStyle]::Bold)
    $ib=New-Object System.Drawing.SolidBrush($Indigo)
    RTL $g "فراخوان مشارکت" $tf $ib 250 120 1420 55 'Center'
    $tf.Dispose();$ib.Dispose()

    # Gold separator
    $gp=New-Object System.Drawing.Pen($Gold,3)
    $g.DrawLine($gp,500,195,1420,195);$gp.Dispose()

    # 4 call-to-action cards
    $calls = @(
        @{Icon="🏛️";Title="جریان‌ها و احزاب و ائتلاف‌ها";
          Desc="از هم‌اکنون پیش‌نویس قانون اساسی موقت پیشنهادی خود را تدوین و منتشر کنید";Color=$Royal},
        @{Icon="👤";Title="هر شهروند ایرانی";
          Desc="مطالعه کنید، بحث کنید، مشارکت کنید — نقد سازنده حق و وظیفه‌ی شماست";Color=$Teal},
        @{Icon="🎓";Title="هر متخصص و پژوهشگر";
          Desc="دانش و تجربه‌ی خود را در خدمت طراحی نهادی گذار بگذارید";Color=$Purple},
        @{Icon="⚖️";Title="هر فعال حقوق بشر";
          Desc="مستندسازی را ادامه دهید — این اسناد مبنای عدالت انتقالی فردا هستند";Color=$Orange}
    )

    for($i=0;$i -lt 4;$i++){
        $c = $calls[$i]
        $y = 220 + ($i * 145)

        $cb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(20,$c.Color.R,$c.Color.G,$c.Color.B))
        RRect $g $cb 260 $y 1400 125 20;$cb.Dispose()

        $bar=New-Object System.Drawing.SolidBrush($c.Color)
        $g.FillRectangle($bar,1610,$y,50,125);$bar.Dispose()

        $ef=New-Object System.Drawing.Font("Segoe UI Emoji",30)
        $g.DrawString($c.Icon,$ef,$db,1620,($y+10));$ef.Dispose()

        $ctf=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
        $ccb=New-Object System.Drawing.SolidBrush($c.Color)
        RTL $g $c.Title $ctf $ccb 280 ($y+15) 1300 32 'Near'
        $ctf.Dispose();$ccb.Dispose()

        $cdf=New-Object System.Drawing.Font("Tahoma",16)
        RTL $g $c.Desc $cdf $db 280 ($y+55) 1300 55 'Near'
        $cdf.Dispose()
    }

    # Final message box
    $fmb=New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255,232,245,253))
    RRect $g $fmb 260 810 1400 140 22;$fmb.Dispose()
    $blBar=New-Object System.Drawing.SolidBrush($Royal)
    $g.FillRectangle($blBar,260,810,1400,8);$blBar.Dispose()

    $fmtf=New-Object System.Drawing.Font("Tahoma",18,[System.Drawing.FontStyle]::Bold)
    $bl=New-Object System.Drawing.SolidBrush($Royal)
    RTL $g "💡 این بیانیه دعوتی است برای اندیشیدن، تکمیل و چکش‌کاری" $fmtf $bl 280 835 1360 30 'Near'
    $fmtf.Dispose();$bl.Dispose()

    $fmf=New-Object System.Drawing.Font("Tahoma",17)
    RTL $g "سند زنده‌ای است که با مشارکت همگان بهتر خواهد شد" $fmf $db 280 875 1360 28 'Near'

    $fmf2=New-Object System.Drawing.Font("Tahoma",20,[System.Drawing.FontStyle]::Bold)
    $gn=New-Object System.Drawing.SolidBrush($Green)
    RTL $g "تصمیم نهایی درباره‌ی آینده‌ی ایران فقط و فقط با مردم ایران است 🇮🇷" $fmf2 $gn 280 910 1360 32 'Near'
    $fmf2.Dispose();$gn.Dispose()

    # Website
    $wf=New-Object System.Drawing.Font("Consolas",16)
    $ib2=New-Object System.Drawing.SolidBrush($Royal)
    $g.DrawString("MahdiSalem.com",$wf,$ib2,850,960);$wf.Dispose();$ib2.Dispose()

    $fmf.Dispose();$db.Dispose()
    Footer $g 25
}

Write-Host "`n=======================================" -ForegroundColor Cyan
Write-Host "  ALL 25 SLIDES COMPLETE!" -ForegroundColor Green
Write-Host "  Check: $dir" -ForegroundColor Yellow
Write-Host "=======================================" -ForegroundColor Cyan