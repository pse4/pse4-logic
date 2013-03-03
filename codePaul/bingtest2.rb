require_relative 'common'
require_relative 'googlerequests'

fg = readHashFromFile('fachgebieteUndSpezialisierungen.txt')
icd = readHashFromFile('icd_code_de_text.txt')

tc = 100
p = ThreadPool.new(tc)
$i = 0
t0 = Time.now

bingRelation = {}

fg.each{|fgc, fgt|
    icd.each{ |icdc, icdt|
        p.schedule {
            s="#{icdt} #{fgt}"
            s += " "+String(bingCount(s))
        #puts "#{s} #{bingCount(s)}"
        }
        $i+=1
        if $i % tc == 0
            p.shutdown
            d = Time.now - t0
            p = ThreadPool.new(tc)
            puts "#{tc/d} items/s"
            t0 = Time.now

            
        end

    }
}

