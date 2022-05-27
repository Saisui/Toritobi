#!/usr/bin/ruby -w
# -*- coding: UTF-8 -*-

''' 将被去重的帧的图片的名字，按帧序号转化成 srt '''

kfs = ARGV[0] || 'kfs' # 帧图片的文件夹
fps = (ARGV[1])||
	(puts("type a decimal fps number(default=60):") || (iii=gets.to_f; iii>0) && iii )||
	60.0
outf = ARGV[2] ||'outline.srt' # 输出文件名

ss=`dir #{kfs}`

hh=[]

ss.each_line{|l| hh << l}

hh = (hh.map{|a| a[-14..-7]})[7..-4]  # 最好是八位数字

allstr = hh.join("\n")


as = allstr.split("\n").  # 输入的所有关键帧序号用换行符分割
	map{|i|i.to_i}.       # 转成数字
	map{|i|i/fps}.       # 每个数字按帧率转成秒
	map{|n|
			[hn=(n/3600).to_i,  # 时
			 ((n%3600)/60).to_i,    # 分
			 n%60.0]}.       # 秒
	map{|a| ["%02d" % a[0] ,"%02d" % a[1],"%05.2f"% a[2]]}

# as.each do |n|
# 	puts "#{n[0]}:#{n[1]}"
# end

aaa = as.map do |n|
	"#{n[0]}:#{n[1]}:#{n[2]}"
end

aa=aaa.map{|s| s.gsub(/\./,",")+"0"}

wt=""
aa.size.times do |i|
	if i != aa.size-1
		wt << "#{i}\n#{aa[i]} --> #{aa[i+1]}\n略\n\n"
	else
		wt << "#{i}\n#{aa[i]} --> #{aa[i]}\n略\n\n"
	end
end

File.new(outf,'w+').syswrite(wt)