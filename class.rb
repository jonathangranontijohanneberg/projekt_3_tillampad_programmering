# Beskrivning: Programmet använder sig av Gosu-biblioteket för att visuellt skapa en pil på ett fönster. Inom Arrow-klassen manipuleras pilens koordinater på olika sätt i olika funktioner som kallas på via Gosu-syntax när tangenter trycks på eller hålls nere. Pilens kan bland annat åka framåt, rotera/svänga åt höger och vänster, sakta ner, ladda hastighet och sedan höja farten, byta färg, förstoras och förminskas.
# Argument: N/A
# Return: N/A
# 
# By: Jonathan Jansen Granö
# Date: 2022-05-30

require 'rubygems'
require 'gosu'

$x_origo = 300
$y_origo = 300

$x_size = 15
$y_size = 70

$down_left_x = $x_origo - $x_size
$down_left_y = $y_origo + $y_size

$up_left_x = $x_origo - $x_size
$up_left_y = $y_origo - $y_size

$up_right_x = $x_origo + $x_size
$up_right_y = $y_origo - $y_size

$down_right_x = $x_origo + $x_size
$down_right_y = $y_origo + $y_size


$left_x_tri = $up_left_x - $x_size
$left_y_tri = $up_left_y
$tip_x_tri = $x_origo
$tip_y_tri = $up_left_y - $y_size
$right_x_tri = $up_right_x + $x_size
$right_y_tri = $up_right_y

$opacity = 0

$opacity2 = 0

$v = 0.1

$speed = 20
$speed_og = $speed
$charge_speed = $speed_og

# Beskrivning: En Klass i vilken flera funktioner som utgör kommandon för hur pilen ska agera med olika knapptryckningar.
# Argument: Integer - klassen tar in ett tal för att fungera, talet motsvarar en knapp på tangentbordet. Vilka tal som motsvarar vilka tangenter kan ses här: https://www.libgosu.org/cpp/namespace_gosu.html.
# Return: N/A
# 
# By: Jonathan Jansen Granö
# Date: 2022-05-30

