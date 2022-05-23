`color cf`

require 'pathname'

pth  = Pathname.getwd    # 当前目录
avex = "mp4"             # 合成文件格式

dn = pth.to_s.split("/")[-1]                                    # 父文件夹的名字
list = pth.children.map{|f| f.to_s}.map{|f| f.split("/")[-1]}   # 文件夹里所有的文件
list.delete_if {|f| f[-1]!="4"}                                 # 按扩展名不为4去掉本脚本文件

ll=[]

# 将文件名 按 次序2个一组作为一组 塞入 ll 中
# 因为是按字符顺序排列的，DASH_A 和 DASH_V 按顺序

list.size.times do |i|
	if i.even?
		ll << [list[i],list[i+1]]
	end
end

# 批量合并文件
ll.size.times do |i|
	a = ll[i][0]
	v = ll[i][1]
	fn = a[0..-14]
	puts "ffmpeg -i \'#{a}\' -i \'#{v}\' -c copy \'#{fn}.mp4\'" # 显示命令
	`ffmpeg -i \"#{a}\" -i \"#{v}\" -c copy \"#{fn}.#{avex}\"`      # cmd 命令
end
puts "批量合成完成，回车以退出"
gets