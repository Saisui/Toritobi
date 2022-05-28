#!/usr/bin/ruby -w
# -*- coding: UTF-8 -*-

# # 将视频裁剪缩放成容易进行处理的尺寸，然后导出所有帧

require 'json'
require 'pathname'

vi=JSON.parse(`ffprobe -select_streams v -show_entries format=duration,size,bit_rate,filename -show_streams -v quiet -of csv="p=0" -of json -i 2c.mp4`)

pdir = Pathname.getwd.to_s.split("/")[-1]

# # 将被去重的帧的图片的名字，按帧序号转化成 srt

kfs = ARGV[0]|| (puts("type a folder name for check(default=kfs):") || (iii=gets; iii!="\n" && iii[..-2] ) )|| 'kfs' # 帧图片的文件夹
fps = (ARGV[1])||
	(puts("type a decimal fps number(default=60):") || (iii=gets.to_f; iii>0) && iii )||
	60.0
outf = ((ARGV[2]) && (ARGV[2]+".srt"))||(pdir+".srt") # 输出文件名
pingf = (ARGV[3])|| # 延迟帧数
	(puts("type a ping frame count (format: [-]integer, default=0):") || (iii=gets.to_i) && iii )|| 0

vw=vi["streams"][0]["width"].to_i
vh=vi["streams"][0]["height"].to_i

puts "输入缩小倍数，默认4。回车输入"
s = ((ss=gets.to_i)>0)&&ss || 4

puts "输入x, y;w, h 回车输入。默认 w=vw/10*9,h=vh/1;x=vw/10,y=vh/5*4输入"
puts
ss = gets
if ss !="\n"
	(x,y,w,h) = *ss.split(/[,;]/).map{|a| a.to_i}
else
	(x,y,w,h) = [vw/10, vh/5*4,vw/10*9, vh/13]
end


`ffprobe -i 2c.mp4 -select_streams v -show_frames -show_entries frame=pict_type -of csv | findstr -n I > frame_index.txt`



`ffprobe -i c.mp4 -select_streams v -show_frames -show_entries frame=pict_type -of csv | findstr -n I > frame_index.txt`

hh = `type frame_index.txt`
hh = hh.split(/\n/)

hh.map!{|a| a.split(/[:,]/)[0]}.
	map!{|e| e.to_i}.
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