class Arrow
    
    # Beskrivning: Initialize-funktionen är en metod i klasser som tar in en input som ett värde i klassen. Här definieras input:en som en Instance Variable, @key_input, för att kunna användas i hela klassen.
    # Argument: Integer - klassen tar in ett tal för att fungera, talet motsvarar en knapp på tangentbordet. Vilka tal som motsvarar vilka tangenter kan ses här: https://www.libgosu.org/cpp/namespace_gosu.html.
    # Return: N/A
    #
    # By: Jonathan Jansen Granö
    # Date: 2022-05-30

    def initialize(key)
        @key_input = key
    end

    # Beskrivning: Roterar alla koordinater på alla hörn av pilens rektangel och triangel runt rektangelns mittpunkt. Använder sig av matrisrotation runt en bestämd punkt enligt ekvationen från denna hemsida: https://www.euclideanspace.com/maths/geometry/affine/aroundPoint/matrix2d/index.htm. Åt vilket håll den roterar bestäms av @key_input-variabeln från Initialize-funktionen.
    # Argument: N/A
    # Return: N/A
    # 
    # By: Jonathan Jansen Granö
    # Date: 2022-05-30

    def rotation
        if @key_input == Gosu::KbA
            $v = -$v.abs
        elsif @key_input == Gosu::KbD
            $v = $v.abs
        end

        down_left_x_tmp = $down_left_x
        down_left_y_tmp = $down_left_y
        
        up_left_x_tmp = $up_left_x
        up_left_y_tmp = $up_left_y

        up_right_x_tmp = $up_right_x
        up_right_y_tmp = $up_right_y

        down_right_x_tmp = $down_right_x
        down_right_y_tmp = $down_right_y

        $down_left_x = (down_left_x_tmp*Math.cos($v) - down_left_y_tmp*Math.sin($v) + $x_origo - $x_origo*Math.cos($v) + $y_origo*Math.sin($v))
        $down_left_y = (down_left_x_tmp*Math.sin($v) + down_left_y_tmp*Math.cos($v) + $y_origo - $x_origo*Math.sin($v) - $y_origo*Math.cos($v))

        $up_left_x = (up_left_x_tmp*Math.cos($v) - up_left_y_tmp*Math.sin($v) + $x_origo - $x_origo*Math.cos($v) + $y_origo*Math.sin($v))
        $up_left_y = (up_left_x_tmp*Math.sin($v) + up_left_y_tmp*Math.cos($v) + $y_origo - $x_origo*Math.sin($v) - $y_origo*Math.cos($v))

        $up_right_x = (up_right_x_tmp*Math.cos($v) - up_right_y_tmp*Math.sin($v) + $x_origo - $x_origo*Math.cos($v) + $y_origo*Math.sin($v))
        $up_right_y = (up_right_x_tmp*Math.sin($v) + up_right_y_tmp*Math.cos($v) + $y_origo - $x_origo*Math.sin($v) - $y_origo*Math.cos($v))

        $down_right_x = (down_right_x_tmp*Math.cos($v) - down_right_y_tmp*Math.sin($v) + $x_origo - $x_origo*Math.cos($v) + $y_origo*Math.sin($v))
        $down_right_y = (down_right_x_tmp*Math.sin($v) + down_right_y_tmp*Math.cos($v) + $y_origo - $x_origo*Math.sin($v) - $y_origo*Math.cos($v))

        left_x_tri_tmp = $left_x_tri
        left_y_tri_tmp = $left_y_tri
        tip_x_tri_tmp = $tip_x_tri
        tip_y_tri_tmp = $tip_y_tri
        right_x_tri_tmp = $right_x_tri
        right_y_tri_tmp = $right_y_tri

        $left_x_tri = (left_x_tri_tmp*Math.cos($v) - left_y_tri_tmp*Math.sin($v) + $x_origo - $x_origo*Math.cos($v) + $y_origo*Math.sin($v))
        $left_y_tri = (left_x_tri_tmp*Math.sin($v) + left_y_tri_tmp*Math.cos($v) + $y_origo - $x_origo*Math.sin($v) - $y_origo*Math.cos($v))

        $tip_x_tri = (tip_x_tri_tmp*Math.cos($v) - tip_y_tri_tmp*Math.sin($v) + $x_origo - $x_origo*Math.cos($v) + $y_origo*Math.sin($v))
        $tip_y_tri = (tip_x_tri_tmp*Math.sin($v) + tip_y_tri_tmp*Math.cos($v) + $y_origo - $x_origo*Math.sin($v) - $y_origo*Math.cos($v))

        $right_x_tri = (right_x_tri_tmp*Math.cos($v) - right_y_tri_tmp*Math.sin($v) + $x_origo - $x_origo*Math.cos($v) + $y_origo*Math.sin($v))
        $right_y_tri = (right_x_tri_tmp*Math.sin($v) + right_y_tri_tmp*Math.cos($v) + $y_origo - $x_origo*Math.sin($v) - $y_origo*Math.cos($v))
    end

    # Beskrivning: Denna funktion körs medan [BLANKSTEG]-knappen hålls ned och förstorar den globala variabeln för hastighet, $speed, vilket sänker hastigheten medan en variabel för laddad hastighet, $charge_speed, höjs för varje uppdateringsintervvall. De globala variablerna $opacity och $opacity2 höjs båda vilket visuellt ändrar färgerna på pilen och bakgrunden för visuell impakt.
    # Argument: N/A
    # Return: N/A
    # 
    # By: Jonathan Jansen Granö
    # Date: 2022-05-30

    def charge_speed
        $charge_speed = ($speed_og*0.99**$speed)*4
        $speed += 1
        $opacity += 1.01**2
        $opacity2 = $opacity/2
    end

    # Beskrivning: Denna funktion körs när [BLANKSTEG]-knappen släpps och körs därför direkt efter charge_speed-funktionen. Hastighetsvariabeln, $speed tilldelas värdet för den laddade hastigheten, $charge_speed.
    # Argument: N/A
    # Return: N/A
    # 
    # By: Jonathan Jansen Granö
    # Date: 2022-05-30
 
    def charge_speed_release
        $speed = ($charge_speed).abs
    end

    # Beskrivning: När SHIFT (vänster) hålls ned på tangentbordet sänks hastigheten/höjs värdet på $speed linjärt för varje uppdateringsintervall. Genomskinligheten av en vit pil, överlappande pilen, sänks i och sänkningen av värdet på den globala variabeln $opacity.
    # Argument: N/A
    # Return: N/A
    # 
    # By: Jonathan Jansen Granö
    # Date: 2022-05-30

    def slow_down
        $speed += 0.5
        $opacity -= 1
    end
    
    # Beskrivning: Funktionen aktiveras när tangenten W hålls ned och tar varje x-koordinat och y-koordinat och ändrar koordinaterna så att varje punkt förflyttas lika långt vilket förflyttar pilen i dess riktning. Steglängden beror på $speed-variabelns värde, ju högre, desto kortare steglängder per uppdateringsintervall vilket får pilen att förflyttas långsammare.
    # Argument: N/A
    # Return: N/A
    # 
    # By: Jonathan Jansen Granö
    # Date: 2022-05-30

    def move
        x_movement = ($up_left_x - $down_left_x)/$speed
        y_movement = -($down_left_y - $up_left_y)/$speed

        $x_origo += x_movement
        $y_origo += y_movement

        $down_left_x += x_movement
        $down_left_y += y_movement

        $up_left_x += x_movement
        $up_left_y += y_movement

        $up_right_x += x_movement
        $up_right_y += y_movement

        $down_right_x += x_movement
        $down_right_y += y_movement

        $left_x_tri += x_movement
        $left_y_tri += y_movement

        $tip_x_tri += x_movement
        $tip_y_tri += y_movement

        $right_x_tri += x_movement
        $right_y_tri += y_movement
    end

    # Beskrivning: Denna funktion byter värdet på den globala variabeln $color varje gång S-tangenten klickas på. Den kollar vilket bestämt värde $color har och roterar till nästa bestämda värde vilket visuellt ändrar färgen på pilen.
    # Argument: N/A
    # Return: N/A
    # 
    # By: Jonathan Jansen Granö
    # Date: 2022-05-30

    def change_color
        if $color == Gosu::Color::RED
            $color = Gosu::Color::YELLOW
        elsif $color == Gosu::Color::YELLOW
            $color = Gosu::Color::GREEN
        elsif $color == Gosu::Color::GREEN
            $color = Gosu::Color::BLUE
        else
            $color = Gosu::Color::RED
        end
    end

    # Beskrivning: Denna funktion aktiveras vid nedhållning av piltangenten som pekar uppåt. Pilens alla hörns koordinater återgår till sina ursprungliga koordinater relativt  pilens rektangels mittpunkt vilket får pilen att peka uppåt. De globala variablerna $x_size och $y_size, som bestämmer hur långt ifrån pilens rektangels mittpunkt alla koordinater är, får sina värden höjda proportionellt vilket får pilen att se ut att växa i storlek.
    # Argument: N/A
    # Return: N/A
    # 
    # By: Jonathan Jansen Granö
    # Date: 2022-05-30

    def size_up
        $x_size *= 1.002
        $y_size *= 1.002

        $down_left_x = $x_origo - $x_size
        $down_left_y = $y_origo + $y_size

        $up_left_x = $x_origo - $x_size
        $up_left_y = $y_origo - $y_size

        $up_right_x = $x_origo + $x_size
        $up_right_y = $y_origo - $y_size

        $down_right_x = $x_origo + $x_size
        $down_right_y = $y_origo + $y_size


        $left_x_tri = $up_left_x - $x_size
        $left_y_tri = $up_left_y
        $tip_x_tri = $x_origo
        $tip_y_tri = $up_left_y - $y_size
        $right_x_tri = $up_right_x + $x_size
        $right_y_tri = $up_right_y

    end

    # Beskrivning: Denna funktion aktiveras vid nedhållning av piltangenten som pekar nedåt. Pilens alla hörns koordinater återgår till sina ursprungliga koordinater relativt  pilens rektangels mittpunkt vilket får pilen att peka uppåt. De globala variablerna $x_size och $y_size, som bestämmer hur långt ifrån pilens rektangels mittpunkt alla koordinater är, får sina värden sänkta proportionellt vilket får pilen att se ut att krympa i storlek. 
    # Argument: N/A
    # Return: N/A
    # 
    # By: Jonathan Jansen Granö
    # Date: 2022-05-30

    def size_down
        $x_size /= 1.002
        $y_size /= 1.002

        $down_left_x = $x_origo - $x_size
        $down_left_y = $y_origo + $y_size

        $up_left_x = $x_origo - $x_size
        $up_left_y = $y_origo - $y_size

        $up_right_x = $x_origo + $x_size
        $up_right_y = $y_origo - $y_size

        $down_right_x = $x_origo + $x_size
        $down_right_y = $y_origo + $y_size


        $left_x_tri = $up_left_x - $x_size
        $left_y_tri = $up_left_y
        $tip_x_tri = $x_origo
        $tip_y_tri = $up_left_y - $y_size
        $right_x_tri = $up_right_x + $x_size
        $right_y_tri = $up_right_y
    end
