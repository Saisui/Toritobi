#!/usr/bin/ruby -w
# -*- coding: UTF-8 -*-

''' 将被去重的帧的图片的名字，按帧序号转化成 srt '''

kfs = ARGV[0]|| (puts("type a folder name for check(default=kfs):") || (iii=gets; iii!="\n" && iii[..-2] ) )|| 'kfs' # 帧图片的文件夹
fps = (ARGV[1])||
	(puts("type a decimal fps number(default=60):") || (iii=gets.to_f; iii>0) && iii )||
	60.0
outf = ARGV[2] ||'outline.srt' # 输出文件名

pingf = (ARGV[3])|| # 延迟帧数
(puts("type a ping frame count (format: [-]integer, default=0):") || (iii=gets.to_i) && iii )|| 0


ss=`dir #{kfs}`

hh=[]

ss.each_line{|l| hh << l}

hh = (hh.map{|a| a[-14..-7]})[7..-4]  # 最好是八位数字

hh.map!{|e| e.to_i}.
		map!{|e|
		if (e + pingf) >= 0 
			e + pingf
		else
			e
		end
	}

aw=[]
hh.size.times do |i|
	if hh[i+1]
		aw << [hh[i], hh[i+1]-1]
	else
		aw << [hh[i], hh[i]+1]
	end
end


aww = aw.map{|p|             # 每一对
		p.map{|i|i/fps.to_f}.     # 每一对的数字按帧率转成秒
		map{|n|
			[hn=(n/3600).to_i,     # 时
			((n%3600)/60).to_i,    # 分
			n%60.0]}.              # 秒
		map{|a| ["%02d" % a[0] ,"%02d" % a[1],("%06.3f"% a[2])]
		}
	}

aaa = aww.map {|p|
	"#{p[0][0]}:#{p[0][1]}:#{p[0][2]} --> #{p[1][0]}:#{p[1][1]}:#{p[1][2]}".gsub(/\./,",")
}

wt=""
aaa.size.times do |i|
	hanzi = i.to_s.tr("0123456789","〇一二三四五六七八九")
	wt << "#{i}\n#{aaa[i]}\n#{hanzi}\n\n"
end

File.new(outf,'w+').syswrite(wt)

puts '导出完成，按回车退出'
gets