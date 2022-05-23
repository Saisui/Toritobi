require 'pathname'
pth = Pathname.getwd
dn = pth.to_s.split("/")[-1] 
list = pth.children.map{|f| f.to_s}.map{|f| f.split("/")[-1]}

list.delete_if do |f|
	not (f =~ /\.ts$/)
end

q=list.size
s=""
(1..q).each do |i|
	s << "#{i}.ts|"
end
s=s[0..-2]

`ffmpeg -i \"concat:#{s}\" -c copy -bsf:a aac_adtstoasc -movflags +faststart #{dn}.mp4`

puts "已将所有.ts 合并成一个视频，输入回车以退出"
gets