end

# Beskrivning: En klass innehållande Gosu-kod. Allt inom klassen bidrar med det visuella i projektet. Klassen öppnar ett fönster. Strukturen för klassen kan ses här: https://www.engineyard.com/blog/create-ruby-games-using-gosu/.
# Argument: N/A
# Return: N/A
# 
# By: Jonathan Jansen Granö
# Date: 2022-05-30

class DemoWindow < Gosu::Window #namnet på fönstret plus Gosu::Window

    # Beskrivning: Initialize-metoden är essentiell när Gosu-biblioteket används. Inom den deklareras variabler som ska användas inom klassen och även Gosu-syntax relaterad till fönstret skrivs in här. Super(600,600,false) ger att skärmmåtten är inställda på 600*600 utan att fullscreen är aktiverat.
    # Argument: N/A
    # Return: N/A
    # 
    # By: Jonathan Jansen Granö
    # Date: 2022-05-30

    def initialize
        super(600,600,false)    #super(bredd,höjd,fullscrren)
        self.caption = "Arrow"
        @background_image = Gosu::Image.new("media/himmel.png", :tileable => true)
        @font = Gosu::Font.new(32)
        @font2 = Gosu::Font.new(20)
        $color = Gosu::Color::RED
    end

    # Beskrivning: Button_down är en metod i Gosu som tar in ett tal vid tryck av en tangent och utför en handling om ett villkor aktiveras vid knapptrycket. Här skapas en Instance Variable som används för att anropa på frunktioner från Arrow-klassen. Om S trycks aktiveras change_color-funktionen från Arrow-klassen. Om esc, Q eller X trycks på stängs programmet och fönstret av.
    # Argument: Integer - tal som motsvarar en tangent på tangentbordet.
    # Return: N/A
    # 
    # By: Jonathan Jansen Granö
    # Date: 2022-05-30

    def button_down(id)
        @class = Arrow.new(id)
        if id == Gosu::KbS
            @class.change_color
        end
        close if id == Gosu::KbEscape || id == Gosu::KbQ || id == Gosu::KbX
    end

    # Beskrivning: Button_up är en metod i Gosu som utför kommandon när en tangent har släppts. När [BLANKSTEG] släpps sktiveras charge_speed_release-funktionen från Arrow-klassen och den globala variabeln $opacity2, som tillhör en svart ruta överlappande hela fönstret, nollställs och rutan blir fullt genomskinlig. Om W-tangenten släpps återgår de globala variablerna $speed, $charge_speed, $opacity och $opacity2 till sina originalvärden. $opacity motsvarar genomskinligheten på en skala från 0 till 255 av en vit pil som överlappar den vanliga pilen.
    # Argument: Integer - tal som motsvarar en tangent på tangentbordet.
    # Return: N/A
    # 
    # By: Jonathan Jansen Granö
    # Date: 2022-05-30

    def button_up id
        if id == Gosu::KB_SPACE
            @class.charge_speed_release
            $opacity2 = 0
        elsif id == Gosu::KB_W
            $speed = 20
            $opacity = 0
            $opacity2 = 0
            $charge_speed = $speed_og

        end
    end

    # Beskrivning: Update-metoden är en essentiell Gosu-syntax som uppdateras varje uppdateringsintervall - 60 uppdateringar/sekund. Update använder syntaxen Gosu.button_down? när den ska utföra ett kommando så länge en tangent hålls ned. När A eller D hålls ner är funktionen rotation aktiv - rotationshållet bestäms baserat på knappen inom rotation-funktionen, när SHIFT hålls ner är slow_down-funktionen aktiv, W håller move-funktionen aktiv, [BLANKSTEG] håller charge_speed aktiv, pil upp håller size_up aktiv och pil ned håller size_down aktiv.
    # Argument: N/A
    # Return: N/A
    # 
    # By: Jonathan Jansen Granö
    # Date: 2022-05-30

    def update
        # https://stackoverflow.com/questions/67421861/gosu-how-to-detect-when-key-is-pressed 
        @class.rotation if Gosu.button_down? Gosu::KB_A
        @class.rotation if Gosu.button_down? Gosu::KB_D

        @class.slow_down if Gosu.button_down? Gosu::KB_LEFT_SHIFT

        @class.move if Gosu.button_down? Gosu::KB_W

        @class.charge_speed if Gosu.button_down? Gosu::KB_SPACE

        @class.size_up if Gosu.button_down? Gosu::KB_UP

        @class.size_down if Gosu.button_down? Gosu::KB_DOWN
    end

    # Beskrivning: Draw är en essentiell bit Gosu-syntax som ritar allt visuellt. Bakgrundsbilden som sparades i en Instance Variable i Initialize ritas här ut med mittpunkt i origo. En svart fyrkant med genomskinligheten $opacity2 ritas över hela skärmen, $opacity2 startar på 0. En rektangel med en triangel över, en pil, ritas ut med variablerna för x- och y-koordinater som förändras i många av funktionerna i Arrow-klassen. Flera trianglar ritas ut för i olika ljus och genomskinlighet ovanpå den enfärgade pilen för att ge pilen mer detalj. En helvit och identisk pil överlappar pilen men med genomskinligheten $opacity som startar på 0. Röda bokstäver som är statiska i höger hörn ritas ut som en UI.
    # Argument: N/A
    # Return: N/A
    # 
    # By: Jonathan Jansen Granö
    # Date: 2022-05-30

    def draw    
        @background_image.draw(0, 0, 0)

        $color2 = Gosu::Color.argb(150, 255, 255, 255)
        $color3 = Gosu::Color.argb(100, 0, 0, 0)
        $color4 = Gosu::Color.argb(255, 255, 200, 200)
        $color5 = Gosu::Color.argb($opacity, 255, 255, 255)
        $color6 = Gosu::Color.argb($opacity2, 0, 0, 0)

        # Svart kvadrat som täcker hela skärmen.
        draw_quad(0, 600, $color6, 600, 600, $color6, 0, 0, $color6, 600, 0, $color6)

        # Rektangeln som agerar bas till pilen.
        draw_quad($down_left_x, $down_left_y, $color, $down_right_x, $down_right_y, $color, $up_left_x, $up_left_y, $color, $up_right_x, $up_right_y, $color)
        # Estetik.
        draw_triangle($down_left_x, $down_left_y, $color2, $x_origo, $y_origo, $color, $up_left_x, $up_left_y, $color)
        draw_triangle($down_right_x, $down_right_y, $color3, $x_origo, $y_origo, $color, $up_right_x, $up_right_y, $color)

        # Triangel som agerar spets till pilen.
        draw_triangle($left_x_tri, $left_y_tri, $color, $tip_x_tri, $tip_y_tri, $color4, $right_x_tri, $right_y_tri, $color)
        # Estetik.
        draw_triangle($left_x_tri, $left_y_tri, $color2, $tip_x_tri, $tip_y_tri, $color2,  $up_left_x, $up_left_y, $color2)
        draw_triangle($up_right_x, $up_right_y, $color3, $tip_x_tri, $tip_y_tri, $color3, $right_x_tri, $right_y_tri, $color3)

        # Estetik, skugga till rektangeln som agerar bas till pilen.
        draw_quad($down_left_x, $down_left_y, $color2, $down_right_x, $down_right_y, $color2, $up_left_x, $up_left_y, $color3, $up_right_x, $up_right_y, $color3)

        # Vita pilens rektangeln som agerar bas till pilen.
        draw_quad($down_left_x, $down_left_y, $color5, $down_right_x, $down_right_y, $color5, $up_left_x, $up_left_y, $color5, $up_right_x, $up_right_y, $color5, 1)
        # Vita pilens triangel som agerar spets till pilen.
        draw_triangle($left_x_tri, $left_y_tri, $color5, $tip_x_tri, $tip_y_tri, $color5, $right_x_tri, $right_y_tri, $color5, 1)

        @font.draw_text("X", 545, 2, 1, 1.5, 1, Gosu::Color::RED)
        @font.draw_text("esc/Q", 533, 27, 1, 0.75, 0.75, Gosu::Color::RED)
    end

end
DemoWindow.new.show
