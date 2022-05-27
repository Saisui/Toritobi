require 'json'

''' 将视频裁剪缩放成容易进行处理的尺寸，然后导出所有帧 '''

vi=JSON.parse(`ffprobe -select_streams v -show_entries format=duration,size,bit_rate,filename -show_streams -v quiet -of csv="p=0" -of json -i 2c.mp4`)

vw=vi["streams"][0]["width"].to_i
vh=vi["streams"][0]["height"].to_i

puts "输入缩放倍数。回车输入"
s = ((ss=gets.to_i)>0)&&ss || 4

puts "输入x, y, w, h。回车输入，默认x=vw/10,y=vh/5*4,w=vw/10*9,h=vh/13"
x=((ss=gets.to_i)>0)&&ss || vw/10
y=((ss=gets.to_i)>0)&&ss || vh/5*4
w=((ss=gets.to_i)>0)&&ss || vw/10*9
h=((ss=gets.to_i)>0)&&ss || vh/13


x=vw/10
y=vh/5*4
w=vw/10*9
h=vh/13
# x=100
# y=500
# w=1000
# h=100

h /= 2*s
h *= 2*s
w /= 2*s
w *= 2*s
`ffmpeg -i 2c.mp4 -vf crop=w=#{w}:h=#{h}:x=#{x}:y=#{y} -an 3c.mp4`
`ffmpeg -i 3c.mp4 -vf scale=#{w/s}:#{h/s} c.mp4`
# `ffmpeg -i 2c.mp4 -vf crop=w=#{w}:h=#{h}:x=#{x}:y=#{y} -scale=50:-1 c.mp4`
`mkdir kfs`
`ffmpeg -i c.mp4 -vsync 2 -f image2 "./kfs/%08d.jpeg`

puts '完成，按任意键退出'
gets